Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640215;
	b=hf1bAe23RnozQnu0tAhjUB3aQxK9DC3ZKqqxKv1edz7SZAFLZC5xsCkYpxQQ7vccDz3n
	 bYhamNOzOD1weVbOYSEEY92FWrm1XreXzumQGTdnJUKSso1TV8+mgMSrhJVzR3VTDTKT+
	 gODDEAXtmq0fhVKIUaPCheXQGUjvWcXqu7DvsrQxVvANN4u4mkqwIVQe33wXS6XN2etI6
	 DIwbVVXCDfa5070aotbSuAIvsNrg08ze0bq3JBGlPLJBXNhGbjkRO2c2zuGcgyJkFQaTW
	 I8cPTkfusmpltyNAkEDxnhfpNDEbO7bk/p0n1C46pEhO3Y5M1uiVC3DWES/Vd0r0x9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
	b=EYzbwredhmY9tSI3ABEgVkNJRsxEsfHlSNh4vohQl4RGqI0QryljxaFUCllrXcyIoXiy
	 XIOn2tEzNoZGoFG8aNbGTWwzQSb8VfSnhP5SAWnLLPAHGpP2xWQV34xPXInBGaBqGmDTr
	 5scPrAOFFSYaeXWh2+uUGOtPZuIUN7Ow+ikNgGOONydUzAfoL+Aw4Df2yf2BGVv9hZIX5
	 Zk94XMFEPJoqhji/x2uexJW3axPIPpU+fVcefXgOcp78HjK7aHuGhQ0tu90Xzb9w1JPjy
	 gvADE1FlIuNAydba/zzEllY1LP3A4iNZz6hEmTHs+0+g7Ycd0I5HFiOgd31BOrrcB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD860A260D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FD860A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9495d543b91so53679985a.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640213; x=1795245013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=deoAJpuvk5/EHzr+FRoWKty8TA+vc+0SUXmTiCKtNa4uUcimyE81R96fWgRz7/nC7/
         nxOrejc2E0NpG+giC4B/bA9RN9+l3poG1jjFyoVlP+tK1N4FUjhnopETAblwvEegsWoC
         N2vrbbw0sLOK+/H4lTrzKguByBIJzuZwK7nM3cHZBJXYMU6oG+tKG62dAlm+3g1Cg81f
         VstGy/u/BNv0z/ag+mwjSrVmjQoyz5R+W7jxdvdz9gY8a6SZa7GWQvZDoyMKi60knIWj
         bNNh1qF23hvGxiMH1MoODeCtKNf/Hnaz6wjOCTAeFWZ3TQbm8zBv4b+McPCHHjOM7T2S
         JqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640213; x=1795245013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=rAVM6Pv/3Hesd2kCMRzmUKa+NP8aJGAralpwzLvHPnhCAexA9ERGlzdvSyOZbuRci/
         uMo+p+ZPkFlFoQv30PUpF4PfhNlXQzH+le7JWB3mIjrLKAxgmGA1cniAqVAoYeINEFri
         xzrJmuhU+trCF+o0zCyMwQZePx/Szj4YIS7pXgcCCIn2QYpzDBsCGjXmRT50DjtqKgri
         gBDR01pPVsTfEiqQuPBriBUlUOFhECXV8uGdkgKi9R1F0/PAMDVPWOWrc79fqRmAjSFb
         K95fnGFZG/ky8rq4mZ3soJXj/Sm/hkiSn6Jz4crFzlIYxq+2I1aqPgcyRBIuM+/uTLZR
         M1nA==
X-Forwarded-Encrypted: i=1; AL+hErGN64ZTt5inrqCojALmtFq7O1vNq2HQn8xLmAj9AHgq/4x7muL3PprCOS4fNFSUxNqY7QncQ604SA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fnUjfdgVgnVpzYR1ihrCuTmXVen+LY+R+8NASrouJZnhYnqrH
	4EqeD0qmjIsRS8/uO8FVaxs7/uXprypzVdG8x/45zKvjUXoyZTQQ7lbAwT2/M4s+M4A=
