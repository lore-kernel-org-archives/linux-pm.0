From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 17 Dec 2014 14:15:28 +0100
Message-ID: <549181F0.3010408@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org> <2663853.2Q3kHisMT7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42951 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaLQNPc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 08:15:32 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so20375733wgh.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 05:15:31 -0800 (PST)
In-Reply-To: <2663853.2Q3kHisMT7@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 12/16/2014 03:38 PM, Arnd Bergmann wrote:
> On Tuesday 16 December 2014 15:12:22 Daniel Lezcano wrote:
>> At the beginning, all that become from not including mach files from=
 the
>> drivers directory which make sense.
>>
>> Perhaps it is time to write a similar mechanism for the cpuidle driv=
ers
>> where we can still separate the low level PM code from the generic
>> cpuidle code.
>
> That way you basically duplicate the same thing we already have, whic=
h
> isn't much better.
>
> In the example of drivers/soc/qcom/spm.c, just call cpuidle_register
> from the spm_dev_probe() function and be done with it. You already
> have a device that is responsible for handling this, don't try to
> construct more than you already need.

If you have to call cpuidle_register, then the cpuidle_driver should be=
=20
provided with all the idle states definition and so on.

That is exactly the opposite of what we have been doing since a couple=20
of years where each SoC had their own driver, in their own directory an=
d=20
duplicating the code again and again from one platform to another platf=
orm.

The changes we have been through cleaned up most of the situation but=20
still we have more to do and I would like to prevent stepping back or=20
give the opportunity to step back.

I don't think we separated code which is not supposed to be. That has a=
=20
positive side effect of cleaning up the drivers.

Also, I understand your point and I am willing to solve this issue but=20
still by keeping the pm low level code separated from the cpuidle drive=
r.

> I would assume that the same can be done for most other platforms.
>
> There are probably cases where the same piece of hardware is responsi=
ble
> for both cpuidle and cpufreq, but what that means is really that you
> should have a single driver for it that does both things. Same for
> SMP support: if you have one register block that does both the SMP
> bringup and the cpuidle stuff, then have *one* driver for this block
> that does it all. There are currently a few dependencies that require
> doing SMP bringup early during boot, but we decided years ago that th=
ose
> are all artificial dependencies and we should be able to boot seconda=
ry
> CPUs much later than we currently do.

I agree with this point and given the number of drivers, the easiest wa=
y=20
to do that is to create cpu pm ops as I gave in the previous email and=20
reuse them for cpu hotplug/bringup. And I believe that is possible if w=
e=20
continue our approach by splitting the low level pm code from the=20
cpuidle driver.

What about doing something simple ? Like creating a struct=20
arm_cpu_pm_ops variable visible from everywhere and filled by the=20
different platform ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

