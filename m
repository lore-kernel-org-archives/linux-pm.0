From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 14:34:23 +0200
Message-ID: <53CD08CF.6080900@linaro.org>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>	<52019695.n2AjkGEsJ7@wuerfel>	<20140721133534.3415e425@free-electrons.com>	<5251405.VTrfDi1rj5@wuerfel> <20140721140917.16e71558@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59823 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbaGUMe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 08:34:26 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so3981993wib.10
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 05:34:24 -0700 (PDT)
In-Reply-To: <20140721140917.16e71558@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 07/21/2014 02:09 PM, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
>
> On Mon, 21 Jul 2014 14:00:22 +0200, Arnd Bergmann wrote:
>
>> I don't know, it really depends on what the differences are between
>> the SoCs, and I haven't looked at them.
>>
>> Using the compatible strings would make it work best if you have one
>> driver per variant, and then share some common code, as opposed to
>> having one shared driver with a number of exceptions.
>>
>> If the differences are just a few parameters, it might be better
>> to encode those parameters in DT properties instead.
>
> The differences are in the cpuidle states that are supported, see
> patches "cpuidle: mvebu: add Armada 370 support" and "cpuidle: mvebu:
> add Armada 38x support" in the series.
>
> I honestly believe that since cpuidle functionality is not described =
in
> the Device Tree and therefore probed using a statically defined
> platform_device, the good way to pass these informations is to simply
> use platform_data.

Ok, so for the record the cpuidle functionality described via DT is=20
under discussion [1].

I understand you need several drivers for the different SoC because of=20
the different latencies.

I admit passing an extra flag via the platform_data is a valid approach=
=20
but I have been unifying the different drivers across the existing SoC=20
and there is still a lot of things to do. So accepting this patch bring=
s=20
another way to discriminate the SoC variant I would like to avoid.

Due the different latencies, I don't think the DT property is enough an=
d=20
that may enter in conflict with Lorenzo's work.

So there are three solutions:

1. Pass the flag through the platform data, I am not really in favor of=
=20
that as mentioned above

2. Use the compatible string like the cpuidle-big-little.c driver, but=20
Arnd is not in favor of that

3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the=20
registering of the cpuidle's platform device to enable the right one


[1] http://www.spinics.net/lists/arm-kernel/msg341541.html


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

