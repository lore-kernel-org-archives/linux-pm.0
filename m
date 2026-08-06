Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF22349CD2
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977790; cv=none; b=sp2fvo+KjqfxyqFs+NWH6a3rlr3qV+vGcu7iC3fZ60E8RWVo6mfz3VhVIdognH1ftYuqa0+y7ZNlJLW3M+HjrrAWwiOow9gcnS2V/QBQLzKBGhf7Le7SOFYbZSwxZoybnV08LswoibpQu0QF9F77yK65YLhsJbiSnBF4v/wLobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977790; c=relaxed/simple;
	bh=q5qto7q6St/Ue9IF5HLUyJ7+iNpjBzl/BR/tr4rTl/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NROjaLZ1JVu6ktGtkv3OouMW0PctRtBQbfT7ZWLIAFG94jGiOPZFP08i9GY6c8obb8tSHggeq98kJBtwYrDEokpvQ67dHQS4MUCdOQv053IRLqBppKnMUM4ypoiuFepfRawCCq8zrI0wSWrkTjRVq0r68lHq2lyJuzWSvX9rOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a376c254913111f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d241f2f0-376a-4b78-989e-9ecd2b31d93c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:422c005b18c63f922ad3c371f6b07ad1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|817|865|898,TC:nil,C
	ontent:-10|-8|-5|14|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a376c254913111f1aa26b74ffac11d73-20260806
X-User: xiongxin@kylinos.cn
Received: from [10.42.13.16] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1318032427; Thu, 06 Aug 2026 08:56:20 +0800
Message-ID: <65192d9f-a60c-42cf-9ff5-59f52377c9d4@kylinos.cn>
Date: Thu, 6 Aug 2026 08:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: flush icache for restored pages from task
 context
To: Will Deacon <will@kernel.org>
Cc: rafael@kernel.org, pavel@kernel.org, james.morse@arm.com,
 linux-pm@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <20260803055412.63981-1-xiongxin@kylinos.cn>
 <anH1mvwdiQxjwfw1@willie-the-truck>
Content-Language: en-US
From: Xiong Xin <xiongxin@kylinos.cn>
In-Reply-To: <anH1mvwdiQxjwfw1@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> On Mon, Aug 03, 2026 at 01:54:12PM +0800, Xiong Xin wrote:
>> When resuming from hibernation with `hibernate=nocompress`, the kernel
>> loads the image via load_image(), which submits read bios asynchronously
>> and waits on them with hib_wait_io(). The bio completion callback
>> hib_end_io() runs from the block IRQ/softirq path.
>>
>> Commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
>> restored in-place") added a flush_icache_range() call inside hib_end_io()
>> (under clean_pages_on_read). On architectures such as ARM64,
>> flush_icache_range() ends with kick_all_cpus_sync() -> smp_call_function()
>> (wait=1), which contains:
>>
>>      WARN_ON_ONCE(!in_task());
>>
>> Because hib_end_io() executes in hardirq/softirq context, in_task() is
>> always false there, and the WARN fires which happens while the resume
>> task is asleep in hib_wait_io() and the CPU is idle, the warning log as
>> follows:
> 
> Hmm, do we have any secondary CPUs online at this point? I wonder if
> either smp_call_function() could push the WARN() down into the branch
> where it knows it is going to call remotely or whether we could elide
> the call to kick_all_cpus_sync() altogether in that case?

Thanks for the review.

Q1: Do we have any secondary CPUs online at this point?

Yes, the secondary CPUs are online, but they are all (almost) in the idle
loop state. The current problem is that the CPU enters idle state due 
toio wait and there are no other processes that can be scheduled (All 
userprocesses and most kernel threads have been frozen). Then it is 
awakenedby an interrupt (irq) to handle the asynchronous IO callback 
function
hib_end_io(). As a result, the kick_all_cpus_sync() call is triggered
in the interrupt context, leading to the generation of a WARNING message.
Is this unrelated to whether other CPUs are online?

Q: Could we elide kick_all_cpus_sync() when all other CPUs are idle?

That's a good suggestion.

But as far as I know, the idle check cannot be made race-free. idle_cpu()
or available_idle_cpu() is a best-effort snapshot. There is a TOCTOU window
between the check and the elision during which another CPU can be woken by
any interrupt and start executing the flushed range with stale I-cache 
entries.

So, in the flush_icache_range() function, is it safe to check whether all
other CPUs are in the idle state?

