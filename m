From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Take limits changes into account properly
Date: Tue, 16 Oct 2018 08:38:49 +0200
Message-ID: <CAHKzcEPsiR1zDQgw_N5Fu7tX+fP+brOs0okvK3yBr=16Y9S28w@mail.gmail.com>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
 <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com> <5406371.vuaACy5i7F@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5406371.vuaACy5i7F@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-kernel@vger.kernel.org, "Bartholomae, Thomas" <t.bartholomae@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Oct 2018 at 23:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the policy limits change between invocations of cs_dbs_update(),
> the requested frequency value stored in dbs_info may not be updated
> and the function may use a stale value of it next time.  Moreover, if
> idle periods are takem into account by cs_dbs_update(), the requested
> frequency value stored in dbs_info may be below the min policy limit,
> which is incorrect.
>
> To fix these problems, always update the requested frequency value
> in dbs_info along with the local copy of it when the previous
> requested frequency is beyond the policy limits and avoid decreasing
> the requested frequency below the min policy limit when taking
> idle periods into account.
>
> Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> @@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
>          * changed in the meantime, so fall back to current frequency in that
>          * case.
>          */
> -       if (requested_freq > policy->max || requested_freq < policy->min)
> +       if (requested_freq > policy->max || requested_freq < policy->min) {
>                 requested_freq = policy->cur;
> +               dbs_info->requested_freq = requested_freq;
> +       }
>
>         freq_step = get_freq_step(cs_tuners, policy);
>
> @@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
>         if (policy_dbs->idle_periods < UINT_MAX) {
>                 unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
>
> -               if (requested_freq > freq_steps)
> +               if (requested_freq > policy->min + freq_steps)
>                         requested_freq -= freq_steps;
>                 else
>                         requested_freq = policy->min;

Looks good.

Acked-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
