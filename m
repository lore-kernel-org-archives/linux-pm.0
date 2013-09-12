From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] cpufreq: use correct values of cpus in __cpufreq_remove_dev_finish()
Date: Thu, 12 Sep 2013 12:47:29 +0200
Message-ID: <5076102.HGJgP9ualc@vostro.rjw.lan>
References: <cover.1378963070.git.viresh.kumar@linaro.org> <52316A40.4050600@linux.vnet.ibm.com> <CAKohponzohnOL4Y81Q1W4Yg=paRO46c-gY=HMbkFUqgrjsT+xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponzohnOL4Y81Q1W4Yg=paRO46c-gY=HMbkFUqgrjsT+xw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 12, 2013 02:51:58 PM Viresh Kumar wrote:
> On 12 September 2013 12:46, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> > That sounds good! Even the naming is much better, it conveys the intent
> > clearly.
> 
> Folded below change in my patch (attached):

Please resend.  And I honestly don't think that [1-3/5] are fixes and
[4/5] is not needed any more.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b556d46..23f5845 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1111,7 +1111,7 @@ static int
> cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
>         int ret;
> 
>         /* first sibling now owns the new sysfs dir */
> -       cpu_dev = get_cpu_device(cpumask_first(policy->cpus));
> +       cpu_dev = get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
> 
>         /* Don't touch sysfs files during light-weight tear-down */
>         if (frozen)
> 
> --

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
