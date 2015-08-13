From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 16:28:39 +0530
Message-ID: <20150813105839.GT20238@linux>
References: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <CAJKOXPcr8SdXRse-oYzfyB=YULk=hCCWuL=AGoJcXrXX_dsnMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32957 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbbHMK6o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 06:58:44 -0400
Received: by pdrh1 with SMTP id h1so18176989pdr.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 03:58:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJKOXPcr8SdXRse-oYzfyB=YULk=hCCWuL=AGoJcXrXX_dsnMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13-08-15, 19:53, Krzysztof Kozlowski wrote:
> 2015-08-13 19:32 GMT+09:00 Jonas Rabenstein
> <jonas.rabenstein@studium.uni-erlangen.de>:
> > With commit 2907ed4377d9 ("cpufreq: exynos: remove Exynos4x12 specific
> > cpufreq driver support"), the last specific Exynos-cpufreq driver
> > depending on ARM_EXYNOS_CPUFREQ was removed. As there is no
> > Exynos-specific cpufreq driver depending on the code in
> > drivers/cpufreq/exynos-cpufreq.c (selected by ARM_EXYNOS_CPUFREQ),
> > this file was deleted and ARM_EXYNOS_CPUFREQ removed from Kconfig.
> > After all, the rule in drivers/cpufreq/Makefile, to combine all
> > specific cpufreq drivers depending on the generic code for Exynos into
> > one objectfile is obsolete and can be removed.
> >
> > Remove unselectable rule for arm-exynos-cpufreq.o from
> > drivers/cpufreq/Makefile, which - if selectable - would generate an
> > always empty objectfile.
> 
> That's a lot, really a lot of words, just to say that
> ARM_EXYNOS_CPUFREQ option was removed and we should get rid of any
> left-overs. The patch is of course valid... but could you trim this to
> a short sentence giving the reason? Mentioned commit ID comes from
> linux-next (or maintainer branch which may rebase) so it won't work
> long-term. I think you can just leave the title of the commit.
> 
> When re-spinning:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Viresh,
> Do you want this to go through samsung-soc tree?

That's Rafael's call, but even he can't take it right now. This patch
has dependency on the samsung pull request. So it should go that way
only.

But if you are already late, then Rafael can apply this after 4.3-rc1
is out.

-- 
viresh
