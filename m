From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Set policy->related_cpus to atleast policy->cpus
Date: Tue, 29 Jan 2013 20:00:23 +0530
Message-ID: <CAKohpomDtasshcO53eD0kR1c3aO+ePC5pAK_mGjJn1EKAMBf_w@mail.gmail.com>
References: <d6827976a56d429848ab8ababa2779a21c68d65f.1359434113.git.viresh.kumar@linaro.org>
	<2215618.GPIWS1OcnB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2215618.GPIWS1OcnB@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: inderpal.singh@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On 29 January 2013 17:21, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, January 29, 2013 10:09:59 AM Viresh Kumar wrote:
>> With the addition of following patch, related_cpus is required to be set by
>> cpufreq platform drivers:
>>
>> commit c1070fd743533efb54e98142252283583f379190
>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>> Date:   Mon Jan 14 13:23:04 2013 +0000
>>
>>     cpufreq: Simplify cpufreq_add_dev()
>>
>
> I've dropped this one in the meantime.
>
> Can you please fold the $subject patch into "cpufreq: Simplify cpufreq_add_dev()"
> and post the result instead?  That surely will be less confusing?

Okay. I will squash this one with cpufreq_add_dev() one + following line:

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 8ff26af..fc714a6 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -189,7 +189,6 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
        policy->cur = spear_cpufreq_get(0);

        cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
-       cpumask_copy(policy->related_cpus, policy->cpus);

        return 0;
 }


Also, because you are happy loosing your commit history in linux-next,
you can drop
the patch that i have reverted as 2/2 of this set.

I will resend the rest again.
