Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640230;
	b=c7zTOHznI3GSSMkpvSsrohwtNiqv9CcTYzDaBQF/lGBFS7r9lIfEG02AQDXrWtSs3xnP
	 rYHetqGP/8yWE29yAGGJHUdLT5xxXbHx7dAoZoKKL/3wxnWW7kyXf5iz5V7AZMDLRTFpu
	 XAW9aiBM438AiLt8kqAIOKJ50ali05cu2PJomBRPoSU9cwqhkS/uGjU2h6dePFWQv5hWl
	 bM9K1WDpLX6mstrYPVrZ6RlXZb2wK1u9/Nb7mnCmwH9cjKLPtsLT+u8OPEMBER70tTYVd
	 Yxy2bFpFlRBTeGiHqVolHqMUHxnA6OJw2XwFPNLa41YGfKU9jsezSYtZf/QjVQirJJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
	b=p52FqUGrlOZhGW1yJyW8k5PTvz4ZkdOFp/6wbxnwTAU3kdAyDyda0X2hpxBqCD1JSSMB
	 f82byqDPKgkqU8PCV2fwL4xRcguTXZZSpZlx/ByOIzaMP3WfWV7WmzwP3alf9+xHHpelC
	 EPf1ZHHxitp1Bi2nARVI+KPGSZYlZcUIECvObcGauk9t+EaFhNBUzKLC8srMrIUkFmybh
	 Otx5Z/dLPlZiYFOpCzyWsbySCJeIMU9758jSlIavQfEC4Bv6fwcmdOgG0CaWks/MOchzv
	 KbITj0CIDD2aVuOdm+ZRQY2fZto9cKcSTjSPtziGNe7Mnu2JMVekPO9afNXXEWoZjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ThWtUYOE;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4160A6F53
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA4160A6F53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ThWtUYOE
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91f332a4b2eso5814536d6.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640229; x=1795245029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
        b=ThWtUYOE58bojETOwoiS6cs6qdiFDpgzkHXRgjHbjxmm/AONOSeugBbicD457oiBaL
         3kem8a/H1pX9d/FFkl6ik8me9yyXIiRnIWseOAR9CUTiE4gCSGTyPH8x2wcwHLj/wpFw
         av3lh3aajoSLB7WMBw7STl4nb8kBzWmr0i2io4kqZUGb4DyNf0T8SwNigv21OL7iKq1R
         2m3pPEnA/fZtCZtxcItt5v45X7mgSC073KBaThPkUuZU37zOufiZKj1oz/8Z616xJKwp
         LYaXfzMeVQbfL6BjgCt/OsbPS+4qNbVTjASn2JD5S6sxZNk5zXDYXfSbJpd1mUMa+WdL
         PAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640229; x=1795245029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCui+DSNeboB03hP2f7maV0wOWIxjAUtx4hYmP2Ak68=;
        b=MmiaCrV0pau4J3fJFvgVq//bXs9tksat/6Xy1e0ytxdi23rrDb8yzG6kUTsxJaFyHv
         zj6PPd35IDdN10O6VfbZ20Vrm/yAONzAmiiFcQMr4l5+Vhki7ksEHSrS5jL3NhCZ0r7h
         VO4BaWlRruS9353rvoMSSn2pq9IHAgWVdgFYj/buGDZJbCqeH+JtrQ1OOdXgtPMlnyzC
         RMt7Qi7i4oJ7FheoWqcqXtApjcYfUc6wKhf4DixeekeuWEPBBxn9aKCNA4Z5j5Io8zTD
         6Gt5pih277Jqy2J/p3Zpy1eOhBRrpjOmAw74jcMeb7J6Ba3lGykecvKT6AW/aEpKMVF6
         D60w==
X-Forwarded-Encrypted: i=1; AL+hErFCZKp/0Cij4tIPbjm0IVlqaO8tK292CAJV0gW93KTPwWUVDzWm8vk3ZXmIyjjmrkiF+Kt/C2+n5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zeWy19pn4MzRDssYajmLlMQO7amGdUP/gfCasUDAJwMKRcrgb
	TH0uA0IEGcvKOLCDP2RkvJX2aumAi3t4FII6Nr+wiTSSvJJTbQL2opcUcHEq/WPLB08=
