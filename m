From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/18] ARM: tegra1: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 20:05:25 +0200
Message-ID: <5165A9E5.1070107@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-11-git-send-email-daniel.lezcano@linaro.org> <5165A165.3000105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:38548 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934881Ab3DJSF3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 14:05:29 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so581195wey.18
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 11:05:28 -0700 (PDT)
In-Reply-To: <5165A165.3000105@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/10/2013 07:29 PM, Stephen Warren wrote:
> On 04/10/2013 08:22 AM, Daniel Lezcano wrote:
>> Subject: ARM: tegra1: cpuidle: use init/exit common routine
>=20
> The tag there should be just ARM: tegra: - Tegra1 isn't something tha=
t's
> supported upstream. Same comment for the other two Tegra patches.

Ok.

>> Remove the duplicated code and use the cpuidle common code for initi=
alization.
>=20
> Other than that, the 3 Tegra patches look reasonable assuming the
> patches that implement the new common APIs are accepted, so the 3 Teg=
ra
> patches,
>=20
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks for review

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

