From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 0/4] thermal: Add support for interrupt based
 notification to thermal layer
Date: Wed, 21 Nov 2012 09:04:06 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263264C2D@SHSMSX101.ccr.corp.intel.com>
References: <1352348786-24255-1-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1352348786-24255-1-git-send-email-amit.kachhap@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Amit,

As THERMAL_TREND_RAISE_FULL/THERMAL_TREND_DROP_FULL
has been introduced to thermal next tree,
I'd like to get your plan about this patch set?

Thanks,
Rui

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Amit Daniel Kachhap
> Sent: Thursday, November 08, 2012 12:26 PM
> To: linux-pm@lists.linux-foundation.org
> Cc: linux-samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; R,
> Durgadoss; lenb@kernel.org; Zhang, Rui; linux-acpi@vger.kernel.org;
> amit.kachhap@linaro.org; jonghwa3.lee@samsung.com
> Subject: [PATCH 0/4] thermal: Add support for interrupt based
> notification to thermal layer
> Importance: High
> 
> The patch submitted by Jonghwa Lee
> (https://patchwork.kernel.org/patch/1683441/)
> adds support for interrupt based notification to thermal layer. This is
> a good feature but the current thermal framework needs polling/regular
> notification for invoking suitable cooling action. So adding 2 new
> thermal trend type to implement this feature.
> 
> All these patches are based on thermal maintainer next tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next
> 
> Amit Daniel Kachhap (3):
>   thermal: Add new thermal trend type to support quick cooling
>   thermal: exynos: Miscellaneous fixes to support falling threshold
>     interrupt
>   thermal: exynos: Use the new thermal trend type for quick cooling
>     action.
> 
> Jonghwa Lee (1):
>   Thermal: exynos: Add support for temperature falling interrupt.
> 
>  drivers/thermal/exynos_thermal.c             |  105 +++++++++++++++---
> --------
>  drivers/thermal/step_wise.c                  |   19 ++++-
>  include/linux/platform_data/exynos_thermal.h |    3 +
>  include/linux/thermal.h                      |    2 +
>  4 files changed, 80 insertions(+), 49 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
