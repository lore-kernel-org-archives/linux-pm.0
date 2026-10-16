Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250524AB1DE;
	Fri, 16 Oct 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155351; cv=none; b=WOmDDAB6lQvnbNdGz/EbOz8ngUsWEkJuN0qGlwAU83xQFfvboWhMaN6EToScEOaPW8DZtcNXH8BiEzgrOR3Z6WYhRBN3Cd+H15D8LYZWA7I3ui0CDbu42oj4/BcNLpn9sRv54+cZ2ms8CZMo7zIXqESWHISM88XX05MIEI6/hHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155351; c=relaxed/simple;
	bh=B/XHc5QEHx65UP08zWBVP53XJ+6UIH9Km0x9u5V/RCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KBXhrlHUq7m5SNyAHnxZy8HEGD6hJRm+na/Dz8kCbO5ehXr5UEq84h26C5XPPM94WZhyznwmrN233KxwDUVQfWJWv/XaYwj/KIFJSjo7+oiZ0Ta0H4UwwehtsuzaYQ3FUjR05+MtWdLyDjg8bWuhF/EPaBOBMkq+QKF9IQ7wMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QADqIEIj; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QADqIEIj; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QADqIEIj";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QADqIEIj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e6bf5NKFYpws3pUZm7Kkxc7Q8Qp6oEjqucdcj1ZE708=;
	b=QADqIEIjlZRGfcdgknIPF7XIE5LNvx2OEOa5Tyhy0rIIpvF5i1F15pvV7HguMdJjc0HzyJuyg
	9KDZFyhB8vkKlGHrl8MV0bC+zUHoN1nEOVoUYNJD/n2fc/YIBnztSzEabqpYBLa4oHrpLDK+jl+
	WmsrklxZKVKhgWcwR03A3Wk=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4j5lKL7399z126Ls7;
	Fri, 16 Oct 2026 20:55:18 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e6bf5NKFYpws3pUZm7Kkxc7Q8Qp6oEjqucdcj1ZE708=;
	b=QADqIEIjlZRGfcdgknIPF7XIE5LNvx2OEOa5Tyhy0rIIpvF5i1F15pvV7HguMdJjc0HzyJuyg
	9KDZFyhB8vkKlGHrl8MV0bC+zUHoN1nEOVoUYNJD/n2fc/YIBnztSzEabqpYBLa4oHrpLDK+jl+
	WmsrklxZKVKhgWcwR03A3Wk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j5l3p0fnWznTVd;
	Fri, 16 Oct 2026 20:43:34 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 253A34056C;
	Fri, 16 Oct 2026 20:55:25 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 16 Oct
 2026 20:55:24 +0800
Message-ID: <342f2eb0-2028-4661-8679-cbb8d7cb354b@huawei.com>
Date: Fri, 16 Oct 2026 20:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Enable boost by default when supported
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mojunjun4@huawei.com>
References: <20261015015812.867988-1-zhangpengjie2@huawei.com>
 <0d05f4b5-b7f3-4fb5-b5cb-8b4d75ab78b3@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <0d05f4b5-b7f3-4fb5-b5cb-8b4d75ab78b3@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi Christian,

Thanks for the review.

On 10/15/2026 4:42 PM, Christian Loehle wrote:
> On 10/15/26 02:58, Pengjie Zhang wrote:
>> The CPPC driver leaves boost disabled by default, even when Highest
> "even"? That's the only case where disabling it even means something?

Agreed, I'll remove "even" in v2.

>> Performance exceeds Nominal Performance. Userspace must explicitly
>> enable boost before governors can use the full advertised performance
>> range.
>>
>> For user convenience, enable boost by default when at least one possible
>> CPU reports support. Check the performance capabilities before registering
>> the driver so that the cpufreq core enables boost for each policy that
>> supports it.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> I often wonder if we should keep boost altogether, the power and
> thermal envelope on silicon nowadays is complex enough for this to have
> little meaning, it in no way guarantees no throttling or that you receive
> the requested performance.
I agree that enabling boost does not guarantee the requested performance.

However, CPPC distinguishes Nominal from Highest Performance. Highest
Performance may not be sustainable for long durations, while Nominal
Performance is expected to be able to maintain continuously.

Boost control lets user trade off burst capacity above nominal against
staying within safe limits. While performance won't be completely steady,
having that flexibility is worth it."

> The (silicon-aware) user can always individually set the ceilings s.t.
> it 'works' for their platform/workload/environment combination via
> scaling_max_freq.
Yes, but users need to determine an appropriate frequency ceiling for
their platform. The boost  provides a simpler way to select the
nominal limit without determining its frequency value for each policy.
>
> Since commit 54e74df5d76d
> was also introduced by Huawei I'd be curious about the usage there,
> AFAICS having a platform with NOMINAL_PERF != HIGHEST_PERF is just
> additional headache on linux for now?
On our server platforms, users can configure whether firmware advertises
highest_perf above nominal_perf. CPPC defines both performance levels and
allows them to differ.

My proposal makes that advertised range available by default while
retaining the boost control for users who want to exclude it.

Thanks,
Pengjie


>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 80893844353c..0a4255a36f60 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>   	.name = "cppc_cpufreq",
>>   };
>>   
>> +static void __init cppc_cpufreq_default_boost_init(void)
>> +{
>> +	struct cppc_perf_caps caps;
>> +	bool enable = false;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (cppc_get_perf_caps(cpu, &caps))
>> +			continue;
>> +
>> +		if (caps.highest_perf > caps.nominal_perf) {
>> +			enable = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	cppc_cpufreq_driver.boost_enabled = enable;
>> +}
>> +
>>   static int __init cppc_cpufreq_init(void)
>>   {
>>   	int ret;
>> @@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
>>   
>>   	cppc_freq_invariance_init();
>>   	populate_efficiency_class();
>> +	cppc_cpufreq_default_boost_init();
>>   
>>   	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>>   	if (ret)
>
