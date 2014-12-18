From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: fix a NULL pointer dereference triggered by
 _PPC changed notification
Date: Thu, 18 Dec 2014 11:53:25 +0530
Message-ID: <CAKohponW0XE9vaxmQ-NKF2awdZ_GxRa2NJUwcTTfkVSG7s=h2A@mail.gmail.com>
References: <1418883638-26906-1-git-send-email-ethan.zhao@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:49803 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaLRGXZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 01:23:25 -0500
Received: by mail-ob0-f172.google.com with SMTP id va8so1809771obc.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 22:23:25 -0800 (PST)
In-Reply-To: <1418883638-26906-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.zhao@oracle.com>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, kristen@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linda Knippers <linda.knippers@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ethan.kernel@gmail.com

On 18 December 2014 at 11:50, Ethan Zhao <ethan.zhao@oracle.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4473eba..b75735c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2021,6 +2021,11 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>         /* Don't start any governor operations if we are entering suspend */
>         if (cpufreq_suspended)
>                 return 0;
> +       /* Governor might not be initiated here if _PPC changed notification
> +        * happened, check it.
> +        */

Its still wrong.

/*
 * Governor might not be initiated here if _PPC changed notification
 * happened, check it.
 */
