From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Use consistent prefixing via pr_fmt
Date: Wed, 6 Apr 2016 11:53:15 +0530
Message-ID: <20160406062315.GU20655@vireshk-i7>
References: <cover.1459887986.git.joe@perches.com>
 <45c8dae5844fb626ab6f4e59298e225c3315269e.1459887986.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36793 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbcDFGXU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 02:23:20 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so26911336pfe.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2016 23:23:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <45c8dae5844fb626ab6f4e59298e225c3315269e.1459887986.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 05-04-16, 13:28, Joe Perches wrote:
> Use the more common kernel style adding a define for pr_fmt.
> 
> Miscellanea:
> 
> o Remove now unused PFX defines
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c            |  8 ++---
>  drivers/cpufreq/cpufreq-nforce2.c         | 20 +++++------
>  drivers/cpufreq/e_powersaver.c            | 38 ++++++++++----------
>  drivers/cpufreq/elanfreq.c                |  2 ++
>  drivers/cpufreq/ia64-acpi-cpufreq.c       |  5 +--
>  drivers/cpufreq/longhaul.c                | 60 +++++++++++++++----------------
>  drivers/cpufreq/loongson2_cpufreq.c       |  7 ++--
>  drivers/cpufreq/maple-cpufreq.c           |  6 ++--
>  drivers/cpufreq/omap-cpufreq.c            |  5 ++-
>  drivers/cpufreq/p4-clockmod.c             | 10 +++---
>  drivers/cpufreq/pmac32-cpufreq.c          |  8 +++--
>  drivers/cpufreq/pmac64-cpufreq.c          | 28 ++++++++-------
>  drivers/cpufreq/powernow-k6.c             | 15 ++++----
>  drivers/cpufreq/powernow-k7.c             | 43 +++++++++++-----------
>  drivers/cpufreq/pxa2xx-cpufreq.c          | 13 +++----
>  drivers/cpufreq/s3c2412-cpufreq.c         | 14 ++++----
>  drivers/cpufreq/s3c2440-cpufreq.c         |  2 ++
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c |  2 ++
>  drivers/cpufreq/s3c24xx-cpufreq.c         |  8 +++--
>  drivers/cpufreq/s5pv210-cpufreq.c         |  6 ++--
>  drivers/cpufreq/sc520_freq.c              |  6 ++--
>  drivers/cpufreq/speedstep-centrino.c      |  5 +--
>  drivers/cpufreq/speedstep-ich.c           |  8 +++--
>  drivers/cpufreq/speedstep-lib.c           |  4 ++-
>  drivers/cpufreq/speedstep-smi.c           |  4 ++-
>  25 files changed, 181 insertions(+), 146 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
