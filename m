Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA03C5546;
	Tue, 28 Apr 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345209; cv=none; b=FnGewmsoxFUClvtoX2vIuVakt33oEEni4ySi+990TQz0bjVHxEnD2WKpwM2Ge2qqsFaAiJqIF2+JQuEb/z9EaToZOiFv2LCfTkNfC4NuQMyENvcny9wZWrBe5BDC2ySqWAcaAzoWBSm9wDDXMhIIWPhu/Ytg0u6vVvIfFjfqIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345209; c=relaxed/simple;
	bh=xT7s5FbgC7VQxhEWr8+IYnQfyq8bFYUPpUuhHibqnWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHzs2AtH/yfXU1b+YKKrEWXmINhIb2PJ/KiGyFXaSX5/OzL0fYmjNckIgjb9OG2kj7L9Ix4qJiZhJxwdsLVI8XelRUULh/CvQDGIwZHuch7tz2ojgj7csbL0mIL3jCSXYYG+3zxoZ9FOkZKSfgw3Dyi8v66kHgHAAnDE0cLvuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 566d046842ae11f1aa26b74ffac11d73-20260428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4b2e6f31-f0d5-4640-ae1c-7bacad8ae641,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:01dec1e8b74ccf8888137bec0460c875,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 566d046842ae11f1aa26b74ffac11d73-20260428
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1769826779; Tue, 28 Apr 2026 10:59:56 +0800
Message-ID: <5563d184-f867-40a0-ac39-93fa60969164@kylinos.cn>
Date: Tue, 28 Apr 2026 10:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Fix some errors in the devfreq core layer when
 governor is NULL
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <27c3f3af-beee-422d-b96a-60472a16b0aa@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <27c3f3af-beee-422d-b96a-60472a16b0aa@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/4/28 10:50, Jie Zhan 写道:
>
> On 4/1/2026 11:28 AM, Yaxiong Tian wrote:
>> While doing some development work with devfreq_add_governor()/
>> devfreq_remove_governor(), I discovered several bugs caused when
>> devfreq->governor is NULL. Specifically:
>>
>> 1) A possible null pointer issue in devfreq_add_governor(), caused
>> by devfreq_remove_governor() setting devfreq->governor to NULL in
>> certain situations, while devfreq_add_governor() lacks corresponding
>> checks for devfreq->governor.
>>
>> 2) When operating on governor and available_governors under /sys,
>> there are also some unexpected errors.
>>
>> For issue 1, the solution is similar to Jie Zhan's PATCH.
>> https://lore.kernel.org/linux-pm/20260326123428.800407-6-zhanjie9@hisilicon.com/
>>
>> The original v1 approach actually changed the original logic, which is incorrect.
>>
>> See the following patches for details.
>>
>> change in v2:
>> 1) rebase to  linux-next(20260326) /devfreq-next
>> 2) remove some code to fix null pointer in patch1
>> 3) add  sysfs_update_group() in patch2
>>
>>
>> Yaxiong Tian (4):
>>    PM / devfreq: Fix possible null pointer issue in
>>      devfreq_add_governor()
>>    PM / devfreq: Fix available_governors_show() when no governor is set
>>    PM / devfreq: Fix governor_store() failing when device has no current
>>      governor
>>    PM / devfreq: Optimize error return value of governor_show()
>>
>>   drivers/devfreq/devfreq.c | 57 +++++++++++----------------------------
>>   1 file changed, 16 insertions(+), 41 deletions(-)
>>
> Hi Yaxiong,
>
> Any plan for updating this in the 7.1 cycle?
>
> Jie
No plans for now. I tried using BT4 and found that it can automatically 
extract your tags. Currently, we only have some disagreements on patch 
4. This patch isn't very important and can be ignored. Let's just wait 
for the maintainers to decide—maybe your solution or someone else's will 
be better.


