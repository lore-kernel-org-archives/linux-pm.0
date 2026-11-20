Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201147;
	b=iacD/hyaJ7nYXEvktT0BdpiGkap1k49JR1HVYXuJ18GgZUQGgKTlNWP47CIcwKk/pIOd
	 f9aMLDjtUSy6mARCTe/nODwDq/DZtp2VLYKAgwbzq8+r/91d0wmJNhAkt7cJPaPmjCJru
	 amTTvwOxeUd2iO6izeWUvzHWMqThjUqRPwvaNOItebOTHkbQ2CANjE/zdFAxHlXLj9jwG
	 +cankLvPz1BQ9KHqRpkwai6e9wQ6cqQMCVB/TFfv2jpa4FK3h0W9WDNofjup7O/j0uXzr
	 OOcpgrv+uc0+y1s0ri/HBehtrQ+8w1IcPBUhyFybeHyX2H0si+uusIA4+RtHSWyTppA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
	b=DakOzAaHzsOOzAvkZ7rL1SySwT09v+i/dHasB5SVtlRgIqMF54wVlDFfrdxLDu2skqVN
	 JZnb5q49uslefiW2kX9TjECKxyz6WQk8BEfWa1gzwvIFzk05uR7JdRYwNxKN0CemKFb0Q
	 uGVX9kUqPronAGkpihU82EbBHjq1WBT6ImPsM04TnIF5H9yxcdDcW+2qxyzJdHiYzy5fi
	 /6N32yIqeAeWVTTIAGN52Ru5xWjGxJOT2VZ4aFDFv6ySZmQ6uqYg3cz1gmSR7bNsFORlA
	 7sC8FWm3IiJBEJbpUIyqWg0kULbYjKPrH+1y4OFZ/VbcBhAmZWjVT6R1D1km6etDhAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jP9mDgSk;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843960A2605
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B843960A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jP9mDgSk
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364d86f7f0so13264341cf.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795201146; x=1795805946; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=jP9mDgSkXq83tjLxbrSbvJK4VhOzYkMGnT1Jm7gDQe/tOWOQWw88VffPoBHzpHtdXZ
         AtKDL72AvMbm6K8+SFolZTdZsq5YCre7TYo+p4r5NsYo5qfix5Rkg5grOkKDHVKVNOAS
         7oCG+E2fpkpUAmmLwq+0Xp2+UXqhc1fXlcHYaL5btJezkYRzJilsdIXdINfLoFlm9DO8
         6CbBfgZVvOJVM+JRwdAK0Dvz71rzy7UBvr/rr8US3Cw4d/p7KopxcO/pFRWbieVCQcWx
         SzmzqLmCMHfM5PgM23TucdXta6FY4M5TN5xDVyML6rCM56A5+RYnYnryKZHICDqx3uzd
         4qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201146; x=1795805946;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=fyOjkcbbPU/SVctpy9ScVIPnooPpoB5UoAhfTuNZv7PugM5TZopQlfKY1kAeoRLnak
         W1FMPiQLdhjd3YlR6T2QbquO9UvCZEd3UOKu3o4OaeZcsEn82Xs6SK2GI+dkFAZUUF0i
         M1wIjEwipuQhTJDKmtODVWg6r4wbmhTAU06Wlz5qb5FUS5yFzgDpuvFhgpyoqfJl4/8i
         74qnelWwazE7Q2zxc0AyAjvngvklxJ83DVWVBzbh7RkTtlq2A5llBrIZ0sHZSX2oAire
         dgs94m64uoeM5j9fRG8RKm0Y3HVhoGgUZwwo3umJkq/U7ED0POZy3lpZFVy5IIx7kqWz
         Y8ew==
X-Forwarded-Encrypted: i=1; AL+hErF0qJDcAxxsoMQ7xRChYjQEbkf7xTB9rYjpIlpuqLv3SCAXiW9uvI27/fHvIifk1JbevXhVSlSzGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3i8CNHz9Fz+/ASVIB/sWCekPAyZ4y4NogwMdaSZLmuW5Fy677
	p9yKF07fst6kAPNcPCeI5yNqYbA0N6pScLo03hTTG44iPnEy4Oxqbf/Y0TKJKxSvSZs=
X-Gm-Gg: AYBFou3+hVXRSeuFhI6lLb8iHmft3znckD6HRmx2tLLngRPoz7qpyN4cRLMaeMh/Xa4
	WHxw7QlPXmUQQIz+E4K5n0dUAt4SuR3x0vLwtEc/owow0nd8frmtwudkTYoDuMfzUQ7pR1WGy/G
	NKEWDRjmLjfsdlTDWs1ILNN943XYsWHKpS6XhpK5PdpiAi6IRU84V2GNuSl2OvOIRc8cDiNyNaM
	lVapEQlkw98VNHP7SX9wQWp2Im+IL9KMBTBPrB8KPDscmAR+4/wv5zDDA9iPxOQ/XCyZrgreJ+u
	m0xjbj1L5AxvUYF5IU3ZGWB1UfnYvtLqgjcwtbfsWEMVEYLjgvttyn13edMg8+6kOs0R5Y2W5Av
	9BpuKiKb8sFBdkRRfi9tCUzMNkneQ006qNAg82md5O9vu+SFfDE1tE2t4/WQ86wGYRByJjz9eLg
	3QXZC87xeQcUqy2JewI1/J5PE7wkBxP4SImGIw19SwsbwVaKpdJwA5e+3JGe/mNtilY+vzBzSnN
	2W1S4/fFPSA+Z12isJP3iz/9iUhALMoN7t4H4NYZ2RT6aCVIWyOxhaez1239ca+hHo+GsdRH41Y
	YHjaNaH0yKn1mS50S1jLvtGJoBmlk5Swaj9EZIoZvYLGuqYX+qT7InakDKg7ISqcHGWVztUsIeF
	vF6PeH6s=
X-Received: by 2002:a05:622a:1a89:b0:55d:2c9a:3776 with SMTP id d75a77b69052e-55d76a811c8mr74428711cf.65.1795201145651;
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884d01csm30305771cf.21.2026.11.20.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
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
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Yury Norov <yury.norov@gmail.com>, 
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
In-Reply-To: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
Date: Fri, 20 Nov 2026 13:59:03 -0500
Message-Id: <179520114342.412063.6068641130948664600.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 13:08 -0500, Gregory Price (Meta) wrote:
> This is v6 of the Private NUMA node series. The series falls into four
> parts, each building on the one before:
> 
>    1-18  mm: introduce N_MEMORY_COMMON
>   19-26  restrict folio-walking MM services to common memory
>   27-44  N_MEMORY_PRIVATE, kept out of cpusets, mempolicy, accounting
>          and the page allocator's ordinary paths
>   45-61  private node features, memory hotplug of private memory,
>          dax/kmem private mode, selftests and documentation
> 
> Patches 1-26 change no behavior on any system and can be reviewed and
> merged on their own. Without private nodes, every path in patches 27-61
> behaves as before.
> 
> The full stack is also available at:
> https://github.com/gourryinverse/linux/tree/scratch/gourry/managed_nodes/private_nodes_v6
>

Apologies - my b4 prep dropped a commit from the stack because I made
the mistake of filtering on author (myself) and it stripped out this
commit:

https://lore.kernel.org/linux-mm/20260923211041.3127588-4-gourry@gourry.net/

The commit is one the branch listed above, and should be otherwise
indepedent of the series (can be pulled in ahead of everything else).

Sorry for the noise / compilation error, won't happen again.

-- 
~Gregory

