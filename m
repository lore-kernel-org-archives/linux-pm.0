From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date: Tue, 30 Apr 2019 13:56:23 +0900
Message-ID: <a1ff3566-6117-b670-a2f3-b60a2bbec14a@samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
        <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi,

I agree of this patch. But, I add the minor comments.

If you edit them according to my comment, feel free to add my following tag:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> This patch add support of a new feature which can be used in DT:
> Performance Monitoring Unit with defined event data type.
> In this patch the event data types are defined for Exynos PPMU.
> The patch also updates the MAINTAINERS file accordingly and
> adds the header file to devfreq event subsystem.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                           |  1 +
>  include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3671fde..1ba4b9b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4560,6 +4560,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>  S:	Supported
>  F:	drivers/devfreq/event/
>  F:	drivers/devfreq/devfreq-event.c
> +F:	include/dt-bindings/pmu/exynos_ppmu.h
>  F:	include/linux/devfreq-event.h
>  F:	Documentation/devicetree/bindings/devfreq/event/
>  
> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
> new file mode 100644
> index 0000000..08fdce9
> --- /dev/null
> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung Exynos PPMU event types for counting in regs
> + *
> + * Copyright (c) 2019, Samsung

Mabye, "Samsung Electronics" instead of 'Samsung'.

> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
> + */
> +
> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +
> +

Remove unneeded blank line.

> +#define PPMU_RO_BUSY_CYCLE_CNT		0x0
> +#define PPMU_WO_BUSY_CYCLE_CNT		0x1
> +#define PPMU_RW_BUSY_CYCLE_CNT		0x2
> +#define PPMU_RO_REQUEST_CNT		0x3
> +#define PPMU_WO_REQUEST_CNT		0x4
> +#define PPMU_RO_DATA_CNT		0x5
> +#define PPMU_WO_DATA_CNT		0x6
> +#define PPMU_RO_LATENCY			0x12
> +#define PPMU_WO_LATENCY			0x16
> +#define PPMU_V2_RO_DATA_CNT		0x4
> +#define PPMU_V2_WO_DATA_CNT		0x5
> +#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
