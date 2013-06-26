From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] ARM: ux500: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 23:28:27 +0200
Message-ID: <201306262328.28009.arnd@arndb.de>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com> <1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com> <CACRpkda4NqFaniYP=bXZar+_0nM0c4b7OuKy4D_vYdfSORGQTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61607 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3FZV2t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 17:28:49 -0400
In-Reply-To: <CACRpkda4NqFaniYP=bXZar+_0nM0c4b7OuKy4D_vYdfSORGQTg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rickard ANDERSSON <rickard.andersson@stericsson.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "Nori, Sekhar" <nsekhar@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, ext Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, Daniel Lezcano <daniel.lezcano@linaro.o>

On Wednesday 26 June 2013, Linus Walleij wrote:
> On Wed, Jun 26, 2013 at 12:15 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> 
> --- a/arch/arm/mach-ux500/cpuidle
> -#include "db8500-regs.h"
> -#include "id.h"
> > +++ b/drivers/cpuidle/cpuidle-ux500.c
> (...)
> > +#include "../../arch/arm/mach-ux500/db8500-regs.h"
> > +#include "../../arch/arm/mach-ux500/id.h"
> 
> Well that was creative. NACK.
> 
> If you want to move the driver you need to come up with
> proper interfaces making the move clean, not just move the files
> and make them compile somewhere else I think.

Seconded. Moving the code into drivers/cpuidle/ doesn't actually
turn it into a proper driver. If we cannot find a way to make these
look like drivers, we shouldn't move them.

	Arnd
