Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014796;
	b=2FWuhTP6bARjnwdMGeUfNHWM/WsLO565Rfz31ZVJU4yRBPnVWx+deClVuM1vqgNQJLm8
	 aBcJY6dSrqflJ77q+APMDxqqV3xSgxRmLiupvaHO5UtFehWZIxTOn3bFETxAPzX0hr4do
	 RwCSbltDxApe0efiFhtC/Ol9Lg/eDWekDSjy1Raex2agn+brlGFgFhooPtpInS1co971s
	 ZUsZC8HKgYV6Zq7fBA7h0Ri3PtoJ6uBcb1isluau2F9kLavuta4pRDPuIfVczyiU4bygJ
	 d5oKYxWdofPeig0ZE/k+2WyRlUXqza+Av99iS2abvJGx7Bv+UKodf87EKXlC2fsTImw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
	b=4qFolQp5SGYp+Zt9JcASb17fffwvfTaZSPkaHkdtAZYRy/JkmkpODYcSVUeR8f/wabEq
	 FP/avMR7o2u5d4AGrwxw3s6l3+aFKSICqCECWv1dzwMEEHsjcuYMaB+iaK8NfWYmwk99R
	 OYUnob6xsvDGTBSG6FL5htc3K016OIB7ZyJ0wRNXgNDJzB9//2tZg7VyMgtFcT6uXNLRK
	 f7wlcRNBQEo8Cdj7wHg8IH2xJvnziFAG/6pHF+AizcYDC1AtDzxthb7Lg6E4h/eO6nc3E
	 d1C5sFjTXPuo+F6+cu2wAh/zQLGQfnRBKKFWd55knaolz0k/ibHntXlM8TBd3Ry/GqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D3606A32C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 098D3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EaNntw86
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-949664ee41cso136566985a.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795014795; x=1795619595; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=EaNntw86OliWenC+AEw8YZaqX/CpkEbuj/R83uxmt0euRu7q4F2m0octKXwFVihjk8
         dg9+4SMbEuteeVIYXzzmNfX/GhJAD2I5TAVlrjYtVKgH9HZf3H9sOEWDi6erVJGPVQR2
         MOUDAtFaOSguVvmB6Aeyd+dyvpdoItqLgrfZkjmHPTZWLIi47UtkzxoGuplmxuiUXO0v
         tyGF3tjz3s4yV7eQvQapqnqBjZtdFZe/FW+VRXsn3qhQN1hGCbekIeZCld143MCK2+pP
         fZ/U2FUvwPZemSkqE/IxMsmjkki3bWHrx43vsMaI4rDk0WQbZdG7s4De/itz35E+w/xw
         0AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014795; x=1795619595;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMVcoG7RRC5e+6Od8G0B0oNhz3JqDhu+jU7/dRmM0d0=;
        b=ppMZsnrLbOVPo5trTkudWu7wJJaO6DNBiE6d2pdWewmB411Axi04UHHhAudmWzZxdI
         MKae6HKBvJ4U73S8qOaHU6RRHCRjZ/LDt5SmPQCkdGttHuOphqFRQ7uXYHIARDNcstbj
         Hw/0pyNVbLaerMyWd7v1nuTa4HAsg+z7Uuh5k/+ZRVj31upL6kOsulXzMxqvxqmGkX+a
         qhcVfnVih4RVO/UVggnozvfhcvszWCBVObRURs3zWSjCaTV4dx7eGtoXJuWuDBonYlMp
         6R8uVzyT7IiRPJ2YGORheYWUwjGh8ZqBz7fmlLHQyrL4tr8u03zjNY9IYr9FJl18mQK9
         kxWg==
X-Forwarded-Encrypted: i=1; AL+hErGeRE1w2VO49+HrI3n4Lx0QzMtvlmLyPYmtUrZPOp5Nmmx8y2TKcOEajWVVmk60okgYEe9FSQHOVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/veVAgFS4oRAIkhrhUQu5/2e3cSqveYYMbFAIt3Igd0ALxo/9w
	CsULOpYcgg4FEx6QAIxRCouyYGs73SPrijevHZ0pB6eXvYOX3qqVoSyCaghw+owZEc4=
X-Gm-Gg: AYBFou0n6zD9qHBHg+JHWJXalXsFqETHH45k89ii3DcTP+1gE/ZS0rdbe5tdc26o0z6
	NWtz2/D6jA7UjA08fSeECEzmAoAj/Rscq4ozG/BkX4DUjFLztTldoGdPEDSEaPMhRGws7CmGWjU
	CxBvzezd/GkZaHUn36o8xNuSiNW93GkL6F+8ChR476yaGNfqtQi6tCqBrQxakW5jdfaIVz4sVAX
	A5FMlnzZLRedlH4fxBYfmaW42WkmZwxfp+8Sax7tWHfBm2lrK7UTfy1WrSHvXbEEuiETttqVzbG
	VT15eiMyIC5ELc3NoHSbooRVqamZXu0oXKAAm4rWQuyj3N0u5v0Qn6p5PHpeojgDj2laUrzixGG
	dxjiZqsbypD+3CG0CaRSetgz66FJRJYwyY4aB16N92brps0fOYxKiX1sOYxn9Np9MHmqWpUNjml
	3sbZoxc1etNsG1iRc8aK2VETL4pegRr9DkfRR0BfdFtkp3Mo/2/wvguqHglTKRpdws2A7C774vl
	XoppNTqLRrLTin/H1MUt3Rbn8zD1zml1XdijYh6yZqqgWwpe5FbAfvpmldJM/u5x4n1iofHWoMY
	kYi9oVzn2HrE8qLE3hRV360r8djVyEC/KcOQNX9lWZJdDZOIQx5C4rE86dS0CiwnPoUT4ClB/sk
	w7QVBR4s=
