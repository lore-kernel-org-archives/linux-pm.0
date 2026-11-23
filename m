Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442546;
	b=EPSBZQl470GopD5NVK+GhfgHUoAI2mmgXPr9EJhvJBV/QKnwZLeOZQHli6tUivUteeR1
	 03Qc/hNqSotLl9isTVKU3yZ8PGR4P3kwN96AVCyuKqeTT00qtVkRbqnVcKScXLkiusyKk
	 Mksq07bfzjJJhuBXC+Y/QUxXiVndBgrTdqch73hXUdMrEh8+6NBRP1esYMLu2l1W1OyjD
	 B3OJ08nW4BIkbzciUKX2/Tqm+++Ppvh7g6PIpJJZvdCUlsdWnLKR4PRMt8EudrHxa6y+R
	 4KNqHAk3oiSrX7vKINXmUg4jxpxf3X9Uhc+CJXygLcCV2A3wZClFPkXnbuQ0+mGfCgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
	b=On2lPL3bKevJsgk3uNhv2slmFqM+v3Wdydcuqh43F6HtYUOCc32pMasRDKlHec+0li8U
	 UFji7d1snVKSV7+Lr/HRlaTGuixOiM2q+/O9Vtyb6SlIi41333ALKtaOk6E5/VSloQXRd
	 3EdijrPBZtAIz7sZLjoSrtz/0bV86gsFUxQoqYc6BAa7YzHWLKiNd1wwaT58zTZHdCeFK
	 Xhf2S6q7+GXmHnJari+6HnOn1bwXDNROBgbUfVuhOdW97XtCtmFLy6rpxasgbEh1rPt8r
	 6OG/5RmtOuUndLsf+8ysn1hgQUp2HLtDT613lMtSe9xhEnrXH59YvuT/xWAFiLLi4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VljreHg9;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB8606A33F
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92BB8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VljreHg9
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0dba37a7fso25533067b3.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795442545; x=1796047345; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=VljreHg9fqduoNCuhUvYdI6zY5hBHSeYwhiI7vf7summ4dEKYq9hFOCCfR6aYF0/2P
         L2riCG2gI435GeC7ZNsfR6fHTud24o8gBnAqDt7qJDsirWdVpATYePJDvcAuDTpix9n4
         LGwyZSTUtozFudCUJyvSw4q4iZ39AoKFu/CZ9iyFv+g5+PfiwXHcWW/55SiIwIHTxq95
         +D/FF6JCGPVqldEw7rHVuKYVNkvZaIANpP3McjVm/7nMaF69sLbbfoPbYTj1aNHccjUA
         BzZMskVSpQ48oEk7/U4zjyTsdufPf56rPR+BY3dYNsiQKYzFM3LIFVLAYoI1XW3G3WoN
         vQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442545; x=1796047345;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3PKiWxJL5rA78k4RAfL19Ict6G9pZhcXRFYMUNqZcE=;
        b=Xowl0b8FdWderC03tdh6vpQkLeJmCSE07ougYukazddZBsY2xBRDHVKWRR4bfEsODk
         aQHlHmyd4b97XMCwJt2BqN3bsnCdLPQi1KiJurEJmWknPF4Y8fjHemTVoumAkFH7fu0i
         actZvKzOPOpJKJz+STW8BHGXcy922WLR4W+RgVG0GRZVPzZC17hVhXpymLH74X358LL8
         0nw6dLDagwm4CM24lQY/ljzCi4FVvle+rAdz78bEV030iGYieuEseR6qqh1Ipeqw5nX9
         91Uz60nKGqOMSfOh2WuPH3D4DyFmt4qPOU74v8wTuIjEBcsJ5eQcnssThrPdeLWwI51d
         huTA==
X-Forwarded-Encrypted: i=1; AL+hErEcS9oM0WdmD3v3eczS0yPLpj+bNfpReu0y3YBdJNSwJ6Rv+6MB246OGVKBEXMItOt5nFdQgzWEwA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/w6BJButu4pnRPdxrdXJnFT/PUcpkdDBxjC3P5Ac3fbY1IQvoW
	tAi3tiHvb6ZQF2ENdBvPmWPbAhw78T62A9LXe1X/HKKDcNBP3e0rrHJY6jGLoZUXuq4=
