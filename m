From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 5/7] soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 08:59:01 +0200
Message-ID: <2151958.o58rGSd9YV@avalon>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be> <1457551122-21838-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:54756 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCJG7A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 01:59:00 -0500
In-Reply-To: <1457551122-21838-6-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 09 March 2016 20:18:40 Geert Uytterhoeven wrote:
> R-Car M2-N is identical to R-Car M2-W w.r.t. power domains, so reuse the
> definitions from the latter.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  include/dt-bindings/power/r8a7793-sysc.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/power/r8a7793-sysc.h
> 
> diff --git a/include/dt-bindings/power/r8a7793-sysc.h
> b/include/dt-bindings/power/r8a7793-sysc.h new file mode 100644
> index 0000000000000000..c2cc74cf06d653ed
> --- /dev/null
> +++ b/include/dt-bindings/power/r8a7793-sysc.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +#ifndef __DT_BINDINGS_POWER_R8A7793_SYSC_H__
> +#define __DT_BINDINGS_POWER_R8A7793_SYSC_H__
> +
> +/*
> + * These power domain indices match the numbers of the interrupt bits
> + * representing the power areas in the various Interrupt Registers
> + * (e.g. SYSCISR, Interrupt Status Register)
> + *
> + * R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
> + */
> +
> +#include "r8a7791-sysc.h"
> +
> +#define R8A7793_PD_CA15_CPU0		R8A7791_PD_CA15_CPU0
> +#define R8A7793_PD_CA15_CPU1		R8A7791_PD_CA15_CPU1
> +#define R8A7793_PD_CA15_SCU		R8A7791_PD_CA15_SCU
> +#define R8A7793_PD_SH			R8A7791_PD_SH
> +#define R8A7793_PD_SGX			R8A7791_PD_SGX

I would use numbers directly without including r8a7791-sysc.h, it would save 
going through yet another file when looking for the numerical value.

> +
> +#endif /* __DT_BINDINGS_POWER_R8A7793_SYSC_H__ */

-- 
Regards,

Laurent Pinchart

