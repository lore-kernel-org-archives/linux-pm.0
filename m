From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2
 for Exynos5433
Date: Thu, 23 Jul 2015 12:43:24 +0300
Message-ID: <20150723094324.GP5422@mwanda>
References: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
 <1437616639-7448-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437616639-7448-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 23, 2015 at 10:57:18AM +0900, Chanwoo Choi wrote:
> +static int exynos_ppmu_v2_disable(struct devfreq_event_dev *edev)
> +{
> +	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
> +	u32 pmnc, clear;
> +
> +	/* Disable all counters */
> +	clear = (PPMU_CCNT_MASK | PPMU_PMCNT0_MASK | PPMU_PMCNT1_MASK
> +		| PPMU_PMCNT2_MASK | PPMU_PMCNT3_MASK);
> +
> +	__raw_writel(clear, info->ppmu.base + PPMUv2_FLAG);

Why aren't you using normal readl()/writel()?  What are the endiannesses
here?

regards,
dan carpenter
