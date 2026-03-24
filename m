Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C1347C7;
	Tue, 24 Mar 2026 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326867; cv=none; b=TLEjPiIghwxQYq3cYn3U7jkLO55cc/LZAt+XEqWSDe7q+hrOe9LtsczXboABBjfZ/f1HjpdzOvnvz0zvBUxriDsr5Q4VZ+d+SXZ1hOyU78HHHAt6P+hmx3HlGgSNPXUMlBZTt8rvf7pdOHS789sRY5EoQDfkugr05ghHnx9RepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326867; c=relaxed/simple;
	bh=D3ZUIb44jTGtSNDKb+qiUM2ASn3XKgvhuZ7ZB3U/Mdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aESceO+f2n3YcH8QxU6vY6U7iZmARMcxH6seDSVozjEYM1lfPU8ihVbbVPuZVPYpSGYl/ZJNuEtudlwWC7Cn6Yo1iOod4aGIrPgPDdJCr1YXdxBykUTOTkmS9RfjwnwcIF/XoWcbtwpRMfNJOZq7M2ixBG6zJ786OAyxJPe30gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZGtikPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZGtikPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA7EC19424;
	Tue, 24 Mar 2026 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774326866;
	bh=D3ZUIb44jTGtSNDKb+qiUM2ASn3XKgvhuZ7ZB3U/Mdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZGtikPA70Vnuok9bvcsYFUzbQA77DcOXbNOOXcD0J97zrXmI9Ql9ldy6Ph2ssL3K
	 Dvn7ehuq7JFd6bewuYdlP+ma2GIp5p7t/z3BAh62XwUwAMXJ+C8f7h9fyC1cSHmFjh
	 WT4ph47uqwqRe8CFLivSwpPYXZxkYPO0q35QinMsTxHeb2DjcI76a9RiUklXY2eGZI
	 42R8/F5o824keKEI/2XqyA3GBTTkw7uehljmYQoFbVQhXFmDhAFFur6zxPQ/D85gfn
	 seWZs+RIIV0cOOO9Dl3rygGS7l+luQq7DBwOtRS8lqrTneJnDhCTEfCYenW0AN4DwP
	 mtJWOYc0bx/Cw==
Message-ID: <081cf637-a1f4-4d3d-99ab-d563dd3ac28c@kernel.org>
Date: Mon, 23 Mar 2026 23:34:24 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
 <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
 <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/26 11:29 PM, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Mon, Mar 23, 2026 at 03:21:17PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
>>
>>
>> On 3/20/2026 9:43 AM, Gautham R. Shenoy wrote:
>>> Currently when amd-pstate-ut test module is loaded, it runs all the
>>> tests from amd_pstate_ut_cases[] array.
>>>
>>> Add a module parameter named "run_only" that allows users to run a
>>> single test from the array by specifying the test name string.
>>>
>>> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> ---
>>>    drivers/cpufreq/amd-pstate-ut.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>>> index 447b9aa5ce40..35e453a49c0f 100644
>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>> @@ -35,6 +35,10 @@
>>>    #include "amd-pstate.h"
>>> +static char *run_only;
>>> +module_param(run_only, charp, 0444);
>>> +MODULE_PARM_DESC(run_only,
>>> +	"Run only the named test case (default: run all)");
>>
>> This default shows the end effect; but it doesn't make sense for this
>> parameter IMO.
>>
>> How about instead if you had a semicolon delimitted list and then defaulted
>> an empty list to mean all tests?  Something like this:
>>
>> static char *test_list;
>> module_param(test_list, charp, 0444)
>> MODULE_PARM_DESC(test_list,
>> 	"Semicolon delimitted list of tests to run (empty means run all tests)");
> 
> 
> This makes sense.
> 
>>
>>>    struct amd_pstate_ut_struct {
>>>    	const char *name;
>>> @@ -275,7 +279,12 @@ static int __init amd_pstate_ut_init(void)
>>>    	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>>>    	for (i = 0; i < arr_size; i++) {
>>> -		int ret = amd_pstate_ut_cases[i].func(i);
>>> +		int ret;
>>> +
>>> +		if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
>>> +			continue;
>>> +
>>> +		ret = amd_pstate_ut_cases[i].func(i);
>>
>> If you take my suggestion then you would split this on semicolon or end of
>> string and then allow matching multiple.
> 
> How about something like the following (diff on top of this
> patch. Will fold it in and post a v4 if this looks ok)
Yeah that's good.

> 
> x8----------------------------------------x8---------------------------------------------x8
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 5d87fb8a26df..5ef22a77a9c5 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -37,10 +37,10 @@
>   
>   #include "amd-pstate.h"
>   
> -static char *run_only;
> -module_param(run_only, charp, 0444);
> -MODULE_PARM_DESC(run_only,
> -       "Run only the named test case (default: run all)");
> +static char *test_list;
> +module_param(test_list, charp, 0444);
> +MODULE_PARM_DESC(test_list,
> +       "Semicolon-delimited list of tests to run (empty means run all tests)");
>   
>   struct amd_pstate_ut_struct {
>          const char *name;
> @@ -403,6 +403,26 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>          return ret;
>   }
>   
> +static bool test_in_list(const char *list, const char *name)
> +{
> +       size_t name_len = strlen(name);
> +       const char *p = list;
> +
> +       while (*p) {
> +               const char *sep = strchr(p, ';');
> +               size_t token_len = sep ? sep - p : strlen(p);
> +
> +               if (token_len == name_len && !strncmp(p, name, token_len))
> +                       return true;
> +
> +               if (!sep)
> +                       break;
> +               p = sep + 1;
> +       }
> +
> +       return false;
> +}
> +
>   static int __init amd_pstate_ut_init(void)
>   {
>          u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> @@ -410,7 +430,8 @@ static int __init amd_pstate_ut_init(void)
>          for (i = 0; i < arr_size; i++) {
>                  int ret;
>   
> -               if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
> +               if (test_list && *test_list &&
> +                   !test_in_list(test_list, amd_pstate_ut_cases[i].name))
>                          continue;
>   
>                  ret = amd_pstate_ut_cases[i].func(i);
> x8----------------------------------------x8---------------------------------------------x8
> 

