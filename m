From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.2 0/5] bq27xxx_battery partial series
Date: Thu, 30 Mar 2017 12:45:49 -0700
Message-ID: <CAKvHMgRE7tx3QNYT9k3n9+Wpcb9Eskp7H6WOriJ7drbBz1TuYA@mail.gmail.com>
References: <20170330090216.12381-1-liam@networkimprov.net> <8b13168b-845e-7ca2-b763-ef61f4f6b81d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36646 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933661AbdC3Tpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 15:45:51 -0400
Received: by mail-io0-f194.google.com with SMTP id 68so3988917ioh.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 12:45:50 -0700 (PDT)
In-Reply-To: <8b13168b-845e-7ca2-b763-ef61f4f6b81d@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org

On Thu, Mar 30, 2017 at 5:39 AM, Andrew F. Davis <afd@ti.com> wrote:
>
> On 03/30/2017 04:02 AM, Liam Breck wrote:
> > Changes in this rev:
> >
> > Removed macro for if (...) dev_dbg(...) from I/O helper functions.
> >
> > Moved update_dm_block() to patch "Add power_supply_battery_info support".
> > No more refactoring please; it's not really improving the code itself :-)
> >
>
> Thats a big no can do :), refactoring is important for patch review,
> each patch needs to be a single logical change that stands on its own. I
> hate refactoring as much as the next guy, but no one said working on
> Linux would be easy!

In the past two years 3 other patchsets on linux-pm have reached 14
versions (where we are counting partial series). One of those is a new
kernel framework. You suggested one additional patch in your fixup
pass, and I did that. It's enough.

> > set_cfgupdate is required for DM write on certain chips, see this Q&A
> > https://e2e.ti.com/support/power_management/battery_management/f/180/p/577798/2121489#2121489
> >
>
> So lets add the functionality for those chips in a separate patch. I
> don't like the way you did set_cfgupdate() so lets not block a patch I
> do like (read/write_block) by including that change in it.

The chips that most need this patchset are the RAM-only ones; they all
require set_cfgupdate. Our hardware has such a chip. I have spent
considerable time making this code compatible with any bq27 part. I
can't donate more time to chips I can't test. set_cfgupdate is
implemented correctly. It doesn't help anyone to patch it separately.

> > Renamed dm_buf .full => .has_data, .updt => .dirty
> > dm_buf has 3 states: !has_data, has_data && !dirty, has_data && dirty
> > I considered a single field and enum values, but I think this is clearer.
> >
> > Renamed set_cfgupdate(..., u16 flag => state)
> > We call set_cfgupdate(di, BQ27XXX_FLAG_CFGUP or 0)
> > We !!state to print the intended flag state in error msg.
> >
>
> Just print that it is a flag, or map from state to string. Personally I
> would just put that in a debug print and not worry if it is pretty.

One msg flags an error condition; it's not a dev_dbg case. We need to
print the expected flag value, anything else is confusing.

> >   power: bq27xxx_battery: Add bulk transfer bus methods
> >   power: bq27xxx_battery: Add chip data memory read/write support
> >   power: bq27xxx_battery: Add power_supply_battery_info support
> >   power: bq27xxx_battery: Enable chip data memory update for certain chips
> >   power: bq27xxx_battery: Remove duplicate register arrays
> >
> >  drivers/power/supply/bq27xxx_battery.c     | 700 +++++++++++++++++++++++------
> >  drivers/power/supply/bq27xxx_battery_i2c.c |  98 +++-
> >  include/linux/power/bq27xxx_battery.h      |  26 +-
> >  3 files changed, 682 insertions(+), 142 deletions(-)
> >
