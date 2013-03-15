From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Fri, 15 Mar 2013 16:07:53 +0100
Message-ID: <51433949.1030204@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org> <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org> <201303151447.06150.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37722 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab3COPH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 11:07:58 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi8so610105wib.7
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 08:07:56 -0700 (PDT)
In-Reply-To: <201303151447.06150.arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, andrew@lunn.ch, magnus.damm@gmail.com, ben-linux@fluff.org, nsekhar@ti.com, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, jason@lakedaemon.net, lenb@kernel.org

On 03/15/2013 03:47 PM, Arnd Bergmann wrote:
> On Friday 15 March 2013, Daniel Lezcano wrote:
>> The cpuidle drivers are duplicating a lot of code and in most
>> of the case there is a common pattern we can factor out:
>>
>>         * setup the broadcast timers
>>         * register the driver
>>         * register the devices
>>
>> This arm driver is the common part between all the ARM cpuidle drive=
rs,
>> with the code factored out.
>>
>> It does not handle the coupled idle state for now but it is the firs=
t
>> step to have everyone to converge to the same code pattern.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Unfortunately, I missed the session in Hong Kong, but I'd like to und=
erstand
> what part of this driver is actually ARM specific. I assume there is =
nothing
> in it that depends on 32 bit ARM hardware, right?

What depends on the 32bits ARM hardware is the drivers themselves. This
ARM driver is the first step to consolidate all SoC cpuidle specific
code we find in arch/arm. The code is designated to factor out these
drivers, as a first step. The second step is to consolidate more this
driver (eg. moving the code in arch/arm/kernel/cpuidle.c in this driver=
).

The last man standing algorithm we have in mach-ux500 and mach-imx is
the same, and will be moved in the ARM cpuidle driver.

The more it will be consolidated, the more it will be ARM specific.

The final step will be to use the device tree to be passed to this
driver and do the cpuidle driver initialization from there.

> Would the same code be used with arch/arm64?

I can't tell but IIUC, a single ARM driver will be used based on the
psci for ARM64, but it does not exist for now. It is possible some code
pattern could be used from the ARM32 cpuidle driver.

> What about other architectures that want to share a cpuidle driver
> with and ARM SoC using the same hardware? We have a lot of examples
> of SoC vendors that use similar components on ARM and non-ARM SoCs
> based on SH, AVR32, Hexagon, C6x, MIPS or PowerPC.

I guess if they share the same code, it could probably go to the cpuidl=
e
core framework instead of a specific driver.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

