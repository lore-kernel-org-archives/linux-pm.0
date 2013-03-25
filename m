From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 20:20:24 +0100
Message-ID: <5150A378.60608@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org> <20130325190908.GC631@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:49183 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758815Ab3CYTUY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 15:20:24 -0400
Received: by mail-wg0-f48.google.com with SMTP id 16so3531170wgi.27
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 12:20:23 -0700 (PDT)
In-Reply-To: <20130325190908.GC631@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/25/2013 08:09 PM, Andrew Lunn wrote:
>>> Please could you add a comment in the code about which piece is
>>> specific to ARM, because its not obvious to me. Its not like there =
is
>>> a reference to WFI for example. It looks like this code could go in
>>> drivers/cpuidle/cpuidle.c
>>
>> Yes, I agree. At the first glance, the code, as it is, could go in t=
his
>> file but more ARM specific code will be moved to this ARM generic co=
de
>> driver like device tree description and couple idle states. The init
>> function would be more arch specific then.
>=20
> Hi Daniel
>=20
> There was a discussion about device tree bindings when i posted
> the kirkwood cpuidle driver, now in drivers/cpuidle/cpuidle-kirkwood.=
c.
>=20
> The conclusion was that pseudo devices, like cpuidle, do not have DT
> bindings. They can check of_machine_is_compatible(), like
> cpuidle-calxeda.c does, or they are platform drivers, which is what
> cpuidle-kirkwood.c is.
>=20
> Even if DT binding was allowed, it again should not be ARM specific.

If the DT binding was allowed, I *may* not be ARM specific but will
certainly used only by the ARM drivers as the x86 platform uses ACPI or
static tables.

> Are coupled idle states ARM specific?

Well the code is not arch specific but today the idle coupling is ARM
specific because it is the only arch using this kind of synchronization=
=2E
There is also a last man standing algorithm common to ux500 and imx
(maybe exynos soon) I would like to merge into this ARM driver.

AFAIK, the cluster shutdown is managed by the hardware on x86 so there
is no need for this.




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

