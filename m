From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Thu, 25 Apr 2013 09:06:23 +0200
Message-ID: <5178D5EF.9090102@linaro.org>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org> <51781B48.30208@gmail.com> <5178D0EF.3090004@linaro.org> <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39059 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3DYHG1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 03:06:27 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so2956750wib.17
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2013 00:06:26 -0700 (PDT)
In-Reply-To: <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, benh@kernel.crashing.org, linus.walleij@linaro.org, nicolas.ferre@atmel.com, paulus@samba.org, josephl@nvidia.com, kgene.kim@samsung.com, swarren@wwwdotorg.org, magnus.damm@gmail.com, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, arnd@arndb.de, linux-pm@vger.kernel.org, nsekhar@ti.com, rob.herring@calxeda.com, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On 04/25/2013 08:49 AM, Viresh Kumar wrote:
> On 25 April 2013 12:15, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>> On 04/24/2013 07:50 PM, Rob Herring wrote:
>=20
>>> Shouldn't MAINTAINERS contain the driver maintainers too?
>>
>> It should contains the upstream maintainer for the subsystem, and
>> optionally a co-maintainer.
>>
>> The MAINTAINERS file gives informations about the patch submission p=
ath.
>>
>> The file's header should contain the maintainer of the driver, so th=
e
>> submitted patches will go to the subsystem maintainer for upstreamin=
g
>> and to the driver maintainer for acked-by.
>>
>> If you add an entry in MAINTAINERS like:
>>
>> ARM/CALXEDA HIGHBANK ARCHITECTURE
>> M:      Rob Herring <rob.herring@calxeda.com>
>> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subs=
cribers)
>> S:      Maintained
>> F:      arch/arm/mach-highbank/
>> +F:     drivers/cpuidle/cpuidle-calxeda.c
>>
>> That will add confusion while we are trying to clarify the situation
>> with a single entry point for the patches submission. If someone wan=
ts
>> to submit a patch for this driver, it will look at the MAINTAINERS f=
ile
>> and won't know if it should send the patch against arm-soc or linux-=
pm.
>=20
> I though otherwise. We can add entry in MAINTAINERS for any module.
> Module can be a framework/architecture or a single driver.

IMO, there are too much drivers for that. It is simpler for someone to
read the MAINTAINERS file to find the cpuidle drivers goes through
linux-pm. I think we can trust Rafael to ask for the acked-by from the
maintainer of the driver before taking the patches.

> Adding entry for cpuidle driver of a architecture as you wrote for ca=
lxeda is
> wrong as it adds to confusion and so there should be a separate entry=
 for
> this driver rather than merging it with arch/ entries.

Yes, actually it was an example to show the confusion we could be facin=
g.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

