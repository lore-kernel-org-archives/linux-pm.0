Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DB309F09;
	Thu,  2 Apr 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108883; cv=none; b=lFuIPNFp9krvv/yCd60+TKVsFtM6NMogRkYb9zCgA9+7RP8Fs3mMGTDISND2nzg8oXbMdcUm/xV5eWD22xUC4bJ1X0QSXjdITZ1Dt32qDmcIBweQFQ2IpIuyq68DK7J1jTN0+gdUpVuXab2HeGj24+81/LFz5eCAynr8KZUTxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108883; c=relaxed/simple;
	bh=chACCJt1IKkEWjgP7E28dkcm0bEKSHUtDpOAmfHWmi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vus4uIJMMk5SK0fZQ079opRzjhwPIeCUCiwjn4b/1V6BVqNiHcKfFZj+mOHA0Z6xGPz3R9kgO6K7SlE3YaaqNzjnbEhqE1Jh5pH7AJ5NlQ77Ka3W4Pfq71VsNcCI/dWJAVm9FQDNQfhJNAGe5US6mDPU7Wq5MSkMRpU9Akotnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b3e8b422e5711f1aa26b74ffac11d73-20260402
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6b473771-6e44-4ad0-86f1-c04c34e5788d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0c7eb77382a74c2a8a3659a9596b3598,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b3e8b422e5711f1aa26b74ffac11d73-20260402
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1940902015; Thu, 02 Apr 2026 13:47:48 +0800
Message-ID: <daa71f81-cb36-4a9a-abf8-6a435ae79676@kylinos.cn>
Date: Thu, 2 Apr 2026 13:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PM / devfreq: Fix governor_store() failing when
 device has no current governor
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033119.67821-1-tianyaxiong@kylinos.cn>
 <a9edebc1-6a28-4ab3-8016-793c585da9c4@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <a9edebc1-6a28-4ab3-8016-793c585da9c4@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/4/2 11:21, Jie Zhan 写道:
>
> On 4/1/2026 11:31 AM, Yaxiong Tian wrote:
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
>>   drivers/devfreq/devfreq.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 2977b07be939..975f82d7a9d1 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>   	char str_governor[DEVFREQ_NAME_LEN + 1];
>>   	const struct devfreq_governor *governor, *prev_governor;
>>   
>> -	if (!df->governor)
>> -		return -EINVAL;
>> -
>>   	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>   	if (ret != 1)
>>   		return -EINVAL;
>> @@ -1403,6 +1400,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
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
>> +		} else {
>> +			ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
>> +		}
>> +		goto out;
>> +	}
>> +
>>   	if (df->governor == governor) {
>>   		ret = 0;
>>   		goto out;
> Hi Yaxiong,
>
> I'd suggest something like this, such that the main body of the function is
> not changed.
>
> Note that this is just an example. Not tested or carefully checked.
"I still prefer my modification. It's clearer and more straightforward, 
and the increase in code size is very small compared to the 
alternatives. Moreover, if we later want to implement 'cannot unload the 
last governor' (which might be the module reference approach you 
mentioned), we can simply remove this code."


>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2977b07be939..aa0f1db3225c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1390,9 +1390,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>          char str_governor[DEVFREQ_NAME_LEN + 1];
>          const struct devfreq_governor *governor, *prev_governor;
>
> -       if (!df->governor)
> -               return -EINVAL;
> -
>          ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>          if (ret != 1)
>                  return -EINVAL;
> @@ -1403,6 +1400,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>                  ret = PTR_ERR(governor);
>                  goto out;
>          }
> +
> +       if (!df->governor)
> +               goto skip_stop;
> +
>          if (df->governor == governor) {
>                  ret = 0;
>                  goto out;
> @@ -1423,6 +1424,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>                  goto out;
>          }
>
> +skip_stop:
>          /*
>           * Start the new governor and create the specific sysfs files
>           * which depend on the new governor.
> @@ -1435,6 +1437,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>                           __func__, df->governor->name, ret);
>
>                  /* Restore previous governor */
> +               if (!prev_governor)
> +                       goto out;
>                  df->governor = prev_governor;
>                  ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>                  if (ret) {
