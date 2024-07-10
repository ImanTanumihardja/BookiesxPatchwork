// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@patchwork/Patchwork721.sol";
import "@patchwork/PatchworkUtils.sol";

contract BookiesBets is Patchwork721 {

    struct Metadata {
        string marketId;
        int256 pick;
        uint256 odd;
        uint256 stake;
        uint256 timestamp;
    }

    constructor(address _manager, address _owner)
        Patchwork721("test", "BookiesBets", "AP", _manager, _owner)
    {}

    function schemaURI() pure external override returns (string memory) {
        return "https://mything/my-metadata.json";
    }

    function imageURI(uint256 tokenId) pure external override returns (string memory) {
        return string.concat("https://mything/my/", Strings.toString(tokenId), ".png");
    }

    function _baseURI() internal pure virtual override returns (string memory) {
        return "";
    }

    function storeMetadata(uint256 tokenId, Metadata memory data) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId] = packMetadata(data);
    }

    function loadMetadata(uint256 tokenId) public view returns (Metadata memory data) {
        return unpackMetadata(_metadataStorage[tokenId]);
    }

    function schema() pure external override returns (MetadataSchema memory) {
        MetadataSchemaEntry[] memory entries = new MetadataSchemaEntry[](5);
        entries[0] = MetadataSchemaEntry(1, 0, FieldType.CHAR32, 1, FieldVisibility.PUBLIC, 0, 0, "marketId");
        entries[1] = MetadataSchemaEntry(2, 0, FieldType.INT256, 1, FieldVisibility.PUBLIC, 1, 0, "pick");
        entries[2] = MetadataSchemaEntry(3, 0, FieldType.UINT256, 1, FieldVisibility.PUBLIC, 2, 0, "odd");
        entries[3] = MetadataSchemaEntry(4, 0, FieldType.UINT256, 1, FieldVisibility.PUBLIC, 3, 0, "stake");
        entries[4] = MetadataSchemaEntry(4, 0, FieldType.UINT256, 1, FieldVisibility.PUBLIC, 4, 0, "timestamp");
        return MetadataSchema(1, entries);
    }

    function packMetadata(Metadata memory data) public pure returns (uint256[] memory slots) {
        slots = new uint256[](5);
        slots[0] = PatchworkUtils.strToUint256(data.marketId);
        slots[1] = uint256(data.pick);
        slots[2] = uint256(data.odd);
        slots[3] = uint256(data.stake);
        slots[4] = uint256(data.stake);
        return slots;
    }

    function unpackMetadata(uint256[] memory slots) public pure returns (Metadata memory data) {
        uint256 slot = slots[0];
        data.marketId = PatchworkUtils.toString32(slot);
        slot = slots[1];
        data.pick = int256(slot);
        slot = slots[2];
        data.odd = uint256(slot);
        slot = slots[3];
        data.stake = uint256(slot);
        slot = slots[4];
        data.timestamp = uint256(slot);
        return data;
    }

    // Load Only marketId
    function loadMarketId(uint256 tokenId) public view returns (string memory) {
        uint256 value = uint256(_metadataStorage[tokenId][0]);
        return PatchworkUtils.toString32(value);
    }

    // Store Only marketId
    function storeMarketId(uint256 tokenId, string memory marketId) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][0] = PatchworkUtils.strToUint256(marketId);
    }

    // Load Only pick
    function loadPick(uint256 tokenId) public view returns (int256) {
        uint256 value = uint256(_metadataStorage[tokenId][1]);
        return int256(value);
    }

    // Store Only pick
    function storePick(uint256 tokenId, int256 pick) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][1] = uint256(pick);
    }

    // Load Only odd
    function loadOdd(uint256 tokenId) public view returns (uint256) {
        uint256 value = uint256(_metadataStorage[tokenId][2]);
        return uint256(value);
    }

    // Store Only odd
    function storeOdd(uint256 tokenId, uint256 odd) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][2] = uint256(odd);
    }

    // Load Only stake
    function loadStake(uint256 tokenId) public view returns (uint256) {
        uint256 value = uint256(_metadataStorage[tokenId][3]);
        return uint256(value);
    }

    // Store Only stake
    function storeStake(uint256 tokenId, uint256 stake) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][3] = uint256(stake);
    }

    // Load Only timestamp
    function loadTimestamp(uint256 tokenId) public view returns (uint256) {
        uint256 value = uint256(_metadataStorage[tokenId][4]);
        return uint256(value);
    }

    // Store Only timestamp
    function storeTimestamp(uint256 tokenId, uint256 timestamp) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][4] = uint256(timestamp);
    }
}