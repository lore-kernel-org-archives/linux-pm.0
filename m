From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 linux-next] cpufreq: conservative: Use an inline
 function to evaluate freq_target
Date: Wed, 6 Mar 2013 21:23:24 +0800
Message-ID: <CAKohpokdG2vd5Cp4Lmcnc5ZrLsa-_4Kcy-DvLjG--6SMVsGZkg@mail.gmail.com>
References: <51366C77.3080309@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51366C77.3080309@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6 March 2013 06:06, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Use an inline function to evaluate freq_target to avoid duplicate code.
>
> Also, define a macro for the default frequency step and fix the
> calculation of freq_target when the max freq is less that 100.

Atleast my poor mind can't make out how. To me it looks like broken now.

> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 08be431..029de49 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -28,6 +28,7 @@
>  /* Conservative governor macros */
>  #define DEF_FREQUENCY_UP_THRESHOLD             (80)
>  #define DEF_FREQUENCY_DOWN_THRESHOLD           (20)
> +#define DEF_FREQUENCY_STEP                     (5)
>  #define DEF_SAMPLING_DOWN_FACTOR               (1)
>  #define MAX_SAMPLING_DOWN_FACTOR               (10)
>
> @@ -39,9 +40,20 @@ static struct cs_dbs_tuners cs_tuners = {
>         .down_threshold = DEF_FREQUENCY_DOWN_THRESHOLD,
>         .sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR,
>         .ignore_nice = 0,
> -       .freq_step = 5,
> +       .freq_step = DEF_FREQUENCY_STEP,
>  };
>
> +static inline unsigned int get_freq_target(struct cpufreq_policy *policy)
> +{
> +       unsigned int freq_target = (cs_tuners.freq_step * policy->max) / 100;
> +
> +       /* max freq cannot be less than 100. But who knows... */
> +       if (unlikely(freq_target == 0))
> +               freq_target = DEF_FREQUENCY_STEP * 1000; /* frequency in KHz */

When can we enter this "if" block, probably only in case where max freq is
less than 100 KHz (And because we have freq unit in KHz in cpufreq, its exact
value is less than 100). Lets say its 90.

So, we will get into your "if" block now and would set freq_target to 90 - 5000.

So its broken, isn't it.

Rest is fine.
