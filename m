Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD738D019;
	Fri, 24 Jul 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919859; cv=none; b=RLcFaOrRSaXkYmbscFo6Ti5Fnlj+1ndyygz6disjvYSLOu3beRxMyBWhzZ4I7gmyUmSpKJxQwFjodZDcacPRu0p/pTyzyXFmoOX6duQ59A1J6+OXgmAlRK0JNI9xqS4LwSmixg/FkAPIi7pgqmCNOgisA91hqwzWwxUuSv+QO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919859; c=relaxed/simple;
	bh=mLzuvRhFQ4wC/ngj0tDT2GFUmaBwGgSRiH544IfSjzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzd2Js1zMJH7/hQpU8JCNHzyCaQmFsiwoJaCLU6v27fR4lc5qTpXBqUohOjmAgZebbuvN2bWdbZgDn0yOYqapf2KDnqCCdCP7l0GbvRTqp0hC4Yk7Yrc1kVvMK45EE2pJ1QqLReesYQZDNf2Hv7TV8NjGEBxOKKnfQ/CttzxeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+kzlG+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+kzlG+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8207E1F000E9;
	Fri, 24 Jul 2026 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919856;
	bh=VrxOniGE7Kw82QxeNBuoFhj5nfTjGlXG87xxpYVe8Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R+kzlG+BxfP1slOvINhukPq5kPLPKMBg6BVG8ZiZ/0omDVyMVd2nrtD9d5oiHhJE1
	 QDwt0SsK4OqvzJwTxNuweT11jZWOnwoSyS4ezMMLovCanZW70qkpD60wTu9H0Jk+NW
	 UCPot+5eYSrWQsn1QcLYq1DkXAqfrHYaVcFXAFAzu7dg4uR8XDsCpxjbnCMY7mb8ir
	 /aILVLSaInJN5ts4eLOPbLRgZqwyeef71D/x5Bmdp7PK07AYqvceswPZ2ewOO1npW8
	 TulieHkd4lNNyTnaqgI+0XeD3l8TeQI4MhdCXxKzqIMYblfQzuXcGobRz8Ri/I8P1j
	 sRZRdFRy7cBKQ==
