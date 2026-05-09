Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3A2F8EBE;
	Sat,  9 May 2026 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291672; cv=none; b=ig/Gh4zjxFNMSjB+AN0/hHd76SNM7TA+zNtPJVB9Zn/Z3pFF1NVd1YfHeYc9p5C94uQdqRp3wGiCNwOlZcueff7D1UQjfLB7e0gEfFvjhwFY41ciZNEcvQtt+5qd4M2N6gWjW0LGY7fmvdtz+xWPalxaVQ+SGjOKfrROA8+vtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291672; c=relaxed/simple;
	bh=HERyAdP+exSX9h4/WV6CKzMtXQyUWufjiWnu+jiS65Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=enA7t17JNezWufGwpF1MomUTHBi1S/G9NGrJ25cusZQd/K54M7v3LvcmyD0lbJtt/oxbXJ0eDRN2E2Xguw+R53RxP6f2SnTMJjIdTCyzkveuXVJCzXuqHpSTLkbZM9wrF18FsE4np+ArEyZFTHdZZHutPtWJ8jEqnl0B6UIqZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tfwk4SfY; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tfwk4SfY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jVx9rVN4vouiKUeinE6cw7Q862gbOCVU/+d2XWxAAis=;
	b=tfwk4SfYR99mq6c7G3WVfA4yGbbEM5PCgDaisDMgJzyn3hfzC2U0iZgO5SIcD9ylcPmIRPR8R
	XjPk0w9SVW+8DweHgBNzBeurB6bSUgI901OcE9Mq+UiA/Hu1a4l1AM8weRkcqP3oLpjFW8EhYLR
	n8eMqgTnNlzUM7du6UXg0lo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gC84M31yBznTxR;
	Sat,  9 May 2026 09:47:15 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id A774640539;
	Sat,  9 May 2026 09:54:20 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 9 May
 2026 09:54:19 +0800
Message-ID: <1d046cd5-8eea-4b1d-ad58-02346207a045@huawei.com>
Date: Sat, 9 May 2026 09:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <rafael@kernel.org>,
	<stratosk@semaphore.gr>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/7/2026 5:33 PM, Viresh Kumar wrote:
> On 23-04-26, 15:12, zhenglifeng (A) wrote:
>> Yes, I think you are right. The behaviors are not the same. I modified this
>> just in order to keep it consistent with the case exceeding down_threshold.
>> I'm not sure if this change of behavior is reasonable. Perhaps Rafael or
>> Viresh could give us some advice.
> 
>>>> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
>>>> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>>>           dbs_info->down_skip = 0;
>>>>             /* if we are already at full speed then break out early */
>>>> -        if (requested_freq == policy->max)
>>>> +        if (dbs_info->requested_freq == policy->max)
>>>>               goto out;
> 
>>>> -        if (requested_freq == policy->min)
>>>> +        if (dbs_info->requested_freq == policy->min)
> 
> What about dropping these `if` blocks completely ? i.e. always call
> __cpufreq_driver_target().
> 
> __cpufreq_driver_target() already have similar checks in place to optimize
> unnecessary freq changes. We don't really need callers to do the same.
> 

__cpufreq_driver_target() only skips this when !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS),
this means that for cppc_cpufreq, amd-pstate and intel_pstate the
unnecessary freq change will still be called.

