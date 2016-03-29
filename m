From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 11:35:40 +0900
Message-ID: <56F9E9FC.7080007@samsung.com>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:23642 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbcC2Cft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 22:35:49 -0400
In-reply-to: <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 24.03.2016 15:40, Viresh Kumar wrote:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/exynos.c        | 25 -------------------------
>  drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
>  2 files changed, 5 insertions(+), 25 deletions(-)

Hi,

I got only 3rd patch (and no cover letter). I don't know what is the
background or what is your plan for this. I suppose you want to merge it
through cupfreq tree? Anyway could you cc-me on everything (or at least
cover letter)?

Best regards,
Krzysztof

