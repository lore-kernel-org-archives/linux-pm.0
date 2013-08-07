From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same
 as current
Date: Wed, 7 Aug 2013 16:52:34 +0530
Message-ID: <CAKohpokp04HXau1fOA6w9K675LwRw6uCCZZKyFAJtF1_pkcC=Q@mail.gmail.com>
References: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49192 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401Ab3HGLWf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2013 07:22:35 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so3086656oag.17
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2013 04:22:34 -0700 (PDT)
In-Reply-To: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>

On 7 August 2013 16:46, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> This patch fixes the issue of un-necessary setting the clock controller
> when the new target frequency is same as the current one. This case usually
> occurs with governors like ondemand which passes the target frequency as the
> percentage of average frequency. This check is present in most of the cpufreq
> driver.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied.
