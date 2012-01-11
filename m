From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 4/6] cpufreq: Preserve sysfs min/max request
Date: Wed, 11 Jan 2012 23:56:58 +0200
Message-ID: <87mx9tdhsl.fsf@amiettinen-lnx.nvidia.com>
References: <1325844234-478-1-git-send-email-amiettinen@nvidia.com>
	<1325844234-478-5-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Any comments to this change?

Antti P Miettinen <amiettinen@nvidia.com> writes:
> Store the value received via sysfs as the user_policy
> min/max value instead of the currently enforced min/max.
> This allows restoring the user min/max values when
> constraints on enforced min/max change.
>
> Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e63b29f..65a512b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -389,7 +389,7 @@ static ssize_t store_##file_name					\
>  		return -EINVAL;						\
>  									\
>  	ret = __cpufreq_set_policy(policy, &new_policy);		\
> -	policy->user_policy.object = policy->object;			\
> +	policy->user_policy.object = new_policy.object;			\
>  									\
>  	return ret ? ret : count;					\
>  }

	--Antti
