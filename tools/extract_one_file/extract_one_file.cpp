#include <iostream>
#include <bit7z/bitfileextractor.hpp>
#include <string>

void showInfo(std::string archivePath, std::string fileName, std::string outputDir, std::string& archiveType)
{
    std::cout << "Extracting:\n" << "Archive Path: " << archivePath << "\nArchive Type: " << archiveType << "\nFile Name: " << fileName << "\nOutput Path: " << outputDir << "\n" << std::endl;
}

int main(int argc, char* argv[])
{
    if (argc != 5)
    {
        std::cerr << "Usage:\nextract_one_file <path_to_archive> <name_of_file> <path_to_extract_to> <type_of_archive>" << std::endl;
        std::cerr << "\nExample:\nextract_one_file test.zip a.txt ./output zip" << std::endl;
        std::cerr << "\nSupported archive types:\nzip, cab, iso(UDF), msi" << std::endl;
        return 1;
    }

    try
    {
        std::string archiveType = argv[4];
        bit7z::Bit7zLibrary lib{ "7z.dll" };
        if (archiveType == "zip")
        {
            bit7z::BitFileExtractor extractor{ lib, bit7z::BitFormat::Zip };
            showInfo(argv[1], argv[2], argv[3], archiveType);
            extractor.extractMatching(argv[1], argv[2], argv[3]);
        }
        else if (archiveType == "cab")
        {
            bit7z::BitFileExtractor extractor{ lib, bit7z::BitFormat::Cab };
            showInfo(argv[1], argv[2], argv[3], archiveType);
            extractor.extractMatching(argv[1], argv[2], argv[3]);
        }
        else if (archiveType == "iso")
        {
            bit7z::BitFileExtractor extractor{ lib, bit7z::BitFormat::Udf };
            showInfo(argv[1], argv[2], argv[3], archiveType);
            extractor.extractMatching(argv[1], argv[2], argv[3]);
        }
        else if (archiveType == "msi")
        {
            bit7z::BitFileExtractor extractor{ lib, bit7z::BitFormat::Compound };
            showInfo(argv[1], argv[2], argv[3], archiveType);
            extractor.extractMatching(argv[1], argv[2], argv[3]);
        }
        else
        {
            std::cerr << "Unknown supported type of archive" << std::endl;
            return 1;
        }
    }
    catch (const bit7z::BitException& e)
    {
        std::cerr << e.what() << std::endl;
    }
}