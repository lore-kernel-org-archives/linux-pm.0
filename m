From: Rob Herring <robherring2@gmail.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Mon, 01 Apr 2013 14:46:07 -0500
Message-ID: <5159E3FF.4050308@gmail.com>
References: <5152503C.2050503@gmail.com> <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com> <20130327133220.GA30868@kahuna> <5153207A.4050109@gmail.com> <20130327170221.GA32231@kahuna> <87d2uk91ai.fsf@linaro.org> <20130327175621.GA32693@kahuna> <alpine.DEB.2.00.1303302156180.6436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:59495 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419Ab3DATqL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 15:46:11 -0400
Received: by mail-ve0-f175.google.com with SMTP id pb11so2934035veb.20
        for <linux-pm@vger.kernel.org>; Mon, 01 Apr 2013 12:46:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303302156180.6436@utopia.booyaka.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 03/30/2013 05:21 PM, Paul Walmsley wrote:
> Hi folks,
> 
> On Wed, 27 Mar 2013, Nishanth Menon wrote:
> 
>> On 10:53-20130327, Kevin Hilman wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>> On 11:38-20130327, Rob Herring wrote:
>>>>> On 03/27/2013 08:32 AM, Nishanth Menon wrote:
>>>>>> On 02:23-20130327, Paul Walmsley wrote:
>>>>>>> On Tue, 26 Mar 2013, Rob Herring wrote:
>>>>>>>>
>>>>>>>> Converting the driver to a platform driver would be another option.
>>>
>>> I think the platform_device conversion is the way to go.  I think you
>>> should do that instead of PATCH 8/8 of your OMAP conversion to the
>>> generic driver[1].
>>
>> Yep, thinking about this over lunch, I came to the same conclusion that
>> instead of checking on DT node existance, platform_device conversion
>> will solve both parts of the puzzle.
> 
> Looked at this a little today.  I see that the platform_driver CPUFreq 
> driver approach was taken with several SoCs in mainline. Could someone 
> explain the theory behind making the CPUFreq drivers platform_drivers, 
> rather than just modules?
> 
> The part that doesn't make sense to me is that the existing CPUFreq 
> drivers don't represent an actual hardware block.  Conceptually, they 
> aren't drivers for the CPU, nor are they drivers for a CPU frequency 
> scaling IP block.  One might as well bind a CPUIdle driver or a CPU 
> throttling thermal driver to the CPU device.

It's not really a cpu device, but rather a virtual device. We could have
multiple devices. cpuidle drivers have the same issue.

> Wouldn't it be best to just make them modules?

Then module auto loading doesn't work AFAIK. We will want them to be
built as modules in multi-platform kernels to reduce the kernel size,
but you don't want to just shift the problem to the OS to decide what
modules a given platform needs.

> Also, noticed that the Highbank CPUFreq driver creates a virtual device in 
> its code.  That also doesn't seem right.  Isn't device creation better 
> left to DT/ACPI/whatever?

DT describes the h/w. Creating DT nodes that match the cpufreq drivers
is not describing the h/w, but what Linux wants currently. Cpufreq
drivers either touch parts of multiple h/w blocks, a single shared h/w
block or don't touch h/w directly. The cpufreq-cpu0 driver is the last
case and does use DT. Perhaps we will get to the point that all
low-level interfaces are abstracted and we can have a single cpufreq driver.

I think platform drivers are the right way to go, but I'd like to come
up with a better way to instantiate the devices. The only idea I've come
up with is to do some sort of automatic device creation based machine
compatible property matching.

Rob
