From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 8/8] ARM: ux500: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 22:42:54 +0200
Message-ID: <CACRpkda4NqFaniYP=bXZar+_0nM0c4b7OuKy4D_vYdfSORGQTg@mail.gmail.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
	<1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:57427 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3FZUmy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 16:42:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so15501301oag.16
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2013 13:42:54 -0700 (PDT)
In-Reply-To: <1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rickard ANDERSSON <rickard.andersson@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "Nori, Sekhar" <nsekhar@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, ext Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Jun 26, 2013 at 12:15 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

--- a/arch/arm/mach-ux500/cpuidle
-#include "db8500-regs.h"
-#include "id.h"
> +++ b/drivers/cpuidle/cpuidle-ux500.c
(...)
> +#include "../../arch/arm/mach-ux500/db8500-regs.h"
> +#include "../../arch/arm/mach-ux500/id.h"

Well that was creative. NACK.

If you want to move the driver you need to come up with
proper interfaces making the move clean, not just move the files
and make them compile somewhere else I think.

Yours,
Linus Walleij
