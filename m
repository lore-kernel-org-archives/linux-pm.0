From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Remove unnecessary braces
Date: Thu, 20 Mar 2014 05:36:36 +0530
Message-ID: <CAKohpomLRH7QT71+N7_7AveKPU3rgQv37Ye6d=pUcKjC6shtEg@mail.gmail.com>
References: <532A0D0C.50507@semaphore.gr>
	<93042283.W9rbzHbJB2@vostro.rjw.lan>
	<532A2759.1000708@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <532A2759.1000708@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 March 2014 04:55, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> I'm sorry for the inconvenience. I read again the CodingStyle (more carefully :) ).
> I'm sending the corrected patch with the single case of unnecessary braces.
>
> Thanks,
> Stratos
>
> ------------------------8<-----------------------
> Remove unnecessary braces from a single statement.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e3aa9de..220c4a9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1330,10 +1330,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>                 if (new_cpu >= 0) {
>                         update_policy_cpu(policy, new_cpu);
>
> -                       if (!cpufreq_suspended) {
> +                       if (!cpufreq_suspended)
>                                 pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
>                                          __func__, new_cpu, cpu);
> -                       }
>                 }
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
