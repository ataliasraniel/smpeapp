class AddressUtils {
  static final List<String> _states = [
    'Acre'.toLowerCase(),
    'Alagoas'.toLowerCase(),
    'Amapá'.toLowerCase(),
    'Amazonas'.toLowerCase(),
    'Bahia'.toLowerCase(),
    'Ceará'.toLowerCase(),
    'Distrito Federal'.toLowerCase(),
    'Espírito Santo'.toLowerCase(),
    'Goiás'.toLowerCase(),
    'Maranhão'.toLowerCase(),
    'Mato Grosso do Sul'.toLowerCase(),
    'Mato Grosso'.toLowerCase(),
    'Minas Gerais'.toLowerCase(),
    'Pará'.toLowerCase(),
    'Paraíba'.toLowerCase(),
    'Paraná'.toLowerCase(),
    'Pernambuco'.toLowerCase(),
    'Piauí'.toLowerCase(),
    'Rio de Janeiro'.toLowerCase(),
    'Rio Grande do Norte'.toLowerCase(),
    'Rio Grande do Sul'.toLowerCase(),
    'Rondônia'.toLowerCase(),
    'Roraima'.toLowerCase(),
    'Santa Catarina'.toLowerCase(),
    'São Paulo'.toLowerCase(),
    'Sergipe'.toLowerCase(),
    'Tocantins'.toLowerCase(),
  ];
  static List<String> get states => _states;
  static List<String> getEstadosByAbreviation() {
    return ['AC', 'AL', 'AM', 'AP', 'BA','CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO'];
  }

  static String convertUfToState(String uf) {
    switch (uf) {
      case 'AC':
        return 'Acre';
      case 'AL':
        return 'Alagoas';
      case 'AP':
        return 'Amapá';
      case 'AM':
        return 'Amazonas';
      case 'BA':
        return 'Bahia';
      case 'CE':
        return 'Ceará';
      case 'DF':
        return 'Distrito Federal';
      case 'ES':
        return 'Espírito Santo';
      case 'GO':
        return 'Goiás';
      case 'MA':
        return 'Maranhão';
      case 'MS':
        return 'Mato Grosso do Sul';
      case 'MT':
        return 'Mato Grosso';
      case 'MG':
        return 'Minas Gerais';
      case 'PA':
        return 'Pará';
      case 'PB':
        return 'Paraíba';
      case 'PR':
        return 'Paraná';
      case 'PE':
        return 'Pernambuco';
      case 'PI':
        return 'Piauí';
      case 'RJ':
        return 'Rio de Janeiro';
      case 'RN':
        return 'Rio Grande do Norte';
      case 'RS':
        return 'Rio Grande do Sul';
      case 'RO':
        return 'Rondônia';
      case 'RR':
        return 'Roraima';
      case 'SC':
        return 'Santa Catarina';
      case 'SP':
        return 'São Paulo';
      case 'SE':
        return 'Sergipe';
      case 'TO':
        return 'Tocantins';
      default:
        return 'Acre';
    }
  }
}
