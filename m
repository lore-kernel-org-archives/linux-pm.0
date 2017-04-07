From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.4 6/10] power: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Fri, 7 Apr 2017 12:56:23 -0700
Message-ID: <CAKvHMgSC0WvFHE82X_ax_mwXtXqSm5KBn+VC0i3NPgZqa1=-HQ@mail.gmail.com>
References: <20170404085706.32592-1-liam@networkimprov.net>
 <20170404085706.32592-4-liam@networkimprov.net> <54023de5-fd59-777b-36b4-d49a1deb98cc@ti.com>
 <CAKvHMgRX9_WzqHuoK3Qs7xQDbsYiCRJokwkP3k5zpiiiFg15Mw@mail.gmail.com>
 <CAKvHMgT6bqtg464r80k0wuR3nWLvZfjrpCGOcgTP+TLBhuYdXA@mail.gmail.com> <c37f430f-12bd-e84e-66fe-2a9eb7c76339@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34594 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932813AbdDGT4Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 15:56:24 -0400
Received: by mail-it0-f66.google.com with SMTP id 193so6673itm.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2017 12:56:24 -0700 (PDT)
In-Reply-To: <c37f430f-12bd-e84e-66fe-2a9eb7c76339@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org

On Fri, Apr 7, 2017 at 12:19 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 04/07/2017 01:58 PM, Liam Breck wrote:
>> On Thu, Apr 6, 2017 at 11:23 AM, Liam Breck <liam@networkimprov.net> wrote:
>>> On Thu, Apr 6, 2017 at 7:30 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 04/04/2017 03:57 AM, Liam Breck wrote:
>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> Previously there was no way to configure these chips in the event that the
>>>>> defaults didn't match the battery in question.
>>>>>
>>>>> We now call power_supply_get_battery_info(), check its values, and write
>>>>> battery data to chip data memory (flash/RAM/NVM).
>>>>>
>>>>
>>>> I'm almost convinced now this is *not* the correct thing to do, we
>>>> should not be writing to NVM. If the DT states different values than in
>>>> the device we need to trust the device. DT is static for a board, the
>>>> battery data may not be.
>>>>
>>>> At most we could have an override flag as a driver param that causes us
>>>> to ignore NVM and use the DT values, but always overwriting the device's
>>>> NVM with the DT values is not what most want.
>>>
>>> Reprising my previous response, with addenda...
>>>
>>> We trust the distro/device kernel package to contain correct config
>>> for RAM-only chips, but not NVM? A battery config would not be set in
>>> mainline dts files, unless a battery is soldered to the board, or
>>> similar. I will note this in our DT binding.
>>>
>
> DT is for hardware descriptions, in cases where the hardware cannot be
> automatically detected. If we find we can get the battery info from the
> battery gauge why would we not only ignore it, but go and overwrite it
> with the info from DT? This is backwards.

Can this driver manage gauges packaged in batteries? I thought it
could only see those wired onto main boards. I agree we should not
update battery-packaged gauges by default. Is it possible to tell the
difference?

On the other hand, no gauge can detect battery characteristics by its
own circuitry. It has to be programmed by human hands. A dtb + this
patch makes a tool for those hands.

And you don't trust device vendors? If a vendor records DT properties
for a gauge, it's specifically because the gauge-resident config isn't
correct.

>>> Re DT provisioning... Device makers and distros are extremely careful
>>> about what they put into DTs and what dtbs are included with a kernel
>>> package. They know that a misconfigured DT is a showstopper, and could
>>> be catastrophic. I've seen the latter -- a guru-level kernel
>>> maintainer whom I work with set a DT voltage level wrong on a
>>> prototype and fried its eMMC chip. If the DT has a gauge config, the
>>> default assumption is that it's correct.
>>>
>
> And if that eMMC chip could communicate its requested voltage we would
> not need to describe it in DT, and we certainly would not say "sorry
> eMMC, you requested 3v but DT says you need 33v, so thats what you're
> getting".

>>> It is wrong to force distros and device makers to include
>>> /etc/modprobe.d/xyz.conf to fully configure the hardware.
>>>
>
> It's either that or add a driver sysfs entry, we don't configure
> hardware in DT, thats rule #1. You got an ack for a binding that

Setting regulator voltage levels is not "configuring hardware"?

> describes a "simple-battery"(one that cannot self report), you are
> misusing this binding as input configuration data to feed to batteries
> that *can* report their configuration.

>>> However we should indeed let users override the DT config with a
>>> module param. How about use-on-chip-config=1, type bool?
>>
>
> If we do add a param it needs to be default "off". It should not update
> saved battery data on the chip in either case, that needs to be a
> manually triggered through sysfs or similar.
>
>> I came up with...
>>
>> static bool bq27xxx_dt_battery = true;
>> module_param_named(use_dt_battery, bq27xxx_dt_battery, bool, S_IRUGO);
>> MODULE_PARM_DESC(use_dt_battery,
>>  "Use devicetree monitored-battery config if present. Default is 1/Y.");
>>
>> After we check for DT monitored-battery, we test bq27xxx_dt_battery,
>> and if false, emit a warning that we are skipping the DT config.
>>
