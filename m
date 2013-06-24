From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix race between sysfs writes and hotplug/policy update
Date: Mon, 24 Jun 2013 11:38:16 +0530
Message-ID: <CAKohpom74ZX90j3f3kcLxPjYBWjHbd3urJ2MXQwtNWKwwpi=xQ@mail.gmail.com>
References: <1371956540-8830-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1371956540-8830-1-git-send-email-skannan@codeaurora.org>
Sender: cpufreq-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Saravana,

On 23 June 2013 08:32, Saravana Kannan <skannan@codeaurora.org> wrote:
> The sysfs store ops need to grab the policy write semaphore to avoid race
> with hotplug and cpufreq_update_policy() calls. Without this, we could end
> up with simultaneous calls to cpufreq_driver->target()

Interesting.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2d53f47..37db7f0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -420,9 +420,13 @@ static ssize_t store_##file_name                                   \
>         if (ret != 1)                                                   \
>                 return -EINVAL;                                         \
>                                                                         \
> +       lock_policy_rwsem_write(policy->cpu);                           \
> +                                                                       \
>         ret = __cpufreq_set_policy(policy, &new_policy);                \
>         policy->user_policy.object = policy->object;                    \
>                                                                         \
> +       unlock_policy_rwsem_write(policy->cpu);                         \
> +                                                                       \
>         return ret ? ret : count;                                       \
>  }

As far as I know, this protection already exists. Check this
function, which eventually calls all **store() related to
struct freq_attr

static ssize_t store(struct kobject *kobj, struct attribute *attr,
		     const char *buf, size_t count)
{
	struct cpufreq_policy *policy = to_policy(kobj);
	struct freq_attr *fattr = to_attr(attr);
	ssize_t ret = -EINVAL;
	policy = cpufreq_cpu_get_sysfs(policy->cpu);
	if (!policy)
		goto no_policy;

	if (lock_policy_rwsem_write(policy->cpu) < 0)
		goto fail;

	if (fattr->store)
		ret = fattr->store(policy, buf, count);
	else
		ret = -EIO;

	unlock_policy_rwsem_write(policy->cpu);
fail:
	cpufreq_cpu_put_sysfs(policy);
no_policy:
	return ret;
}
