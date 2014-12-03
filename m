From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv3 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Wed, 3 Dec 2014 12:00:58 +0530
Message-ID: <CAKohpomv8fXqVEBWkmJTHKrkdVUbZCodV_D_pu3hjRqH0wUEeg@mail.gmail.com>
References: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61725 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaLCGa7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 01:30:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id nt9so4056051obb.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 22:30:58 -0800 (PST)
In-Reply-To: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 28 November 2014 at 20:23, Eduardo Valentin <edubezval@gmail.com> wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1ab0018..88d2775 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -440,6 +440,9 @@ __cpufreq_cooling_register(struct device_node *np,
>         int ret = 0, i;
>         struct cpufreq_policy policy;
>
> +       if (!cpufreq_frequency_get_table(0))

Please add a pr_debug() here, that will be quite useful while debugging.

Also, you can't simply pass 0 to get_table() above. We might be
registering the cooling device for some other cluster as well..

This is what I have done in my patch earlier.

cpufreq_frequency_get_table(cpumask_first(clip_cpus));

And this will work for all cases.
