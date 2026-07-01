Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053B282F1B;
	Wed,  1 Jul 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941937; cv=none; b=oTfYFfucc5wf9z3bXMYrhMolyx+NrRCCouca/4wDysby9vqnzn4bBRq7faYLEYEwz0P2NvOkKCId3MyQC1yic6FEEWJxp3qJuCFgKDhyc2sFOP81s7z1zzW/TC+Xfk1B+Auekkugop9YgGo1NXOg7icpaCa6E+UUWmOSL7BgbY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941937; c=relaxed/simple;
	bh=p7inwEkikDHPBjGDFoiFnrONp8/i9bivq1WwpjfNdH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILlYZhOkiDRWalmK7KdvL94mbAMWtoiEAw1LzOt5JqPvbmY68oU78E/KCn70Frer7FwLyrTrhDLvydFs4ezud8culdfysVker6DyyIkPW+maLHmQnQyzp4VKYUblzKZryOYbOP8tsh8kqprM3aZk2BeJtzETmtCW6O8EDsiURzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqIpe07B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqIpe07B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2871F000E9;
	Wed,  1 Jul 2026 21:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941936;
	bh=OoRUOnIMYYBK4JW+BASzeBpKzSzFajYr5tpR995ygv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dqIpe07BaDU2woc5NFRXOMun+jXXjdTy21roUiZ/k2ytdeYTWZdRZUwp+BV66iY/x
	 gA8mbOVVYOt/vD4iQnn8TCtNWU4r68TFKEPpGiA2HP+Qczg9JeksOaEaSyIUZHjgdK
	 x3uhrJiBtcbkrXX0c4HUdVMCFP9JBR+gSjxZKXVQIqvHXRtpckdAfC3cVERGZTdqo6
	 dQhxxhjC2a2b7goRkHCPJYB17RtAeGGqy55/1S1mBCwUPsRMdZpD5Fw0btrg7G9hv3
	 KzovxnB+enbCQmmAohn5wRXlRBaC1uDj6PUP+WZ3IOESEufbJI9+VU+mJZt/3H0EZv
	 zGJnWH93aF0ig==
Message-ID: <51ab81bd-4c77-446d-b9ec-afad343f4321@kernel.org>
Date: Wed, 1 Jul 2026 16:38:52 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] cpufreq/amd-pstate: Reduce the scope of exported
 symbols
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630190304.5671-2-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260630190304.5671-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 14:03, K Prateek Nayak wrote:
> Symbols exported by amd-pstate.c are ever only needed for amd-pstate-ut.
> Introduce EXPORT_SYMBOL_FOR_PSTATE_UT() to export these symbols
> selectively to "amd-pstate-ut" namespace as opposed to all GPL modules.
> 
> No functional changes intended.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 14 +++++++-------
>   drivers/cpufreq/amd-pstate.h |  7 +++++++
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 61f30820d95a..44c03b0be219 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -75,7 +75,7 @@ const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
>   		mode = AMD_PSTATE_UNDEFINED;
>   	return amd_pstate_mode_string[mode];
>   }
> -EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_mode_string);
>   
>   struct quirk_entry {
>   	u32 nominal_freq;
> @@ -1266,7 +1266,7 @@ void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>   	kfree(cpudata->profile_name);
>   	cpudata->dynamic_epp = false;
>   }
> -EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_clear_dynamic_epp);
>   
>   static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>   {
> @@ -1472,7 +1472,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   
>   	return count;
>   }
> -EXPORT_SYMBOL_GPL(store_energy_performance_preference);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
>   
>   ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>   {
> @@ -1506,7 +1506,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
> -EXPORT_SYMBOL_GPL(show_energy_performance_preference);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
>   
>   static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
>   					   const char *buf, size_t count)
> @@ -1606,7 +1606,7 @@ struct freq_attr **amd_pstate_get_current_attrs(void)
>   		return NULL;
>   	return current_pstate_driver->attr;
>   }
> -EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_current_attrs);
>   
>   static struct freq_attr **get_freq_attrs(void)
>   {
> @@ -1791,7 +1791,7 @@ int amd_pstate_get_status(void)
>   {
>   	return cppc_state;
>   }
> -EXPORT_SYMBOL_GPL(amd_pstate_get_status);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
>   
>   int amd_pstate_update_status(const char *buf, size_t size)
>   {
> @@ -1811,7 +1811,7 @@ int amd_pstate_update_status(const char *buf, size_t size)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(amd_pstate_update_status);
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_update_status);
>   
>   static ssize_t status_show(struct device *dev,
>   			   struct device_attribute *attr, char *buf)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 23e8baa05849..edd697a5e29f 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -11,6 +11,13 @@
>   #include <linux/pm_qos.h>
>   #include <linux/platform_profile.h>
>   
> +#if IS_MODULE(CONFIG_X86_AMD_PSTATE_UT)
> +#define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol) \
> +	EXPORT_SYMBOL_FOR_MODULES(symbol, "amd-pstate-ut")
> +#else
> +#define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol)
> +#endif
> +
>   /*********************************************************************
>    *                        AMD P-state INTERFACE                       *
>    *********************************************************************/

