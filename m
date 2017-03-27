From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v6 3/4] clk: samsung: exynos5433: Add runtime PM support
Date: Mon, 27 Mar 2017 17:24:49 +0200
Message-ID: <583f5de0-ef54-2558-9673-a2b52f38e5e9@samsung.com>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
        <CGME20170322113555eucas1p2e6d19d66de5dc48b9f34e4b639759f78@eucas1p2.samsung.com>
        <1490182543-28550-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59194 "EHLO
        epoutp02.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753296AbdC0PY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 11:24:59 -0400
In-reply-to: <1490182543-28550-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 03/22/2017 12:35 PM, Marek Szyprowski wrote:
> +static int __init exynos5433_cmu_probe(struct platform_device *pdev)
> +{

> +	/*
> +	 * Enable runtime pm here, so clock core with use runtime pm for all
> +	 * registered clocks. Additionally we increase the runtime PM usage
> +	 * count during the clock registration, to avoid the clock core from
> +	 * runtime suspending the device.
> +	 */

While applying I rephrased the above comment to:

/*
  * Enable runtime PM here to allow the clock core using runtime PM
  * for the registered clocks. Additionally, we increase the runtime
  * PM usage count before registering the clocks, to prevent the
  * clock core from runtime suspending the device.
  */

> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);


-- 
Thanks,
Sylwester
