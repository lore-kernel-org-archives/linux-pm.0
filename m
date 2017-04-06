From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.4 6/10] power: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Thu, 6 Apr 2017 11:23:14 -0700
Message-ID: <CAKvHMgRX9_WzqHuoK3Qs7xQDbsYiCRJokwkP3k5zpiiiFg15Mw@mail.gmail.com>
References: <20170404085706.32592-1-liam@networkimprov.net>
 <20170404085706.32592-4-liam@networkimprov.net> <54023de5-fd59-777b-36b4-d49a1deb98cc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36669 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbdDFSXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2017 14:23:15 -0400
Received: by mail-it0-f66.google.com with SMTP id a140so5228441ita.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2017 11:23:15 -0700 (PDT)
In-Reply-To: <54023de5-fd59-777b-36b4-d49a1deb98cc@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org

On Thu, Apr 6, 2017 at 7:30 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 04/04/2017 03:57 AM, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Previously there was no way to configure these chips in the event that the
>> defaults didn't match the battery in question.
>>
>> We now call power_supply_get_battery_info(), check its values, and write
>> battery data to chip data memory (flash/RAM/NVM).
>>
>
> I'm almost convinced now this is *not* the correct thing to do, we
> should not be writing to NVM. If the DT states different values than in
> the device we need to trust the device. DT is static for a board, the
> battery data may not be.
>
> At most we could have an override flag as a driver param that causes us
> to ignore NVM and use the DT values, but always overwriting the device's
> NVM with the DT values is not what most want.

Reprising my previous response, with addenda...

We trust the distro/device kernel package to contain correct config
for RAM-only chips, but not NVM? A battery config would not be set in
mainline dts files, unless a battery is soldered to the board, or
similar. I will note this in our DT binding.

Re DT provisioning... Device makers and distros are extremely careful
about what they put into DTs and what dtbs are included with a kernel
package. They know that a misconfigured DT is a showstopper, and could
be catastrophic. I've seen the latter -- a guru-level kernel
maintainer whom I work with set a DT voltage level wrong on a
prototype and fried its eMMC chip. If the DT has a gauge config, the
default assumption is that it's correct.

It is wrong to force distros and device makers to include
/etc/modprobe.d/xyz.conf to fully configure the hardware.

However we should indeed let users override the DT config with a
module param. How about use-on-chip-config=1, type bool?




>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 172 ++++++++++++++++++++++++++++++++-
>>  include/linux/power/bq27xxx_battery.h  |   1 +
>>  2 files changed, 172 insertions(+), 1 deletion(-)
