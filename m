Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B23D890A;
	Tue, 31 Mar 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949865; cv=none; b=jsSAYMt0kUVm7Is0ouyv9IJV7RxXEJddGjRdhBAl1/A7MVwYU3w/vzBmZ+jLw/uQt1B1YPFcoYL2/CdZUBqHRdsPSFKaxWRYr++CiC2ayhAryVrQAidHm4zBEjkqPckH9fDrEtGbdvr97lwedUxlwzoe+klKXIwjjqubkMGG39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949865; c=relaxed/simple;
	bh=lR05ctPdLj3oG8UazDz4O+clSBl8eyaoi19+h9DOSug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oiuJvJumXeGtCRarFaVd4QYfxhhi9mrUqLhp5Roa0bvQLStj0vin86P1M/s+/Vp+hWCr9ZiFJNqYmRjqfG/QqyH/GvMOf2viKPlUV7SSQtZYbjR6lfOWWiIGmcX9hbclSHMUkKTaF4ZDR0qzFbk0w1/1jxE5WRkfiRgK0DAf++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4flND42VLlzLlTM;
	Tue, 31 Mar 2026 17:31:32 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id C0C2A40539;
	Tue, 31 Mar 2026 17:37:40 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 17:37:40 +0800
Message-ID: <4d1d2077-a336-4914-b7b1-204cab5a60e0@hisilicon.com>
Date: Tue, 31 Mar 2026 17:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/4] PM / devfreq: Fix governor_store() failing
 when device has no current governor
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>, <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091710.1006814-1-tianyaxiong@kylinos.cn>
 <5ac69894-aa0d-475f-8950-a0ff98f9fa2e@hisilicon.com>
 <ebee5d1c-f42f-4b51-aa98-2a015ee61706@kylinos.cn>
 <d6c69fc9-d504-4c62-8181-f531276c7443@hisilicon.com>
 <f954648e-33d0-4b07-977d-96af182fc2ef@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <f954648e-33d0-4b07-977d-96af182fc2ef@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/31/2026 5:30 PM, Yaxiong Tian wrote:
> 
> 在 2026/3/31 16:53, Jie Zhan 写道:
>>
>> On 3/31/2026 4:02 PM, Yaxiong Tian wrote:
>>> 在 2026/3/31 15:16, Jie Zhan 写道:
>>>> On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
>>>>> Since devfreq_remove_governor() may clear the device's current governor
>>>>> in certain situations, while governors actually exist independently
>>>>> of the device, directly returning EINVAL in this case is inaccurate.
>>>>>
>>>>> To fix this issue, remove this check and add relevant logic for when
>>>>> df->governor is NULL.
>>>>>
>>>>> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
>>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>>> ---
>>>>>    drivers/devfreq/devfreq.c | 15 ++++++++++++---
>>>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 0bf320123e3a..4a312f3c2421 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -1425,9 +1425,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>        char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>>        const struct devfreq_governor *governor, *prev_governor;
>>>>>    -    if (!df->governor)
>>>>> -        return -EINVAL;
>>>>> -
>>>>>        ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>>>>        if (ret != 1)
>>>>>            return -EINVAL;
>>>>> @@ -1438,6 +1435,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>            ret = PTR_ERR(governor);
>>>>>            goto out;
>>>>>        }
>>>>> +
>>>>> +    if (!df->governor) {
>>>>> +        df->governor = governor;
>>>>> +        ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>>>> +        if (ret) {
>>>>> +            dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>>>> +                __func__, df->governor->name, ret);
>>>>> +            df->governor = NULL;
>>>>> +        }
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>> The sequence that starts the governor, and stops, and then re-starts looks
>>>> quite weird.
>>>> Can you do a NULL pointer check before the IMMUTABLE flag check and
>>>> stopping governor, rather than this?
>>> This patch only addresses the issue raised in the commit message. As for the original
>>>
>>> start, stop, and then restart sequence, I haven't found any problems with it so far.
>>>
>> You just added the first 'start' here.
>> Please see the other process in governor_store().
> Could you explain what you mean?
> Wouldn't it be correct to directly operate on the devices without a governor first and then exit?


Ok, the code here starts the governor and directly goes to 'out' that
unlocks mutex, so create_sysfs_files() is skipped.
For example, setting 'userspace' as the governor won't create its belonging
files.

Therefore, I'd suggest that doing a NULL pointer check before the IMMUTABLE
flag check and stopping governor, where df->governor is used, so the
existing logic is not changed.

>>>>>        if (df->governor == governor) {
>>>>>            ret = 0;
>>>>>            goto out;
