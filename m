From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] cpufreq: intel_pstate: Remove duplicate CPU ID check
Date: Tue, 10 Jun 2014 10:51:49 +0530
Message-ID: <CAKohpokABMSRr88Tf=+Kn4b4=r7ThE+mjdAZcU+dvo28b47Kcg@mail.gmail.com>
References: <53962059.6070306@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:64127 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaFJFVu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 01:21:50 -0400
Received: by mail-oa0-f48.google.com with SMTP id g18so6917662oah.7
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2014 22:21:49 -0700 (PDT)
In-Reply-To: <53962059.6070306@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10 June 2014 02:30, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> We check the CPU ID during driver init. There is no need
> to do it again per logical CPU initialization.
>
> So, remove the duplicate check.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index aebd457..4e7f492 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -691,14 +691,8 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
>
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
> -
> -       const struct x86_cpu_id *id;
>         struct cpudata *cpu;
>
> -       id = x86_match_cpu(intel_pstate_cpu_ids);
> -       if (!id)
> -               return -ENODEV;
> -
>         all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
>         if (!all_cpu_data[cpunum])
>                 return -ENOMEM;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
