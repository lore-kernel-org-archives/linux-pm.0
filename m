From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for
 all
Date: Tue, 23 Apr 2013 15:43:45 +0200
Message-ID: <51769011.7030608@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org> <516FB35D.7000303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:43286 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab3DWNoD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 09:44:03 -0400
Received: by mail-ee0-f45.google.com with SMTP id l10so265953eei.18
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 06:44:01 -0700 (PDT)
In-Reply-To: <516FB35D.7000303@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>
>> 	cpuidle_register_driver(drv);
>> 	for_each_possible_cpu(cpu) {
>> 		device =3D &per_cpu(cpuidle_dev, cpu);
>> 		cpuidle_register_device(device);
>> 	}
>>
> Not exactly related to $subject patch but the driver should
> be registered after all devices has been registered to avoid
> devices start using the idle state data as soon as it is
> registered. In multi CPU system, this race can easily happen.

Could you elaborate what problems the system will be facing if a cpu
starts using the idle state data as soon as it is registered ?

Is there a bug related to this ?

> Current CPUIDLE core layer is also written with the assumption
> that driver will be registered first and then the devices which
> is not mandatory as per typical drive/device model.

Yes, that's true. The framework assumes cpuidle_register_driver is
called before cpuidle_register_device.

> May be you can fix that part while you are creating this common
> wrapper.

Personally, as that will modify the cpuidle core layer and the changes
are not obvious (because of the design of the code) I prefer to do that
in a separate patchset if it is worth to do it - if there is a bug
related to it, then there is no discussion, we have to do it :)

[ ... ]

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

