Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC512B143;
	Mon, 25 May 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671153; cv=none; b=rgv90Wmg1hSh6JVDp1L7jYyGLNYrt64dgUL8aOJcV+ReLDP+AkyyakPMNqg1H2CQH7mRvGJqareGrPIzgQEVT35OZoQYtYSbsZsP/yK7HBDzQeEkzpPfEUsrA258GkhFqRRcFts1eaQ3BJ7SRHDbXvvnFIZNkc8Qn8tgYav6EG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671153; c=relaxed/simple;
	bh=7lFSEt6EJf6rliZ3OMuTT1GBO9rTRaNVZYR9BCLIpK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QkYeWMaX/2KQcXG8Uh6tMWQ8JSDKPOtnzOGh6lFS5fHzBXW69IcE6KWBZK1U0iIbuuHkv95p+lR4Uy9wUMXLMj1U0K0yqyav+fB7OmAtTf/OhfUC9L6rOCXu6IAbtsh7vKLILb3ct6peTSbinU3XkI9ShcJ240TN6rJylgeW3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gNyD71mZzzcb0D;
	Mon, 25 May 2026 08:57:59 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id AA95440538;
	Mon, 25 May 2026 09:05:41 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 09:05:40 +0800
Message-ID: <b47c38f9-462d-4974-b23e-b654bcf804dd@hisilicon.com>
Date: Mon, 25 May 2026 09:05:40 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
 <112c6947-d496-46a9-8561-bbc23793e615@hisilicon.com>
 <9a8065c7-249d-4a48-96a3-460048f1f94b@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <9a8065c7-249d-4a48-96a3-460048f1f94b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/21/2026 7:58 PM, Pierre Gondois wrote:
> Hello Jie,
> 
> On 5/20/26 10:38, Jie Zhan wrote:
>> On 5/11/2026 9:55 PM, Pierre Gondois wrote:
>>> Consider policy->min/max being set in the driver .init()
>>> callback as a QoS request. Impacted driver are:
>>> - gx-suspmod.c (min)
>>> - cppc-cpufreq.c (min)
>>> - longrun.c (min/max)
>>>
>>> Update the documentation accordingly.
>>>
>>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>>> ---
>>>   Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
>>>   drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
>>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
>>> index c5635ac3de547..ab4f3c0f3a89b 100644
>>> --- a/Documentation/cpu-freq/cpu-drivers.rst
>>> +++ b/Documentation/cpu-freq/cpu-drivers.rst
>>> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>>>   |policy->cur                | The current operating frequency of   |
>>>   |                    | this CPU (if appropriate)           |
>>>   +-----------------------------------+--------------------------------------+
>>> -|policy->min,                |                       |
>>> -|policy->max,                |                       |
>>> +|policy->min                | If set by the driver in ->init(),    |
>>> +|                    | used as initial minimum frequency       |
>>> +|                    | QoS request.               |
>>> ++-----------------------------------+--------------------------------------+
>>> +|policy->max                | If set by the driver in ->init(),    |
>>> +|                    | used as initial maximum frequency       |
>>> +|                    | QoS request.               |
>>> ++-----------------------------------+--------------------------------------+
>> Hi Pierre,
>>
>> Trivial bit: add the general meaning alongside its driver usage at the init
>> stage, and mention it defaults to cpuinfo_min/max_freq if not set?
>>
>> I mean something like:
>> The minimum/maximum scaling frequency.  If set by the driver in ->init(),
>> used as initial minimum/maximum frequency QoS request; otherwise, follow
>> policy->cpuinfo.min/max_freq.
> 
> Just one NIT, policy->min/max should follow the min/max allowed freq.
> 
> the cpufreq driver can set. E.g. a thermal constraint can impact it (cf. dtpm_cpu.c).
> 
> Would this fit ?
> 
> The minimum/maximum scaling frequency.  If set by the driver in ->init(),
> used as initial minimum/maximum frequency QoS request; otherwise, follow
> the min/max allowed freq. the cpufreq driver can set.
> 
Sure! That's good.
> 
>> Thanks,
>> Jie
>>>   |policy->policy and, if necessary,  |                       |
>>>   |policy->governor            | must contain the "default policy" for|
>>>   |                    | this CPU. A few moments later,       |
>> [ ... ]
> 
