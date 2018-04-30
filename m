From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Mon, 30 Apr 2018 16:44:50 +0200
Message-ID: <20180430144450.GI11457@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115206epcas1p2da6ae1d85708907dc99a97baf0791b4d@epcas1p2.samsung.com>
 <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524743493-28113-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Check for critical trip point existence in exynos_tmu_initialize()
>   so it is checked on all SoCs (except Exynos5433 for now).

Why "except Exynos5433" ?
 
> * Use dev_err() instead of pr_err().
> 
> * Fix dev_err() to reference "device tree" not "of-thermal.c".
> 
> * Remove no longer needed check from exynos4412_tmu_initialize().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
