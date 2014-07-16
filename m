From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Wed, 16 Jul 2014 12:19:37 -0700
Message-ID: <53C6D049.7000705@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <53C5C738.5040705@codeaurora.org>
 <CAKohpomt34NcMH=H5L_fhf-6R6p27_h=aCNcpT6T12u35d=Z+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohpomt34NcMH=H5L_fhf-6R6p27_h=aCNcpT6T12u35d=Z+w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 07/16/2014 01:30 AM, Viresh Kumar wrote:
> On 16 July 2014 05:58, Saravana Kannan <skannan@codeaurora.org> wrote:
>>> +       if (!cpus && cpufreq_driver->stop_cpu &&
>>> cpufreq_driver->setpolicy) {
>>> +               cpufreq_driver->stop_cpu(policy);
>>> +       }
>>>
>>
>> Viresh, I tried your suggestion (and my initial thought too) to combine this
>> as an if/else with the previous if. But the indentation got nasty and made
>> it hard to read. I'm sure the compiler will optimize it. So, I would prefer
>> to leave it this way.
>
> Okay, I gave that comment again :)
>
> Try this:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f72b2b7..092a0ba 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -991,8 +991,10 @@ static int cpufreq_change_policy_cpus(struct
> cpufreq_policy *policy,
>                                          CPUFREQ_UPDATE_POLICY_CPU, policy);
>          }
>
> -       cpus = !cpumask_empty(policy->cpus);
> -       if (has_target() && cpus) {
> +       if (!cpumask_empty(policy->cpus)) {
> +               if (!has_target())
> +                       goto unlock;
> +
>                  ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
>                  if (!ret)
>                          ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> @@ -1001,9 +1003,7 @@ static int cpufreq_change_policy_cpus(struct
> cpufreq_policy *policy,
>                          pr_err("%s: Failed to start governor\n", __func__);
>                          goto unlock;
>                  }
> -       }
> -
> -       if (!cpus && cpufreq_driver->stop_cpu && cpufreq_driver->setpolicy) {
> +       } else if (cpufreq_driver->stop_cpu && cpufreq_driver->setpolicy) {
>                  cpufreq_driver->stop_cpu(policy);
>          }
>

Not bad :) I'll take it.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
