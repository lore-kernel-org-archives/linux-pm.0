Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE193C0606;
	Tue, 31 Mar 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943393; cv=none; b=AA+z9K33HgctUCSwmrM5GAJtQv5p/wnxEHdvzlajCUZsZa7eEs9KQiMRi5dwWP0a9wVYyXLx3ZoB42sJEwZ4tsFkoyUyRjqpRndbjNmpBmrlUeL9/6rq1oDOY3b5w+VOO2Fcqu+3YLMZyusnRaL2C3Qlg+hnM3yu9MXR1UX4Iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943393; c=relaxed/simple;
	bh=8SBVsPIU0riP7/9aNPXIi4bpd8krftbFrAaG6vsSnmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BagtA2qkwxOba0g4uDQktk5uGmEOwzcLMAGbgtO/cvW9iLMWtf70hJL5mI8BvzmXR8KHYqrzoauje/sxdV+p5ry7v0rwlhIXVew91XoiBm6/cAfpc+nSYXv1Pn77bYPLRqOCigEt9Ih5tSTSykcGT+5HxYM2ZlKyY75Nau9nNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e73a4a02cd611f1aa26b74ffac11d73-20260331
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8b942797-216d-4fdb-99ed-21225a397fee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0c1770d037e48cb2c2114178b83559fd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e73a4a02cd611f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1794928678; Tue, 31 Mar 2026 15:49:43 +0800
Message-ID: <aa7ee42d-0685-4a70-a084-bf0bdfa82e4a@kylinos.cn>
Date: Tue, 31 Mar 2026 15:49:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] PM / devfreq: Fix possible null pointer issue
 in devfreq_add_governor()
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <20260319091653.1005878-1-tianyaxiong@kylinos.cn>
 <f167d24d-73f9-4463-889e-89fb9f1e4a1a@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <f167d24d-73f9-4463-889e-89fb9f1e4a1a@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/31 15:04, Jie Zhan 写道:
>
> On 3/19/2026 5:16 PM, Yaxiong Tian wrote:
>> When a user removes a governor using devfreq_remove_governor(), if
>> the current device is using this governor, devfreq->governor will
>> be set to NULL. When the user registers any governor
>> using devfreq_add_governor(), since devfreq->governor is NULL, a
>> null pointer error occurs in strncmp().
>>
>> For example: A user loads the userspace gov through a module, then
>> a device selects userspace. When unloading the userspace module and
>> then loading it again, the null pointer error occurs:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000010
>> Mem abort info:
>> ESR = 0x0000000096000004
>> EC = 0x25: DABT (current EL), IL = 32 bits
>> *******************skip *********************
>> Call trace:
>> __pi_strncmp+0x20/0x1b8
>> devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
>> do_one_initcall+0x4c/0x278
>> do_init_module+0x5c/0x218
>> load_module+0x1f1c/0x1fc8
>> init_module_from_file+0x8c/0xd0
>> __arm64_sys_finit_module+0x220/0x3d8
>> invoke_syscall+0x48/0x110
>> el0_svc_common.constprop.0+0xbc/0xe8
>> do_el0_svc+0x20/0x30
>> el0_svc+0x24/0xb8
>> el0t_64_sync_handler+0xb8/0xc0
>> el0t_64_sync+0x14c/0x150
>>
>> To fix this issue, modify the relevant logic in devfreq_add_governor():
>> Only check whether the new governor matches the existing one when
>> devfreq->governor exists. When devfreq->governor is NULL, directly
>> select the new governor and perform the DEVFREQ_GOV_START operation.
>>
>> Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   drivers/devfreq/devfreq.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 54f0b18536db..63ce6e25abe2 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1288,23 +1288,21 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>>   		int ret = 0;
>>   		struct device *dev = devfreq->dev.parent;
>>   
>> -		if (!strncmp(devfreq->governor->name, governor->name,
>> +		if (devfreq->governor && !strncmp(devfreq->governor->name, governor->name,
>>   			     DEVFREQ_NAME_LEN)) {
> Probaly do:
> if (!devfreq->governor)
> 	continue;
> so as to keep the line short and the "else if (!devfreq->governor) {" below
> can be removed.
If that's the case, a dev without a governor would not be able to add a 
new governor.
>
> and also:
> if (!strncmp(devfreq->governor->name, governor->name,
> 	DEVFREQ_NAME_LEN))
> 	continue;
> so we don't have to indent that much.

Currently, governor->name can be set arbitrarily, so duplicate names are 
possible.

But they could still be two different governors. Leaving it unchanged 
seems fine to me.

>
>>   			/* The following should never occur */
>> -			if (devfreq->governor) {
>> +			dev_warn(dev,
>> +				 "%s: Governor %s already present\n",
>> +				 __func__, devfreq->governor->name);
>> +			ret = devfreq->governor->event_handler(devfreq,
>> +						DEVFREQ_GOV_STOP, NULL);
>> +			if (ret) {
>>   				dev_warn(dev,
>> -					 "%s: Governor %s already present\n",
>> -					 __func__, devfreq->governor->name);
>> -				ret = devfreq->governor->event_handler(devfreq,
>> -							DEVFREQ_GOV_STOP, NULL);
>> -				if (ret) {
>> -					dev_warn(dev,
>> -						 "%s: Governor %s stop = %d\n",
>> -						 __func__,
>> -						 devfreq->governor->name, ret);
>> -				}
>> -				/* Fall through */
>> +					 "%s: Governor %s stop = %d\n",
>> +					 __func__,
>> +					 devfreq->governor->name, ret);
>>   			}
>> +		} else if (!devfreq->governor) {
>>   			devfreq->governor = governor;
>>   			ret = devfreq->governor->event_handler(devfreq,
>>   						DEVFREQ_GOV_START, NULL);
