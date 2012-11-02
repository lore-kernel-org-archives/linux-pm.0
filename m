From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: remove the unnecessary initialization of a local variable
Date: Fri, 02 Nov 2012 13:54:05 +0100
Message-ID: <1423078.2ZMUiF84t8@vostro.rjw.lan>
References: <000901cdb72b$74a6af10$5df40d30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52197 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab2KBMt6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 08:49:58 -0400
In-Reply-To: <000901cdb72b$74a6af10$5df40d30$%han@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, October 31, 2012 02:49:13 PM Jingoo Han wrote:
> This patch removes unnecessary initializer for the 'ret' variable.

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 261ef65..4e9fcc5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -404,7 +404,7 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
>  static ssize_t store_##file_name					\
>  (struct cpufreq_policy *policy, const char *buf, size_t count)		\
>  {									\
> -	unsigned int ret = -EINVAL;					\
> +	unsigned int ret;						\
>  	struct cpufreq_policy new_policy;				\
>  									\
>  	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
> @@ -459,7 +459,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
>  					const char *buf, size_t count)
>  {
> -	unsigned int ret = -EINVAL;
> +	unsigned int ret;
>  	char	str_governor[16];
>  	struct cpufreq_policy new_policy;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
