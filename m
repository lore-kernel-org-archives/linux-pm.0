Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442718;
	b=fgIs/QHVw/V79FkCDqnUc928gfr+vflJrFTXX1bZbayLieriYLFx5t9Ecs2b+jPRBWyX
	 ZA6X6Cdq91Te52XdEpruv4JpT+Vu9owS1rdEQh0AQcLNXbwSu0Umx4rUofPGsAlUt+KIe
	 bbcGkkJFtIhCktxynTbzRhQDGhNN+DT0gX+ubnNDIKU1EYawzWJ+lKmtWas8xtKCi7MKq
	 spuibo1sh67NheM2FKvmZ2M/QT3pWp92PTyFQqqp62C4ZBmO7kj0ZKn6AkrucZokMJ2Fp
	 j53TmWUGR60sOLag+0frEN/Ro3g+HQo1QztUnARVXQepPhb9/BFjYsy1iYiy+umcbQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
	b=lvkL1MrclmIw0ZJIgE7uNOsQ3fFH+zFF5qjKBVPybmouydeSaxhlyi0aD4WsdhyVezp7
	 FQ0G+Wr3H+HuMAmqxjU/ZKBw0CKwwbdwxce+ELVFxLb99H4AN+LCcanmWrp0k9HNG7id8
	 RSElXw3PcmfV3iZinrdfNhNqxrYkS4JO49Y+lACclSO2M4nzcaKx88MQBj4ea+ZJrUZEM
	 8K5fd/4cksgZYKw/KSnAfRGtS1r1INVIfgl1gNw6vIAJhhhIc3ZQcfssxEKgTW1McI35n
	 tYBDryDa254ZPE/s3aYRHh7dZfxxTPiy0ySS99n0zoMTYc60VoIdBrezZjGsioJ2qew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=igq0rNBf;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9A606A32E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A9A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=igq0rNBf
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67db89857abso3354823d50.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795442717; x=1796047517; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
        b=igq0rNBfR5HbxAZkN3J9ZVhbsB1qEA961sp/d7IqeNGyTiy13BYtzWR9s/RamaGEgu
         kc4sU+btJ7XNLZ5KXBxvURVrVQTw+iIpKNkheMbVp3xGacR1R1kfOolkY9OvEfyDy2WU
         t8c3MRu8Ph/FVIkYBtPSoZ4kr+2q46nvdG4OkaZ8HKw2uHjsXYgGlmshpBuDHEEM6Ue2
         CnIWmzY9CuCkfe/LjkxDPgvTI37B5eL8NNhGF5PzhFOodXssf4pgSvAhXFcLZzhsXatI
         zvry3mYpF+760cfsuTrJwWemnN2NLrmMWr51jTqFRXg7TtEf6JJSY0VorkioDqKLVzoA
         4mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442717; x=1796047517;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
        b=cSYL0RGiRDRo2mGk3bqAlxbl4el0G4hpVQCj+3WGcj4aOz+gUfnRmD5yJ8Cd/yf460
         ZeoLG36eKDurF2syMbmBddW3XhyrOXMbMElivqvOgS2jrzpvXrGpHnpRfvD6SWfKKxjO
         +SWOl0hU+650Q81dNar/qY47YMhc3z8b5whHgwjmBg+OUla5UZ9n3CT1bq/G3LgkVx6P
         rnFUyh8000OwbIhZ66jk0qPC8jGg5kajqYWkpESe82q+RVIOpgv/IucnQsMxZkSZPN34
         rlaLhSW1ACJ08RDC3dvYfCTVNANgbSx1e4fsY0n2JZn9Xbh0oQm+S68eyVSpIMha+4HH
         0ZRQ==
X-Forwarded-Encrypted: i=1; AL+hErG7doDgbkXhK0ssHk+r8dzpITSQW2y8qz60sXrqjIEtDXXTElCGgK/Gb7i+MsI0glJ9+1MW00nkXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AjNVFQoko7euloztFd+syLqpBoTYYU5pQMBRh2q+xhwHgSxnJ
	lHkpryaLnNR/qDpFWAB0GnZltHku7lc46Z2q1GpTayDTaSYxYs5AN4NR3x0Fij2UGXc=
