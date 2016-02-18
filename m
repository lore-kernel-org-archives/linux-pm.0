From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: Add cooling levels for CPUs on
 exynos5422/5800
Date: Thu, 18 Feb 2016 11:51:33 +0530
Message-ID: <20160218062133.GT2610@vireshk-i7>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32859 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425210AbcBRGVq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 01:21:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id fl4so25139702pad.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 22:21:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 18-02-16, 14:13, Krzysztof Kozlowski wrote:
> On Exynos5422 and Exynos5800 we support 12 cpufreq steps (200-1300 MHz) for LITTLE
> and 18 steps for big core (200-1700 MHz). Add respective cooling cells.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Add cooling properties to all CPUs (suggested by Viresh).
> ---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
