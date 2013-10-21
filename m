From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s3c64xx: Rename index to driver_data
Date: Mon, 21 Oct 2013 12:59:30 +0530
Message-ID: <CAKohpom-KBME6fa3BUmKfZSgJxYngD7RG+CD3vHHKdtWtrtOxA@mail.gmail.com>
References: <1381775807-20144-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50129 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3JUH3c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 03:29:32 -0400
Received: by mail-qc0-f182.google.com with SMTP id n7so2554632qcx.27
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 00:29:31 -0700 (PDT)
In-Reply-To: <1381775807-20144-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com

On 15 October 2013 00:06, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> The index field of cpufreq_frequency_table has been renamed to driver
> data in this commit:
>
> commit 5070158804b5339c71809f5e673cea1cfacd804d
> cpufreq: rename index as driver_data in cpufreq_frequency_table
>
> This patch updates the s3c64xx driver to match.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> index 8a72b0c..15631f9 100644
> --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> @@ -166,7 +166,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
>                 if (freq->frequency == CPUFREQ_ENTRY_INVALID)
>                         continue;
>
> -               dvfs = &s3c64xx_dvfs_table[freq->index];
> +               dvfs = &s3c64xx_dvfs_table[freq->driver_data];
>                 found = 0;
>
>                 for (i = 0; i < count; i++) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: Can you please get this in 3.12 as a bug fix?
