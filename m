From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/3] add power off driver for i.mx6
Date: Wed, 12 Nov 2014 18:56:22 +0800
Message-ID: <20141112105620.GM2704@dragon>
References: <1415780439-29728-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39659 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbaKLK4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 05:56:35 -0500
Received: by mail-pd0-f172.google.com with SMTP id r10so12039472pdi.31
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2014 02:56:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415780439-29728-1-git-send-email-b38343@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Gong <b38343@freescale.com>
Cc: kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, smoch@web.de

On Wed, Nov 12, 2014 at 04:20:36PM +0800, Robin Gong wrote:
> Resend the patchset  with the latest MAINTAINERS
> Add simple power off driver for i.mx6, including:
> - add basic imx-snvs-poweroff driver in drivers/power/reset
> - add device node in all dts files of i.mx6.
> - enable in config file
> 
> Change from v3:
> - disable poweroff driver in soc level dts and enable it in board level dts
> - replace 'EIO' with 'ENODEV' while of_iomap fail.
> Change from v2:
> - remove useless included head files
> - split device binding doc from dts patch
> - add description for the case that PMIC_ON_REQ not used as external power
>   control
> 
> Robin Gong (3):
>   ARM: dts: imx6: add pm_power_off support for i.mx6 chips
>   power: reset: imx-snvs-poweroff: add power off driver for i.mx6
>   ARM: configs: imx_v6_v7_defconfig: add power off driver

I'm fine with the series.  But before I take the patches, I need an ACK
from DT folks on the bindings.

Shawn