X-Gm-Gg: AZFdTZfmwMhCZyLvH454uZjNM533bS9lZkpJdAgO6EiINHvTE46lf992JGUaZPYWg1n
	uRMQgRqT1Ij3OPhu6RVunhlOJSJwce5LLLquFek81LbSykoqQgBJ9y5Dbasblh075e3Bugz61/v
	5by8Rko9GV01P5W+tNsPNpttxPMpQeqd4QEhGrEI+B/tYbiNsSywYbjd3byT1iBDJPGfZ6V2c8Z
	Jocu9tQzqe2a8pKBe2NntIckP4PTh63epe3IgAHC6KY5HIfNONOyK9dIQ5tezZj2cJ2zsbduA59
	/It8QWLOS91hLDpTZS7ue2//+scwUr6bNFjiiLQEJlU4T132Ii3KZcecz8epPsOoK+3k9lwksOg
	051WZdFtd7bZdICLR9XtTDIgDbNyrveDj8U/GWTLUNpvGwep8cML7hfCTVDxpL0uRvNBMqL0YVA
	v0BO4zcdm0hK/sw4ZVMRQSwsmYofWrwNq1pRdZennxsdNBz+9qIEyEPdD8GQ6iRGu2AmiQOEbcf
	yXEq5YxN2Gp+DJ+CfmP9UfmDxf3ZJBQKjeK5ZZ43zfpE0f99n1mSEAK5cU8QxzGjwv+OPSFuNN9
	IGZDXooDQ4pGF2O5Ww0HjryMzydzosHXfmxeGOiCYhdXLrgtPt47FQBWOJv+Jk/YqMsHRqLHE/k
	lSmqmNIwK1G8s7aGxuNAmewsRfC/2
X-Received: by 2002:a05:690e:4881:10b0:67c:efb:636c with SMTP id 956f58d0204a3-67df4425656mr2221811d50.51.1795442717363;
        Mon, 23 Nov 2026 06:05:17 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a08552sm106091806d6.34.2026.11.23.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:05:16 -0800 (PST)
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
Subject: Re: [PATCH 23/60] mm/damon: restrict DAMON-native folio operations
 to common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMcsTqyCgQ0dISw@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-23-74f5f9a115c2@gourry.net>
 <awMcsTqyCgQ0dISw@yury>
Date: Mon, 23 Nov 2026 09:05:14 -0500
Message-Id: <179544271490.412063.3555696768623975197.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:47 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:09:14PM -0500, Gregory Price via B4 Relay wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > DAMON acquires folios to age them, check their accesses, and apply LRU
> > operations and migration. Treat these as general-purpose MM services
> > and restrict them to N_MEMORY_COMMON.
> > 
> > Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
> > it would pass the checks that keep ZONE_DEVICE memory out of these
> > operations.
> > 
> > Treat these folios like ZONE_DEVICE memory.
> > 
> > DAMON cannot acquire such a folio, so it never ages one and virtual
> > address monitoring reports it as accessed, and DAMOS cannot isolate
> > one for migration.
> > 
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/damon/ops-common.c | 5 +++--
> >  mm/damon/vaddr.c      | 2 +-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 15cabc79613b..57201a0c5e3a 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -17,8 +17,9 @@
> >  
> >  static bool damon_folio_acceptable(struct folio *folio, bool monitor)
> >  {
> > -	return folio_test_lru(folio) ||
> > -		(monitor && folio_test_hugetlb(folio));
> > +	return folio_is_common_memory(folio) &&
> > +		(folio_test_lru(folio) ||
> > +		 (monitor && folio_test_hugetlb(folio)));
> 
> Can you minimize the diff? That would also improve on readability IMO:
> 
>         if (!folio_is_common_memory())
>                 return false;
> 
> 	return folio_test_lru(folio) ||
> 		(monitor && folio_test_hugetlb(folio));

that's reasonable, thanks!

-- 
~Gregory

