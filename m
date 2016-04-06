From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Drop stale comment
Date: Thu, 07 Apr 2016 01:33:16 +0200
Message-ID: <1850547.Z4XbnPBHDc@vostro.rjw.lan>
References: <815261ca63befe7070b279b7c7373f0828d0c1bc.1458793308.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45853 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752352AbcDFXaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 19:30:46 -0400
In-Reply-To: <815261ca63befe7070b279b7c7373f0828d0c1bc.1458793308.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, March 24, 2016 09:51:57 AM Viresh Kumar wrote:
> The comment in file header doesn't hold true anymore, drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index f951f911786e..5f8dbe640a20 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -4,9 +4,6 @@
>   * Copyright (C) 2014 Linaro.
>   * Viresh Kumar <viresh.kumar@linaro.org>
>   *
> - * The OPP code in function set_target() is reused from
> - * drivers/cpufreq/omap-cpufreq.c
> - *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.

Applied, thanks!

