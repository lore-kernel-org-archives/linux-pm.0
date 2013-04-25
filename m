From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Thu, 25 Apr 2013 12:19:56 +0530
Message-ID: <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
	<51781B48.30208@gmail.com>
	<5178D0EF.3090004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:53231 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab3DYGt5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 02:49:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id k19so1366389qcs.41
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2013 23:49:56 -0700 (PDT)
In-Reply-To: <5178D0EF.3090004@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, benh@kernel.crashing.org, linus.walleij@linaro.org, nicolas.ferre@atmel.com, paulus@samba.org, josephl@nvidia.com, kgene.kim@samsung.com, swarren@wwwdotorg.org, magnus.damm@gmail.com, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, arnd@arndb.de, linux-pm@vger.kernel.org, nsekhar@ti.com, rob.herring@calxeda.com, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On 25 April 2013 12:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 04/24/2013 07:50 PM, Rob Herring wrote:

>> Shouldn't MAINTAINERS contain the driver maintainers too?
>
> It should contains the upstream maintainer for the subsystem, and
> optionally a co-maintainer.
>
> The MAINTAINERS file gives informations about the patch submission path.
>
> The file's header should contain the maintainer of the driver, so the
> submitted patches will go to the subsystem maintainer for upstreaming
> and to the driver maintainer for acked-by.
>
> If you add an entry in MAINTAINERS like:
>
> ARM/CALXEDA HIGHBANK ARCHITECTURE
> M:      Rob Herring <rob.herring@calxeda.com>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      arch/arm/mach-highbank/
> +F:     drivers/cpuidle/cpuidle-calxeda.c
>
> That will add confusion while we are trying to clarify the situation
> with a single entry point for the patches submission. If someone wants
> to submit a patch for this driver, it will look at the MAINTAINERS file
> and won't know if it should send the patch against arm-soc or linux-pm.

I though otherwise. We can add entry in MAINTAINERS for any module.
Module can be a framework/architecture or a single driver.

Adding entry for cpuidle driver of a architecture as you wrote for calxeda is
wrong as it adds to confusion and so there should be a separate entry for
this driver rather than merging it with arch/ entries.
