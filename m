Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AEB3176E0
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850905; cv=none; b=XUN4bQlLKHdnHaHSwKhF1YvOmFKDglqWl6KUubOM9OnwOKIY4oQSq4g/vxrsC1kYb2qbqRLVp8j01UJJAZ/ZKyxs0VI9QOHExp/go+FJVGjz/UaJGyN+t8h9rbc3uaJp+m7rWDIZ6HWjoNBq2gzBQx070Kb39Ztnj2t9M9yE4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850905; c=relaxed/simple;
	bh=4hKywbhG/HF5tZZTwNULR5mmWJ+cLkp8GKPbpw3/9hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uWS0hN3mQ3APuvkDbPAsQlprxzK/ZGVB5Z1fqz/vDgRsY5Ms1q48HiIvO33bOJ95rtJZo3ZqY1dEpzNtcFE70L21rvpf7kHH4CfnUZsEV0YVuYQzDqcVWGWNWJuKXN6aNfnjhrjf/MSD27UTkimS2G4iXqhfSsLzPm04xoNIFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOxISn4A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOxISn4A"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fdacf2616so10415355e9.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778850902; x=1779455702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=53U0/0WbYXGpXcNIwxeYgyri/QpasHpNUn8IYc1HDQk=;
        b=cOxISn4AXEieSZHMW0z52zvkYfGPiUW3qRq/lv2pRDJ8UtvsqAeB2ymE/cwS+dxo4i
         KKj/tuFSmrf5FEnfNRKXnS1oK9ybHexmpgekd3M9F8YNjxn91ByfVb0h+o+E8TnOa/Kd
         UQRDUSF3B3s12ahUr1SUPqYb2/s5cTdzlWXukiIgDwCeMuZj1ARmpl0hGycZ6ndbImDc
         aautnqYFWRnC0kR6OzGlu8SXmjgtmjaANiaOMNZ3ZLQ8/qD6HKHLrqE+bH50hYOsk/VI
         ERVwW9/DD513fIR2J4NJTCKag6xuOooqZy/4jGlrI0XeliFoMK+9ZNXUUWcvuNwGrlu5
         EJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850902; x=1779455702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53U0/0WbYXGpXcNIwxeYgyri/QpasHpNUn8IYc1HDQk=;
        b=cISFrNXyr0kK+5e/6P2RJLkYPYX9zE1cccBNdl1D0FwdDQRASKUbGKdZsQBXk9trJI
         PCSyDxlUu5NIVnpUvoeO9bsaKwsP9n50pUG4X1OYmlz9J6haRc/JhwogJq3udc6dkPD/
         al/S//wzBY2NY+oq9aBpTMFZ10FlLzqfhidrZ5avYcYo0JEjpT4tyXVOaxISwH/+iD5F
         glJbyG4xnC0EzqevJwERgnksOGWjfuj+Lg0Giot/A2cYzB04UWGB26PPwP4zqvt85sei
         19nLyb7K9nVsn4somOhy46SVxretoG68wVsG3xHQexnQq2LZLIpO83P9SyRCY3lT3uF5
         cAag==
X-Forwarded-Encrypted: i=1; AFNElJ/6P90/x2yKw1d2FYy1vwAIGGu4rSddyDQUtJIr5lyVBgG9g7nhgIspxyH+Nj6NLuPp649EIv06Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhkv2hev8oqoMjTBoOpddE9qLmVmxmNIWJKp9gMsRgvjuZuDmB
	vYAhTKWfPnZCdTEAhBmvLxjsnzK3RjAWUZOf9QWxRTdcoCn4wOjphkUM1UP8JI6MRoyoRuGDSGs
	GPeEYyN4lNjunNg==
X-Received: from wmsl28.prod.google.com ([2002:a05:600c:1d1c:b0:48a:5459:ee82])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fe651b57fmr51391315e9.27.1778850902255;
 Fri, 15 May 2026 06:15:02 -0700 (PDT)
Date: Fri, 15 May 2026 13:15:01 +0000
In-Reply-To: <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260513-page_alloc-unmapped-prep-v1-4-dacdf5402be8@google.com> <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
X-Mailer: aerc 0.21.0
Message-ID: <DIJA0MM2F3D2.61WBO3MJZRNQ@google.com>
Subject: Re: [PATCH 4/4] mm/page_alloc: remove ifdefs from pindex helpers
From: Brendan Jackman <jackmanb@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed May 13, 2026 at 5:19 PM UTC, Vlastimil Babka (SUSE) wrote:
> On 5/13/26 14:35, Brendan Jackman wrote:
>> The ifdefs are not technically needed here, everything used here is
>> always defined.
>> 
>> Switching to IS_ENABLED() makes the code a bit less tiresome to read.
>> 
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  mm/page_alloc.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5d6144c8860ed10fd641184f389c4953465d5178..2985ad0ab1044bdfda8ccc7aaed2ded19b5ac7ed 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -650,19 +650,17 @@ static void bad_page(struct page *page, const char *reason)
>>  
>>  static inline unsigned int order_to_pindex(int migratetype, int order)
>>  {
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>> +		bool movable = migratetype == MIGRATE_MOVABLE;
>>  
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	bool movable;
>> -	if (order > PAGE_ALLOC_COSTLY_ORDER) {
>> -		VM_BUG_ON(!is_pmd_order(order));
>> +		if (order > PAGE_ALLOC_COSTLY_ORDER) {
>> +			VM_BUG_ON(!is_pmd_order(order));
>>  
>> -		movable = migratetype == MIGRATE_MOVABLE;
>> -
>> -		return NR_LOWORDER_PCP_LISTS + movable;
>> +			return NR_LOWORDER_PCP_LISTS + movable;
>> +		}
>> +	} else {
>> +		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>>  	}
>> -#else
>> -	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> -#endif
>
> Uh yeah, VM_BUG_ONs are frowned upon now. But doing a VM_WARN_ON_ONCE here
> makes little sense. There's no safe fallback if we end up here with a wrong
> value. 

Isn't that grounds for upgrading them to a real BUG then? My experience
has been (I broke this code lots of times lol, I REALLY struggle with
this arithmetic stuff) if something goes wrong here the machine quickly
gets irrevocably and undebuggably borked. Crashing is the best case
scenario.

> And it's all internal to page alloc so I'd just drop those checks
> completely at this point.

But, I won't die on the above hill, if people really hate BUG that much
happy to go with the flow. 

In that case, I'd suggest we drop them as a separate patch.
