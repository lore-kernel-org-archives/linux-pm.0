From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v7 8/9] power: bq27xxx_battery: Add print_dm() to log chip memory
Date: Wed, 22 Feb 2017 13:36:09 -0800
Message-ID: <CAKvHMgS-1+P2LcW=USftbLb-Bd84wHZ1YR5kZFe0jAZY9G91rA@mail.gmail.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-9-liam@networkimprov.net> <c8f3b791-abe8-6993-c760-92303f7e2867@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33257 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755204AbdBVVgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2017 16:36:15 -0500
Received: by mail-it0-f65.google.com with SMTP id e137so2275729itc.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2017 13:36:10 -0800 (PST)
In-Reply-To: <c8f3b791-abe8-6993-c760-92303f7e2867@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Wed, Feb 22, 2017 at 12:39 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 02/21/2017 03:30 PM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>
> Do you prefer kernel@ or liam@, you should probably pick one and use it
> uniformly.
>
> This patch is nice for debugging, but not upstreamable, it is full of
> checkpatch and formatting issues, it should probably just be dropped
> from this series.

Your hw developer customers will want this.

It's up to you whether every line of code in bq27xxx must fit the
format guidelines. I can adjust the format. Or leave it in commented
out?

>> Enable listing of chip RAM and/or NVM at startup, for debugging use.
>> Intially supports BQ27425 State NVM, subclass 82.
>> Support for other chips may be added.
>>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 51 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 8085d4a..bfb3aa9 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -664,6 +664,55 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
>>       return ret;
>>  }
>>
>> +/* Translate f4 floating point values to/from hexadecimal:
>> + *   perl -e 'printf("%08x\n", unpack("I", pack("f", 3.93e-4   )))' # 39ce0b91
>> + *   perl -e 'printf("%f\n"  , unpack("f", pack("I", 0x39ce0b91)))' # 0.000393
>> + */
>> +
>> +#define BQ27XXX_REG(f,o,v) dev_info(di->dev, "offset %d, " f "\n", o, v)
>> +
>> +static void bq27xxx_battery_print_dm(struct bq27xxx_device_info *di) {
>> +     enum { h1, h2, i2, u1, f4 };
>> +
>> +     struct dm_reg { int offset, type; }
>> +             /* each array row describes one data block */
>> +             c425_s82[][10] = {
>> +                     { { 2,h1},{ 3,i2},{ 5,h2},{12,i2},{14,i2},{18,i2},{22,i2},{29,u1},{30,i2},{99,0} },
>> +                     { {32,i2},{34,i2},{36,i2},{38,u1},{39,u1},{40,f4},{99,0} },
>> +             };
>> +             /* add more subclass maps here */
>> +
>> +     struct dm_class { int id, len; struct dm_reg (*reg)[10]; }
>> +             c425[] = {
>> +                     { .id = 82, .len = 2, .reg = c425_s82 },
>> +             };
>> +             /* add more chip maps here */
>> +
>> +     struct dm_class *chip = c425; /* set to your chip */
>> +
>> +     struct bq27xxx_dm_buf buf = { };
>> +     int c, b, r;
>> +     for (c=0; c < 1; ++c) {
>> +             buf.class = chip[c].id;
>> +             dev_info(di->dev, "subclass %d registers...\n", chip[c].id);
>> +             for (b=0; b < chip[c].len; ++b) {
>> +                     buf.block = b;
>> +                     bq27xxx_battery_read_dm_block(di, &buf);
>> +                     for (r=0; chip[c].reg[b][r].offset != 99; ++r) {
>> +                             int o = chip[c].reg[b][r].offset;
>> +                             u8* p = &buf.a[o % sizeof buf.a];
>> +                             switch (chip[c].reg[b][r].type) {
>> +                             case h1: BQ27XXX_REG("%02x", o,      *p); break;
>> +                             case h2: BQ27XXX_REG("%04x", o,      be16_to_cpup((u16*)p)); break;
>> +                             case i2: BQ27XXX_REG("%d",   o, (s16)be16_to_cpup((u16*)p)); break;
>> +                             case u1: BQ27XXX_REG("%u",   o,      *p); break;
>> +                             case f4: BQ27XXX_REG("%08x", o,      be32_to_cpup((u32*)p)); break;
>> +                             }
>> +                     }
>> +             }
>> +     }
>> +}
>> +
>>  static void bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
>>  {
>>       struct bq27xxx_dm_reg *reg = bq27xxx_dm_regs[di->chip];
>> @@ -683,6 +732,8 @@ static void bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
>>               else
>>                       dev_warn(di->dev, "unsupported config register %s\n", str);
>>       }
>> +     /* bq27xxx_battery_print_dm(di); uncomment for debugging */
>> +     (void)bq27xxx_battery_print_dm; /* prevent compiler warning */
>>  }
>>
>>  static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
>>
