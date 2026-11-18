Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015527;
	b=Gu4QqzWGMeRgC3yO5T2ZU0eVteWbx/cJtmjXAxEx7ML9YVYdSDnCFrLVM8T99Lw6u+zp
	 W8EhExk+5dEWsiz6bExsy8pJSmYp36K0znFdFY4Qb2nBrUJfT5+yruwEx1i3S3mfslUal
	 +MkVJat8kukYNXt4wHPz07Puw9CZYpavDkrayW2XKB11x0pSKOWK1xHU2yEB8cGD6EiBy
	 nsQgrp+LeExUeCWMhcHh+AK+6nzUjRl8ew5FyncBLMj0tUN9Ds026UiHHDMXkvEsoR2cf
	 Jdw511bPinT2nfeBC9AdtzDzL2h0DfNBcREA6/5WSZrG0n3Ng6vPrjvSXZ00DcboLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
	b=Syg50qNbcpOSc8nnVV8Mh5yCd240Z/K59XXDRKughWYM5haQlbRfiO/2sKwhUOhZC72u
	 s4J0kRHZq6CvT+raHmIrfXJW2dUq9rY/B1J2jiaTthrEXTAt/GHawBnhBy/OFlvJQFgZ4
	 wK4SEo0OtnRPQbE01RUqnoEZFuyrUrZ2ICtuk0lQTbb5aNLGyIqOiD5FYANfW5DZNvaOr
	 RdDuR7uzWZM4ATLmDyxdmRVTpnrhrlp1xqvYcpuFdkWF9AlqyMlvj3etka3Vk61Be+KQO
	 cV3gICEWsyFw/El42WTkHmLBDIOiLOenmI4GLxzBzfcpmz7jowdhWchjUYV/FkKVObw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jkZEPAu8;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7F60A380F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B7F60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jkZEPAu8
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91f23ddf32fso7789386d6.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015525; x=1795620325; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=jkZEPAu8G20dCMvp4wOqgPO0yASbJPGo6TZFMEVOnKUdDpBmEyKfI01QGahGYUWTgZ
         6rvG+N243czLM9HKkvkmHsiJb9ZvM4M/fZyW2BhlVIye2uekD8TTxu+s1qLJIpSDQ7cP
         9hi45s8gqaY67ARzEu79KD7plOLEcTzwXFpRdPyxa7RESrACnv7wXvjGt2mToZGmnehS
         JSqOZ7ighA+zighnUNhC6662LdHcCZjcdWBkLgyzEbo3qSBV9DplCJ5sVYDimiwNOJ/l
         z6IGWGVC1ADaY55tKPi7ed3N21OLLXvs8O7Ai3vdZL5AbhWkgCdNRI2ur8QP/ofCfRdn
         y9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015525; x=1795620325;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhtDXpbRWCIEhu50xIx6ItwVhQLsPfY15TO/C9JpkIY=;
        b=tFpZm2pIBCSCJwRLMHKD3EL2bIeQhvrYjgVHyRHP5fssibUMTg7+HvWamu+0eJ+sug
         MepH4v281AYybd04RaRjMFFaLCqncZeelqS33NehN6hQFV47UeuJ9BKLwydRby0ObAAS
         ycLySaB+w3al0vjGc5uNKAl7ly+WzGNYnEBIxw2uJU7Tc9H84ZxIzYyVBuHRWNBqLaTu
         cNDetq4Gwq96H2p6WkQXfb5aR7S+ZQc+3N87LmcDGPhsDfK8y+gpMAYrd969+x1mP+E1
         yW/bf1gYiPGUVSzth6sUke8ufE3WUD8NtpRnwD3/REH2rIuZYfCU3l+sOUk2zhNPG0cp
         xEDg==
X-Forwarded-Encrypted: i=1; AL+hErHdX6rSLj6E09uXbTZOyJz0Jw1/jOpXAFz1/SRK7j0B6VTcpVOpeBQGY6rB24S/IQNXyoMt2H0OnA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9NlI6Y50Ejf0/jB9vVKAWbRDP5D/3Um/G+ELz3IRCpgBU9dUXN
	3MpO8edAeE/Eq3U0D+9fbKwb0ei8Q3KIxEfTMfQTRMVxK4yC9VwbjoN6i6vHFtd9XFY=
