From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 3/6] cpufreq: Export user_policy min/max
Date: Fri, 6 Jan 2012 07:33:20 -0800
Message-ID: <20120106153320.GF12530@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-4-git-send-email-amiettinen@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325810186-28986-4-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Why do you need to export these values here and from the pmqos ABI?

I don't think we want this change.  Also, isn't it redundant WRT
existing CPU freq govoner sysfs output?

--mark

On Fri, Jan 06, 2012 at 02:36:23AM +0200, Antti P Miettinen wrote:
> Add sysfs nodes for user_policy min and max settings.
> 
> Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8c2df34..e63b29f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -364,6 +364,8 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>  show_one(scaling_min_freq, min);
>  show_one(scaling_max_freq, max);
>  show_one(scaling_cur_freq, cur);
> +show_one(policy_min_freq, user_policy.min);
> +show_one(policy_max_freq, user_policy.max);
>  
>  static int __cpufreq_set_policy(struct cpufreq_policy *data,
>  				struct cpufreq_policy *policy);
> @@ -582,6 +584,8 @@ cpufreq_freq_attr_rw(scaling_min_freq);
>  cpufreq_freq_attr_rw(scaling_max_freq);
>  cpufreq_freq_attr_rw(scaling_governor);
>  cpufreq_freq_attr_rw(scaling_setspeed);
> +cpufreq_freq_attr_ro(policy_min_freq);
> +cpufreq_freq_attr_ro(policy_max_freq);
>  
>  static struct attribute *default_attrs[] = {
>  	&cpuinfo_min_freq.attr,
> @@ -595,6 +599,8 @@ static struct attribute *default_attrs[] = {
>  	&scaling_driver.attr,
>  	&scaling_available_governors.attr,
>  	&scaling_setspeed.attr,
> +	&policy_min_freq.attr,
> +	&policy_max_freq.attr,
>  	NULL
>  };
>  
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
