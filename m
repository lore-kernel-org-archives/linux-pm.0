Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023623CF026;
	Tue, 31 Mar 2026 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944239; cv=none; b=OqcFjPcPSeuJTYw0poKKmAeIQ6udmKVgpjgeiy8hpEaCOufHO+n1BXFMd5EaW/nj5+nYKEvx3lPbHX1YVuxoMvRoqNk5xPwBsxh0yD+Zh8d2GnC+PPpo1NIJQdPc7LxaoGtsfCU4ZS5v71NMLZG1zDrR+ep4Pxu7e0nby2Ysejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944239; c=relaxed/simple;
	bh=5uqK731vR+75H7gwgy/wyP4VaSiYXOIDzhMXGozGNfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcqLdJk1l7YPokxmtB1oAYiR3Sg8P1RO45+f1K3AiqsaAev09mB1/bIL7dwFvziKDpXZhjfK6JlZjjWGJzfKgJVFzuGNCXLg4q3ApqVke1Ud/kFpMNLThPH1WzUr9un3G3ZC7W2P/avLrEVb6W0taiAp+aAHxd4r5DdYefHKzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 27e99e262cd811f1aa26b74ffac11d73-20260331
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:294f5939-fec9-4294-bd88-e7ca3a4a3314,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:93166592832e548ed8e6089bd16be6dc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 27e99e262cd811f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1152301081; Tue, 31 Mar 2026 16:03:51 +0800
Message-ID: <b353e059-f07d-4d51-a98e-76e915e179dc@kylinos.cn>
Date: Tue, 31 Mar 2026 16:03:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/4] PM / devfreq: Optimize error return value of
 governor_show()
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091719.1007244-1-tianyaxiong@kylinos.cn>
 <9f58b042-d420-4e9b-a26b-b95bc6e11fac@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <9f58b042-d420-4e9b-a26b-b95bc6e11fac@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/31 15:21, Jie Zhan 写道:
>
> On 3/19/2026 5:17 PM, Yaxiong Tian wrote:
>> When df->governor is NULL, governor_show() returns -EINVAL, which
>> confuses users.
>>
>> To fix this issue, return -ENOENT to indicate that no governor is
>> currently set for the device.
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   drivers/devfreq/devfreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 4a312f3c2421..7cc60711fafd 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1412,7 +1412,7 @@ static ssize_t governor_show(struct device *dev,
>>   	struct devfreq *df = to_devfreq(dev);
>>   
>>   	if (!df->governor)
>> -		return -EINVAL;
>> +		return -ENOENT;
> What about -ENODEV?
I think a governor is not a device, so -ENOENT would be more appropriate.
>>   
>>   	return sprintf(buf, "%s\n", df->governor->name);
>>   }
