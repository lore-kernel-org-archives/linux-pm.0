Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E7447801
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833600; cv=none; b=rh+juDnxPbm3BK8a6Emrojt5fP+skW9mxuYvSNs5NwdB4MPvFLw9K5OIkyvSNyz+qaB2JPS4FGuPj8bdTaTheNltAXZIdur9yM+3bXuTvAMTib3RG7n2TKeVMpbcOOd+VOFxv9WEPK1VBXOroD0sAGyYq/LO8jB5h7oQKyfbrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833600; c=relaxed/simple;
	bh=cu3NreXdo19Q8IjbfcCZbcoziCthmL2ZI+FvR70tz3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neZTB5t6GgciMLwd7NzOiq66pJKIWE+8thXUsFpOw4yoX2ngYjDQSahe8QqbNKlH252qxKC8MPeyPF8DrBKwDPo5Y93P8zAMCkEmRvSZBV3a1xWA8wC9ZK7c2nDPXcOQqht6r9T2EgngSLBQUYlL4GPP4KPK20IhTwO0Z/lIs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 87aa79dea21211f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e52499a2-835b-42bc-8678-3bfb4bdd3197,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:60a5a62d8be7d164cce9f38947115899,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:-10|3|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 87aa79dea21211f19a56ed5b684f684d-20260827
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2033492893; Thu, 27 Aug 2026 20:26:29 +0800
Message-ID: <5fd7d1ad-ef2b-49b9-a397-ca130754fe4e@kylinos.cn>
Date: Thu, 27 Aug 2026 20:26:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Add unlikely annotations to
 saveable_page()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
References: <20260603032255.2126508-1-lijun01@kylinos.cn>
 <CAJZ5v0hUYObm8QAB1DJ6wFb0wum+sFmR7VG-5YBnJ1eAMYyJsA@mail.gmail.com>
 <290c98d1-0336-4def-a67a-49844805a862@kylinos.cn>
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <290c98d1-0336-4def-a67a-49844805a862@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


