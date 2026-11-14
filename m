Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640218;
	b=yxAafmEZxwnX+CByD3io+zh2GdvlUi6hx5icX0aw4rgaK7HJjiNqda6yk0Xs987KumKP
	 F3+BkCSOkTmJS+el4lXYqrKtutkWfa1CHaMLqs0YKlTJmkw5NUQFgIglg/+LkfoKs6RoH
	 A8Fx9i7hdl5vxxXSnqQPUHKGepphDmMCq5vNYlXvWkGg+50kAdGnZTcRmwJYXqbpchi/d
	 G4VFWPj7wGMmN9YME7lSJGrVlXxwbvIZKWSuLqr9faa0307Qq0nMSf892LNc05uRzz+Yk
	 DxaZpkTctK3TXL8lzt7JXb7nfq4Z9eXiqQfK6TO0+g/zhh6PKUZ6OnP6NG6TlZaC56Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
	b=rDDvgDOAP3pXxxOnzid1hFEL0JBDmU2SnGsAQWrw6kwG9mKocIAeKTnt4pzMLaWRKB20
	 SstR+g9B9PW99OvQTfxlO/tZICGYwPmfr0fDBbP1MVhgdByHN2HFKxZ1EroUECHUuaZD8
	 WyeDFk8qGso7ZbGhkUgpYrMFIuKb94pWDVZ+KZu29r5KJ+z7SRmRWuzkmAP9Xx1JW619e
	 yaG35mK5OZH16DJ3xd2Hoi+y5krMYg8qOaOT9+kmyHphzpx868pHmgBurU36qEwwn8dQX
	 aHy5fVJUmi2HNcc47146Pze+FoCdkC0vFO9GnffIdNnb3uJbcc+lxlYH+GdKKsgVmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8260A3802
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A8260A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91eb53957cbso45070986d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640217; x=1795245017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=fZh2cb1LiTzSJJuOnufVWdO5uqn8qMfsQjZkSDcuVrcFCC3Nz081OmFdRyBdfcDXeK
         PtqCPeoNuyEztLDVFQOTRjF70fsbDa/YamFvNQf9kWWfHaCXg82Zwzsa4UJu71zJVFbz
         DrH38E4lxwMsJRxFci+ewX/0oAPjtdvLPYZ5VTYhAzrtXdl3mrASJNk9oDZMBuGQX7J4
         pZnpsmYLNfNkHHM8PmVTtoIUGhudURHAF6PdA0hZAdyipbVro6zJupwZRkdKN0fw+Q0d
         ORi4tocZDqoL6xebdcxuIfScFZIYh9Xs4P3jbWKeSHPO5JkBm9C1FtrFtA0lJ4W59m0I
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640217; x=1795245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=TC+RaWD+900hmqzSHX3gnvgYx3f403v4HOZSi5UDe0ZB4iM0KGKHO6LRVCleyz2sRN
         bOKlB5L2wStdN8LdLH7FldrFc2G7vp76GbcoNHucY1o/Nnv+NPmO6c+Rn+ygT4dGNpoI
         zIhgsWGuqwQdzSsYgsc0KChU01ahxy6Zhu5zALMlqj/FWEz0GwtM873xGU3jqMafN4Uu
         mJRF9wPWrr/+fcrrCGVOkyNiNUFUEUpUvPTpAbpGfGIdArHe4+9fPQOptFKPArRcO19P
         cHsYgkUxAqP5b2V+GEgGrWS4ab+Waf21apryGhPNChRykZjyBN+hOj6so5RmOyTBjINS
         NOAg==
X-Forwarded-Encrypted: i=1; AL+hErEscpNKNd+GA0A0eDhmQeYgiDhUG2QmHT30IMwObCdKRHS4NU2v24+xG7QIbtEiX22Nya4MjVEP0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9MP1X8Y2OlVAemLi1+jauZafCQ+2KDNqKNaM0DdV/zlvgVDzny
	Xd0/wG+d4vTqzep2SNtiRcuaDPb3RcMs+ZA0ei0G1Z5NS8SzofDSi7mYH5TFcUMI2jM=
X-Gm-Gg: AYBFou0PmyMz3bB834ke5eojYbf28+qasBaqsvHUjAx5AjsU8jqacbFyFyNY4glz9c+
	pAgrlp6vKx92kHDMpnNRwk4xIoorJ4aetVY0Tg5VKBh7ejJoDyeBeFp07OnwvwkAINdyvxni6ly
	qtGpdy+6jrkNBk0FdXIYsVDyurUw8f+UlSV626WlDOPEA8EqcjjZsdlYvLH4divj18ffEe9DcVv
	vlx8fKyIcJB+lY0znMB/hCa9S3q088qUOpcxh+xsd9WUADTOYR8vOj8rH8kZz1G6xUPNPFl7OB9
	Tp72SjkLVRRWkFpmVwC+Uq76yGPWuUxbl7sbouSmBCMI0uln4M7YOn/62oMqy9vBcyM7p/WLlTw
	mvHfvXTaeJ63d1nvuQV+rQIHMmSj923W0lOoHSQuNuJ7aPjSmFAoY8gICQ5SOS+gFGiqfzoJG03
	g6jXCh7vJnpUEzlBK2TgTP9/dtMWJK4nPTcJJ36upPSjcMLGUr2y3sJfzZ5RapL7otwjqtZ1go1
	H3draMc5Kn9oLinEmhyATFoNGf/uD1I4tJicj+64TKCxyYj9YXiuaa6O9ojUgUD1fmMn4NSO5Iy
	cH4VbUIObOCXNLXczeAMqwLK5/hZwmY8ZHUVcEgogjPr1plQ6kMFCFAJcYs1lZExK4Gw/zDfw+k
	xD1lqNrmiSwzBTQ1x7mBA0VEx5bff6oFN/9ys
X-Received: by 2002:a05:6214:6347:10b0:91e:cf4d:f868 with SMTP id 6a1803df08f44-91f2420f9c3mr56246926d6.22.1794640216984;
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 06/22] mm: base hash distribution on common memory nodes
Date: Sat, 14 Nov 2026 02:09:43 -0500
Message-ID: <20261114070959.3490008-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hashdist is useful when large kernel hash tables can be allocated across
multiple NUMA nodes. The tables come from ordinary allocations, which
only N_MEMORY_COMMON nodes serve.

Count N_MEMORY_COMMON nodes when applying the single-node optimization.

All memory is common as of now, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b4c4dba93652d..0c076bf5bf380 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -685,7 +685,7 @@ __setup("hashdist=", set_hashdist);
 
 static inline void fixup_hashdist(void)
 {
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state(N_MEMORY_COMMON) == 1)
 		hashdist = false;
 }
 #else
-- 
2.53.1-Meta

