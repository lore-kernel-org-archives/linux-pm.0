Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966C33EAEC;
	Thu, 26 Mar 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550763; cv=none; b=eE53VvHZPqK9//DY/yEfN03PdUo5QpCTZOaPxpkKkIGl+oUvL1S0YD/+wmbxjX6H6Vxa854xEMabUk588O25g0xhjKVOErskBgUL1pYNUR61CbyxlrauRyyECboLi10+9/nfwpQ078OCKUwQ4UlZuBzmLzP88ftaAx/3G2imTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550763; c=relaxed/simple;
	bh=knxK1IEXKLxGl5G7uj89Lngwqteee4c5YVwGm1klXSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PraFYNqQ/GEQIkjclNZyN3lUO/6K2YWudD0MYR5WcEs9fSp1pX4QjqFKtAVHbMKPHd8h4gBENRFsWPfp1p/JYtaEhTiMLEjELJgI6WgvaemmTNlH/9K9FM4+37v5/9yYjDgTOXN6BY/UL1E5Y+PbaEE846eE5DfD925BJwax4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNVMdGb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNVMdGb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD42C116C6;
	Thu, 26 Mar 2026 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774550763;
	bh=knxK1IEXKLxGl5G7uj89Lngwqteee4c5YVwGm1klXSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hNVMdGb8dc9ILDKOQ7AwmapFHvDTRjJNhNrwMXRPBQPHMdeHttq3Nrd14TBqm/HCt
	 JQQ2lGyAxuAPm/6hLPcDSrTgPo+lwj36ZAj24WCIiLoTQ28e4/bgwQgidhJJVc+t/X
	 A91bYtjUzw/IidpNgqINwAmA8HUUuE9Q15jQ4SM+I8TY+jL6Ln+KB1+J7hYpWTx011
	 P2e24LAHsM2NIb8Hzjp7AB1gIvYsiwfbLwXm9t3yAuN7lCQtysSZpCaASRSct1rrUW
	 goEMxSFo+k6VwhVZrocQIeW9vGuwTULR7kjZA41ZBnhRU9b9DrRyAnQW9DtsW6/+pI
	 O8Oi01EsRUz0g==
Message-ID: <e7210e30-05e1-4125-99f6-55ac38591ca1@kernel.org>
Date: Thu, 26 Mar 2026 13:46:01 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] amd-pstate-ut: Add module parameter to select
 testcases
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
 <20260326114756.20374-9-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260326114756.20374-9-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/26/26 06:47, Gautham R. Shenoy wrote:
> Currently when amd-pstate-ut test module is loaded, it runs all the
> tests from amd_pstate_ut_cases[] array.
> 
> Add a module parameter named "test_list" that accepts a
> comma-delimited list of test names, allowing users to run a
> selected subset of tests. When the parameter is omitted or empty, all
> tests are run as before.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 447b9aa5ce40..3dcdf56883a6 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -35,6 +35,10 @@
>   
>   #include "amd-pstate.h"
>   
> +static char *test_list;
> +module_param(test_list, charp, 0444);
> +MODULE_PARM_DESC(test_list,
> +	"Comma-delimited list of tests to run (empty means run all tests)");
>   
>   struct amd_pstate_ut_struct {
>   	const char *name;
> @@ -58,6 +62,25 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>   	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
>   };
>   
> +static bool test_in_list(const char *list, const char *name)
> +{
> +	size_t name_len = strlen(name);
> +	const char *p = list;
> +
> +	while (*p) {
> +		const char *sep = strchr(p, ',');
> +		size_t token_len = sep ? sep - p : strlen(p);
> +
> +		if (token_len == name_len && !strncmp(p, name, token_len))
> +			return true;
> +		if (!sep)
> +			break;
> +		p = sep + 1;
> +	}
> +
> +	return false;
> +}
> +
>   static bool get_shared_mem(void)
>   {
>   	bool result = false;
> @@ -275,7 +298,13 @@ static int __init amd_pstate_ut_init(void)
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>   
>   	for (i = 0; i < arr_size; i++) {
> -		int ret = amd_pstate_ut_cases[i].func(i);
> +		int ret;
> +
> +		if (test_list && *test_list &&
> +		    !test_in_list(test_list, amd_pstate_ut_cases[i].name))
> +			continue;
> +
> +		ret = amd_pstate_ut_cases[i].func(i);
>   
>   		if (ret)
>   			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);