X-Received: by 2002:a05:620a:444b:b0:949:6d95:f63a with SMTP id af79cd13be357-94999810096mr508584985a.78.1795014794676;
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70a8fsm23976506d6.30.2026.11.18.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:13:14 -0800 (PST)
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
Subject: Re: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
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
In-Reply-To: <av1DvCQd_OvkGgLU@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <av1DvCQd_OvkGgLU@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:13:12 -0500
Message-Id: <179501479267.1206716.268867271510310543.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:01 +0800, Richard Cheng wrote:
> Hi Gregory,
> 
> I've browsed through the serie, I'll go into detail in each patch
> in the following days, for now I have one general question.
>

Thank you for the read and the feedback!

> I wonder how the "common memory only" rule is enforced ?
> 
> As far as I read it, there're 2 ways:
> 1. The zonelist, you build them from N_MEMORY_COMMON, so non-common
>    node isn't in any zonelist.
> 2. A check at the call site, e.g. node_state(nid, N_MEMORY_COMMON) or
>    folio_is_common_memory()
> 

Those are essentially the two cases, which are already present in the
code in one shape or another in the existing shape:

   node_state(nid, N_MEMORY);
        or
   folio_is_zone_device(folio)

With the exception of one or two places, the series largely modifies
these locations to use N_MEMORY_COMMON instead (or in addition, in the
case of zone device).  There are a few places we add common checks where
zone device checks were not already present (because they were missing
or did not apply, usually PMD scenarios).

> 
> Code reaches a node's memory in 3 ways: zonelist, node id, or by folio.
> I couldn't find a statement of which mechanism is responsible for which
> kind of path.
>

Being a bit more precise: How do we reach a node's folios/pages?

 1) through some kernel structure, obvious examples:
    - page tables
    - VMAs / pagemaps / xarrays
    - LRUs

 2) pfn walks
    - memory hot-unplug
    - contiguous allocation
    - DAMON

 3) page allocator
    - freelists (page allocator)
    Sort of its own category since you ask it for folios from a node

> I see some consistent issues,
> 1. zonelist paths are covered by way number 1. Some of them also carry
>    way number 2, some don't
> 2. node id and folio paths can only be covered by way number 2. Some entry
>    points have the check, and some do not.
> 
> I can't tell when a call site has no check is deliberate or missed.
> This matters once non-common node gets its own zonelist, as patch 4 metioned I think?
>
> Could you clarify the rule ? e.g. which zonelist users must filter on N_MEMORY_COMMON
> themselves? and why the zonelist alone is not enough for them ?

Some of this is obfuscated by the fact that the existing code already
does this filtering for you.

I suppose I have some premature changes to add additional filtering
where it isn't needed yet to reduce the complexity of later patches,
but I can see why this is confusing when introduced by itself.

Consider this:

-       for_each_zone_zonelist_nodemask(zone, z, zonelist,
-                                       gfp_zone(gfp_mask), nodemask) {
+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_COMMON) {

This is a bit of a preparatory change to later convert this to:

+       for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+                                nodemask, N_MEMORY_RECLAIM) {

It looks like we're filtering by N_MEMORY_COMMON, but we're actually
iterating the fallback zonelist (constructed from N_MEMORY_COMMON)

  struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);

Later we update this node_zonelist() call to determine whether the
private nodelist should be walked, at which point you do have to filter
for service support.

> Whether every path that takes a node id or a folio must check N_MEMORY_COMMON, and
> which ones are left for the feature bits in phase 3 ?
> 
> Let's get the rule settled down and make it as the foundation as well as phase 2 and
> phase 3 ?

So:
  1) If you're walking the normal zonelists, you're already filtered

  2) If you're walking nodelists, you need to filter on N_MEMORY_COMMON

  3) If you're operating on folios, you need to check common_memory()

  4) If you're walking the private zonelist, filter on N_MEMORY_COMMON


So let me do this:
  1) i'll restructure this phase to omit premature changes like above
     (they'll move into N_MEMORY_PRIVATE and N_MEMORY_<FEATURE> commits).

  2) I'll restructure N_MEMORY_COMMON commits here to handle cases 1-3
     above in that order, and that'll hopefully clear up the confusion.

-- 
~Gregory

