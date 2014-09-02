From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Remove unneeded variable
Date: Tue, 2 Sep 2014 10:14:57 +0530
Message-ID: <CAKohpomMPiMALaamoio_+aBRaJfiONXanFMzFx+iuOKYjDfwFg@mail.gmail.com>
References: <1409574225-5618-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409574225-5618-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 September 2014 17:53, Gabriele Mazzotta <gabriele.mzt@gmail.com> wrote:
> It should have been removed with commit d1b6848590af
> ("cpufreq / intel_pstate: Optimize intel_pstate_set_policy")
>
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index e396ad3..0668b38 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -708,10 +708,6 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
>
>  static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  {
> -       struct cpudata *cpu;
> -
> -       cpu = all_cpu_data[policy->cpu];
> -
>         if (!policy->cpuinfo.max_freq)
>                 return -ENODEV;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
