From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: suspended DRAM bridge
Date: Tue, 02 Apr 2013 00:03:22 +0200
Message-ID: <515A042A.6010005@fold.natur.cuni.cz>
References: <5159BAC9.80700@fold.natur.cuni.cz> <35938665.ZFvDxnCU3l@vostro.rjw.lan> <5159F775.30805@fold.natur.cuni.cz> <1461283.gKidiaRK7T@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:46471 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758443Ab3DAWD0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 18:03:26 -0400
In-Reply-To: <1461283.gKidiaRK7T@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Rafael J. Wysocki wrote:
> On Monday, April 01, 2013 11:09:09 PM Martin Mokrejs wrote:
>> Hi Rafael,
>>
>> Rafael J. Wysocki wrote:
>>> On Monday, April 01, 2013 06:50:17 PM Martin Mokrejs wrote:
>>>> Hi Rafael,
>>>>   I have a simple question. Why seems my DRAM controller suspended?
>>>
>>> I suppose that runtime PM is disabled for that device and therefore
>>> runtime_status is meaningless.
>>
>> But I really mean this pair of values:
>>
>> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
>>
>> /sys/bus/pci/devices/0000:00:00.0/power/control:auto
>>
>>
>>>
>>> And really, that attribute is for *debugging* things by developers who know
>>> what they are looking for and not for random poking.
>>
>> Well, if me or you are to figure out why laptop-mode-tools make my life
>> even more miserable with hotplug issues the requests to provide
>>
>> grep . /sys/bus/pci/devices/*/power/runtime_status
>> grep . /sys/bus/pci/devices/*/power/control
>>
>> provide crap. How can I infer something if I cannot trust the values?
> 
> The phrase "trust the values" above doesn't make sense.  You need to know what
> the values are supposed to *mean* in the first place, which you evidently
> don't.
> 
> And what they mean is:
> 
> /sys/devices/.../power/runtime_status - the current value of the device's
> runtime_status attribute at the moment.  [Notice that you need to know the code
> in question to know the meaning of that attribute.]  That field always has
> certain value, even though it may not make sense *to* *you*.

That's why I asked what 'suspended' means in case of a DRAM bridge (of the only
bridge in a working laptop). ;-)

> 
> /sys/devices/.../power/control - "on" means that user space doesn't allow the
> device to be runtime-suspended, while "auto" meanse that it *does* allow that
> to happen.  Nothing more or less than that.
> 
> In particular, "auto" doesn't need to mean that the device will be
> runtime-suspended at all and the value of runtime_status requires
> interpretation.

But your conclusion was that 
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
does NOT mean it is actually suspended otherwise the laptop would not work.

> 
> That's how it goes.

I did realize that control:'auto' does NOT immediately mean runtime_status:'suspended',
don't worry. I posted above a pair of values for 0000:00:00.0 and your explanation
seemed that 
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
and
/sys/bus/pci/devices/0000:00:00.0/power/control:auto

does not say the truth (that the device is actually suspended).


But if I sent you /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
then what for do you need /sys/bus/pci/devices/0000:00:00.0/power/control ?
And even, if I sent /sys/bus/pci/devices/0000:00:00.0/power/control:auto.

> 
> Now, if you want me (or anyone else on this list) to help you, why don't you
> test 3.9-rc5 with the patch at https://patchwork.kernel.org/patch/2368081/
> applied and send *one* message describing *briefly* what *does* *not* *work*
> for you, without attaching any logs, lspci outputs and so on just yet?

You just asked, ok, will do.

> 
> Then, we can try to address the problems you have in 3.9-rc5 and go back to the
> (still supported) 'stable' kernels from there.
> 
> Does that sound like a workable plan?

Sure.

Martin
