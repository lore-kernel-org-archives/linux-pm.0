From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [V3 patch 05/19] ARM: ux500: cpuidle: replace for_each_online_cpu
 by for_each_possible_cpu
Date: Tue, 16 Apr 2013 14:34:39 +0200
Message-ID: <CACRpkdasndAyCitHkB3z3vH06WOD7qtzzjD9cXmAkvUEO_x3OA@mail.gmail.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
	<1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45611 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3DPMel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2013 08:34:41 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so410844ieb.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2013 05:34:39 -0700 (PDT)
In-Reply-To: <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, Rob Herring <rob.herring@calxeda.com>, "Nori, Sekhar" <nsekhar@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, deepthi@linux.vnet.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jiri Kosina <jkosina@suse.cz>, Kukjin Kim <kgene.kim@samsung.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, ext Tony Lindgren <tony@atomide.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Patch Tracking <patches@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>

On Fri, Apr 12, 2013 at 2:35 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> All the drivers are using, in their initialization function, the
> for_each_possible_cpu macro.
>
> Using for_each_online_cpu means the driver must handle the initialization
> of the cpuidle device when a cpu is up which is not the case here.
>
> Change the macro to for_each_possible_cpu as that fix the hotplug
> initialization and make the initialization routine consistent with the
> rest of the code in the different drivers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
