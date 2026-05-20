Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB93A8FEA;
	Wed, 20 May 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264618; cv=none; b=f48xhjS3095VSb034/2zXII7/iuGDOhabnQKsMFo7Z+mTGjQyR2mWfjMl2ist/OjhmtZb+3k0okKrdzIIZhFdtLshyk0WajF5sUjW6Koti5YFs+EkQTuEcgMoHFxOHRKmyZIGwz2gAKvrXdL0jcL79ymrTaINt0XosUP43N5BA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264618; c=relaxed/simple;
	bh=cIasKyT9Mql+NubQsZlvMMF1xjUkubhMwwkPzQLjz7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXz1vLeBDMUEqtUraWb97OUatVtZjo0S0LY2DNStWpFIyfC2uPgYrXYLuObgcMk8z5vLatFlPn1b6YbqU/sjoRG6m9u13TQAVSYoFyO3pCbT2QZZRXzFjLKsw5p3+NQFC+D5f/D3RU3jC1vPeNahmhVM31V7xer+ZjhhW0jFAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gL3tF5RSmzRhTJ;
	Wed, 20 May 2026 16:02:29 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id B15B040561;
	Wed, 20 May 2026 16:10:10 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 May
 2026 16:10:07 +0800
Message-ID: <6c637b9b-7240-4225-a974-a0a90da9a49b@hisilicon.com>
Date: Wed, 20 May 2026 16:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cpufreq: Extract cpufreq_policy_init_qos()
 function
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
 <20260511135538.522653-2-pierre.gondois@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260511135538.522653-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/11/2026 9:55 PM, Pierre Gondois wrote:
> Extract the QoS related logic from cpufreq_policy_online()
> to make the function shorter/simpler.
> 
> The logic is placed in cpufreq_policy_init_qos() and is
> now executed right after the following calls:
> - cpufreq_driver->init()
> - cpufreq_table_validate_and_sort()
> 
> This helps preparing following patches that will,
> in cpufreq_policy_init_qos():
> - treat the policy->min/max values set by drivers as QoS requests.
> - set a default policy->min/max value to all policies.
> 
> No functional change.
> 
LGTM, thanks!
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 53 +++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
[ ... ]
