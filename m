From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] Cpufreq Fixes for 3.9
Date: Sat, 12 Jan 2013 14:27:25 +0100
Message-ID: <3417394.mgXgKYU9J9@vostro.rjw.lan>
References: <cover.1357967566.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38760 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab3ALNVi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Jan 2013 08:21:38 -0500
In-Reply-To: <cover.1357967566.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Saturday, January 12, 2013 10:44:37 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> As requested, i am resending all my cpufreq fixes together. I have added correct
> Tested-by flags.

I have dropped the previous versions and applied this series instead.

There's no need to add a Tested-by for yourself if you sign-off a patch,
though.  Tested-by is information that somebody *in* *addition* to the
original author has tested the patch, because we all should test the patches
we sign-off, right?

Rafael


> Viresh Kumar (5):
>   cpufreq: Manage only online cpus
>   cpufreq: Notify governors when cpus are hot-[un]plugged
>   cpufreq: Don't use cpu removed during cpufreq_driver_unregister
>   cpufreq: Simplify __cpufreq_remove_dev()
>   cpufreq: Simplify cpufreq_add_dev()
> 
>  drivers/cpufreq/cpufreq.c       | 316 +++++++++++++++++-----------------------
>  drivers/cpufreq/cpufreq_stats.c |  27 +++-
>  drivers/cpufreq/freq_table.c    |   9 ++
>  include/linux/cpufreq.h         |  14 +-
>  4 files changed, 178 insertions(+), 188 deletions(-)
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
