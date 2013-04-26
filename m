From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [V2 PATCH] cpuidle: add maintainer entry
Date: Fri, 26 Apr 2013 09:49:46 -0700
Message-ID: <87txmtz179.fsf@linaro.org>
References: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33245 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3DZQtv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 12:49:51 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so2605656pad.31
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2013 09:49:50 -0700 (PDT)
In-Reply-To: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 26 Apr 2013 13:05:44 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, kernel@pengutronix.de, swarren@wwwdotorg.org, horms+renesas@verge.net.au, josephl@nvidia.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, horms@verge.net.au, magnus.damm@gmail.com, benh@kernel.crashing.org, paulus@samba.org, kgene.kim@samsung.com, linus.walleij@linaro.org, viresh.kumar@linaro.org, lenb@kernel.org, nsekhar@ti.com, ben-linux@fluff.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Currently the cpuidle drivers are spread across the different archs.
>
> The patch submission for cpuidle are following different path: the cpuidle core
> code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
> tree, sh goes through sh arch tree, pseries goes through PowerPC and
> finally intel goes through Len's tree while acpi_idle goes under linux-pm.
>
> That makes difficult to consolidate the code and to propagate modifications
> from the cpuidle core to the different drivers.
>
> Hopefully, a movement has initiated to put the cpuidle drivers into the
> drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c
>
> Add an explicit maintainer entry in the MAINTAINER to clarify the situation
> and prevent new cpuidle drivers to goes to an arch directory.
>
> The upstreaming process is unchanged: Rafael takes the patches to merge them
> into its tree but with the acked-by from the driver's maintainer. So the header
> must contains the name of the maintainer.
>
> This organization will be the same than cpufreq.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andrew Lunn <andrew@lunn.ch>  #for kirkwood
> Acked-by: Jason Cooper <jason@lakedaemon.net> #for kirkwood

Acked-by: Kevin Hilman <khilman@linaro.org>
