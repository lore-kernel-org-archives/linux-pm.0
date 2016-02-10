From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 5/7] cpufreq: governor: No need to manage state machine now
Date: Wed, 10 Feb 2016 01:36:09 +0100
Message-ID: <CAJZ5v0gHk5L9vJ+BTnXdHAMzFZr7GX2RAD4gjSs+6L=NG3a0FQ@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<9b7ac57013a525863d6c0c5e86419744d37879a4.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35268 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbcBJAgK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 19:36:10 -0500
In-Reply-To: <9b7ac57013a525863d6c0c5e86419744d37879a4.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> cpufreq core now guarantees that policy->rwsem wouldn't get dropped

"The cpufreq core ..." and "won't be dropped"

> while calling CPUFREQ_GOV_POLICY_EXIT governor event and will be kept

"while running the ->governor callback for the CPUFREQ_GOV_POLICY_EXIT
event and will be held"

> acquired until the complete sequence of governor state changes has
> finished.
>
> And so we can remove the state machine checks that were put in place
> earlier.

"This allows governor state machine checks to be dropped from multiple
functions in cpufreq_governor.c."

>
> This also means that policy_dbs->policy can be initialized while

"initialized upfront"

> policy_dbs is allocated, to move all initialization together.

"so the entire initialization of struct policy_dbs is carried out in one place."

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 27 +++++----------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 7038ada3915d..464f346815e0 100644

[cut]

> @@ -650,14 +644,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
>
>  static int cpufreq_governor_stop(struct cpufreq_policy *policy)
>  {
> -       struct policy_dbs_info *policy_dbs = policy->governor_data;
> -
> -       /* State should be equivalent to START */
> -       if (!policy_dbs->policy)
> -               return -EBUSY;
> -
> -       gov_cancel_work(policy_dbs);
> -       policy_dbs->policy = NULL;
> +       gov_cancel_work(policy);
>
>         return 0;
>  }

So maybe we can call gov_cancel_work(policy) from
cpufreq_governor_dbs() directly and get rid of this wrapper too?

Thanks,
Rafael
