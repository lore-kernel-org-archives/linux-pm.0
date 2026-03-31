Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1A3D75B0;
	Tue, 31 Mar 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944133; cv=none; b=HQFcWWh0qjfmHInFPTWH9r4M9k89wdGYEQQECQEUqivvN3Rep+vCSRN8MxNreRwPaSmFBVMCnLqr5r20qNgAvw5wmS7ehIOC2Vjmpr5YnOpC6FzWbCDEBav8v+j+bOyUCeZrdAP41Cw4q3W3KY3sKZ3wNBOrtzSqmPf2vNCs5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944133; c=relaxed/simple;
	bh=SkBE8if+1kwrpsQVM8SMzg1YKuIUImAMgr0GjPz7XS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPwxhCmt/DQ+z3NQRrqtnAkYaEax6JWe1wunf5T9yQgXZCCS0YhXAn4LJKS/7TS29b4PTfPYJmTchrp12BJdYb6p5Ew/0Etxw7N/fhEUjJGx2SInVuOrd1WdMfMhWz8riyzx8+lDLhKbaYQ8Zm7a4BrfafwAUjAbCaqS4FdS2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e81fe7fa2cd711f1aa26b74ffac11d73-20260331
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:46fa3b06-49cc-479d-a7f6-6cfd83d20e3a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1209fa6ea655702f5d35e355f4f05c54,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e81fe7fa2cd711f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 757621866; Tue, 31 Mar 2026 16:02:04 +0800
Message-ID: <ebee5d1c-f42f-4b51-aa98-2a015ee61706@kylinos.cn>
Date: Tue, 31 Mar 2026 16:02:02 +0800
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
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <5ac69894-aa0d-475f-8950-a0ff98f9fa2e@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/31 15:16, Jie Zhan 写道:
>
> On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
>> Since devfreq_remove_governor() may clear the device's current governor
>> in certain situations, while governors actually exist independently
>> of the device, directly returning EINVAL in this case is inaccurate.
>>
>> To fix this issue, remove this check and add relevant logic for when
>> df->governor is NULL.
>>
>> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   drivers/devfreq/devfreq.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0bf320123e3a..4a312f3c2421 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1425,9 +1425,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   	char str_governor[DEVFREQ_NAME_LEN + 1];
>>   	const struct devfreq_governor *governor, *prev_governor;
>>   
>> -	if (!df->governor)
>> -		return -EINVAL;
>> -
>>   	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>   	if (ret != 1)
>>   		return -EINVAL;
>> @@ -1438,6 +1435,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   		ret = PTR_ERR(governor);
>>   		goto out;
>>   	}
>> +
>> +	if (!df->governor) {
>> +		df->governor = governor;
>> +		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>> +		if (ret) {
>> +			dev_warn(dev, "%s: Governor %s not started(%d)\n",
>> +				__func__, df->governor->name, ret);
>> +			df->governor = NULL;
>> +		}
>> +		goto out;
>> +	}
>> +
> The sequence that starts the governor, and stops, and then re-starts looks
> quite weird.
> Can you do a NULL pointer check before the IMMUTABLE flag check and
> stopping governor, rather than this?

This patch only addresses the issue raised in the commit message. As for 
the original

start, stop, and then restart sequence, I haven't found any problems 
with it so far.

>>   	if (df->governor == governor) {
>>   		ret = 0;
>>   		goto out;
