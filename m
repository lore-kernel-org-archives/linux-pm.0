From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Add Tegra186 cpufreq driver
Date: Tue, 11 Apr 2017 12:05:48 +0530
Message-ID: <20170411063548.GD3670@vireshk-i7>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35835 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdDKGfw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 02:35:52 -0400
Received: by mail-pf0-f179.google.com with SMTP id i5so44200059pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2017 23:35:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

On 04-04-17, 16:43, Mikko Perttunen wrote:
> Add a new cpufreq driver for Tegra186 (and likely later).
> The CPUs are organized into two clusters, Denver and A57,
> with two and four cores respectively. CPU frequency can be
> adjusted by writing the desired rate divisor and a voltage
> hint to a special per-core register.
> 
> The frequency of each core can be set individually; however,
> this is just a hint as all CPUs in a cluster will run at
> the maximum rate of non-idle CPUs in the cluster.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Many cosmetic / restructuring changes
> - Only one aperture read from DT now, with a new
>   structure containing the offset among other details
>   per cluster.
> - Don't enable the driver by default.
> 
>  drivers/cpufreq/Kconfig.arm        |   6 +
>  drivers/cpufreq/Makefile           |   1 +
>  drivers/cpufreq/tegra186-cpufreq.c | 275 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 282 insertions(+)
>  create mode 100644 drivers/cpufreq/tegra186-cpufreq.c

For all three patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
