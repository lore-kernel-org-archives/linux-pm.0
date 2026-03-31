Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EE3D47BB;
	Tue, 31 Mar 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950868; cv=none; b=PuNlpotr3EqjxxTF7WTAWDr0h2ZdaWRTxM8U1cRbLeJpxrmgtk3IGDrgMyJiUR4Tvxc3e4Kc2GFOJkFQfDS+3+u5UzRYkbX784L0XnQyn5WcvaXrPa7KNIvLDTE3NdCb76Mb/1wCTdGam4jt4j+fKsyOT+Ov32hkswb0886Ebz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950868; c=relaxed/simple;
	bh=oOP5e7idlWUgqNg/0uUJOKftmZYhurfzLzh7P92nNJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEBwvEM4Inh/Jk98S3E81csWU/MG7lNFd9n8Vh5jxOvXr7jfMXchuNGOXrpSY/kml3oVGLe0K7hpf9M1I2leTkdgcn4kJOC+6YSX6cfRnTkE0mgq/p4imsVui4EXS23VyH93xQSQyu3TQYDFVaZJ/AXSDWH7CS3ikOEk2rbjqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9886b98e2ce711f1aa26b74ffac11d73-20260331
X-CID-CACHE: Type:Local,Time:202603311730+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a7bc8efb-23ed-46e8-a3e7-9fedda5eb466,IP:0,U
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
X-UUID: 9886b98e2ce711f1aa26b74ffac11d73-20260331
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 262967614; Tue, 31 Mar 2026 17:54:23 +0800
Message-ID: <10e912b5-b7a9-4f4d-92fb-9de450e82c23@kylinos.cn>
Date: Tue, 31 Mar 2026 17:54:20 +0800
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
 <f954648e-33d0-4b07-977d-96af182fc2ef@kylinos.cn>
 <4d1d2077-a336-4914-b7b1-204cab5a60e0@hisilicon.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <4d1d2077-a336-4914-b7b1-204cab5a60e0@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/3/31 17:37, Jie Zhan 写道:
---skip------
> Ok, the code here starts the governor and directly goes to 'out' that
> unlocks mutex, so create_sysfs_files() is skipped.
> For example, setting 'userspace' as the governor won't create its belonging
> files.
>
> Therefore, I'd suggest that doing a NULL pointer check before the IMMUTABLE
> flag check and stopping governor, where df->governor is used, so the
> existing logic is not changed.

Yes, I missed that. However, we still need to check df->governor later 
and perform corresponding operations.
How about adding ret = sysfs_update_group(&df->dev.kobj, 
&gov_attr_group) based on the original code (against the latest linux-next)?

