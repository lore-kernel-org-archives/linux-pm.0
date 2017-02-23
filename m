From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v7 8/9] power: bq27xxx_battery: Add print_dm() to log chip
 memory
Date: Wed, 22 Feb 2017 18:34:04 -0600
Message-ID: <e754b311-0870-2661-bfc1-89b4dff6ee04@ti.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-9-liam@networkimprov.net>
 <c8f3b791-abe8-6993-c760-92303f7e2867@ti.com>
 <CAKvHMgS-1+P2LcW=USftbLb-Bd84wHZ1YR5kZFe0jAZY9G91rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:57301 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbdBWAeK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2017 19:34:10 -0500
In-Reply-To: <CAKvHMgS-1+P2LcW=USftbLb-Bd84wHZ1YR5kZFe0jAZY9G91rA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On 02/22/2017 03:36 PM, Liam Breck wrote:
> On Wed, Feb 22, 2017 at 12:39 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 02/21/2017 03:30 PM, Liam Breck wrote:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>
>> Do you prefer kernel@ or liam@, you should probably pick one and use it
>> uniformly.
>>
>> This patch is nice for debugging, but not upstreamable, it is full of
>> checkpatch and formatting issues, it should probably just be dropped
>> from this series.
> 
> Your hw developer customers will want this.
> 

The kernel is not for hw developers, we have our evil vendor trees for
this stuff. That said, I have no problem with this here, but all the
print outs should at least dev_debug.

> It's up to you whether every line of code in bq27xxx must fit the
> format guidelines. I can adjust the format. Or leave it in commented
> out?
> 

It's not really up to me, Sebastian has the real final call, I would
just cleanup the format.

>>> Enable listing of chip RAM and/or NVM at startup, for debugging use.
>>> Intially supports BQ27425 State NVM, subclass 82.
>>> Support for other chips may be added.
>>>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  drivers/power/supply/bq27xxx_battery.c | 51 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>> index 8085d4a..bfb3aa9 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -664,6 +664,55 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
>>>       return ret;
>>>  }
>>>
>>> +/* Translate f4 floating point values to/from hexadecimal:
>>> + *   perl -e 'printf("%08x\n", unpack("I", pack("f", 3.93e-4   )))' # 39ce0b91
>>> + *   perl -e 'printf("%f\n"  , unpack("f", pack("I", 0x39ce0b91)))' # 0.000393
>>> + */
>>> +
>>> +#define BQ27XXX_REG(f,o,v) dev_info(di->dev, "offset %d, " f "\n", o, v)
>>> +
>>> +static void bq27xxx_battery_print_dm(struct bq27xxx_device_info *di) {
>>> +     enum { h1, h2, i2, u1, f4 };
>>> +
>>> +     struct dm_reg { int offset, type; }
>>> +             /* each array row describes one data block */
>>> +             c425_s82[][10] = {
>>> +                     { { 2,h1},{ 3,i2},{ 5,h2},{12,i2},{14,i2},{18,i2},{22,i2},{29,u1},{30,i2},{99,0} },
>>> +                     { {32,i2},{34,i2},{36,i2},{38,u1},{39,u1},{40,f4},{99,0} },
>>> +             };
>>> +             /* add more subclass maps here */
>>> +
>>> +     struct dm_class { int id, len; struct dm_reg (*reg)[10]; }
>>> +             c425[] = {
>>> +                     { .id = 82, .len = 2, .reg = c425_s82 },
>>> +             };
>>> +             /* add more chip maps here */
>>> +
>>> +     struct dm_class *chip = c425; /* set to your chip */
>>> +
>>> +     struct bq27xxx_dm_buf buf = { };
>>> +     int c, b, r;
>>> +     for (c=0; c < 1; ++c) {
>>> +             buf.class = chip[c].id;
>>> +             dev_info(di->dev, "subclass %d registers...\n", chip[c].id);
>>> +             for (b=0; b < chip[c].len; ++b) {
>>> +                     buf.block = b;
>>> +                     bq27xxx_battery_read_dm_block(di, &buf);
>>> +                     for (r=0; chip[c].reg[b][r].offset != 99; ++r) {
>>> +                             int o = chip[c].reg[b][r].offset;
>>> +                             u8* p = &buf.a[o % sizeof buf.a];
>>> +                             switch (chip[c].reg[b][r].type) {
>>> +                             case h1: BQ27XXX_REG("%02x", o,      *p); break;
>>> +                             case h2: BQ27XXX_REG("%04x", o,      be16_to_cpup((u16*)p)); break;
>>> +                             case i2: BQ27XXX_REG("%d",   o, (s16)be16_to_cpup((u16*)p)); break;
>>> +                             case u1: BQ27XXX_REG("%u",   o,      *p); break;
>>> +                             case f4: BQ27XXX_REG("%08x", o,      be32_to_cpup((u32*)p)); break;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     }
>>> +}
>>> +
>>>  static void bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
>>>  {
>>>       struct bq27xxx_dm_reg *reg = bq27xxx_dm_regs[di->chip];
>>> @@ -683,6 +732,8 @@ static void bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
>>>               else
>>>                       dev_warn(di->dev, "unsupported config register %s\n", str);
>>>       }
>>> +     /* bq27xxx_battery_print_dm(di); uncomment for debugging */
>>> +     (void)bq27xxx_battery_print_dm; /* prevent compiler warning */
>>>  }
>>>
>>>  static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
>>>
