From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq-dt: add suspend frequency support
Date: Thu, 3 Sep 2015 08:23:54 +0530
Message-ID: <20150903025354.GC13140@linux>
References: <1441212476-21316-1-git-send-email-b.zolnierkie@samsung.com>
 <55E739F5.8060000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E739F5.8060000@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02-09-15, 11:03, Stephen Boyd wrote:
> On 09/02/2015 09:47 AM, Bartlomiej Zolnierkiewicz wrote:
> > Add suspend frequency support and set it to the boot frequency,
> > this matches what the old exynos-cpufreq driver has been doing.
> >
> > This patch fixes suspend/resume support on Exynos4412 based
> > Trats2 board and reboot hang on Exynos4412 based Odroid U3
> > board.
> >
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > This patch supersedes "[PATCH] ARM: dts: exynos4412-odroid-*: add
> > workaround for CPUfreq/reboot issue" one from yesterday.
> 
> What do we do about cpufreq-dt users that don't want to change frequency
> during suspend?

Again, this should be done via opp-v2 suspend-opp feature instead.

-- 
viresh
