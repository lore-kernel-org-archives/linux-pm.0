From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/5] ARM: S3C64XX: Add SPDX license identifier
Date: Fri, 29 Dec 2017 10:52:12 +0000
Message-ID: <20171229105212.thkj4q4qezsg2jdl@localhost.localdomain>
References: <1514231675-17582-1-git-send-email-krzk@kernel.org>
 <1514231675-17582-3-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39028 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753861AbdL2Kxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Dec 2017 05:53:47 -0500
Content-Disposition: inline
In-Reply-To: <1514231675-17582-3-git-send-email-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Dec 25, 2017 at 08:54:33PM +0100, Krzysztof Kozlowski wrote:
> Replace GPL license statements with a SPDX license indentifiers (GPL-2.0
> and GPL-2.0+).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-s3c64xx/crag6410.h                  |  5 +----
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c      | 15 ++++++-------
>  arch/arm/mach-s3c64xx/mach-crag6410.c             | 19 ++++++-----------

For the Cragganmore bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> index ea5f2169c850..29ed7b7bafb6 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -1,12 +1,9 @@
> -/* Speyside modules for Cragganmore - board data probing
> - *
> - * Copyright 2011 Wolfson Microelectronics plc
> - *	Mark Brown <broonie@opensource.wolfsonmicro.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +//Speyside modules for Cragganmore - board data probing

There is a space missing here but probably only worth fixing if
you are respinning the series for other reasons anyway.

> +//
> +// Copyright 2011 Wolfson Microelectronics plc
> +//	Mark Brown <broonie@opensource.wolfsonmicro.com>
