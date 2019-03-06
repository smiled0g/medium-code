/**
 * @dev Returns the current min_deposit of the given entry, using 
 * depositDecayFunction to compute the ratio of remaining min_deposit
 * based on how long the entry has been listed.
 */
function currentMinDeposit(bytes32 entryData)
  public
  view
  entryMustExist(entryData)
  returns (uint256)
{
  Entry storage entry = entries[entryData];
  uint256 minDeposit = get("min_deposit");
  if (now < entry.listedAt) {
    return minDeposit;
  } else {
    return (minDeposit.mul(
      depositDecayFunction.calculate(now.sub(entry.listedAt)))
    ).div(DENOMINATOR);
  }
}
