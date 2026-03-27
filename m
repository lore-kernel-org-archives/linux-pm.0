Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76831C84CB
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577181; cv=none; b=fguzPkfdAH9gYEWF91zLUrhtjS1wojALF6nYLPfEieX2ULtEWXEzIrnUWd5A0KEH8XW1WrGcKsxWrClbiqy7eKQiSAsq4CqlYft9+0tt+hofkDT9jRLrEN3Jj+T5b38wRqnun3MQEJlI1tiIT1JGCNa8nq2IaejQTGSVEj1NjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577181; c=relaxed/simple;
	bh=akRa2NIZL9H+rwSwwVDigSKhFRZ7C3lMMNNi7rvCIyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxEmfC2kSLUdHq3/mNLLR1DgmyUekC2BoxY4PfaNmN+0XOMgbbqKbR5TZlMvBv+fkGNqoYUEgfAVFA87wdCKnvk8NAemL696CuUrPw7jNTM7IHRNIYp2keabqfbgorEHsD8zE0om4B52qWxAftKmJMYKrc+vUwvOj7aITDVer5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 88cfe52e298111f1a21c59e7364eecb8-20260327
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:47f67297-d4c4-4a22-95d6-f026f0d123cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:6e92079a5dc80ba334bbc31596d1fe50,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 88cfe52e298111f1a21c59e7364eecb8-20260327
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1468667143; Fri, 27 Mar 2026 10:06:14 +0800
Message-ID: <2f9ab345-5940-4298-87a5-bf9121fe219e@kylinos.cn>
Date: Fri, 27 Mar 2026 10:06:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] devfreq: Fix NULL pointer dereference when a
 governor module is unloaded
To: Jie Zhan <zhanjie9@hisilicon.com>, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxarm@huawei.com, jonathan.cameron@huawei.com, zhenglifeng1@huawei.com,
 zhangpengjie2@huawei.com, lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
 <1774576755240654.100.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <1774576755240654.100.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/26 21:14, Jie Zhan 写道:
>
> On 3/26/2026 8:34 PM, Jie Zhan wrote:
>> When compiled as a kernel module, the governor module can be dynamically
>> inserted or removed.  'devfreq->governor' would become NULL if the governor
>> module is removed when it's in use, and NULL pointer dereference would be
>> triggered.  A similar issue was also reported in [1].
>>
>> To address this issue:
>>
>> Patch 1-5 rework mutex, factor out a common governor setting function, and
>> clean up some unreachable code.
>>
>> Patch 6-8 prevent a governor module in use from being removed (except for
>> force unload) by getting/putting a refcount of the governor's module when
>> switching governors.
>>
>> Patch 9-10 allow 'governor' and 'available_governors' to work normally even
>> when a governor module in use is force unloaded.
>>
>> Note that this series is based on [1] or devfreq-next, otherwise code

Sorry, please ignore the "remember to CC me on the patches." in my 
previous email.

  In my opinion, it would be better to prioritize the FIX first before 
proceeding with the lock mechanism optimizations and other work. This 
would make it easier to backport the patches to lower-version kernels. I 
noticed the patch is already in the devfreq-testing branch. I hope the 
FIX work can be moved forward smoothly to resolve the null pointer and 
other bugs. Thank you!



> sorry, based on [2] or devfreq-next
>> would conflict.
>>
>> [1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
>> [2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/