Message-ID: <409ce8fd-e2b9-4b0f-94d8-1d473e0d269c@kernel.org>
Date: Fri, 24 Jul 2026 14:04:14 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] cpufreq/amd-pstate-ut: Add unit test for CPPC
 Performance Priority
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Kalpana Shetty <kalpana.shetty@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-10-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723201228.22584-10-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 15:12, K Prateek Nayak wrote:
> Add a unit test for CPPC Performance Priority that modifies the floor
> perf and confirms if the modification was successful similar to the
> energy_performance_preference unit test.
> 
> On platforms that do not support X86_FEATURE_CPPC_PERF_PRIO, the test
> returns -EOPNOTSUPP and amd_pstate_ut_check_floor_freq is marked as
> "skipped".
> 
> Suggested-by: Kalpana Shetty <kalpana.shetty@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> changelog rfc v1..v2:
> 
> o New patch.
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 83 ++++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.c    |  7 +--
>   drivers/cpufreq/amd-pstate.h    |  2 +
>   3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index d1f730e3502b..6a17941380c2 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -59,6 +59,7 @@ static int amd_pstate_ut_check_freq(u32 index);
>   static int amd_pstate_ut_epp(u32 index);
>   static int amd_pstate_ut_check_driver(u32 index);
>   static int amd_pstate_ut_check_freq_attrs(u32 index);
> +static int amd_pstate_ut_check_floor_freq(u32 index);
>   
>   static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>   	{"amd_pstate_ut_acpi_cpc_valid",    amd_pstate_ut_acpi_cpc_valid   },
> @@ -68,6 +69,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>   	{"amd_pstate_ut_epp",               amd_pstate_ut_epp              },
>   	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
>   	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
> +	{"amd_pstate_ut_check_floor_freq",  amd_pstate_ut_check_floor_freq },
>   };
>   
>   static bool test_in_list(const char *list, const char *name)
> @@ -560,6 +562,77 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>   	return ret;
>   }
>   
> +static int amd_pstate_ut_check_floor_freq(u32 index)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +	char *buf __free(cleanup_page) = NULL;
> +	unsigned int orig_floor_freq;
> +	unsigned int floor_freq;
> +	int ret, cpu = 0;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
> +		return -EOPNOTSUPP;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy || !policy->driver_data)
> +		return -ENODEV;
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	guard(rwsem_write)(&policy->rwsem);
> +
> +	/* Retrieve original floor frequency */
> +	memset(buf, 0, PAGE_SIZE);
> +	ret = show_amd_pstate_floor_freq(policy, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = kstrtou32(buf, 0, &orig_floor_freq);
> +	if (ret)
> +		return ret;
> +
> +	memset(buf, 0, PAGE_SIZE);
> +	snprintf(buf, PAGE_SIZE, "%u", policy->cpuinfo.min_freq);
> +
> +	/* Set floor frequency to cpuinfo.min_freq */
> +	ret = store_amd_pstate_floor_freq(policy, buf, strlen(buf));
> +	if (ret < 0) {
> +		pr_err("Failed to set floor frequency to %s\n", buf);
> +		return ret;
> +	}
> +
> +	memset(buf, 0, PAGE_SIZE);
> +	ret = show_amd_pstate_floor_freq(policy, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	strreplace(buf, '\n', '\0');
> +	ret = kstrtou32(buf, 0, &floor_freq);
> +	if (ret)
> +		return ret;
> +
> +	/* Confirm sysfs reflects the change correctly. */
> +	if (floor_freq != policy->cpuinfo.min_freq) {
> +		pr_err("Floor frequency value mismatch: %u != %u\n",
> +		       floor_freq, policy->cpuinfo.min_freq);
> +		return -EINVAL;
> +	}
> +
> +	memset(buf, 0, PAGE_SIZE);
> +	snprintf(buf, PAGE_SIZE, "%u", orig_floor_freq);
> +
> +	/* Restore the original value. */
> +	ret = store_amd_pstate_floor_freq(policy, buf, strlen(buf));
> +	if (ret < 0) {
> +		pr_err("Failed to restore floor frequency to %s\n", buf);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int __init amd_pstate_ut_init(void)
>   {
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> @@ -578,10 +651,16 @@ static int __init amd_pstate_ut_init(void)
>   
>   		ret = amd_pstate_ut_cases[i].func(i);
>   
> -		if (ret)
> +		if (ret) {
> +			/* Platform does not support the feature being tested. */
> +			if (ret == -EOPNOTSUPP) {
> +				pr_err("%-4d %-20s\t skipped!\n", i+1, amd_pstate_ut_cases[i].name);
> +				continue;
> +			}
>   			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
> -		else
> +		} else {
>   			pr_info("%-4d %-20s\t success!\n", i+1, amd_pstate_ut_cases[i].name);
> +		}
>   	}
>   
>   	return 0;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b875e92103e1..a42899722a21 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1502,8 +1502,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   }
>   EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
>   
> -static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
> -					   const char *buf, size_t count)
> +ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy, const char *buf, size_t count)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> @@ -1526,13 +1525,15 @@ static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
>   
>   	return ret ?: count;
>   }
> +EXPORT_SYMBOL_FOR_PSTATE_UT(store_amd_pstate_floor_freq);
>   
> -static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
> +ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
>   }
> +EXPORT_SYMBOL_FOR_PSTATE_UT(show_amd_pstate_floor_freq);
>   
>   static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
>   {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index edd697a5e29f..f8e2f6ba1534 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -160,6 +160,8 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   				    const char *buf, size_t count);
>   ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
>   void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
> +ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy, const char *buf, size_t count);
> +ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf);
>   
>   struct freq_attr;
>   

