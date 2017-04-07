From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.4 6/10] power: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Fri, 7 Apr 2017 11:58:12 -0700
Message-ID: <CAKvHMgT6bqtg464r80k0wuR3nWLvZfjrpCGOcgTP+TLBhuYdXA@mail.gmail.com>
References: <20170404085706.32592-1-liam@networkimprov.net>
 <20170404085706.32592-4-liam@networkimprov.net> <54023de5-fd59-777b-36b4-d49a1deb98cc@ti.com>
 <CAKvHMgRX9_WzqHuoK3Qs7xQDbsYiCRJokwkP3k5zpiiiFg15Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36636 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbdDGS6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 14:58:13 -0400
Received: by mail-io0-f194.google.com with SMTP id 68so8349113ioh.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2017 11:58:13 -0700 (PDT)
In-Reply-To: <CAKvHMgRX9_WzqHuoK3Qs7xQDbsYiCRJokwkP3k5zpiiiFg15Mw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org

On Thu, Apr 6, 2017 at 11:23 AM, Liam Breck <liam@networkimprov.net> wrote:
> On Thu, Apr 6, 2017 at 7:30 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 04/04/2017 03:57 AM, Liam Breck wrote:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Previously there was no way to configure these chips in the event that the
>>> defaults didn't match the battery in question.
>>>
>>> We now call power_supply_get_battery_info(), check its values, and write
>>> battery data to chip data memory (flash/RAM/NVM).
>>>
>>
>> I'm almost convinced now this is *not* the correct thing to do, we
>> should not be writing to NVM. If the DT states different values than in
>> the device we need to trust the device. DT is static for a board, the
>> battery data may not be.
>>
>> At most we could have an override flag as a driver param that causes us
>> to ignore NVM and use the DT values, but always overwriting the device's
>> NVM with the DT values is not what most want.
>
> Reprising my previous response, with addenda...
>
> We trust the distro/device kernel package to contain correct config
> for RAM-only chips, but not NVM? A battery config would not be set in
> mainline dts files, unless a battery is soldered to the board, or
> similar. I will note this in our DT binding.
>
> Re DT provisioning... Device makers and distros are extremely careful
> about what they put into DTs and what dtbs are included with a kernel
> package. They know that a misconfigured DT is a showstopper, and could
> be catastrophic. I've seen the latter -- a guru-level kernel
> maintainer whom I work with set a DT voltage level wrong on a
> prototype and fried its eMMC chip. If the DT has a gauge config, the
> default assumption is that it's correct.
>
> It is wrong to force distros and device makers to include
> /etc/modprobe.d/xyz.conf to fully configure the hardware.
>
> However we should indeed let users override the DT config with a
> module param. How about use-on-chip-config=1, type bool?

I came up with...

static bool bq27xxx_dt_battery = true;
module_param_named(use_dt_battery, bq27xxx_dt_battery, bool, S_IRUGO);
MODULE_PARM_DESC(use_dt_battery,
 "Use devicetree monitored-battery config if present. Default is 1/Y.");

After we check for DT monitored-battery, we test bq27xxx_dt_battery,
and if false, emit a warning that we are skipping the DT config.
