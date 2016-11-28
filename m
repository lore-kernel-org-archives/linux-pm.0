From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Fix register map for
 BQ27510 and BQ27520
Date: Mon, 28 Nov 2016 11:13:19 -0600
Message-ID: <792c4722-9f32-3fda-85b2-6c8320111151@ti.com>
References: <20161104183313.2767-1-afd@ti.com>
 <20161123230832.anbbhmllij4bxpsh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:51608 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbcK1RNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 12:13:23 -0500
In-Reply-To: <20161123230832.anbbhmllij4bxpsh@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/23/2016 05:08 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 04, 2016 at 01:33:13PM -0500, Andrew F. Davis wrote:
>> The BQ27510 and BQ27520 use a slightly different register map than the
>> BQ27500, add a new type enum and add these gauges to it.
>>
>> Fixes: d74534c27775 ("power: bq27xxx_battery: Add support for additional bq27xxx family devices")
>> Based-on-patch-by: Kenneth R. Crudup <kenny@panix.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c     | 41 +++++++++++++++++++++++++++++-
>>  drivers/power/supply/bq27xxx_battery_i2c.c |  4 +--
>>  include/linux/power/bq27xxx_battery.h      |  3 ++-
>>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> Queued into for-next. I think pali's hint, that bq27xxx_battery_overtemp()
> should be implemented using a switch-case is valid to make the code more
> readable. Please provide this change as follow-up patch.
> 

I think there may be better ways than even switch-case, perhaps we can
add additional info flags to the part's description tables, then just
branch on that for each accessor type.

Anyway, I'll see what I can to to clean this up when I get some bandwidth.

Thanks,
Andrew
