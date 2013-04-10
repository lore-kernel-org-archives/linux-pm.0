From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 21:59:09 +0200
Message-ID: <5165C48D.5060303@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org> <CAMbhsRSigxzDK3v20ARhXaXK11KL1xZRWkFOXA16YUZ=FtJN9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48945 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935117Ab3DJT7O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 15:59:14 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so5217806wid.6
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 12:59:13 -0700 (PDT)
In-Reply-To: <CAMbhsRSigxzDK3v20ARhXaXK11KL1xZRWkFOXA16YUZ=FtJN9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, jason@lakedaemon.net, andrew@lunn.ch, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, Rob Herring <rob.herring@calxeda.com>, nsekhar@ti.com, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Jiri Kosina <jkosina@suse.cz>, Kukjin Kim <kgene.kim@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux PM list <linux-pm@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>J

On 04/10/2013 08:22 PM, Colin Cross wrote:
> On Wed, Apr 10, 2013 at 7:22 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>
>>         cpuidle_register_driver(drv);
>>         for_each_possible_cpu(cpu) {
>>                 device =3D &per_cpu(cpuidle_dev, cpu);
>>                 cpuidle_register_device(device);
>>         }
>>
>> This code is duplicated in each cpuidle driver.
>>
>> On UP systems, it is done this way:
>>
>>         cpuidle_register_driver(drv);
>>         device =3D &per_cpu(cpuidle_dev, cpu);
>>         cpuidle_register_device(device);
>>
>> On UP, the macro 'for_each_cpu' does one iteration:
>>
>> #define for_each_cpu(cpu, mask)                 \
>>         for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
>>
>> Hence, the initialization loop is the same for UP than SMP.
>>
>> Beside, we saw different bugs / mis-initialization / return code unc=
hecked in
>> the different drivers, the code is duplicated including bugs. After =
fixing all
>> these ones, it appears the initialization pattern is the same for ev=
eryone.
>>
>> Let's add a wrapper function doing this initialization with a cpumas=
k parameter
>> for the coupled idle states and use it for all the drivers.
>=20
> Isn't this going to cause problems for big.LITTLE, which has two
> independent sets of coupled cpus, and may even have different drivers
> for the two types of cpu?

AFAICT no, because the "low levels" API are still there, I mean
cpuidle_register_driver and cpuidle_register_device. That will be up to
the b.L driver to use the API which fits its need.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

