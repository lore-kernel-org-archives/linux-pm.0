From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ondemand: fix wrong delay sampling rate
Date: Fri, 23 Nov 2012 19:23:28 +0530
Message-ID: <CAKohpommGWb0WRnUDd_Do4yuadA5RcR4_ULFEqt+t9DNFnCg-Q@mail.gmail.com>
References: <1353676358-4385-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1353676358-4385-1-git-send-email-fabio.baltieri@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23 November 2012 18:42, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Restore the correct delay value for ondemand's od_dbs_timer, as it was
> changed erroneously in 83f0e55.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index bdaab92..cca3e9f 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -234,7 +234,8 @@ static void od_dbs_timer(struct work_struct *work)
>                         dbs_info->sample_type = OD_SUB_SAMPLE;
>                         delay = dbs_info->freq_hi_jiffies;
>                 } else {
> -                       delay = delay_for_sampling_rate(dbs_info->rate_mult);
> +                       delay = delay_for_sampling_rate(od_tuners.sampling_rate
> +                                               * dbs_info->rate_mult);

So sorry for my poor code :(

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
