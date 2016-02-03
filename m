From: Mason <slash.tmp@free.fr>
Subject: Re: Plain DFS (no voltage scaling)
Date: Wed, 3 Feb 2016 19:19:12 +0100
Message-ID: <56B244A0.60309@free.fr>
References: <56B11B67.3090600@free.fr> <56B217C9.1050405@free.fr>
 <20160203161331.GI3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:20965 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965637AbcBCSTV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Feb 2016 13:19:21 -0500
In-Reply-To: <20160203161331.GI3469@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 03/02/2016 17:13, Viresh Kumar wrote:
> On 03-02-16, 16:07, Mason wrote:
>> On 02/02/2016 22:11, Mason wrote:
>>
>>> I plan to enable the on-demand governor on the tango platform:
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi
>>>
>>> I found the cpufreq-dt binding doc:
>>>
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt
>>>
>>> Something is not clear to me:
>>>
>>> If my platform cannot scale the voltage, what information
>>> should I put in the voltage part of the DT?
>>
>> Someone pointed out that tweaking the frequency without tweaking
>> the voltage might be counter-productive.
>>
>> I measured the power consumption of the entire board (at the power outlet)
>> for 3 CPU frequencies (all other things being equal, I hope).
>>
>> idle @ 111 MHz = 4.6 W
>> idle @ 333 MHz = 4.6 W
>> idle @ 999 MHz = 4.6 W
>>
>> load @ 111 MHz = 5.0 W
>> load @ 333 MHz = 5.7 W
>> load @ 999 MHz = 7.7 W
>>
>> When idle, the kernel calls WFI, which "turns off" most of the CPU
>> (clock gating?) such that the actual frequency does not matter.
>>
>> At full load (I use cpuburn to jog as many FUs simultaneously as
>> possible) it looks like each additional MHz requires ~3 mW.
>>
>> So it would appear that an on-demand governor might not help to
>> save power.
> 
> Why do you say so ?

Here's my (possibly incorrect) reasoning:

If the CPU is idle, kernel calls WFI and frequency apparently
doesn't matter.

If the CPU has work to do, the on-demand governor will bump the
frequency to the max (I think).

I don't think the CPU spends a lot of time in the intermediate
frequencies (neither max nor min).

But maybe my logic is flawed?

Also, some users (of our older kernel) reported problems were
they considered the on-demand governor was "too slow" to ramp
the frequency up. (But I don't know if they'd played with the
configuration knobs.)

Regards.

