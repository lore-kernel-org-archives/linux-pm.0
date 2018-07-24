From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Date: Tue, 24 Jul 2018 18:46:35 +0200
Message-ID: <2442216.oppRSGRAaL@amdc3058>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
        <20180718200250.6478-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180718200250.6478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> index 0646500bca69..642e4e7f4084 100644
> --- a/include/dt-bindings/thermal/thermal_exynos.h
> +++ b/include/dt-bindings/thermal/thermal_exynos.h
> @@ -1,19 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

This code should be GPL-2.0 only, original license statement is most
likely result of using wrong file as the source of copy-paste. So I
would like to have the license fixed first before doing conversion to
SPDX.

>  /*
>   * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
>   *
>   *  Copyright (C) 2014 Samsung Electronics
>   *  Lukasz Majewski <l.majewski@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #ifndef _EXYNOS_THERMAL_TMU_DT_H

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
