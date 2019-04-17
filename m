From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date: Wed, 17 Apr 2019 17:10:38 +0900
Message-ID: <3fcb6dde-7ccc-4da6-5f8b-c8338edaa155@samsung.com>
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c@eucas1p2.samsung.com>
        <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
> This patch add support of a new feature which can be used in DT:
> Performance Monitoring Unit with defined event data type.
> In this patch the event data types are defined for Exynos PPMU.
> The patch also updates the MAINTAINERS file accordingly.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                           |  5 +++++
>  include/dt-bindings/pmu/exynos_ppmu.h | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3671fde..f4aac78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12376,6 +12376,11 @@ L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/pm8001/
>  
> +PMU EXYNOS DT BINDINGS
> +M:	Lukasz Luba <l.luba@partner.samsung.com>
> +S:	Maintained
> +F:	include/dt-bindings/pmu/exynos_ppmu.h
> +

IMHO, I'm not sure that it is right of adding one dt-binding header file
to MAINTAINERS file. If right, I'm OK.


>  PNP SUPPORT
>  M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
> new file mode 100644
> index 0000000..a6971eb
> --- /dev/null
> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung Exynos PPMU event types for counting in regs
> + *
> + * Copyright (c) 2019, Samsung
> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
> + */
> +
> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +
> +
> +#define PPMU_RO_BUSY_CYCLE_CNT		0x0
> +#define PPMU_WO_BUSY_CYCLE_CNT		0x1
> +#define PPMU_RW_BUSY_CYCLE_CNT		0x2
> +#define PPMU_RO_REQUEST_CNT		0x3
> +#define PPMU_WO_REQUEST_CNT		0x4
> +#define PPMU_RO_DATA_CNT		0x5
> +#define PPMU_WO_DATA_CNT		0x6
> +#define PPMU_RO_LATENCY			0x12
> +#define PPMU_WO_LATENCY			0x16
> +#define PPMU_V2_EVT3_RW_DATA_CNT	0x22

If we can select the data type for monitoring, it looks good to me.
But, when I developed the Exynos PPMU, I has not tested other data type
except for PPMU_RO_DATA_CNT and PPMU_WO_DATA_CNT.

Do you test all data types with PPMU device?

> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
