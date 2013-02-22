From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/4] cpufreq: governor: Implement per policy instances
 of governors
Date: Fri, 22 Feb 2013 07:53:43 +0530
Message-ID: <CAKohpon5KSV4ZyijuG9hNqEXxwXzFev1AcygKWL9-scyWxhOyw@mail.gmail.com>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
	<eada017a865d03fe67df39c4672f258fb2d71447.1360568193.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45397 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3BVCXo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 21:23:44 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so166252obb.22
        for <linux-pm@vger.kernel.org>; Thu, 21 Feb 2013 18:23:44 -0800 (PST)
In-Reply-To: <eada017a865d03fe67df39c4672f258fb2d71447.1360568193.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com, Viresh Kumar <viresh.kumar@linaro.org>

On 11 February 2013 13:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h

>  #define CPUFREQ_PRECHANGE      (0)
> @@ -183,11 +197,10 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div, u_int mu
>  #define CPUFREQ_GOV_STOP       2
>  #define CPUFREQ_GOV_LIMITS     3
>  #define CPUFREQ_GOV_POLICY_INIT        4
> -#define CPUFREQ_GOV_POLICY_EXIT        4
> +#define CPUFREQ_GOV_POLICY_EXIT        5

See, i told you i had this change, but got merged to the wrong commit. :)
