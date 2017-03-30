From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v12.2 0/5] bq27xxx_battery partial series
Date: Thu, 30 Mar 2017 07:39:49 -0500
Message-ID: <8b13168b-845e-7ca2-b763-ef61f4f6b81d@ti.com>
References: <20170330090216.12381-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:15686 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbdC3Mj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 08:39:57 -0400
In-Reply-To: <20170330090216.12381-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, linux-pm@vger.kernel.org

On 03/30/2017 04:02 AM, Liam Breck wrote:
> Changes in this rev:
> 
> Removed macro for if (...) dev_dbg(...) from I/O helper functions.
> 
> Moved update_dm_block() to patch "Add power_supply_battery_info support".
> No more refactoring please; it's not really improving the code itself :-)
> 

Thats a big no can do :), refactoring is important for patch review,
each patch needs to be a single logical change that stands on its own. I
hate refactoring as much as the next guy, but no one said working on
Linux would be easy!

> set_cfgupdate is required for DM write on certain chips, see this Q&A
> https://e2e.ti.com/support/power_management/battery_management/f/180/p/577798/2121489#2121489
> 

So lets add the functionality for those chips in a separate patch. I
don't like the way you did set_cfgupdate() so lets not block a patch I
do like (read/write_block) by including that change in it.

> Renamed dm_buf .full => .has_data, .updt => .dirty
> dm_buf has 3 states: !has_data, has_data && !dirty, has_data && dirty
> I considered a single field and enum values, but I think this is clearer.
> 
> Renamed set_cfgupdate(..., u16 flag => state)
> We call set_cfgupdate(di, BQ27XXX_FLAG_CFGUP or 0)
> We !!state to print the intended flag state in error msg.
> 

Just print that it is a flag, or map from state to string. Personally I
would just put that in a debug print and not worry if it is pretty.

> 
>   power: bq27xxx_battery: Add bulk transfer bus methods
>   power: bq27xxx_battery: Add chip data memory read/write support
>   power: bq27xxx_battery: Add power_supply_battery_info support
>   power: bq27xxx_battery: Enable chip data memory update for certain chips
>   power: bq27xxx_battery: Remove duplicate register arrays
> 
>  drivers/power/supply/bq27xxx_battery.c     | 700 +++++++++++++++++++++++------
>  drivers/power/supply/bq27xxx_battery_i2c.c |  98 +++-
>  include/linux/power/bq27xxx_battery.h      |  26 +-
>  3 files changed, 682 insertions(+), 142 deletions(-)
> 
