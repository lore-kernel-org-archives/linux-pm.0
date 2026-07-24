Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533736F428;
	Fri, 24 Jul 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919363; cv=none; b=OFkkL8LLBdzD6sk/QCreZxBAsOh89b/j1GBGLPhBa4VpYR45MKXbxQ3aBpjMJxjx2kDTGcp8QguyLe/9Q04L3SNDtFh/EnMON3vb/DyCh3lLXZHNCCcudM5ikLCHBWnWGl1rEtTXR9mjR5/2heJIgOqLa0Lcqo5m8au/gIJk7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919363; c=relaxed/simple;
	bh=rsfTShCdmdn1/ceBIuq6QCI2aAItpH77oSJxxGMFQt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWPSIg/0rUnOXFekCcgf/T7W/zFfezsG65X8DRNmIyShUET2XUuULGZZ5JpDe5Xd4mMWplrvSCNBTiUFIYpOr+2skKtYMq1SOaGQvbf4YJ5+AYH93D3cqXPApyEfId1fyzRp3Y9EuDG/gRGSAbXoOj8REckqSSbjHC4CH+4RQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX9l447C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX9l447C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5929E1F000E9;
	Fri, 24 Jul 2026 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919362;
	bh=jJc99ZCJ5mqfP824dZ19AxuFPL8fzdqnCjcbQZrT0/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lX9l447CaZo2pMmrEPJ99Is4k6wEzpImGj6HYO/AXCOe2TK9sNIXLzjPsqOLjHGtz
	 uHILSm3ff4RStcWwb9rr05GDSF+QuP/9FmTy+On5VzpPq1pBDYPcJOWrR8A2FQSdta
	 hZOrUsJISjoL4RCUOl+QOBK2mRB8LaE5c4+R9qHmrpQnxSR4QUI4vKx69l4RuZt/l9
	 pNtE/iGOPxqPsDUH8co8moT366UQ/w6ohsZOHZMZsszYXJUj3QeKBRUmZHRwVcBWWO
	 5mlN+ZvxJ1BKfoDjosezaEn1KWMl/VpgYHLY+OL2QPEhyvkZMDbviGIit10iJsMdnP
	 k7nRWYmCJZeGg==
Message-ID: <e80267b8-2809-4b4c-97a4-0f348414a4a9@kernel.org>
Date: Fri, 24 Jul 2026 13:55:59 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] cpufreq/amd-pstate: Remove "amd_dynamic_epp"
 cmdline and "dynamic_epp" sysfs
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-6-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723201228.22584-6-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 15:12, K Prateek Nayak wrote:
> Since dynamic_epp has been converted to an
> "energy_performance_preference", toggling the feature via the sysfs file
> or the kernel cmdline is now redundant.
> 
> Remove the sysfs file and the "amd_dynamic_epp" cmdline and only depend
> on "energy_performance_preference" to toggle dynamic_epp.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changelog rfc v1..v2:
> 
> o Removed "dynamic_epp" gloabal control, the "amd_synamic_epp" cmdline,
>    and the "fdynamic_epp" sysfs since they are all redundant after the
>    rework.
> ---
>   drivers/cpufreq/amd-pstate.c | 55 +-----------------------------------
>   1 file changed, 1 insertion(+), 54 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fc90e4108c22..92da8937df04 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -87,7 +87,6 @@ static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool amd_pstate_prefcore = true;
> -static bool dynamic_epp;
>   static struct quirk_entry *quirks;
>   
>   /*
> @@ -1834,50 +1833,12 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> -static ssize_t dynamic_epp_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
> -}
> -
> -static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
> -				 const char *buf, size_t count)
> -{
> -	bool enabled;
> -	int ret;
> -
> -	ret = kstrtobool(buf, &enabled);
> -	if (ret)
> -		return ret;
> -
> -	guard(mutex)(&amd_pstate_driver_lock);
> -
> -	if (cppc_state != AMD_PSTATE_ACTIVE) {
> -		pr_debug("dynamic_epp can only be toggled in active mode\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Nothing to do */
> -	if (dynamic_epp == enabled)
> -		return count;
> -
> -	/* reinitialize with desired dynamic EPP value */
> -	dynamic_epp = enabled;
> -	ret = amd_pstate_change_driver_mode(cppc_state);
> -	if (ret)
> -		dynamic_epp = false;
> -
> -	return ret ? ret : count;
> -}
> -
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> -static DEVICE_ATTR_RW(dynamic_epp);
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> -	&dev_attr_dynamic_epp.attr,
>   	NULL
>   };
>   
> @@ -1984,10 +1945,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>   	}
>   
> -	if (dynamic_epp)
> -		ret = amd_pstate_set_dynamic_epp(policy);
> -	else
> -		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
> +	ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
>   	if (ret)
>   		goto free_cpudata1;
>   
> @@ -2398,19 +2356,8 @@ static int __init amd_prefcore_param(char *str)
>   	return 0;
>   }
>   
> -static int __init amd_dynamic_epp_param(char *str)
> -{
> -	if (!strcmp(str, "disable"))
> -		dynamic_epp = false;
> -	if (!strcmp(str, "enable"))
> -		dynamic_epp = true;
> -
> -	return 0;
> -}
> -
>   early_param("amd_pstate", amd_pstate_param);
>   early_param("amd_prefcore", amd_prefcore_param);
> -early_param("amd_dynamic_epp", amd_dynamic_epp_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

