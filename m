From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpufreq: build fixes
Date: Fri, 30 Jan 2015 01:58:03 +0100
Message-ID: <1773560.dycYOFyPKY@vostro.rjw.lan>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422451015-390439-1-git-send-email-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 28, 2015 02:16:52 PM Arnd Bergmann wrote:
> These came out of running randconfig build tests on ARM. The three
> patches are completely independent, so please apply what looks good.
> 
> The two s3c patches are for old bugs and should go through the
> cpufreq tree.
> 
> The exynos bug only exists in the thermal-soc tree at the moment
> and should get picked up by Eduardo with an Ack from the cpufreq
> maintainers, or alternatively the bug should get fixed differently
> if someone can come up with a better solution.
> 
> Arnd Bergmann (3):
>   cpufreq: s3c: remove incorrect __init annotations
>   cpufreq: s3c: remove last use of resume_clocks callback
>   cpufreq: exynos: allow modular build
> 
>  drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
>  drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
>  drivers/cpufreq/exynos4210-cpufreq.c |  1 +
>  drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
>  drivers/cpufreq/exynos5250-cpufreq.c |  1 +
>  drivers/cpufreq/s3c2416-cpufreq.c    |  4 ++--
>  drivers/cpufreq/s3c24xx-cpufreq.c    | 10 +---------
>  7 files changed, 18 insertions(+), 19 deletions(-)

I'm assuming that this series will go in through the Samsumg tree.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