X-Gm-Gg: AZFdTZckMWJkU7D1uxFprmLOMVRvIDR38RMLMY5+G2wasbC9zfDi1NQzBXciZE+VLhN
	mfsHde3iOkbCDxAjdovcXEz1SeYGVzv6c+jeP9M8cAGrwX78Lh0RLZ346bDVEsH6omiH8LD2fdn
	LJKFNY3aDfhkqiQd75RxWGTDywmyGng/kKzzZiVuHjKcKhDqG9c2U1Po9FfOjfXtjQ4UGKe3N3g
	jeSvtTJYTzP/Z3b8soA0tFNfUY8CCXAqVl1LoGqgmcjZVZu59ermqTZWUcq8dvcSHYGcmFGrS4/
	RkRkMvviAZfBB9CERB8U0/WNDOBb3cmhxEcUIdejUu4rnusYLbFXL9l5wjYgfTkPmYIm7fOLf3K
	jbiVR1wQszVPHSyIXmqx3fwSl5sZGaavPINAZ6GUUN5Hs9VHPHfPUenzALY17HhNn919EvwhjaV
	DanH0W7vtqUcjcAW4cyIOgcqC3kaRlPQuohGbMkd3xcRS2N7vvKFIca1ZIIsE2BQPNU/E8yZ8YX
	sGf/m3lgC89AuZgb0iTm7fbkON5MONNsCW0a5fkcy1bS0n3vKxr+DuPV+RzxgKo9Ah0cObY2LXQ
	2QmdCpKUX8Z9BiUlz84aGIZ67UTxF2gYZnitaS+iFTzY1EUUOoJj/QgdRAn+B8ToEIbDChvOreQ
	f/+sjg7Y=
X-Received: by 2002:a05:6214:240d:b0:91f:12a4:27f2 with SMTP id 6a1803df08f44-92114c4e8f8mr45557396d6.6.1795015525386;
        Wed, 18 Nov 2026 07:25:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921149f9c36sm24415306d6.5.2026.11.18.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:25:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/22] mm/hugetlb: restrict pool growth to common
 memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1PyBvUVJcy_Psd@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-14-gourry@gourry.net>
 <av1PyBvUVJcy_Psd@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:25:22 -0500
Message-Id: <179501552287.1206716.17381960047395782233.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:32 +0800, Richard Cheng wrote:
> > @@ -3802,23 +3801,21 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >  	unsigned long allocated;
> >  	struct folio *folio;
> >  	LIST_HEAD(page_list);
> > -	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
> > +	NODEMASK_ALLOC(struct nodemask_scratch, scratch, GFP_KERNEL);
> >  
> > -	/*
> > -	 * Bit mask controlling how hard we retry per-node allocations.
> > -	 * If we can not allocate the bit mask, do not attempt to allocate
> > -	 * the requested huge pages.
> > -	 */
> > -	if (node_alloc_noretry)
> > -		nodes_clear(*node_alloc_noretry);
> > -	else
> > +	/* Scratch masks for allocation eligibility and per-node retries. */
> > +	if (!scratch)
> >  		return -ENOMEM;
> > +	nodes_clear(scratch->mask2);
> >  
> >  	/*
> >  	 * resize_lock mutex prevents concurrent adjustments to number of
> >  	 * pages in hstate via the proc/sysfs interfaces.
> >  	 */
> >  	mutex_lock(&h->resize_lock);
> > +
> > +	/* Fresh pool pages come from the ordinary allocation domain. */
> > +	nodes_and(scratch->mask1, *nodes_allowed, node_states[N_MEMORY_COMMON]);
> 
> For a global request the caller passes &node_states[N_MEMORY], so before this patch
> the grow loop read the live mask on every alloc_pool_huge_folio().
> Now the mask is sampled once, before the loop.
> 
> The loop drops hugetlb_lock and can run for a long time. If a node gets its first
> memoroy in that window, the old code would start using it. The new code won't, until
> the next write to nr_hugepages.
> 
> So the pool can end up uneven, or smaller than requested if the other nodes are full.
> 
> I think the nodes_and() should be placed inside the loop to keep the old behavior ?

I can make the adjustment, but the concern is that previously we'd
start spreading the distribution of hugepages differently when there's a
race between hugetlb allocation and memory hotplug?

That seems like a pretty innocuous corner case to be worried about.

I can see about retaining the old behavior, but i'm not sure what you're
describing is reliable behavior already.

-- 
~Gregory

