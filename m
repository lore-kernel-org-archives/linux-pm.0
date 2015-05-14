From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: exynos: remove Exynos4210 specific cpufreq
 driver support
Date: Thu, 14 May 2015 10:33:12 +0530
Message-ID: <20150514050312.GA26341@linux>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-7-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34683 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbENFDO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 01:03:14 -0400
Received: by pdbqa5 with SMTP id qa5so73397050pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 22:03:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428079429-4252-7-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 03-04-15, 18:43, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Exynos4210 based platforms have switched over to use generic
> cpufreq driver for cpufreq functionality. So the Exynos
> specific cpufreq support for these platforms can be removed.
> 
> Changes by Bartlomiej:
> - dropped Exynos5250 support removal for now
> - updated exynos-cpufreq.[c,h]
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   11 --
>  drivers/cpufreq/Makefile             |    1 -
>  drivers/cpufreq/exynos-cpufreq.c     |    5 +-
>  drivers/cpufreq/exynos-cpufreq.h     |    9 --
>  drivers/cpufreq/exynos4210-cpufreq.c |  184 ----------------------------------
>  5 files changed, 1 insertion(+), 209 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
