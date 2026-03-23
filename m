Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20763630BA;
	Mon, 23 Mar 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297279; cv=none; b=ITcM7KHFz7xUfM9pqxeApoBKiQCt5LW7CP7qJS2WVMcUVRw9wCHI+U0YJaL3Vo5JiKsaZA5s0x2/dP7d+o+iOzR2J/StF3ZxN5gYSzP+lbYQVViW5MUPS9nRk/8E7QTUkuj6OrS1JObV9Bck3cNtmtLZRpaUGxCONoX80dOmcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297279; c=relaxed/simple;
	bh=IcO7TctMMV5qCB6tSyKcM7ODR20s+oH05/Zr/5ZVqak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijxZnnjWsQSl3q9bC4/GlQUwCf42srQjOiO3GQnpUAzi0+QAue1NIJdaAzIaZX2Rnw+L3ipIZBYuEt+GiOWUkk57XE90ZmMgOlMR674aAyDoUu0PATei/Pu/ZAS6kBOgGqhCJ9d3cUnFztuE/1t5WOgAvhXghMpr9Bc3/7gF/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSS5iiid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSS5iiid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD93EC4CEF7;
	Mon, 23 Mar 2026 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774297279;
	bh=IcO7TctMMV5qCB6tSyKcM7ODR20s+oH05/Zr/5ZVqak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lSS5iiidHuri3eDrdtAZ6ppbjyzYEHN9beUaI7thULXoHL7U47gjq4pcCB9y2mXpH
	 rC8NcdQ6sWsQFtvuWa/MsyspdkMeOPGQhMQZ3Lq/8zGWgr/CFVWrtRivFzI0oVwrYH
	 c7itJsEERRhF15BhAUHFO+BtfdkWSO9NJhNAspmTfklc6SapEvtqP8fk2lYo2V/Vuo
	 cv3uxIeYNGZWYoLby18zTq/Hw+/DJLFWD2H5ga9h4vPrK8803Ipc+rV2HtRKC8tyfO
	 TpVphT763K/dAwgwWR/F1e3wWlkzoC4htmpoOvK4EMRhIrmucv8e/cgj/kJ7TbD6FA
	 EvrLrZzSikW2A==
Message-ID: <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
Date: Mon, 23 Mar 2026 15:21:17 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260320144321.18543-9-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2026 9:43 AM, Gautham R. Shenoy wrote:
> Currently when amd-pstate-ut test module is loaded, it runs all the
> tests from amd_pstate_ut_cases[] array.
> 
> Add a module parameter named "run_only" that allows users to run a
> single test from the array by specifying the test name string.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 447b9aa5ce40..35e453a49c0f 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -35,6 +35,10 @@
>   
>   #include "amd-pstate.h"
>   
> +static char *run_only;
> +module_param(run_only, charp, 0444);
> +MODULE_PARM_DESC(run_only,
> +	"Run only the named test case (default: run all)");

This default shows the end effect; but it doesn't make sense for this 
parameter IMO.

How about instead if you had a semicolon delimitted list and then 
defaulted an empty list to mean all tests?  Something like this:

static char *test_list;
module_param(test_list, charp, 0444)
MODULE_PARM_DESC(test_list,
	"Semicolon delimitted list of tests to run (empty means run all tests)");

>   
>   struct amd_pstate_ut_struct {
>   	const char *name;
> @@ -275,7 +279,12 @@ static int __init amd_pstate_ut_init(void)
>   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>   
>   	for (i = 0; i < arr_size; i++) {
> -		int ret = amd_pstate_ut_cases[i].func(i);
> +		int ret;
> +
> +		if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
> +			continue;
> +
> +		ret = amd_pstate_ut_cases[i].func(i);

If you take my suggestion then you would split this on semicolon or end 
of string and then allow matching multiple.

>   
>   		if (ret)
>   			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);

