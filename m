From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Tue, 26 Jan 2016 18:17:26 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601261803410.3886@nanos>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com> <1450349309-8107-4-git-send-email-jonathanh@nvidia.com> <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com> <569E1366.8070005@nvidia.com> <alpine.DEB.2.11.1601201620450.3575@nanos>
 <CAPDyKFrqQO6Mh7ew5YTW011a11LmFW7c+cZpAKmY8tovxjGmOw@mail.gmail.com> <alpine.DEB.2.11.1601212026230.3886@nanos> <CAPDyKFoNcARZRZfXM1Rdn2PZqtnUdbfn1Fb4PzKZs_DKkxKtSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37750 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965001AbcAZRSl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 12:18:41 -0500
In-Reply-To: <CAPDyKFoNcARZRZfXM1Rdn2PZqtnUdbfn1Fb4PzKZs_DKkxKtSw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, 22 Jan 2016, Ulf Hansson wrote:
> Here's a small collection of drivers that I easily picked up as
> candidates for using these new APIs.
> In principle, they would invoke these new APIs from their runtime PM callbacks.
> 
> drivers/spi/spi-atmel.c
> drivers/spi/spi-pl022.c
> drivers/i2c/busses/i2c-omap.c
> drivers/i2c/busses/i2c-nomadik.c
> drivers/i2c/busses/i2c-sh_mobile.c
> drivers/mmc/host/mtk-sd.c
> drivers/mmc/host/mmci.c

Instead of adding those calls to each driver, we can be smart and flag the
interrupt as AUTO_RUNTIME_SUSPEND or such.

So the runtime_pm core can handle it when invoking the
dev_pm_ops->runtime_suspend()/resume() callbacks.

Unfortunately the devres stuff is exceptionally bad to be used for this, but
with some surgery it should be doable.

Thanks,

	tglx