X-Gm-Gg: AYBFou2+nBeK5bwAgWfwMHQL3v/Y6IcZv2ZAfbVcyK+8nun5koulAMnxQIptPN/971b
	5MqKRlVRfxFuEmjgXX/wicZs65IhIcMlRDDOrrPQKSwGeMwPEtJ1/Vi9Bqlpf0cAHaCUjBBiL4u
	7IbhL6kA8jyo9I0+pR91dr/td5X2gE59Wq9z/RpN3IrNJKTc2a8V5YqTcdo+Qx3oY+eCSJb4BB/
	vPv2OsZTx800e0VtCfJD1UQ6pLO7QB36FA5uQsDsHabY9UJALeIszOkn6/Dxxd9QSFQYVygc1bv
	/c6rzbW6bNJOznEOHUyQfbX2dje3oQrytEmQOEYuV53gDTzhQQbN3nHeH65KkBMuQdXusTGlYrE
	vLSh1NEaK26N3EE4vYsLuQMgOrNo6qLqJKLzbmsEspVgxGd1aUwAAL4un71frJe/NTt/i6+m8ik
	S1ZGIZLb60U0xzmZrkeJm6jU5ZLq9jTo8EbIsHso242yPtMyvuIaRUj01+kt8bcME4iUeWCCtky
	edRDHy9i7i7Vb59WXZZY+cwBJbfisYD4g1+Vq8QQjrD3CZZJtJL5YDVmeFQptRyF6UMNs088sO+
	mU5KtnzUzKz7aPtFGEwBe18e+uo/GmJIxJisQi8i/wCFwWLJvhhUHxgSRLjCiytpU4hwEehYn13
	dv2AwWnVdYCUOsUE=
X-Received: by 2002:a05:620a:4005:b0:940:e34a:aead with SMTP id af79cd13be357-9494b9488f8mr838653885a.5.1794640229507;
        Fri, 13 Nov 2026 23:10:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:29 -0800 (PST)
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
Subject: [PATCH 12/22] mm/damon: restrict DAMON-native folio operations to common memory
Date: Sat, 14 Nov 2026 02:09:49 -0500
Message-ID: <20261114070959.3490008-13-gourry@gourry.net>
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

DAMON acquires folios to age them, check their accesses, and apply LRU
operations and migration. Treat these as general-purpose MM services
and restrict them to N_MEMORY_COMMON.

Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
it would pass the checks that keep ZONE_DEVICE memory out of these
operations.

Treat these folios like ZONE_DEVICE memory.

DAMON cannot acquire such a folio, so it never ages one and virtual
address monitoring reports it as accessed, and DAMOS cannot isolate
one for migration.

Reject migration destinations outside N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/damon/ops-common.c | 7 ++++---
 mm/damon/vaddr.c      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b9571f53e538c..51b4b5d572e77 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -17,8 +17,9 @@
 
 static bool damon_folio_acceptable(struct folio *folio, bool monitor)
 {
-	return folio_test_lru(folio) ||
-		(monitor && folio_test_hugetlb(folio));
+	return folio_is_common_memory(folio) &&
+		(folio_test_lru(folio) ||
+		 (monitor && folio_test_hugetlb(folio)));
 }
 
 /*
@@ -498,7 +499,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 		return nr_migrated;
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
-			!node_state(target_nid, N_MEMORY)) {
+			!node_state(target_nid, N_MEMORY_COMMON)) {
 		damon_putback_folio_list(folio_list);
 		return nr_migrated;
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1e65e7651cd98..338876559140b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -830,7 +830,7 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	if (folio_nid(folio) == nid)
 		return;
 
-	if (!folio_isolate_lru(folio))
+	if (!folio_is_common_memory(folio) || !folio_isolate_lru(folio))
 		return;
 	node_stat_add_folio(folio, NR_ISOLATED_ANON +
 			folio_is_file_lru(folio));
-- 
2.53.1-Meta

