From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] PM / OPP: Move the OPP directory out of power/
Date: Tue, 26 Sep 2017 10:41:06 +0530
Message-ID: <2cdd51f6-c5ac-9fe3-60df-d83a06ec85d0@ti.com>
References: <2767b448493ca16f064618d36387ac56dfec0e56.1506384278.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:35619 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934183AbdIZFLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 01:11:15 -0400
In-Reply-To: <2767b448493ca16f064618d36387ac56dfec0e56.1506384278.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org

On Tuesday 26 September 2017 05:35 AM, Viresh Kumar wrote:
> The drivers/base/power/ directory is special and contains code related
> to power management core like system suspend/resume, hibernation, etc.
> It was fine to keep the OPP code inside it when we had just one file for
> it, but it is growing now and already has a directory for itself.
> 
> Lets move it directly under drivers/ directory, just like cpufreq and
> cpuidle.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/Makefile                       | 1 +
>  drivers/base/power/Makefile            | 1 -
>  drivers/{base/power => }/opp/Makefile  | 0
>  drivers/{base/power => }/opp/core.c    | 0
>  drivers/{base/power => }/opp/cpu.c     | 0
>  drivers/{base/power => }/opp/debugfs.c | 0
>  drivers/{base/power => }/opp/of.c      | 0
>  drivers/{base/power => }/opp/opp.h     | 0
>  8 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/{base/power => }/opp/Makefile (100%)
>  rename drivers/{base/power => }/opp/core.c (100%)
>  rename drivers/{base/power => }/opp/cpu.c (100%)
>  rename drivers/{base/power => }/opp/debugfs.c (100%)
>  rename drivers/{base/power => }/opp/of.c (100%)
>  rename drivers/{base/power => }/opp/opp.h (100%)

MAINTAINERS needs update too. Also, shouldn't PM_OPP now find a home in
drivers/opp/Kconfig?

Thanks,
Sekhar
