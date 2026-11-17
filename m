Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918089;
	b=EuKjcWvEo9PF/yWHtkH8czDYntviTTZsTZM6yg/e0wLKDox9TIItMuCpkvytHlL4yqaP
	 NZ2uTP8cLZ8lecmbLoaHr3HMcQyMkaSzto2iAz32p9Fp3R0FpfsfXBeiJc/ZXZ0DZl/X7
	 0LkklsMO+WBJnsZIk6C1JjsCEUaMdNc1E6ldgx6vRqp7I06R0TBDM9dWPyTwwEN9csBjz
	 RpvrV5YxudLlm4CH2kY0fb3KG5aXzQKWueVkN4WlMPHjkQ7FokNBGiZhw8ux7+wowfxDK
	 LggWy+nYyAF6jr84+7AV7rq4UAZNwJlMVZjfIx3iV/MJJbxjaz+ka4/psMVJJNzb0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918089;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=h8pgwT7/LO23i619Y0UAnqja3IksVLcqKsSokGT7RtI=;
	b=TiwRUwXhfGROLp41j1WCKvfX7oKQm1kX0AsNkfCwFf1oyJoCzN38SdryFW7t+xV961xE
	 IhL0rKhcmzTI8EavKW0xRbyag9eBCWTfIZSuOyqivOpA2yuRsszcsldNirz2Tx2lpEp97
	 4DGDrEjHsDcwWk6ZrP+U65OoUqSdGPfiUoG/bH1EKIUaxOZPs84PcqB06lPtGmP+YMPkL
	 4HzNtrIUL0pDTVfaweu1Od4dxaxZss63l00CA9QkZ+9ODXH19MEkOsLwCXZNmWgY6qSw6
	 FhW9iSx0yP1P3ewxzZnHuTEPxrFcIu3s8uIiydVcLvU68zCLPyK5xuw0YozeO1JeFQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=w3AiHftS;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602C606A31C;
	Tue, 17 Nov 2026 12:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4602C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=w3AiHftS
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=h8pgwT7/LO23i619Y0UAnqja3IksVLcqKsSokGT7RtI=;
	b=w3AiHftS3/udF+xmmZ1FLvfES3xWYex2cK4+fWFMZcl29zgDh7nEqTkI+0Fg0B7PEJUxtbg5B
	XULBwWWQSGPncSPhprBeKXNRmnSrD8vxUJq64j374OIYCo8Vx+23pWWh9omL4ES5VtcLEjWTbAl
	0EzY4eIOd6aw5zqtJxk9Etc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jTP393njBzKm5K;
	Tue, 17 Nov 2026 20:21:09 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 571B64057A;
	Tue, 17 Nov 2026 20:21:23 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 20:21:22 +0800
Message-ID: <eb615885-2756-4750-9e8f-411308c77a42@huawei.com>
Date: Tue, 17 Nov 2026 20:21:22 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: Enable boost by default
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mojunjun4@huawei.com>
References: <20261117105240.1113405-1-zhangpengjie2@huawei.com>
 <47ef2005-97ff-4841-8a87-5093323e1914@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <47ef2005-97ff-4841-8a87-5093323e1914@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 11/17/2026 7:06 PM, Christian Loehle wrote:
> On 11/17/26 10:52, Pengjie Zhang wrote:
>> The CPPC driver leaves boost disabled by default when Highest Performance
>> exceeds Nominal Performance. Userspace must explicitly enable boost
>> before governors can use the full advertised performance range.
>>
>> For user convenience, set .boost_enabled = true in cppc_cpufreq_driver.
>> Since cppc_cpufreq_cpu_init() sets policy->boost_supported when
>> highest_perf > nominal_perf, the cpufreq core will enable boost by
>> default only for policies that support it.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>
> That being said it doesn't apply cleanly on bleeding-edge, so you might
> wanna rebase to make Rafael's life a little easier.
Yes, cppc_cpufreq seems to have merged a lot of content into linux-next.
>> ---
>> Changes in v3:
>> - Drop cppc_cpufreq_default_boost_init() and set .boost_enabled = true
>>    statically in cppc_cpufreq_driver (Christian).
>> - Link to v2: https://lore.kernel.org/all/20261022075901.3436021-1-zhangpengjie2@huawei.com/
>>
>> Changes in v2:
>> - Drop "even" from the commit message (Christian).
>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 957fa7775260..1ea16e95c0e9 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1059,6 +1059,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>   	.fast_switch = cppc_cpufreq_fast_switch,
>>   	.init = cppc_cpufreq_cpu_init,
>>   	.exit = cppc_cpufreq_cpu_exit,
>> +	.boost_enabled = true,
>>   	.set_boost = cppc_cpufreq_set_boost,
>>   	.attr = cppc_cpufreq_attr,
>>   	.name = "cppc_cpufreq",
>
>
