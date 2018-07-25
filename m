From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH] bq25890_charger.c : add the BQ25896 part
Date: Wed, 25 Jul 2018 06:17:45 -0600
Message-ID: <cdfed37dd6a24a4afffc0d880601e2c7@www.akkea.ca>
References: <20180723135117.2090-1-angus@akkea.ca>
 <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Angus Ainslie <angus.ainslie@puri.sm>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 2018-07-25 03:58, Krzysztof Kozlowski wrote:
> On 23 July 2018 at 15:51, Angus Ainslie <angus@akkea.ca> wrote:
>> Add some debugging to be able to check the proper initialization
>> of the BQ25896 part.
> 
> Hi,
> 
> This should be split into separate patchset. Do not mix two features
> in one commit.
> 

Ok, I'll take it apart

>> Enable the BQ25896 part.
>> 
>> Add 2 new parameters "voltage_now" and "model_name".
>> 
>> Signed-off-by: Angus Ainslie <angus.ainslie@puri.sm>
> 
> Your signed-off-by does not match From address.
> 

That was intentional as I wanted Purism to get credit for it. I'm 
guessing that's not the correct way of doing it.

>> ---
>>  drivers/power/supply/bq25890_charger.c | 68 
>> ++++++++++++++++++++++----
>>  1 file changed, 58 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/power/supply/bq25890_charger.c 
>> b/drivers/power/supply/bq25890_charger.c
>> index 8e2c41ded171..32cdae15ce40 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -32,6 +32,7 @@
>>  #define BQ25890_IRQ_PIN                        "bq25890_irq"
>> 
>>  #define BQ25890_ID                     3
>> +#define BQ25896_ID                     0
>> 
>>  enum bq25890_fields {
>>         F_EN_HIZ, F_EN_ILIM, F_IILIM,                                
>> /* Reg00 */
>> @@ -153,8 +154,8 @@ static const struct reg_field bq25890_reg_fields[] 
>> = {
>>         [F_CONV_RATE]           = REG_FIELD(0x02, 6, 6),
>>         [F_BOOSTF]              = REG_FIELD(0x02, 5, 5),
>>         [F_ICO_EN]              = REG_FIELD(0x02, 4, 4),
>> -       [F_HVDCP_EN]            = REG_FIELD(0x02, 3, 3),
>> -       [F_MAXC_EN]             = REG_FIELD(0x02, 2, 2),
>> +       [F_HVDCP_EN]            = REG_FIELD(0x02, 3, 3),  // reserved 
>> on BQ25896
>> +       [F_MAXC_EN]             = REG_FIELD(0x02, 2, 2),  // reserved 
>> on BQ25896
>>         [F_FORCE_DPM]           = REG_FIELD(0x02, 1, 1),
>>         [F_AUTO_DPDM_EN]        = REG_FIELD(0x02, 0, 0),
>>         /* REG03 */
>> @@ -163,6 +164,7 @@ static const struct reg_field bq25890_reg_fields[] 
>> = {
>>         [F_OTG_CFG]             = REG_FIELD(0x03, 5, 5),
>>         [F_CHG_CFG]             = REG_FIELD(0x03, 4, 4),
>>         [F_SYSVMIN]             = REG_FIELD(0x03, 1, 3),
>> +       /* MIN_VBAT_SEL on BQ25896 */
>>         /* REG04 */
>>         [F_PUMPX_EN]            = REG_FIELD(0x04, 7, 7),
>>         [F_ICHG]                = REG_FIELD(0x04, 0, 6),
>> @@ -181,7 +183,7 @@ static const struct reg_field bq25890_reg_fields[] 
>> = {
>>         [F_CHG_TMR]             = REG_FIELD(0x07, 1, 2),
>>         [F_JEITA_ISET]          = REG_FIELD(0x07, 0, 0),
>>         /* REG08 */
>> -       [F_BATCMP]              = REG_FIELD(0x08, 6, 7),
>> +       [F_BATCMP]              = REG_FIELD(0x08, 6, 7), // 5-7 on 
>> BQ25896
> 
> So this field is different on BQ25896...
> 

The BATCMP field is not currently used by the driver but it is reference 
by "bq25890_tables". Should I remove that reference or make a special 
case for something that isn't used ?

>>         [F_VCLAMP]              = REG_FIELD(0x08, 2, 4),
>>         [F_TREG]                = REG_FIELD(0x08, 0, 1),
>>         /* REG09 */
>> @@ -195,12 +197,13 @@ static const struct reg_field 
>> bq25890_reg_fields[] = {
>>         [F_PUMPX_DN]            = REG_FIELD(0x09, 0, 0),
>>         /* REG0A */
>>         [F_BOOSTV]              = REG_FIELD(0x0A, 4, 7),
>> +       /* PFM_OTG_DIS 3 on BQ25896 */
>>         [F_BOOSTI]              = REG_FIELD(0x0A, 0, 2),
>>         /* REG0B */
>>         [F_VBUS_STAT]           = REG_FIELD(0x0B, 5, 7),
>>         [F_CHG_STAT]            = REG_FIELD(0x0B, 3, 4),
>>         [F_PG_STAT]             = REG_FIELD(0x0B, 2, 2),
>> -       [F_SDP_STAT]            = REG_FIELD(0x0B, 1, 1),
>> +       [F_SDP_STAT]            = REG_FIELD(0x0B, 1, 1), // reserved 
>> on BQ25896
>>         [F_VSYS_STAT]           = REG_FIELD(0x0B, 0, 0),
>>         /* REG0C */
>>         [F_WD_FAULT]            = REG_FIELD(0x0C, 7, 7),
>> @@ -401,6 +404,18 @@ static int 
>> bq25890_power_supply_get_property(struct power_supply *psy,
>>                 val->strval = BQ25890_MANUFACTURER;
>>                 break;
>> 
>> +       case POWER_SUPPLY_PROP_MODEL_NAME:
>> +               bq->chip_id = bq25890_field_read(bq, F_PN);
> 
> Why do you need to read it again?
> 

Right, it should be set in probe.

>> +
>> +               if (bq->chip_id == BQ25890_ID)
>> +                       val->strval = "BQ25890";
>> +               else if (bq->chip_id == BQ25896_ID)
>> +                       val->strval = "BQ25896";
>> +               else
>> +                       val->strval = "UNKNOWN";
>> +
>> +               break;
>> +
>>         case POWER_SUPPLY_PROP_ONLINE:
>>                 val->intval = state.online;
>>                 break;
>> @@ -453,6 +468,20 @@ static int 
>> bq25890_power_supply_get_property(struct power_supply *psy,
>>                 val->intval = bq25890_find_val(bq->init_data.iterm, 
>> TBL_ITERM);
>>                 break;
>> 
>> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +               if (!state.online) {
>> +                       val->intval = 0;
>> +                       break;
>> +               }
> 
> This looks like unrelated change. Please split it.
> 

Ok

>> +
>> +               ret = bq25890_field_read(bq, F_SYSV); /* read measured 
>> value */
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               /* converted_val = 2.304V + ADC_val * 20mV (table 
>> 10.3.15) */
>> +               val->intval = 2304000 + ret * 20000;
>> +               break;
>> +
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -608,30 +637,43 @@ static int bq25890_hw_init(struct bq25890_device 
>> *bq)
>>         };
>> 
>>         ret = bq25890_chip_reset(bq);
>> -       if (ret < 0)
>> +       if (ret < 0) {
>> +               dev_dbg(bq->dev, "BQ259x reset failed %d\n", ret);
> 
> "BQ259x" prefix is not needed.
> 

Ok

[snip]

> 
> Document the compatible. If you run checkpatch.... it would point it.

Sorry, I'll fix all the checkpatch errors.

> 
> Best regards,
> Krzysztof

Cheers
Angus
