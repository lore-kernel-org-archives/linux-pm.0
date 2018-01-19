From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: remove at32ap-cpufreq
Date: Fri, 19 Jan 2018 11:14:41 +0530
Message-ID: <20180119054441.GM3012@vireshk-i7>
References: <20180118200202.11883-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44605 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeASFos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jan 2018 00:44:48 -0500
Received: by mail-pf0-f193.google.com with SMTP id m26so601511pfj.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 21:44:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180118200202.11883-1-clabbe.montjoie@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 18-01-18, 21:02, Corentin Labbe wrote:
> Since AVR32 arch was removed, at32ap-cpufreq is useless.
> Remove this driver.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/cpufreq/Kconfig          |  10 ---
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/at32ap-cpufreq.c | 127 ---------------------------------------
>  3 files changed, 138 deletions(-)
>  delete mode 100644 drivers/cpufreq/at32ap-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
