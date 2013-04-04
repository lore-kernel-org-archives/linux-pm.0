From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] cpufreq: ondemand: allow custom
 powersave_bias_target handler to be registered
Date: Thu, 4 Apr 2013 22:06:35 +0530
Message-ID: <CAKohpom6BSJZc_ohgnjRTV2EBUAPy8TKVphtoRaNSt1wFP70uA@mail.gmail.com>
References: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
	<1365092344-11310-2-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:56446 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763207Ab3DDQgh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 12:36:37 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so2699067obc.40
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2013 09:36:35 -0700 (PDT)
In-Reply-To: <1365092344-11310-2-git-send-email-jacob.shin@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Borislav Petkov <bp@alien8.de>

On 4 April 2013 21:49, Jacob Shin <jacob.shin@amd.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c

> +static void od_set_powersave_bias(unsigned int powersave_bias)
> +{
> +       unsigned int cpu;
> +       struct od_dbs_tuners *od_tuners;
> +
> +       if (!have_governor_per_policy()) {
> +               od_tuners = od_dbs_cdata.gdbs_data->tuners;
> +               od_tuners->powersave_bias = powersave_bias;
> +               return;
> +       }
> +
> +       for_each_online_cpu(cpu) {
> +               struct cpufreq_policy *policy;
> +               struct dbs_data *dbs_data;
> +               policy = per_cpu(od_cpu_dbs_info, cpu).cdbs.cur_policy;
> +               dbs_data = policy->governor_data;
> +               od_tuners = dbs_data->tuners;
> +               od_tuners->powersave_bias = powersave_bias;
> +       }

You can keep only the for_each_online_cpu() loop and remove the other
one. And in that one also, you don't have to do this for every cpu...

something like this will help you...

cpus_processed = NULL;

for_each_online_cpu(cpu) {
    if cpu-is-present-in cpus_processed
        continue;

    cpu-set-mask(cpus_processed, policy->cpus);

}

Syntax is poor, please choose the correct one.

> +}
