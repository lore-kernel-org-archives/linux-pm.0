From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ondemand: allow custom od_ops to be registered
Date: Thu, 28 Mar 2013 13:06:39 +0530
Message-ID: <CAKohpokNNOfawOuvYFnFacMwKQV9gLnhD370UU4-BiVMnft87g@mail.gmail.com>
References: <1364423841-6920-1-git-send-email-jacob.shin@amd.com>
	<1364423841-6920-2-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:49584 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab3C1Hgk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Mar 2013 03:36:40 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so6245116oah.24
        for <linux-pm@vger.kernel.org>; Thu, 28 Mar 2013 00:36:40 -0700 (PDT)
In-Reply-To: <1364423841-6920-2-git-send-email-jacob.shin@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 28 March 2013 04:07, Jacob Shin <jacob.shin@amd.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> +void od_register_ops(struct od_ops *ops)
> +{
> +       if (ops->powersave_bias_init_cpu)
> +               od_ops.powersave_bias_init_cpu = ops->powersave_bias_init_cpu;
> +       if (ops->powersave_bias_target)
> +               od_ops.powersave_bias_target = ops->powersave_bias_target;
> +       if (ops->freq_increase)
> +               od_ops.freq_increase = ops->freq_increase;
> +}

We don't need to support all the three. First and last ones strictly belong
to ondemand governor.
