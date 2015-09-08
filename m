From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Tue, 8 Sep 2015 08:16:59 +0530
Message-ID: <20150908024659.GF26760@linux>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33231 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbbIHCrE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 22:47:04 -0400
Received: by pacex6 with SMTP id ex6so110298289pac.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 19:47:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 07-09-15, 17:41, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds suspend frequency support (using opp-v2
> bindings and suspend-opp functionality) to cpufreq-dt driver and
> then adds suspend opp for Exynos4412 based boards.
> 
> This patch series fixes suspend/resume support on Exynos4412
> based Trats2 board and reboot hang on Exynos4412 based Odroid
> U3 board.
> 
> Changes since v3:
> - fixed dev_pm_opp_get_suspend_opp() locking
> - shortened variable name in dev_pm_opp_get_suspend_opp()
> - adjusted cpufreq_generic_suspend() to work with cpufreq-dt
> - removed no longer needed cpufreq_dt_suspend()
> - added Acked-by tag from Viresh to patch #4

Just a minor comment on 3/4 and after fixing that:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
