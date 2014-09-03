From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
Date: Wed, 03 Sep 2014 13:10:32 +0200
Message-ID: <4774333.eJdjGCa2sL@wuerfel>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 September 2014 12:52:16 Ulf Hansson wrote:
> 
>  arch/arm/mach-exynos/exynos.c         |   1 -
>  arch/arm/mach-s3c64xx/common.c        |   5 -
>  arch/arm/mach-s3c64xx/common.h        |   7 -
>  arch/arm/mach-s3c64xx/mach-anw6410.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-crag6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-hmt.c      |   1 -
>  arch/arm/mach-s3c64xx/mach-mini6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-ncp.c      |   1 -
>  arch/arm/mach-s3c64xx/mach-real6410.c |   1 -
>  arch/arm/mach-s3c64xx/mach-smartq5.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-smartq7.c  |   1 -
>  arch/arm/mach-s3c64xx/mach-smdk6400.c |   1 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |   1 -
>  arch/arm/mach-s3c64xx/pm.c            |   7 -
>  arch/arm/mach-shmobile/pm-r8a7779.c   |   1 -
>  arch/arm/mach-shmobile/pm-rmobile.c   |   1 -
>  drivers/base/power/domain.c           | 322 ++++------------------------------
>  drivers/base/power/domain_governor.c  |   7 +-
>  drivers/sh/pm_runtime.c               |  11 --
>  include/linux/pm_domain.h             |  56 +-----
>  20 files changed, 40 insertions(+), 388 deletions(-)
> 

Wow, great diffstat!

I have no idea what this series really does, but I love it ;-)

	Arnd
