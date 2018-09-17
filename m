From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27411
Date: Mon, 17 Sep 2018 15:37:18 -0500
Message-ID: <3da8eff1-3d4a-4515-c855-34aececc4d71@ti.com>
References: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180916113523.fq4n7nsasigy3wyg@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916113523.fq4n7nsasigy3wyg@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Liu Xiang <liu.xiang6@zte.com.cn>
Cc: pali.rohar@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, liuxiang_1999@126.com
List-Id: linux-pm@vger.kernel.org

On 09/16/2018 06:35 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jul 22, 2018 at 09:33:56PM +0800, Liu Xiang wrote:
>> According to the datasheet, bq27411 is similar to bq27421.
>>
>> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
>> ---
> 
> Looks good to me. Do you plan to test/review this Andrew, or
> should I proceed with merging this patch?
> 


I do not have this particular hardware for testing, but the patch does
look correct,

Reviewed-by: Andrew F. Davis <afd@ti.com>


> -- Sebastian
> 
>>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 1 +
>>  drivers/power/supply/bq27xxx_battery.c                     | 9 +++++++++
>>  drivers/power/supply/bq27xxx_battery_i2c.c                 | 2 ++
>>  include/linux/power/bq27xxx_battery.h                      | 1 +
>>  4 files changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> index 37994fd..4fa8e08 100644
>> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> @@ -23,6 +23,7 @@ Required properties:
>>   * "ti,bq27546" - BQ27546
>>   * "ti,bq27742" - BQ27742
>>   * "ti,bq27545" - BQ27545
>> + * "ti,bq27411" - BQ27411
>>   * "ti,bq27421" - BQ27421
>>   * "ti,bq27425" - BQ27425
>>   * "ti,bq27426" - BQ27426
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index f022e1b..6dbbe95 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -432,6 +432,7 @@ enum bq27xxx_reg_index {
>>  		[BQ27XXX_REG_AP] = 0x18,
>>  		BQ27XXX_DM_REG_ROWS,
>>  	};
>> +#define bq27411_regs bq27421_regs
>>  #define bq27425_regs bq27421_regs
>>  #define bq27426_regs bq27421_regs
>>  #define bq27441_regs bq27421_regs
>> @@ -665,6 +666,7 @@ enum bq27xxx_reg_index {
>>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq27411_props bq27421_props
>>  #define bq27425_props bq27421_props
>>  #define bq27426_props bq27421_props
>>  #define bq27441_props bq27421_props
>> @@ -725,6 +727,12 @@ enum bq27xxx_dm_reg_id {
>>  #define bq27545_dm_regs 0
>>  #endif
>>  
>> +static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
>> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
>> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2800,  3700 },
>> +};
>> +
>>  static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>  	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>  	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>> @@ -802,6 +810,7 @@ enum bq27xxx_dm_reg_id {
>>  	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
>>  	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
>>  	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
>> +	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>>  	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>>  	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
>>  	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 4006912..2677c38 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -247,6 +247,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
>>  	{ "bq27546", BQ27546 },
>>  	{ "bq27742", BQ27742 },
>>  	{ "bq27545", BQ27545 },
>> +	{ "bq27411", BQ27411 },
>>  	{ "bq27421", BQ27421 },
>>  	{ "bq27425", BQ27425 },
>>  	{ "bq27426", BQ27426 },
>> @@ -279,6 +280,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
>>  	{ .compatible = "ti,bq27546" },
>>  	{ .compatible = "ti,bq27742" },
>>  	{ .compatible = "ti,bq27545" },
>> +	{ .compatible = "ti,bq27411" },
>>  	{ .compatible = "ti,bq27421" },
>>  	{ .compatible = "ti,bq27425" },
>>  	{ .compatible = "ti,bq27426" },
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index d6355f4..507c5e2 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -24,6 +24,7 @@ enum bq27xxx_chip {
>>  	BQ27546,
>>  	BQ27742,
>>  	BQ27545, /* bq27545 */
>> +	BQ27411,
>>  	BQ27421, /* bq27421, bq27441, bq27621 */
>>  	BQ27425,
>>  	BQ27426,
>> -- 
>> 1.9.1
>>
