From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
Date: Thu, 08 Jan 2015 11:02:54 +0100
Message-ID: <54AE55CE.6040201@linaro.org>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com> <54AE459B.8010703@linaro.org> <54AE4ADF.3030307@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38011 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbAHKC6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 05:02:58 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so1671497wgh.4
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2015 02:02:57 -0800 (PST)
In-Reply-To: <54AE4ADF.3030307@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <kevin.hilman@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

On 01/08/2015 10:16 AM, Sudeep Holla wrote:
> Hi Daniel,
>
> On Thursday 08 January 2015 02:23 PM, Daniel Lezcano wrote:
>> On 01/08/2015 07:29 AM, Sudeep Holla wrote:
>>> If big.LITTLE driver is initialized even when MCPM is unavailable,
>>> we get the below warning the first time cpu tries to enter deeper
>>> C-states.
>>
>> Can you elaborate why MCPM could be unavailable when the tc2 pm code
>> registers the mcpm platform ops before the cpuidle driver ?
>>
>>
> I can think of 3 possible scenarios. Let me know if these make sense.
>
> 1. If the firmware settings in Vexpress configuration files are set t=
o
>     boot in legacy mode, but MCPM is enabled in the kernel.

If I am not wrong, we have a BUG_ON in this path, right ?

> 2. If some failure occurs during MCPM initialization
> 3. For example, if CCI is not accessible as in some Exynos boards [1]=
,
>     we don't want to wait till mpcm_cpu_suspend ?

Well, I think if the firmware is preventing us to play with the CCI but=
=20
MCPM is enabled. We should add BUG_ON also in the same initialization=20
path. IIRC, Kevin spent some time to figure out what was happening to=20
its odroid-xu3 board before understanding mcpm wasn't able to deal with=
=20
the CCI due to the broken firmware.

The patch you are proposing is valid. Nevertheless, I would really like=
=20
to have the firmwares to be fixed and your patch is hiding an=20
incompatible firmware with the kernel configuration and letting the=20
kernel continue to work in degraded mode.

IMO, it would be better to be more strict with the mcpm initialization=20
and not let the system boot if something is wrong with it which I=20
believe is coming from the firmware and let the user to figure out what=
=20
is really happening by letting him to disable mcpm in the kernel=20
configuration (which in turn will disable cpuidle).

Nico, Kevin, what is your opinion ?



> [1]
> https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg396=
24.html



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

