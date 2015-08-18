From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH 2/3 v6] cpufreq: mediatek: Add MT8173 cpufreq
 driver
Date: Tue, 18 Aug 2015 15:54:28 +0530
Message-ID: <20150818102428.GD31148@linux>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <1439803465-19683-3-git-send-email-pi-cheng.chen@linaro.org>
 <18468574.WHJNqYO5N4@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34405 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbHRKYi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 06:24:38 -0400
Received: by pdbfa8 with SMTP id fa8so66655406pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2015 03:24:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18468574.WHJNqYO5N4@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

On 18-08-15, 12:09, Bartlomiej Zolnierkiewicz wrote:
> > +	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
> 
> This is not very friendly for multiplatform support
> (mt8173_cpufreq_driver_init() can be called on other platforms,
> i.e. Samsung Exynos7 one if ARCH_EXYNOS7 is also enabled in
> the kernel config).
> 
> Why can't it be fixed with checking Device Tree with
> of_machine_is_compatible("mediatek,mt8173")
> (assuming that it can be used on arm64 like on arm32)?

Because I asked him to remove that in v5 :( as I somehow had in mind
that this wouldn't even compile for other platforms.

@Pi-cheng: Please send v7 only for this patch and add the DT platform
check you were doing earlier. Sorry.

-- 
viresh
