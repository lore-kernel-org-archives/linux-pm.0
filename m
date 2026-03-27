Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EF318B9C;
	Fri, 27 Mar 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576528; cv=none; b=BnLacw1InxHfYkKQ22kXtQai79fBj40SoM2rd7YqLy+oqADmxpPTTGg3I7QT09ACmlbG/xJYtIBOFIw9uzO4aR+VmsgEqb5WoHJH6pebzyJY6Bs9s6kobH8mX8c3kyjCSqiMCjR0m1EmNp792fPC7T3PVx3dHPRBJhEjPtqRpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576528; c=relaxed/simple;
	bh=XTVWuAXchdkLTQ/KIoseCPBytQzwLzoWmmEdKyVwSZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crqlcm7rrn1fNfu36kM1RZUNfN+ICn4Ecfq4LnB49zlvdzZ7Y9/XIH5gD2AYnTt/HKzi7rV2+/C3rQDvsnO8gMNOxJQzsMgHE2bn3Ss1sLC/wE6uECtBvBPFP+NQq5bd58t2NM7w4anO4L1MFvn14GZKjLQJAQ/xuAOw594Q5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 01dfbce8298011f1a21c59e7364eecb8-20260327
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:0ea18da4-b11c-4504-90a8-d317301eeaf7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:dfbcf60dd960fa3a58ec4966a3beeae8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 01dfbce8298011f1a21c59e7364eecb8-20260327
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1810477172; Fri, 27 Mar 2026 09:55:18 +0800
Message-ID: <99dfd307-2ead-4f7c-a787-6a53ac40c36b@kylinos.cn>
Date: Fri, 27 Mar 2026 09:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/4] Fix some errors in the devfreq core layer when
 governor is NULL
To: Jie Zhan <zhanjie9@hisilicon.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319091409.998397-1-tianyaxiong@kylinos.cn>
 <1774486650723160.85.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <1774486650723160.85.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/25 18:06, Jie Zhan 写道:
>
> On 3/19/2026 5:14 PM, Yaxiong Tian wrote:
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
>> See the following patches for details.
> Hi Yaxiong,
>
> Sorry for catching this late.
>
> I happen to be working on the same issues recently on a local tree, though
> delayed for quite a while due to other business.
>
> It would be a totally different approach by reworking the locking logic,
> which, I supposed, can make the devfreq framework cleaner to maintain.
>
> I'll send it out shortly.  Hopefully it can be a reference for us to
> discuss with.
>
> Thanks!
> Jie

Hi  Jie
	Thank you for your reply. I saw your PATCH in the public linked list, and I think your optimization work, such as the lock mechanism improvements, should be placed after my FIX. This will make it easier to backport the patches and fix lower-version kernels.
	I see the patch is already in the devfreq-testing branch. I hope this work can be pushed forward as soon as possible to resolve the null pointer and other bugs.
	Finally, if you have any further optimizations, remember to CC me on the patches. :)

>> Yaxiong Tian (4):
>>    PM / devfreq: Fix possible null pointer issue in
>>      devfreq_add_governor()
>>    PM / devfreq: Fix available_governors_show() when no governor is set
>>    PM / devfreq: Fix governor_store() failing when device has no current
>>      governor
>>    PM / devfreq: Optimize error return value of governor_show()
>>
>>   drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++------------------
>>   1 file changed, 25 insertions(+), 21 deletions(-)
>>
