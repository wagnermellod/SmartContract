// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.9;

contract RegistraVeiculo {

    address private owner;
    
    constructor () public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Voce nao e o dono do contrato");
        _;
    }

    function contractAddress() public payable onlyOwner {
        uint256 balance = address(this).balance;
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Erro na transferencia");
    }
 
    struct Veiculo {
        string tipoveiculo;
        string modelo;
        string cor;
        string placa;
        string renavan;
        uint valor;
    }
    
    mapping(address => Veiculo[]) public veiculos;
    mapping(string => Veiculo) public findPlaca;
    
   function salvaVeiculo( string memory _tipoveiculo, string memory _modelo, string memory _cor,
        string memory _placa,string memory _renavan,uint  _valor) public payable {
            bool _validaplaca = validaplaca(_placa);
            if (_validaplaca==false){
                require(_validaplaca == false, "Placa do veiculo invalida, deve possiur 8 caracteres");
            }else{
                Veiculo memory _veiculo = Veiculo(_tipoveiculo, _modelo, _cor,_placa,_renavan,_valor);
                veiculos[msg.sender].push(_veiculo);
                findPlaca[_placa] = _veiculo;
            }
            
    }
    
    function getVeiculos() public view returns(Veiculo[] memory) {
        Veiculo[] memory retveiculos = veiculos[msg.sender];
        return retveiculos;
    }

     function validaplaca(string memory _placa) private pure returns (bool) {
        if( bytes(_placa).length == 8){
            return true; 

        }else{
            return false;
        }
            
    }
   
    
}