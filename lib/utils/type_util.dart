String obtainTypeNameByTypeIndex(int typeIndex) {
  switch (typeIndex) {
    case 1 : return "宣传";
    case 3 : return "感谢 / 吐槽";
    case 4 : return "失物";
    case 5 : return "求助";
    case 6 : return "脱单";
    case 7 : return "一卡通";
    default: return null;
  }
}