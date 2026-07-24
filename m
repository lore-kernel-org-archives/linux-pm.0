Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE03E1692;
	Fri, 24 Jul 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919893; cv=none; b=H6cYHqGPYnTY2rOUKG8il6du9XZ2tWDqp0LKtTrdVynKVxNy58SlHoP6RBhQVvpKBJ68HJ28W3vmCR9bmiQQUKtJABub2DpSsW9SkKEFua4YWBx4nxauS87ebNKhU/wEnEpGQYfkPa9XITo4SHJj47NUWWBIHDTWKbSR6zSbMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919893; c=relaxed/simple;
	bh=L98R7fQ5U/qywk5V9loN+PuSY1jprJFXslQb7vVpg1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6AbRAktwKZuOPyRWRtLyQWp7SBGDJCraRucThxA5+8kqUpRFPKewgwKz4cjjyzYe9VqKvh2AYo3O/aBWUMBivYGtchcWHsBdtBl7DaMsahgC4pa+bqkuoyWl9nRB30iOhcyKyIZTZ8lTviGHfcXMsyuBMB3TRT1g4xHKJuStwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF/qURQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF/qURQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBB61F000E9;
	Fri, 24 Jul 2026 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919891;
	bh=wAf8H8VyvhWvMkgzSo8WU7e3qA2/yIuMhtsSvtTnX4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZF/qURQY7d0zwa1fT+5LH0hncWTQeRAnT+QKkHZal7XSiioPIIci8nqTPlk374oqI
	 sRpnKv74ANoO/w7vKeMJ9wCbRkfFt/AdERWd0lHFvMBRf7buJQos33sPr36tceCWDI
	 ySnRXpaQl7TK14O1If+xyktx43vFZnx6+TXJfOrkg7E63iFlQjWQ6dfu3lH4f+hoYo
	 Pu8KldyXKxG5jDF9wQADgZIoErYhirB4OtELPB0Bi508zOdDWHI6LW0Zxl+p3HsJSV
	 5m6HlfNkv9TrTOCyzXvAU2BRfp/oZnixo7KqBt7pkScgBg1thyB+lPrz9BEFQvthl9
	 mQfvHMw0Ogcgg==
Message-ID: <e5a3591f-60d7-417b-a63b-394c0dde60c7@kernel.org>
Date: Fri, 24 Jul 2026 14:04:49 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] cpufreq/amd-pstate-ut: Add unit test for "dynamic"
 EPP mode
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-9-kprateek.nayak@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723201228.22584-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 15:12, K Prateek Nayak wrote:
> Extend the EPP unit test to cover the "dynamic" epp mode. Since
> "dynamic_epp" is no longer a system-wide toggle, remove the legacy
> "dynamic_epp" bits from the unit test.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changelog rfc v1..v2:
> 
> o Simplified some aspect of test now that dynamic_epp global knob is
>    removed.
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 45 ++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 2142838ad6cc..d1f730e3502b 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -275,6 +275,7 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>   static int amd_pstate_ut_epp(u32 index)
>   {
>   	static const char * const epp_strings[] = {
> +		"dynamic",
>   		"power",
>   		"balance_power",
>   		"balance_performance",
> @@ -282,10 +283,10 @@ static int amd_pstate_ut_epp(u32 index)
>   	};
>   	char *buf __free(cleanup_page) = NULL;
>   	struct cpufreq_policy *policy = NULL;
> +	unsigned long orig_dynamic_epp = 0;
>   	enum amd_pstate_mode orig_mode;
>   	struct amd_cpudata *cpudata;
>   	unsigned long orig_policy;
> -	bool orig_dynamic_epp;
>   	int ret, cpu = 0;
>   	u16 epp;
>   	int i;
> @@ -294,9 +295,11 @@ static int amd_pstate_ut_epp(u32 index)
>   	if (!policy)
>   		return -ENODEV;
>   
> -	cpudata = policy->driver_data;
>   	orig_mode = amd_pstate_get_status();
> -	orig_dynamic_epp = cpudata->dynamic_epp;
> +	if (policy->driver_data) {
> +		cpudata = policy->driver_data;
> +		orig_dynamic_epp = cpudata->dynamic_epp;
> +	}
>   
>   	/* Drop reference before potential driver change. */
>   	cpufreq_cpu_put(policy);
> @@ -321,16 +324,6 @@ static int amd_pstate_ut_epp(u32 index)
>   	orig_policy = cpudata->policy;
>   	cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
>   
> -	/*
> -	 * Disable dynamic EPP before running test. If "orig_dynamic_epp" is
> -	 * true, the  driver will do a redundant switch at the end and there
> -	 * is no need for enabling it again at the end of the test.
> -	 */
> -	if (cpudata->dynamic_epp) {
> -		pr_debug("Dynamic EPP is enabled, disabling it\n");
> -		amd_pstate_clear_dynamic_epp(policy);
> -	}
> -
>   	for (epp = 0; epp <= U8_MAX; epp++) {
>   		u8 val;
>   
> @@ -367,6 +360,11 @@ static int amd_pstate_ut_epp(u32 index)
>   		if (ret < 0)
>   			goto out;
>   		strreplace(buf, '\n', '\0');
> +		/*
> +		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
> +		 * Trim at "(" and just compare tie the epp string.
> +		 */
> +		strreplace(buf, '(', '\0');
>   
>   		if (strcmp(buf, epp_strings[i])) {
>   			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
> @@ -380,18 +378,23 @@ static int amd_pstate_ut_epp(u32 index)
>   out:
>   	if (policy) {
>   		cpudata->policy = orig_policy;
> +		/*
> +		 * If the driver had enabled dynamic_epp to brgin with,
begin
> +		 * restore it here before dropping policy reference.
> +		 */
> +		if (orig_dynamic_epp) {
> +			int ret2;
> +
> +			ret2 = store_energy_performance_preference(policy,
> +								  epp_strings[0],
> +								  strlen(epp_strings[0]));
> +			if (!ret && (ret2 < 0))
> +				ret = ret2;
> +		}
>   		up_write(&policy->rwsem);
>   		cpufreq_cpu_put(policy);
>   	}
>   
> -	if (orig_dynamic_epp) {
> -		int ret2;
> -
> -		ret2 = amd_pstate_set_mode(AMD_PSTATE_DISABLE);
> -		if (!ret && ret2)
> -			ret = ret2;
> -	}
> -
>   	if (orig_mode != amd_pstate_get_status()) {
>   		int ret2;
>   

