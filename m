From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v6 7/8] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Fri, 17 Feb 2017 11:56:42 -0800
Message-ID: <CAKvHMgQZuC02udrqcLs_GYoJoOLTVojhbra3k5T5=QYuc9j_bA@mail.gmail.com>
References: <20170211024340.19491-1-liam@networkimprov.net>
 <20170211024340.19491-8-liam@networkimprov.net> <CAKvHMgQQ16+Xcffz8hE8oRPFhPMq7xtPDDXCP5mnJnh8ma7aDg@mail.gmail.com>
 <CAKvHMgRCJqD9PaB3n7tEFz-anb-r+4cmUayjkRjOvt4UVvSY1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35218 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934855AbdBQUDJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 15:03:09 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so4545380ith.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 12:03:09 -0800 (PST)
In-Reply-To: <CAKvHMgRCJqD9PaB3n7tEFz-anb-r+4cmUayjkRjOvt4UVvSY1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

On Wed, Feb 15, 2017 at 11:45 AM, Liam Breck <liam@networkimprov.net> wrote:
> On Sun, Feb 12, 2017 at 6:32 PM, Liam Breck <liam@networkimprov.net> wrote:
>> Hi Andrew,
>>
>> Based on Sebastian's feedback on v1-4 of this patchset, I believe it
>> will go upstream. (He hasn't written anything on linux-pm since before
>> I posted v5 a week ago.)
>>
>> Could we get your feedback on making this adaptable to the rest of the
>> BQ27 family? Specifically...
>>
>> Is the op sequence in these functions common across the chips?
>>
>> bq27xxx_battery_set_seal_state()
>> bq27xxx_battery_read_dm_block()
>> bq27xxx_battery_write_dm_block()
>>
>> Should we move these constants to bq27xxx_regs[chip][name]?
>>
>> /* writable registers */
>> #define BQ27XXX_DATA_CLASS             0x3E
>> #define BQ27XXX_DATA_BLOCK             0x3F
>> #define BQ27XXX_BLOCK_DATA             0x40
>> #define BQ27XXX_BLOCK_DATA_CHECKSUM    0x60
>> #define BQ27XXX_BLOCK_DATA_CONTROL     0x61
>>
>> /* writable register inputs */
>> #define BQ27XXX_SET_CFGUPDATE          0x13
>> #define BQ27XXX_SOFT_RESET             0x42
>> #define BQ27XXX_SUBCLASS_STATE_NVM     82
>
> I dug into bqtool:gauge.c. I learned a couple things which I've added
> to the patch, e.g. retrieve and compare checksum after read_dm_block.
>
> Re command ids and params, only subclass, field offsets, and unseal
> key differ among chips, which I planned for. However the driver's
> current 9 enumerated chips won't accommodate all the diff unseal keys.
> But I shall leave that for others to solve.
>
> Re op sequence, bqtool apparently uses set_cfgupdate for the 441 & 621
> chips, but not others, whereas the 425 manual implies that it's nec.
> And bqtool uses exit_cfgupdate where 425 manual indicates soft_reset.
> See open/close_dm_rom (441 & 621) vs. open/close_dm_flash. We need
> some guidance on that issue.

I checked datasheets for one chip in each family defined in bqtool,
and all chips in the 421-621 & 425 families. Only the latter 2
families use set_cfgupdate & soft_reset. I've rev'd patch accordingly;
will post this evening.

http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line732

Bqtool may have a bug on 425 since it doesn't set_cfgupdate in that
case, which the manual says is required.
