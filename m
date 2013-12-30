From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Mon, 30 Dec 2013 12:04:51 +0530
Message-ID: <CAKohpomwA0PHBvFiK+-i6LDHX8J_s2hfm4-ciKFB9DSS8q0Wdw@mail.gmail.com>
References: <1388136651-21883-1-git-send-email-jiel@marvell.com>
	<CAKohpokWMgXotgKWFmqOPzdoZME=frBQOjeU1uFJwQ778DHAKg@mail.gmail.com>
	<52C112CC.4040306@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52C112CC.4040306@marvell.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jane Li <jiel@marvell.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 December 2013 11:59, Jane Li <jiel@marvell.com> wrote:
> I checked my code, and found I lost following part.
> My local code base is not exactly same as open source, and has included
> this.
>
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index e6be635..c4d0ee6 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -19,6 +19,7 @@
>  #include <linux/export.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/slab.h>
> +#include <linux/cpufreq.h>
>
>  #include "cpufreq_governor.h"

This shouldn't be required as cpufreq_governor.h must be including
cpufreq.h..

> Yes, I test it. After adding cpufreq_governor_lock in gov_queue_work() and
> running same test, there is no debugobjects warning.

But it really can't work at all.. There should be a separate copy of lock
in every file that includes cpufreq.h.. And so this shouldn't have worked.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 16d7b4a..185c9f5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -39,7 +39,7 @@ static struct cpufreq_driver *cpufreq_driver;
>
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
> -static DEFINE_MUTEX(cpufreq_governor_lock);
> +DEFINE_MUTEX(cpufreq_governor_lock);
>
>  static LIST_HEAD(cpufreq_policy_list);
>
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index e6be635..485ee0d 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,8 @@
>
>  #include "cpufreq_governor.h"
>
> +extern struct mutex cpufreq_governor_lock;
> +

Looks fine.
