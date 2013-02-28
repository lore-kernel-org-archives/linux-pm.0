From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next 3/3] cpufreq: conservative: Fix relation when
 decreasing frequency
Date: Thu, 28 Feb 2013 11:17:03 +0530
Message-ID: <CAKohpomiG1G2NUScDpzbqTBJAOfNr3PcWe55PoGK8bvY4tCdMw@mail.gmail.com>
References: <1362029882-28993-1-git-send-email-namhyung@kernel.org>
	<1362029882-28993-3-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1362029882-28993-3-git-send-email-namhyung@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Namhyung Kim <namhyung.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On 28 February 2013 11:08, Namhyung Kim <namhyung@kernel.org> wrote:
> From: Namhyung Kim <namhyung.kim@lge.com>
>
> The relation should be CPUFREQ_RELATION_L to find optimal frequency
> when decreasing.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index dd2fd9094819..0d582811d66c 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -106,7 +106,7 @@ static void cs_check_cpu(int cpu, unsigned int load)
>                         dbs_info->requested_freq = policy->min;
>
>                 __cpufreq_driver_target(policy, dbs_info->requested_freq,
> -                               CPUFREQ_RELATION_H);
> +                               CPUFREQ_RELATION_L);

Other two patches are fine but really not sure about this one.
When decreasing freq, what do we want:
- lowest frequency at or above target, i.e. >= requested_freq
- highest frequency below or at target, i.e. <= requested_freq

I thought second option was better and so CPUFREQ_RELATION_H
suits more. What made you do this change?