resend:
> I measured the time using ftrace and ues 16G mem,
>
> add the 'trace_suspend_resume'  follow the next code:
>
> /**
>  * count_data_pages - Compute the total number of saveable non-highmem 
> pages.
>  */
> static unsigned int count_data_pages(void)
> {
>     struct zone *zone;
>     unsigned long pfn, max_zone_pfn;
>     unsigned int n = 0;
>
>     for_each_populated_zone(zone) {
>         if (is_highmem(zone))
>             continue;
>
>         mark_free_pages(zone);
>         max_zone_pfn = zone_end_pfn(zone);
>         trace_suspend_resume(TPS("gtt"), 1, true);// 0 no unlikely  ,1 
> add unlikely
>         for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
>             if (saveable_page(zone, pfn))
>                 n++;
>         trace_suspend_resume(TPS("gtt"), 1, false);
>     }
>     return n;
> }
>
> no unlikely:
> 1.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             bash-4447  [001] ....   329.153746: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             bash-4447  [001] ....   329.165423: suspend_resume: gtt[0] 
> begin
>             bash-4447  [001] ....   329.171690: suspend_resume: gtt[0] 
> end
>             bash-4447  [001] .n..   329.243525: suspend_resume: gtt[0] 
> begin
>             bash-4447  [001] .n..   329.282176: suspend_resume: gtt[0] 
> end
> 2.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [002] ....   134.297172: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [002] ....   134.308849: suspend_resume: gtt[0] begin
>             [002] ....   134.315070: suspend_resume: gtt[0] end
>             [002] .n..   134.387108: suspend_resume: gtt[0] begin
>             [002] .n..   134.425987: suspend_resume: gtt[0] end
> 3.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [000] ....   290.611694: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [000] ....   290.623367: suspend_resume: gtt[0] begin
>             [000] .n..   290.629714: suspend_resume: gtt[0] end
>             [000] .n..   290.701410: suspend_resume: gtt[0] begin
>             [000] .n..   290.740172: suspend_resume: gtt[0] end
> 4.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [003] ....   725.819915: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [003] ....   725.831599: suspend_resume: gtt[0] begin
>             [003] ....   725.837876: suspend_resume: gtt[0] end
>             [003] ....   725.909548: suspend_resume: gtt[0] begin
>             [003] ....   725.948195: suspend_resume: gtt[0] end
> 5.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [001] ....   916.628746: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [001] ....   916.640480: suspend_resume: gtt[0] begin
>             [001] ....   916.646784: suspend_resume: gtt[0] end
>             [001] .n..   916.718700: suspend_resume: gtt[0] begin
>             [001] .n..   916.757641: suspend_resume: gtt[0] end
> 6.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [000] ....  1021.912180: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [000] ....  1021.923863: suspend_resume: gtt[0] begin
>             [000] ....  1021.930089: suspend_resume: gtt[0] end
>             [000] .n..  1022.001849: suspend_resume: gtt[0] begin
>             [000] .n..  1022.040800: suspend_resume: gtt[0] end
>
> add unlikely
> 1.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [000] ....   112.477071: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [000] ....   112.488796: suspend_resume: gtt[1] begin
>             [000] ....   112.494885: suspend_resume: gtt[1] end
>             [000] .n..   112.567024: suspend_resume: gtt[1] begin
>             [000] .n..   112.604116: suspend_resume: gtt[1] end
> 2.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [000] ....  1154.893337: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [000] ....  1154.905017: suspend_resume: gtt[1] begin
>             [000] ....  1154.911116: suspend_resume: gtt[1] end
>             [000] .n..  1154.982854: suspend_resume: gtt[1] begin
>             [000] .n..  1155.019977: suspend_resume: gtt[1] end
> 3.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [003] ....  1439.914148: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [003] ....  1439.925880: suspend_resume: gtt[1] begin
>             [003] ....  1439.932008: suspend_resume: gtt[1] end
>             [003] .n..  1440.003734: suspend_resume: gtt[1] begin
>             [003] .n..  1440.040764: suspend_resume: gtt[1] end
> 4.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [001] ....  1781.264580: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [001] ....  1781.276264: suspend_resume: gtt[1] begin
>             [001] ....  1781.282374: suspend_resume: gtt[1] end
>             [001] .n..  1781.354068: suspend_resume: gtt[1] begin
>             [001] .n..  1781.391102: suspend_resume: gtt[1] end
> 5.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [001] ....  2048.269344: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [001] ....  2048.281028: suspend_resume: gtt[1] begin
>             [001] ....  2048.287112: suspend_resume: gtt[1] end
>             bash-4575  [001] .n..  2048.359144: suspend_resume: gtt[1] 
> begin
>             bash-4575  [001] .n..  2048.396316: suspend_resume: gtt[1] 
> end
> 6.
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             [000] ....  2184.274783: suspend_resume: gtt 
> hibernate_preallocate_memory[0] begin
>             [000] .n..  2184.286520: suspend_resume: gtt[1] begin
>             [000] .n..  2184.292586: suspend_resume: gtt[1] end
>             [000] .n..  2184.364327: suspend_resume: gtt[1] begin
>             [000] .n..  2184.401569: suspend_resume: gtt[1] end
>
>
> The following results were obtained by analyzing these data：
> ues unlikely in saveable_pages, the duration of the 'for':
> 1,    0.043181
> 2,    0.043222
> 3,    0.043158
> 4,    0.043144
> 5,    0.043256
> 6,    0.043308
>  not add unlikely in saveable_pages, the duration of the 'for':
> 1,    0.044918
> 2,    0.0451
> 3,    0.045109
> 4,    0.044924
> 5,    0.045245
> 6,    0.045177
> so  a difference between the max  0.045245  and the min  0.043144 is 
> 0.002101sec.
>
>  2026/6/8 21:29, Rafael J. Wysocki :
>> On Wed, Jun 3, 2026 at 5:23 AM Li Jun <lijun01@kylinos.cn> wrote:
>>> Add unlikely() branch prediction hints to conditions in saveable_page()
>>> that are expected to be false in the common case:
>>>
>>> - !page || page_zone(page) != zone: PFN valid implies page exists
>>> - PageOffline(page): offline pages are rare
>>> - PageReserved(page) && (...): reserved pages are relatively uncommon
>>> - page_is_guard(page): guard pages are debug-only and rare
>>>
>>> This helps the compiler optimize code layout for the hot path (valid
>>> saveable pages), improving performance during hibernation image 
>>> creation
>>> when scanning large amounts of memory.
>>>
>>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
>> Are you actually able to measure the difference?
>>
>> If so, how much of a difference is there?
>>
>>> ---
>>>   kernel/power/snapshot.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>>> index d933b5b2c05d..182f27eb573a 100644
>>> --- a/kernel/power/snapshot.c
>>> +++ b/kernel/power/snapshot.c
>>> @@ -1380,7 +1380,7 @@ static struct page *saveable_page(struct zone 
>>> *zone, unsigned long pfn)
>>>                  return NULL;
>>>
>>>          page = pfn_to_online_page(pfn);
>>> -       if (!page || page_zone(page) != zone)
>>> +       if (unlikely(!page || page_zone(page) != zone))
>>>                  return NULL;
>>>
>>>          BUG_ON(PageHighMem(page));
>>> @@ -1388,14 +1388,14 @@ static struct page *saveable_page(struct 
>>> zone *zone, unsigned long pfn)
>>>          if (swsusp_page_is_forbidden(page) || 
>>> swsusp_page_is_free(page))
>>>                  return NULL;
>>>
>>> -       if (PageOffline(page))
>>> +       if (unlikely(PageOffline(page)))
>>>                  return NULL;
>>>
>>> -       if (PageReserved(page)
>>> -           && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>>> +       if (unlikely(PageReserved(page)
>>> +           && (!kernel_page_present(page) || pfn_is_nosave(pfn))))
>>>                  return NULL;
>>>
>>> -       if (page_is_guard(page))
>>> +       if (unlikely(page_is_guard(page)))
>>>                  return NULL;
>>>
>>>          return page;
>>> -- 
>>> 2.25.1
>>>
>>>
