From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Fri, 16 Jun 2017 04:32:13 -0700
Message-ID: <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net> <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com> <20170616103307.bfl6ig66qeq2qvz6@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:33498 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbdFPLcU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 07:32:20 -0400
Received: by mail-it0-f53.google.com with SMTP id g184so2415828ita.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2017 04:32:19 -0700 (PDT)
In-Reply-To: <20170616103307.bfl6ig66qeq2qvz6@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>

Hi Sebastian,


On Fri, Jun 16, 2017 at 3:33 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi Liam,
>
> On Fri, Jun 16, 2017 at 02:21:42AM -0700, Liam Breck wrote:
>> On Thu, Jun 15, 2017 at 9:02 AM, Sebastian Reichel
>> <sebastian.reichel@collabora.co.uk> wrote:
>> > On Wed, Jun 07, 2017 at 11:37:57AM -0700, Liam Breck wrote:
>> >>  static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>> >> -     { "bq27200", BQ27000 },
>> >> -     { "bq27210", BQ27010 },
>> >> -     { "bq27500", BQ2750X },
>> >> -     { "bq27510", BQ2751X },
>> >> -     { "bq27520", BQ2751X },
>> >> -     { "bq27500-1", BQ27500 },
>> >> -     { "bq27510g1", BQ27510G1 },
>> >> -     { "bq27510g2", BQ27510G2 },
>> >> -     { "bq27510g3", BQ27510G3 },
>> >> -     { "bq27520g1", BQ27520G1 },
>> >> -     { "bq27520g2", BQ27520G2 },
>> >> -     { "bq27520g3", BQ27520G3 },
>> >> -     { "bq27520g4", BQ27520G4 },
>> >> -     { "bq27530", BQ27530 },
>> >> -     { "bq27531", BQ27530 },
>> >> -     { "bq27541", BQ27541 },
>> >> -     { "bq27542", BQ27541 },
>> >> -     { "bq27546", BQ27541 },
>> >> -     { "bq27742", BQ27541 },
>> >> -     { "bq27545", BQ27545 },
>> >> -     { "bq27421", BQ27421 },
>> >> -     { "bq27425", BQ27421 },
>> >> -     { "bq27441", BQ27421 },
>> >> -     { "bq27621", BQ27421 },
>> >> +     /* dest.    di->real_chip       di->chip      */
>> >> +     { "bq27200",   (BQ27000   << 16) |  BQ27000   },
>> >> +     { "bq27210",   (BQ27010   << 16) |  BQ27010   },
>> >> +     { "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
>> >> +     { "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
>> >> +     { "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
>> >> +     { "bq27500-1", (BQ27500   << 16) |  BQ27500   },
>> >> +     { "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
>> >> +     { "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
>> >> +     { "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
>> >> +     { "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
>> >> +     { "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
>> >> +     { "bq27520g3", (BQ27520G3 << 16) |  BQ27520G3 },
>> >> +     { "bq27520g4", (BQ27520G4 << 16) |  BQ27520G4 },
>> >> +     { "bq27530",   (BQ27530   << 16) |  BQ27530   },
>> >> +     { "bq27531",   (BQ27531   << 16) |  BQ27530   },
>> >> +     { "bq27541",   (BQ27541   << 16) |  BQ27541   },
>> >> +     { "bq27542",   (BQ27542   << 16) |  BQ27541   },
>> >> +     { "bq27546",   (BQ27546   << 16) |  BQ27541   },
>> >> +     { "bq27742",   (BQ27742   << 16) |  BQ27541   },
>> >> +     { "bq27545",   (BQ27545   << 16) |  BQ27545   },
>> >> +     { "bq27421",   (BQ27421   << 16) |  BQ27421   },
>> >> +     { "bq27425",   (BQ27425   << 16) |  BQ27421   },
>> >> +     { "bq27441",   (BQ27441   << 16) |  BQ27421   },
>> >> +     { "bq27621",   (BQ27621   << 16) |  BQ27421   },
>> >
>> > This is ugly. The proper way to do this is by providing a pointer
>> > to a structure with all required information. E.g.:
>> >
>> > static const struct bq27xxx_pdata chip_info_bq27530 {
>> >     .reg_layout = &reg_info_bq27530,
>> >     .feature = false,
>> >     /* more stuff */
>> > };
>> >
>> > static const struct bq27xxx_pdata chip_info_bq27531 {
>> >     .reg_layout = &reg_info_bq27530,
>> >     .feature = true,
>> >     /* more stuff */
>> > };
>> >
>> > /* ... */
>> >
>> > static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>> > /* ... */
>> > { "bq27530", &chip_info_bq27530 },
>> > { "bq27531", &chip_info_bq27531 },
>> > /* ... */
>> > }
>>
>> How's this...
>>
>> static const struct bq27xxx_chip_ids[] = {
>>   [BQ27425] = { .chip = BQ27421, .real_chip = BQ27425 },
>>   ...
>> }
>>
>> static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>   { "bq27425", &bq27xxx_chip_ids[BQ27425] },
>> ...
>
> That's better, but let's get rid of real_chip. Just add the required
> information directly to the above struct (e.g. seal_key, ramtype).

I don't think the new chip data belongs in bq27*_i2c.c. All the
(extensive) existing chip data is in the main file.

A later patch could rework the chip data scheme; I was trying to
minimize changes in this one. The original i2c table did a real_chip
-> chip mapping. Now we're just carrying real_chip forward.

The easiest fix would be to define a macro which does << and |

{ "bq27621",   BQ27XXX_ID_PAIR(BQ27621, BQ27421) },
