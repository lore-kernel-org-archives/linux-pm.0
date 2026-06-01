Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD18BBAE;
	Mon,  1 Jun 2026 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279466; cv=none; b=RMK+Z0q+86N2lt4HvkNxbwJ9VcfPQuHvXfNPJVWeqsPCxjaiL52Fnv2wJNuujqiI5b2HhoVD+edkVSL6gnTQoaAXuHgTCJkK1woZQYbIMLXhMp+EL0IzqdAKhz0JXvP7nuhRkgHJbHlZXAyXV1n0W4BMrQpuC1LjZFDswrwRXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279466; c=relaxed/simple;
	bh=24u0Mc/omcptN/bXvWCbC/xhppIqcwqy22nqFlXk27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T6+wpmlYpXlEAd4+ETM1ACnzqm2Ec6SQyCPQUH9BP9y1XeuAn1W3OUTDGC12++3A8i57lOtt1sYFDGfT3Fsa7kwGkWTGzSlvbT0OzDfrdrJVXsH8lmrMMoUs7jQhe0pQhxW4S7nWnj0OxxLkXntlP1515RX7Bn4BA5dtB98P7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PqZWk8y9; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PqZWk8y9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=n6O/rJnqc29q+9bm0i+9ElxVQIbKP87fJyka1ARSiLI=;
	b=PqZWk8y9AK9nxhWXCFpDQs0N5riIKYx7IJNft1TIUVObqLqzqKxzJPQiaDA+c0nwhCVazVoNL
	FrU3FWVzaL5zGM3N0EqntW9dSYBqZjafpEkZ0Q4glhkX1PdT1qiEgIDBx3K2Pt7xlpZ31P2hqaP
	WtnREqT0t4m5J9RIQ04DHf8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gTHBS34fDz1cyPZ;
	Mon,  1 Jun 2026 09:56:32 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id BA9364056C;
	Mon,  1 Jun 2026 10:04:19 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 10:04:18 +0800
Message-ID: <2712839c-fb9b-4717-a36f-a0f922115be8@huawei.com>
Date: Mon, 1 Jun 2026 10:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Documentation: fix freq_step description
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>
CC: <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>
References: <20260529111122.3321645-1-zhangpengjie2@huawei.com>
 <f598e862-8120-4922-9d04-6e3729187420@oss.qualcomm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <f598e862-8120-4922-9d04-6e3729187420@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 5/30/2026 10:36 PM, Zhongqiu Han wrote:
> On 5/29/2026 7:11 PM, Pengjie Zhang wrote:
>> The conservative governor documentation incorrectly states that setting
>> freq_step to 0 will use the default 5% frequency step. In reality, since
>> the governor's initial implementation
>> commit b9170836d1aa ("[CPUFREQ] Conservative cpufreq governer"),
>> freq_step=0 has always caused the governor to skip frequency updates
>> entirely.
>
> Hi Pengjie,
>
> Thanks for the patch.
>
> The documentation fix looks correct: in the current code,
> cs_dbs_update() has an early goto out when freq_step == 0, which skips
> the call to get_freq_step() and all subsequent frequency change logic.
>
> However, the commit message's historical claim appears to be inaccurate.
> In the original implementation (b9170836d1aa), freq_step=0 had
> asymmetric behavior: frequency decreases were skipped (early return),
> but frequency increases still used the hardcoded 5% fallback (freq_step
> = 5 after the unlikely(freq_step == 0) check).
>
> If so, would it make sense to remove/update the historical claim to
> avoid the incorrect historical claim?
>
Thanks for the careful review.

Agreed. The correct commit for the symmetric freq_step=0 behavior
should be 8e677ce83bf4 ("[CPUFREQ] conservative: fixup governor to
function more like ondemand logic"), not b9170836d1aa.

I'll fix the commit message in v2.

On a related note, I have a quick question regarding code readability in
this area. Currently, the code uses the name "freq_step" for two different
concepts:

1. `cs_tuners->freq_step`: The tunable exposed via sysfs/documentation,
    which represents a percentage.
2. `freq_step = get_freq_step(...)`: The local variable representing the
    actual calculated frequency step (in kHz). The `if 
(unlikely(freq_step == 0))`
    check also applies to this absolute value.

Since mixing a percentage and an absolute kHz value under the same name
might be slightly confusing for readers, would it make sense to rename the
local variable (e.g., to `freq_step_khz`) to clearly distinguish the two?

Cheers,
     Pengjie

>>
>> Correct the documentation to reflect the actual behavior: freq_step=0
>> disables frequency changes by the governor entirely.
>>
>> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and 
>> consolidation")
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   Documentation/admin-guide/pm/cpufreq.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst 
>> b/Documentation/admin-guide/pm/cpufreq.rst
>> index dbe6d23a5d67..98c724d49047 100644
>> --- a/Documentation/admin-guide/pm/cpufreq.rst
>> +++ b/Documentation/admin-guide/pm/cpufreq.rst
>> @@ -586,8 +586,8 @@ This governor exposes the following tunables:
>>       100 (5 by default).
>>         This is how much the frequency is allowed to change in one 
>> go.  Setting
>> -    it to 0 will cause the default frequency step (5 percent) to be 
>> used
>> -    and setting it to 100 effectively causes the governor to 
>> periodically
>> +    it to 0 disables frequency changes by the governor entirely and 
>> setting
>> +    it to 100 effectively causes the governor to periodically
>>       switch the frequency between the ``scaling_min_freq`` and
>>       ``scaling_max_freq`` policy limits.
>
>
