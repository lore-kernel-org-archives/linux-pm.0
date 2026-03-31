Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACDE3ED5CD;
	Tue, 31 Mar 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949432; cv=none; b=W2Dxxk1X44ritZlFxSMlkrjzusD71IYSDah/ZWvbQ9J340z19pDEmzqZyipn89z1w57o5f40t+8fbdlT7PHl9Y6rcYbn7bKQyZ7OwhOJTw157zq3TyCJw9lg6cq/yqizRpXZNxsIN5JNIPfmaynmV2xfSqkNpH1tleKo9pcA18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949432; c=relaxed/simple;
	bh=tCcFV7UsIazPIkAWJ8jZF1p/YDnHm2sj+kpw//p9y24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ3hXdOccRZb9N1DZpM6dWEKK1yUM2jFD9llTnSN9lqgVjdxf+85p1ewJtRPjzROhUWdTJXyotBY/yIY2J1F7m7XGtZ2rhS5zGxRYQ3GA83gwZc/TSmtV11ADuUCpdYrT4Sd5e2Gl9u4J/vjg6qi3bJmbUuUN2YvdKZA09Y8lHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c9b23382ce411f1aa26b74ffac11d73-20260331
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:aa0705ed-e1ec-47b1-8b50-6d5102834049,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e9a3049094644b7571781103b23568e0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c9b23382ce411f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1873808177; Tue, 31 Mar 2026 17:30:20 +0800
Message-ID: <f954648e-33d0-4b07-977d-96af182fc2ef@kylinos.cn>
Date: Tue, 31 Mar 2026 17:30:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/4] PM / devfreq: Fix governor_store() failing
 when device has no current governor
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091710.1006814-1-tianyaxiong@kylinos.cn>
 <5ac69894-aa0d-475f-8950-a0ff98f9fa2e@hisilicon.com>
 <ebee5d1c-f42f-4b51-aa98-2a015ee61706@kylinos.cn>
 <d6c69fc9-d504-4c62-8181-f531276c7443@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <d6c69fc9-d504-4c62-8181-f531276c7443@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/31 16:53, Jie Zhan 写道:
>
> On 3/31/2026 4:02 PM, Yaxiong Tian wrote:
>> 在 2026/3/31 15:16, Jie Zhan 写道:
>>> On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
>>>> Since devfreq_remove_governor() may clear the device's current governor
>>>> in certain situations, while governors actually exist independently
>>>> of the device, directly returning EINVAL in this case is inaccurate.
>>>>
>>>> To fix this issue, remove this check and add relevant logic for when
>>>> df->governor is NULL.
>>>>
>>>> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 15 ++++++++++++---
>>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 0bf320123e3a..4a312f3c2421 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -1425,9 +1425,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>        char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>        const struct devfreq_governor *governor, *prev_governor;
>>>>    -    if (!df->governor)
>>>> -        return -EINVAL;
>>>> -
>>>>        ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>>>        if (ret != 1)
>>>>            return -EINVAL;
>>>> @@ -1438,6 +1435,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>            ret = PTR_ERR(governor);
>>>>            goto out;
>>>>        }
>>>> +
>>>> +    if (!df->governor) {
>>>> +        df->governor = governor;
>>>> +        ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>>> +        if (ret) {
>>>> +            dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>>> +                __func__, df->governor->name, ret);
>>>> +            df->governor = NULL;
>>>> +        }
>>>> +        goto out;
>>>> +    }
>>>> +
>>> The sequence that starts the governor, and stops, and then re-starts looks
>>> quite weird.
>>> Can you do a NULL pointer check before the IMMUTABLE flag check and
>>> stopping governor, rather than this?
>> This patch only addresses the issue raised in the commit message. As for the original
>>
>> start, stop, and then restart sequence, I haven't found any problems with it so far.
>>
> You just added the first 'start' here.
> Please see the other process in governor_store().
Could you explain what you mean?
Wouldn't it be correct to directly operate on the devices without a 
governor first and then exit?
>>>>        if (df->governor == governor) {
>>>>            ret = 0;
>>>>            goto out;