X-Gm-Gg: AYBFou1FubFW5iG5VQlHn84OYBdCKKQJLlVXolTiXszgwe91d9N+T7k/wkhM4Zph9an
	DVLMD92QUUNCLoEZIBfInn+hrNiABNSnnKyfiRHH+A6zwNTQXQQaRlk7Of7VYengl2Sn/JrI7pO
	6W0cArGyZ6QEgVcObJpqQ0p5BA1o8/jI+lTY/3WhIlHwjyo7QdH+cHY68HQm2HYWju7dJDp5LF/
	d6mRq/ucL3qb9cuCJ3DkSKtE8Cb03rNcLShqneL4NWvG9yWLOI9P794EKegO0YM/vdgVF23Mx+N
	zE4W/3ZG7wTqRuGEwcybHD9ehS1CTXLSHqHKEoUPMxWzaSZoAp26/chf21GpjWNVATeyl3Y1QqK
	Jd5FfAEctcLabhoFKstPBi5mpp2hzAxm5iwOF07fLnrSVy+oz9JuIG5jjcti3RhWIdrVewNf0es
	4fVM4s42lUd+o188rblNMccR532i0DB/5k/vtr3oIDuAOuQ/hseVPkFnWY9clcYaXkcKFshL9V1
	UmgdcO1F2LruHmP2JCPQSpreP9mvtd9EeYIUgH/u7TwArR5oEyq/GNYyttziH91V06zmH7k/57/
	16eVD1d4htcHt5zBkbmHELWrHF8K/l8YyM76kQ02cgtmKOkBMhD9B3IwbZTZ3J/gEZmmj5GJbWb
	vzdCrMMzbIMHofXg=
X-Received: by 2002:a05:620a:7087:b0:949:402b:f18e with SMTP id af79cd13be357-9494bc7e777mr835710585a.66.1794640213010;
        Fri, 13 Nov 2026 23:10:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:12 -0800 (PST)
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
Subject: [PATCH 04/22] mm/page_alloc: build zonelists from common memory
Date: Sat, 14 Nov 2026 02:09:41 -0500
Message-ID: <20261114070959.3490008-5-gourry@gourry.net>
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

Zonelists decide which nodes an allocation can reach.

The fallback lists hold every node in N_MEMORY, and a node's
__GFP_THISNODE list holds its own zones whatever the node's state.

Ordinary allocations should reach only common (general purpose) memory.

Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
zonelists only for a common node.

The build_local_zonelist() refactor lets use reuse the code to build
a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.

Every node with memory is common, and a memoryless node has no zones to
list, so the zonelists are unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ffa972811462..580feeb608b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5906,17 +5906,14 @@ int find_next_best_node_in(int node, nodemask_t *used_node_mask,
 }
 
 
-/*
- * Build __GFP_THISNODE zonelists
- */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+/* Build a local-only zonelist when this node is eligible. */
+static void build_local_zonelist(pg_data_t *pgdat, int zlidx, bool eligible)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct zoneref *zonerefs =
+		pgdat->node_zonelists[zlidx]._zonerefs;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
+	if (eligible)
+		zonerefs += build_zonerefs_node(pgdat, zonerefs);
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
 }
@@ -5960,8 +5957,12 @@ static void build_node_zonelist(pg_data_t *pgdat, const nodemask_t *candidates,
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	build_node_zonelist(pgdat, &node_states[N_MEMORY], ZONELIST_FALLBACK);
-	build_thisnode_zonelists(pgdat);
+	int nid = pgdat->node_id;
+
+	build_node_zonelist(pgdat, &node_states[N_MEMORY_COMMON],
+			    ZONELIST_FALLBACK);
+	build_local_zonelist(pgdat, ZONELIST_NOFALLBACK,
+			     node_state(nid, N_MEMORY_COMMON));
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.53.1-Meta

