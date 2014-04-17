From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
Date: Thu, 17 Apr 2014 13:38:03 -0700
Message-ID: <CADHgK6v43=KSpe2FRG374nbHSMOt9hb+xEhO7z20vhEAQsx0tQ@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
	<1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
	<20140416101243.GA6952@n2100.arm.linux.org.uk>
	<CADHgK6vyWU1HCueN=F5D0JxzknV==h-jOG9JmcXeOrH_RGV4JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41473 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaDQUiE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Apr 2014 16:38:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so894375wgh.34
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2014 13:38:03 -0700 (PDT)
In-Reply-To: <CADHgK6vyWU1HCueN=F5D0JxzknV==h-jOG9JmcXeOrH_RGV4JQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russ Dill <Russ.Dill@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@codeaurora.org>, Laura Abbott <lauraa@codeaurora.org>, Jiang Liu <liuj97@gmail.com>, Sricharan R <r.sricharan@ti.com>, Victor Kamensky <victor.kamensky@linaro.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Ben Dooks <ben>

Hi Russell,

It seems to work fine with your virt_to_phys on the 3.13 + OMAP
patches kernel, and I checked on the 3.15-rc1 kernel + hibernation and
it compiled and ran fine.  I tried a couple of hibernations on this
version as well and they worked (aside from the crash in kernel_halt
we're discussing separately).  I believe this just works by chance
though because the omap platform has no real hibernation support
there.

I'll try now to merge up the omap patches to 3.15-rc1.

Thanks,

Sebastian
