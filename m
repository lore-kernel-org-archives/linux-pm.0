Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53373345CDA;
	Thu, 30 Apr 2026 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519773; cv=none; b=pm4FJdAaO1mU6qCF/40d37uLJudX6dvlvLVeGQ9PJHkpYUogyx0k/m3ikgRk9z9Si3KLJaZp0LFJM0a7SWBSlE8zZBVsrT0cEGAzTJ+XO3ZU/pIpLT7f3XJkOMjaq2oqkL5230XgSpW3/gcVa/ffIm/vCD0SYDYvJlwboRdI+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519773; c=relaxed/simple;
	bh=Q7C8eIFdfYj2iqPHA20R7TStbDZ6h9K3Si13ouG8n/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4rwcpHVNZbgo0P8WNL8T6SipM/7jNdNcZqnv67IuRcijeHn1oONkqwlsb8+BP03GrI+QcylMIK/tKDhNVFeTeU4XKYCU0gP/0QUiQYzshjlyhFfVaA78i88i+id42Wt7laHkwGB4Kt7/TNFVJ+4yDZI/xXXZ+hIwHkmSwyto5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9773aa4444411f1aa26b74ffac11d73-20260430
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c966d154-fb14-4829-b02a-4888461d2c09,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:c966d154-fb14-4829-b02a-4888461d2c09,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:6d598905f2b540f35c3254cc178cecf5,BulkI
	D:260430112926258Q1M2M,BulkQuantity:0,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:n
	il,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9773aa4444411f1aa26b74ffac11d73-20260430
X-User: tianyaxiong@kylinos.cn
Received: from [172.27.57.19] [(175.2.159.75)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 812915853; Thu, 30 Apr 2026 11:29:25 +0800
Message-ID: <4085f36c-c490-4c94-8efb-4a413c769524@kylinos.cn>
Date: Thu, 30 Apr 2026 11:29:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PM / devfreq: Fix governor_store() failing when
 device has no current governor
To: Choi Chanwoo <cwchoi00@gmail.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, zhanjie9@hisilicon.com,
 nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033119.67821-1-tianyaxiong@kylinos.cn>
 <7a500e85-d20d-47f8-b4ce-7015052193c7@gmail.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <7a500e85-d20d-47f8-b4ce-7015052193c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/4/30 06:28, Choi Chanwoo 写道:
>
> 2026-04-01 PM 12:31에 Yaxiong Tian 이(가) 쓴 글:
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
> Hi,
>
> I think that the following patch is able to support on your case.
> Could you please check it?
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e5d3f9cf94dc..f08fc6966eae 100644
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
> @@ -1403,6 +1400,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>                  ret = PTR_ERR(governor);
>                  goto out;
>          }
> +       if (!df->governor)
> +               goto start_new_governor;
> +
>          if (df->governor == governor) {
>                  ret = 0;
>                  goto out;
> @@ -1423,6 +1423,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>                  goto out;
>          }
>   
> +start_new_governor:
>          /*
>           * Start the new governor and create the specific sysfs files
>           * which depend on the new governor.
> @@ -1436,6 +1437,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>   
>                  /* Restore previous governor */
>                  df->governor = prev_governor;
> +               if (!df->governor)
> +                       goto out;
> +
>             
>
> Thanks,
> Chanwoo Choi
Of course. I have tested it, and this patch is fine. So if you have 
already prepared
the patch, you can add my Reviewed-by tag:
Reviewed-by: Yaxiong Tian tianyaxiong@kylinos.cn.
Or directly use my V3 version:
https://lore.kernel.org/all/20260430032035.75496-1-tianyaxiong@kylinos.cn/

