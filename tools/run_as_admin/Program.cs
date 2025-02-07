using System;
using System.Reflection;
using System.Security.Principal;
using System.Diagnostics;

namespace run_as_admin
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("How to use:\nrun_as_admin <command>");
                return;
            }

            WindowsIdentity identity = WindowsIdentity.GetCurrent();
            WindowsPrincipal principal = new WindowsPrincipal(identity);
            if (principal.IsInRole(WindowsBuiltInRole.Administrator))
            {
                RunCommand(args[0]);
            }
            else
            {
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.UseShellExecute = true;
                startInfo.WorkingDirectory = Environment.CurrentDirectory;
                startInfo.FileName = Assembly.GetExecutingAssembly().Location;
                startInfo.Verb = "runas";
                startInfo.Arguments = string.Join(" ", args);
                try
                {
                    Process.Start(startInfo);
                }
                catch
                {
                    return;
                }

                Environment.Exit(0);
            }
        }

        public static void RunCommand(string command)
        {
            using (Process pc = new Process())
            {
                pc.StartInfo.FileName = "powershell.exe";
                pc.StartInfo.CreateNoWindow = false;
                pc.StartInfo.UseShellExecute = false;
                pc.StartInfo.RedirectStandardInput = true;
                pc.StartInfo.RedirectStandardOutput = false;
                pc.StartInfo.RedirectStandardError = false;
                pc.Start();
                pc.StandardInput.WriteLine(command);
                pc.StandardInput.WriteLine("Start-Sleep -Seconds 5 > $null");
                pc.StandardInput.WriteLine("exit");
                pc.WaitForExit();
            }
        }
    }
}