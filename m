From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] Cpufreq: Make governor data on nonboot cpus across system suspend/resume
Date: Sun, 17 Nov 2013 15:44:24 +0100
Message-ID: <3555392.CLJaBWE9DL@vostro.rjw.lan>
References: <9847309.KdKOG5y1Zx@vostro.rjw.lan> <1384616184-6197-1-git-send-email-tianyu.lan@intel.com> <5288425A.6000501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5288425A.6000501@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, November 17, 2013 09:43:14 AM viresh kumar wrote:
> On 16 November 2013 21:06, Lan Tianyu <tianyu.lan@intel.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > @@ -1818,9 +1818,13 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
> >                 mutex_unlock(&cpufreq_governor_lock);
> >         }
> >
> > -       if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
> > -                       ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
> > +       if ((event == CPUFREQ_GOV_POLICY_INIT) && ret) {
> > +               module_put(policy->governor->owner);
> > +               if (ret == -EALREADY)
> > +                       return 0;
> > +       } else if ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret) {
> >                 module_put(policy->governor->owner);
> > +       }
> 
> This can still be written more efficiently I believe:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 138ebe9..54e28e1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1866,10 +1866,12 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>         ret = policy->governor->governor(policy, event);
> 
>         if (!ret) {
> -               if (event == CPUFREQ_GOV_POLICY_INIT)
> +               if (event == CPUFREQ_GOV_POLICY_INIT) {
>                         policy->governor->initialized++;
> -               else if (event == CPUFREQ_GOV_POLICY_EXIT)
> +               } else if (event == CPUFREQ_GOV_POLICY_EXIT) {
>                         policy->governor->initialized--;
> +                       module_put(policy->governor->owner);
> +               }
>         } else {
>                 /* Restore original values */
>                 mutex_lock(&cpufreq_governor_lock);
> @@ -1877,13 +1879,14 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>                         policy->governor_enabled = true;
>                 else if (event == CPUFREQ_GOV_START)
>                         policy->governor_enabled = false;
> +               else if (event == CPUFREQ_GOV_POLICY_INIT)
> +                       if (ret == -EALREADY) {

You can write this as

               else if (event == CPUFREQ_GOV_POLICY_INIT && ret == -EALREADY) {

> +                               module_put(policy->governor->owner);
> +                               ret = 0;
> +                       }
>                 mutex_unlock(&cpufreq_governor_lock);
>         }
> 
> -       if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
> -                       ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
> -               module_put(policy->governor->owner);
> -
>         return ret;

Apart from the above I agree.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
