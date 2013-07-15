From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Mon, 15 Jul 2013 15:25:47 +0530
Message-ID: <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
	<20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60320 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GOJzs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 05:55:48 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so13866869obc.9
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 02:55:47 -0700 (PDT)
In-Reply-To: <20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Srivatsa,

I may be wrong but it looks something is wrong in this patch.

On 12 July 2013 03:47, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c

> @@ -1239,29 +1263,40 @@ static int __cpufreq_remove_dev(struct device *dev,
>         if ((cpus == 1) && (cpufreq_driver->target))
>                 __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
>
> -       pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> -       cpufreq_cpu_put(data);
> +       if (!frozen) {
> +               pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> +               cpufreq_cpu_put(data);

So, we don't decrement usage count here. But we are still increasing
counts on cpufreq_add_dev after resume, isn't it?

So, we wouldn't be able to free policy struct once all the cpus of a
policy are removed after suspend/resume has happened once.
