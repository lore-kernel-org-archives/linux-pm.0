From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
Date: Sun, 14 Apr 2013 22:22:54 +0200
Message-ID: <516B101E.3040807@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org> <20130414151429.GF5061@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40549 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab3DNUXA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2013 16:23:00 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq17so201566wib.17
        for <linux-pm@vger.kernel.org>; Sun, 14 Apr 2013 13:22:58 -0700 (PDT)
In-Reply-To: <20130414151429.GF5061@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/14/2013 05:14 PM, Andrew Lunn wrote:
> On Fri, Apr 12, 2013 at 02:36:03PM +0200, Daniel Lezcano wrote:
>> Remove the duplicated code and use the cpuidle common code for initi=
alization.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew for testing.

  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

