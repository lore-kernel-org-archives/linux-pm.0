From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/4] cpufreq-dt: add suspend frequency support
Date: Wed, 09 Sep 2015 03:16:48 +0200
Message-ID: <2547413.Uj7KDUeGpY@vostro.rjw.lan>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56385 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753274AbbIIAs7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 20:48:59 -0400
In-Reply-To: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tuesday, September 08, 2015 06:41:00 PM Bartlomiej Zolnierkiewicz wrote:
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
> Changes since v4:
> - removed superfluous CONFIG_PM ifdefs
> - added Acked-by tag from Krzysztof to patch #4
> - added Acked-by tag from Viresh to patches #1-3
> 
> Changes since v3:
> - fixed dev_pm_opp_get_suspend_opp() locking
> - shortened variable name in dev_pm_opp_get_suspend_opp()
> - adjusted cpufreq_generic_suspend() to work with cpufreq-dt
> - removed no longer needed cpufreq_dt_suspend()
> - added Acked-by tag from Viresh to patch #4
> 
> Changes since v2:
> - rewrote to use suspend-opp functionality
> 
> Changes since v1:
> - removed superfluous ";"
> 
> Depends on:
> - next-20150902 branch of linux-next kernel tree

I've queued up [1-3/4] for the next PM pull request.

The [4/4] has to go in separately through the platform tree.

Thanks,
Rafael