X-Gm-Gg: AZFdTZduJYKWAlMGey9I3Qh50eZB07tcNiv5hhahSBpXDCQUTuahpalj1XS3rigPpnX
	5YxOnWgCa6lM7yyV0fjGi6jcKn0B+IhQcrGCu1Mok4CP1KIVCbUMdaqj1xci1jdFloGSKByUDUn
	Zrexw5QpHxKVKBNWd5kP72RJLXUM8MOkbYbUVT3P/Fi7idSIzGt9tjnwtU5m7JHbzLS9jsIWKOA
	Fx7shc04ke+AS0MXEL8eK3mtqivPDV+jikJNZNVCJ2eU2vRzPQ2Qa2VWbTrj9oLimrkF3cSe5ug
	CgQmwbFv/6oidzxTEHUhOPej5FR2+L0D5wr0F3JYXzDLlsg+MRumzy6g/xI+ANIl17nybQxsNQk
	ZA+3jgd+LnB+FjfhHZZ3pSBfm6XMI9TC0TxQTxgvCcZSl5TLp5/ge9GZzeANukQpPRNuX30GFz+
	mFCRUbMArph6vwVleMAcjHKKqYkpB0QGVB2VuRm/KEo5fJOPUFIphNMTQ/NBgWMek7qi8F8ORbi
	ajwuy1NRlFGYB23tji4offxfb0uR/5STZDsBajrG1IFrwQ1+DVS8Mut2x2F3Qwj7YL82YjwFj+x
	2RuVS2AQSJHchozRHbjI9oKYLqTpRQSQms2Acr/zJb5XgS3ZF1xtSK2fW6BPK7sepe/2p44s0RD
	5qHfowRM=
X-Received: by 2002:a05:690e:1449:b0:67c:b95:6753 with SMTP id 956f58d0204a3-67df451a476mr4209002d50.146.1795442545280;
        Mon, 23 Nov 2026 06:02:25 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm104854846d6.41.2026.11.23.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:02:24 -0800 (PST)
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
Subject: Re: [PATCH 18/60] mm/khugepaged: base the recommended
 min_free_kbytes on common memory
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
In-Reply-To: <awMbTMt2M876rTy9@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-18-74f5f9a115c2@gourry.net>
 <awMbTMt2M876rTy9@yury>
Date: Mon, 23 Nov 2026 09:02:22 -0500
Message-Id: <179544254257.412063.6102711886866280853.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:41 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:09:09PM -0500, Gregory Price via B4 Relay wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > set_recommended_min_free_kbytes() reserves two pageblocks per populated
> > zone to help THP allocations avoid fragmentation. The reserve serves
> > ordinary allocations, which use only common memory, so count only the
> > zones on N_MEMORY_COMMON nodes.
> > 
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/khugepaged.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2dc4245814df..a930d99f89da 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -3151,6 +3151,9 @@ void set_recommended_min_free_kbytes(void)
> >  	}
> >  
> >  	for_each_populated_zone(zone) {
> > +		if (!node_state(zone_to_nid(zone), N_MEMORY_COMMON))
> > +			continue;
> 
> This is the 2nd time you add this check. Maybe fold it into the
> for_each()? Assuming, you keep N_MEMORY meaning unchanged, that would
> look like:
> 
>  #define for_each_populated_zone_state(zone, state)            \
>          for (zone = (first_online_pgdat())->node_zones;       \
>               zone;                                            \
>               zone = next_zone(zone))                          \
>                  if (!populated_zone(zone) ||                  \
>                      !node_state(zone_to_nid(zone), state))    \
>                          ; /* do nothing */                    \
>                  else 
>  
>  #define for_each_populated_n_memory_zone(zone)                \
>             for_each_populated_zone_state(zone, N_MEMORY)
> 
> 

thats reasonable, thanks!

-- 
~Gregory

