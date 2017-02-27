From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v8 7/9] power: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Mon, 27 Feb 2017 15:21:00 -0600
Message-ID: <4a6622a3-5fea-ac37-c906-4073ef655983@ti.com>
References: <20170227071117.18934-1-liam@networkimprov.net>
 <20170227071117.18934-8-liam@networkimprov.net>
 <164968b9-e809-d7fc-176b-cbeded20d43d@ti.com>
 <CAKvHMgR8Ly9GYYmE5BgPsayQmd7_gwTV1_4NfdEfU3Giacdqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:52917 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdB1Lsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2017 06:48:35 -0500
In-Reply-To: <CAKvHMgR8Ly9GYYmE5BgPsayQmd7_gwTV1_4NfdEfU3Giacdqcg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 02/27/2017 02:05 PM, Liam Breck wrote:
> On Mon, Feb 27, 2017 at 10:06 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 02/27/2017 01:11 AM, Liam Breck wrote:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Previously there was no way to configure chip registers in the event that the
>>> defaults didn't match the battery in question.
>>>
>>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
>>> and writes battery data to chip RAM or non-volatile memory.
>>>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  drivers/power/supply/bq27xxx_battery.c | 458 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 456 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>> index 7475a5f..41d4ce7 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -51,7 +51,7 @@
>>>
>>>  #include <linux/power/bq27xxx_battery.h>
>>>
>>> -#define DRIVER_VERSION               "1.2.0"
>>> +#define DRIVER_VERSION               "1.3.0"
>>>
>>>  #define BQ27XXX_MANUFACTURER "Texas Instruments"
>>>
>>> @@ -59,6 +59,7 @@
>>>  #define BQ27XXX_FLAG_DSC     BIT(0)
>>>  #define BQ27XXX_FLAG_SOCF    BIT(1) /* State-of-Charge threshold final */
>>>  #define BQ27XXX_FLAG_SOC1    BIT(2) /* State-of-Charge threshold 1 */
>>> +#define BQ27XXX_FLAG_CFGUP   BIT(5)
>>>  #define BQ27XXX_FLAG_FC              BIT(9)
>>>  #define BQ27XXX_FLAG_OTD     BIT(14)
>>>  #define BQ27XXX_FLAG_OTC     BIT(15)
>>> @@ -72,6 +73,11 @@
>>>  #define BQ27000_FLAG_FC              BIT(5)
>>>  #define BQ27000_FLAG_CHGS    BIT(7) /* Charge state flag */
>>>
>>> +/* control register params */
>>> +#define BQ27XXX_SEALED                       0x20
>>> +#define BQ27XXX_SET_CFGUPDATE                0x13
>>> +#define BQ27XXX_SOFT_RESET           0x42
>>> +
>>>  #define BQ27XXX_RS                   (20) /* Resistor sense mOhm */
>>>  #define BQ27XXX_POWER_CONSTANT               (29200) /* 29.2 µV^2 * 1000 */
>>>  #define BQ27XXX_CURRENT_CONSTANT     (3570) /* 3.57 µV * 1000 */
>>> @@ -102,6 +108,11 @@ enum bq27xxx_reg_index {
>>>       BQ27XXX_REG_SOC,        /* State-of-Charge */
>>>       BQ27XXX_REG_DCAP,       /* Design Capacity */
>>>       BQ27XXX_REG_AP,         /* Average Power */
>>> +     BQ27XXX_DM_CTRL,        /* BlockDataControl() */
>>
>> /* Block Data Control */
>>
>>> +     BQ27XXX_DM_CLASS,       /* DataClass() */
>>
>> /* Data Class */
> 
> I used the terms from the docs, so a search will find meaningful results.
> 
>>> +     BQ27XXX_DM_BLOCK,       /* DataBlock() */
>>> +     BQ27XXX_DM_DATA,        /* BlockData() */
>>> +     BQ27XXX_DM_CKSUM,       /* BlockDataChecksum() */
>>>       BQ27XXX_REG_MAX,        /* sentinel */
>>>  };
>>>
>>> @@ -125,6 +136,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x0b,
>>>               [BQ27XXX_REG_DCAP] = 0x76,
>>>               [BQ27XXX_REG_AP] = 0x24,
>>> +             [BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
>>>       },
>>>       [BQ27010] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -144,6 +160,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x0b,
>>>               [BQ27XXX_REG_DCAP] = 0x76,
>>>               [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
>>>       },
>>>       [BQ27500] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -163,6 +184,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x2c,
>>>               [BQ27XXX_REG_DCAP] = 0x3c,
>>>               [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27510] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -182,6 +208,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x20,
>>>               [BQ27XXX_REG_DCAP] = 0x2e,
>>>               [BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27530] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -201,6 +232,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x2c,
>>>               [BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
>>>               [BQ27XXX_REG_AP] = 0x24,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27541] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -220,6 +256,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x2c,
>>>               [BQ27XXX_REG_DCAP] = 0x3c,
>>>               [BQ27XXX_REG_AP] = 0x24,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27545] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -239,6 +280,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x2c,
>>>               [BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
>>>               [BQ27XXX_REG_AP] = 0x24,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27421] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -258,6 +304,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x1c,
>>>               [BQ27XXX_REG_DCAP] = 0x3c,
>>>               [BQ27XXX_REG_AP] = 0x18,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>>       },
>>>       [BQ27425] = {
>>>               [BQ27XXX_REG_CTRL] = 0x00,
>>> @@ -277,6 +328,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
>>>               [BQ27XXX_REG_SOC] = 0x1c,
>>>               [BQ27XXX_REG_DCAP] = 0x3c,
>>>               [BQ27XXX_REG_AP] = 0x18,
>>> +             [BQ27XXX_DM_CTRL] = 0x61,
>>> +             [BQ27XXX_DM_CLASS] = 0x3e,
>>> +             [BQ27XXX_DM_BLOCK] = 0x3f,
>>> +             [BQ27XXX_DM_DATA] = 0x40,
>>> +             [BQ27XXX_DM_CKSUM] = 0x60,
>>
>> That wasn't so painful was it :)
> 
> It added 11% to the patch :-/
> 
>>>       },
>>>  };
>>>
>>> @@ -452,6 +508,81 @@ static struct {
>>>  static DEFINE_MUTEX(bq27xxx_list_lock);
>>>  static LIST_HEAD(bq27xxx_battery_devices);
>>>
>>> +#define BQ27XXX_DM_SZ                        32
>>> +
>>> +#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
>>> +
>>> +struct bq27xxx_dm_reg {
>>> +     u8 subclass_id;
>>> +     u8 offset;
>>> +     u8 bytes;
>>> +     u16 min, max;
>>> +};
>>> +
>>> +struct bq27xxx_dm_buf {
>>> +     u8 class;
>>> +     u8 block;
>>> +     u8 a[BQ27XXX_DM_SZ];
>>> +     bool full, updt;
>>> +};
>>> +
>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>> +     .class = bq27xxx_dm_regs[(di)->chip][i].subclass_id, \
>>> +     .block = bq27xxx_dm_regs[(di)->chip][i].offset / BQ27XXX_DM_SZ, \
>>> +}
>>> +
>>> +static inline u16* bq27xxx_dm_buf_ptr(struct bq27xxx_dm_buf *buf,
>>> +                                   struct bq27xxx_dm_reg *reg) {
>>> +     if (buf->class == reg->subclass_id
>>> +      && buf->block == reg->offset / BQ27XXX_DM_SZ)
>>> +             return (u16*) (buf->a + reg->offset % BQ27XXX_DM_SZ);
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +enum bq27xxx_dm_reg_id {
>>> +     BQ27XXX_DM_DESIGN_CAPACITY = 0,
>>> +     BQ27XXX_DM_DESIGN_ENERGY,
>>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>> +};
>>> +
>>> +static const char* bq27xxx_dm_reg_name[] = {
>>> +     [BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
>>> +     [BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
>>> +};
>>> +
>>> +static struct bq27xxx_dm_reg bq27421_dm_regs[] = { /* not tested */
>>> +     [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>> +     [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
>>> +};
>>> +
>>> +//static struct bq27xxx_dm_reg bq27621_dm_regs[] = { /* not tested */
>>> +//   [BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
>>> +//   [BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
>>> +//   [BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
>>> +//};
>>
>> I don't think this comment style is allowed.
> 
> This is a to-do item.
> 
>>> +
>>> +static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
>>> +     [BQ27421] = bq27421_dm_regs, /* and BQ27441 */
>>> +     [BQ27425] = bq27425_dm_regs,
>>> +//   [BQ27621] = bq27621_dm_regs,
>>> +};
>>
>> I know it is not tested, but lets not comment it out, I'll do a round of
>> testing for this part when this series is ready.
> 
> ID for 621 is not yet defined. We need an efficient way to add IDs.
> Perhaps via chip-id and group-id. Most current ID refs would be to
> group-id. I'd like to defer that, so we should only add inputs for the
> single-chip groups in this patchset: 500, 545, 425.
> 
> We must NOT set one-time program (OTP) memory, mentioned in 421 & 441
> docs. It's not clear whether documented data-memory ops change OTP.
> Can you ask? The 425 has rewritable NVM. The 621 docs don't say. All
> the above have cfgupdate mode, which the rest of the family lacks.
> 

This would be a good question for e2e[0].

[0] http://e2e.ti.com/support/power_management/battery_management/f/180
