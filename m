From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250 platform
Date: Mon, 20 Apr 2015 14:07:33 -0700
Message-ID: <7h1tjeh5ka.fsf@deeprootsystems.com>
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
	(Bartlomiej Zolnierkiewicz's message of "Mon, 13 Apr 2015 19:33:57
	+0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> Hi,
>
> This patch series removes the use of Exynos5250 specific support
> from exynos-cpufreq driver and enables the use of cpufreq-dt driver
> for this platform.  The exynos-cpufreq driver itself is also removed
> as it is no longer used/needed after Exynos5250 support removal.
>
> This patch series has been tested on Exynos5250 based Arndale board.
>
> Depends on:
> - next-20150330 branch of linux-next kernel tree
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
>   platform" [1]
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
>   platform" [2]
> - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]

Any chance you could prepare a branch with all the dependencies for easy
testing?

Also, The previous version from Thomas was v12, and this one is neither
versioned nor has any reference to what may have changed since that
version.  Also, on v12, I had several comments[1] and wonder if they've
been addressed.

Kevin

[1] http://article.gmane.org/gmane.linux.power-management.general/53494/match=patch+v12+0+6+use+generic+cpufreq
