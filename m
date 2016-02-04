From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: governor: fix compile warning
Date: Thu, 4 Feb 2016 18:25:46 +0100
Message-ID: <CAJZ5v0h3wqdQky1NOPS1JzAPo-NfVy3Wz7sQRVWweecvbdHpNA@mail.gmail.com>
References: <1454566011-18072-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36608 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbcBDRZs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 12:25:48 -0500
Received: by mail-lb0-f171.google.com with SMTP id dx2so35382825lbd.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 09:25:47 -0800 (PST)
In-Reply-To: <1454566011-18072-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Feb 4, 2016 at 7:06 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Fix warning reported by 0-day
>> drivers/cpufreq/cpufreq_governor.c:293:4: error: implicit declaration of
>> function 'irq_work_queue_on' [-Werror=implicit-function-declaration]

I'm wondering how you managed to get this error really.

The last patch in my update util series is adding a #include
<linux/irq_work.h> to cpufreq_governor.h, so it should be OK.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 541c323..0da7fc4 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -17,6 +17,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/export.h>
> +#include <linux/irq_work.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/slab.h>
>

Thanks,
Rafael
