From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 4/4] cpufreq: exynos: remove Exynos5250 specific cpufreq
 driver support
Date: Wed, 01 Jul 2015 15:26:57 +0200
Message-ID: <3020078.iPsxHyMrL0@amdc1976>
References: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
 <1435598772-21708-5-git-send-email-b.zolnierkie@samsung.com>
 <5591E12E.7060007@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5591E12E.7060007@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Tuesday, June 30, 2015 09:22:06 AM Krzysztof Kozlowski wrote:
> On 30.06.2015 02:26, Bartlomiej Zolnierkiewicz wrote:
> > Exynos5250 based platforms have switched over to use generic
> > cpufreq driver for cpufreq functionality. So the Exynos
> > specific cpufreq support for these platforms can be removed.
> > 
> > Based on the earlier work by Thomas Abraham.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/cpufreq/Kconfig.arm          |  11 --
> >  drivers/cpufreq/Makefile             |   1 -
> >  drivers/cpufreq/exynos-cpufreq.c     |   3 -
> >  drivers/cpufreq/exynos-cpufreq.h     |  17 ---
> >  drivers/cpufreq/exynos5250-cpufreq.c | 210 -----------------------------------
> >  5 files changed, 242 deletions(-)
> >  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
> 
> Nice diff stat, I like it!
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Few thoughts:
> 1. Javier's email has changed, CC-ed the correct one. Can you update it
> in all patches (CC-tags)?

Done in v3.

> 2. It looks like the patchset should go through one tree so the
> Exynos5250 cpufreq support won't disappear, right?

Right, this would be an ideal situation.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
