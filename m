From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: offer TI thermal support only when ARCH_OMAP2PLUS
 is defined
Date: Tue, 08 Oct 2013 19:40:48 +0200
Message-ID: <4296924.z1ntgL0xa6@amdc1032>
References: <3702969.8rn3SOscJE@amdc1032> <52542E42.5090805@ti.com>
 <1830886.95xXFHTq6V@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28606 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab3JHRkw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2013 13:40:52 -0400
In-reply-to: <1830886.95xXFHTq6V@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>

On Tuesday, October 08, 2013 06:59:19 PM Bartlomiej Zolnierkiewicz wrote:

[...]

> > Restricting drivers to be compiled to specific architecture is a poor
> > design strategy. Specifically, on the TI Bandgap device driver, as I
> > already mentioned to you, this is again clear, as it is currently used
> > on different archs, and the code can be easily reused when other archs,
> > different than DRA and OMAP, need it.
> 
> It is the correct strategy to restrict hardware specific device drivers
> (i.e. ARM Exynos thermal driver) to be compiled only for hardware that
> it is available on (i.e. ARM Exynos SoCs). If TI bandgap driver is not
> hardware specific and can be used on non TI hardware than you're of
> course right.

Just small addition. We are not using TI bandgap IP in any current ARM
Samsung SoCs so TI bandgap IP support should not be available on them
(=> we should not use ARCH_HAS_BANDGAP at all, usage for EXYNOS_THERMAL
is incorrect as I already explained in previous mail).

OTOH archs/SoCs that are using such IP can select ARCH_HAS_BANDGAP freely.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

