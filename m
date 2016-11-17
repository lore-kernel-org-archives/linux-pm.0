From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: conservative: Fix comment explaining
 frequency updates
Date: Thu, 17 Nov 2016 09:10:59 +0530
Message-ID: <20161117034059.GB4894@vireshk-i7>
References: <4986155b-de07-1a4c-186c-71d90b12e75c@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34625 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbcKQDlC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 22:41:02 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so83739101pgx.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2016 19:41:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4986155b-de07-1a4c-186c-71d90b12e75c@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 16-11-16, 21:27, Stratos Karafotis wrote:
> The original comment about the frequency increase to maximum is wrong.
> 
> Both increase and decrease happen at steps.
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  -> v2
> Remove a trailing space
> 
>  drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index a48b724..7522ec6 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -55,8 +55,8 @@ static inline unsigned int get_freq_step(struct cs_dbs_tuners *cs_tuners,
>   * sampling_down_factor, we check, if current idle time is more than 80%
>   * (default), then we try to decrease frequency
>   *
> - * Any frequency increase takes it to the maximum frequency. Frequency reduction
> - * happens at minimum steps of 5% (default) of maximum frequency
> + * Frequency updates happen at minimum steps of 5% (default) of maximum
> + * frequency
>   */
>  static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
