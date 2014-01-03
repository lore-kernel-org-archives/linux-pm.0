From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Fri, 3 Jan 2014 12:20:05 +0530
Message-ID: <CAKohpomWCpxCSFfG601Pc_FKcbZ3J7G2nsBABMb8qqQJ38h1cg@mail.gmail.com>
References: <1388731451-10963-1-git-send-email-jiel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:64767 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaACGuH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2014 01:50:07 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so15822534oag.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2014 22:50:05 -0800 (PST)
In-Reply-To: <1388731451-10963-1-git-send-email-jiel@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jane Li <jiel@marvell.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 3 January 2014 12:14,  <jiel@marvell.com> wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index dc196bb..15c62df 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -389,6 +389,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                                    unsigned int relation);
>  int cpufreq_register_governor(struct cpufreq_governor *governor);
>  void cpufreq_unregister_governor(struct cpufreq_governor *governor);
> +extern struct mutex cpufreq_governor_lock;
>
>  /* CPUFREQ DEFAULT GOVERNOR */
>  /*

Move this to cpufreq_governor.h instead. I don't want this to be available
for everybody to use it.
