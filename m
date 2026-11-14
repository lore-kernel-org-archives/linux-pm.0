Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640238;
	b=aBzbYR0XM+3fvJmALzNaIhJhJCpHh0hzZIX6TzJw1vIRjpoOjpkuplbGZ71a1eeY7tIm
	 udQB2dRIsZLwk47JVgFfep8Z6B1BiTKluiCHz7HNln4n7/nAkuW6aenpQlOtjNi9Twsgy
	 EkpuP00f1PIT13su/cayMONdwPDvKfkUhHQBzeNzDc1MR69E9BcZEQ/0Ql+KC9LfBc5CT
	 I0uLnr5ePWuANFhBshJaals/x4mzZOUP7T7SySXoIj9peyIt+GxkEfvfxDs5ov24ZKe4U
	 kgtEe6Arny4SeOf0LooBg/blpTEt7nZ2a4k9jH0EcEw3SWs0nW+WmtAyYesOil90yTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
	b=JbVYHL8oEQH9GCgKvuYSttKUfqYFW7FcTqHz8kCkjR+VtaS4v41YmcmjfdNXn2f/QCEh
	 +yk/yHNzRsYyrWgUaUUNvKzEjpjjZKv8x0jZCH1toGCTqkl6YW9gp0X2c5pzubbqVSb8H
	 k5ZllYKqm54zpmsAV39//cobQ8pmfa6s1rNKoRAsUd94N0BsZ4LG4fFBXkp5Qou7k1SKr
	 Mlgwn0bTadvNnIG0XyarXT61x6w75NNQxrz/shP/Vd6w7JLgx49mzJfC5bWAKJWN96mZp
	 hnI6aGLDLxAprGSwbJNWITYUw7TDdP3eVDjwc7lnp8Pkv/2fAQXnq00hFIMnjZ0xm4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B5606B432
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8B5606B432
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ec2d42231so30642916d6.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640237; x=1795245037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=SHqBm5ifuCi19eDdU6VNqfmX84OjLjh+oaxxPBrlTMKU80mySufaDtPUSv6TTq+zz3
         +Co78G47v6fONadDGxWKcNGUQvCgSrwXJFg8TppF+aZFOOUhKhDRDlDN+xaZiBXJsiWL
         7noGrim9jrxIISpyaZ75eU1EtKup7BugNNCXeDRghcA0y55HF5VFSXgx+LF7yGQw43gl
         GLL3BdlC928/BgZG2pu06rv3+OF8ZRWEogeefHb19bWYkkkKNU3yHRNuGBA6IGU7rTay
         OtcyhxTBnFmqdGbB+seDvJevG79lSnyMnw54BDiFQvk2elI7rbEALpd9fiaBlOif5Kem
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640237; x=1795245037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=v4TCQEvwrN1zMelrregOVz9r6egxyKTHIRrsFnVpVy/N4oW/ALLq7Shaqoq7zqZOnq
         s8y2CmrH9Ed45Ln/fxdCJRsWBs33v8sxC4XOpZFnpNZtKLcVwL7lz15dSsrsQ66OPWfG
         NNRhtXJL7JlebBIhCMBN0MXo/F4nFM8F20pDMku5OI6+Vo4wOJH4D/SvO5cqzci35U5i
         QVj8vytMBJV6eDpALMtsIS4lxEVnbGWDPj3pXXv8A3xR0GD58YJCe9DmDjR29/JVi/Bk
         VrIKDwr3S4IHIMT/Cxr4DzL4a91mN/6MJ4sLh09+5CuXbo3hMlRaMK2kXgjRgRqfTcDL
         Dg7A==
X-Forwarded-Encrypted: i=1; AL+hErHLPVW2Y6w6/ItE1G4ssgdFRnyP/4C/OvQ5ZGPLKRdvc71qAnXOBYApoQm2E9to7oGD6uEAYTlYuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9w+5f35z/Y/QNDcCEAp/MU8KAFQaCgAjlLiNiQcu4FHsdKiRG4
	L3WaFute7Z5F3S2ScEzm6uEkY7LaOYJUrRs2ktAfFIA/34f1M8JK3qeR7PhvR6O68b0=
X-Gm-Gg: AYBFou1+2QKkYdKasShAdv8a8KxSM2IlfEZw3SM6Zvkqj0OhcgFtWSSjQI4NDDOlWEv
	tZrgYomlGCPzZ4kSmaNIXbkxQDSaYHmgDaxMMTa7+ql0LpCrwWE/c8GLCfsgqXNfwTusNUAYxSf
	BtTQbHeRx7KEkYnLnkA2xI27dliQD93g+bL0x7ATXp/3jzLle528ExFBSCsMhbjpYl7iBWtXWaj
	RC+DQQ3WoySBomBNwhZ4ST8KIkLrpFamIvwKCmCGzsrGOGiQQL+a8vAgyV9e1jQvY30q/8dB7HP
	mgdcoStrSzlwn9J+z9WGVcYgjPZKFWMC3sauAa6eVoveXK7FJmZZWk9PTYbxiQavu/l3P/lp9Lj
	fED6p3MSEordab2iYqI39sBoUPre9aBcuWBiGBrFn1Xw2QxSAB6kNZKueNm78oXwXuJcYLkF//m
	tXoDJl+dGDMbURrJ+98uimmMYQTU1HUxVoarLRo6qPoIeE95SUGJje+JC4CIxxhzXXXiGXQX5AJ
	xsWxD4RNOEkG8MChQc8WlOPEvsydwEQDUiaoyUPStYu1Zo20GAsUptIQfrei0FaN9p8psGz8FyC
	RzAdKnBv9DWzo4O0YxSzJT0ANW/7ZESYe5+Jwc1YWMezyKvOnVRV9Sj9tsHpssTdwXvxNajs3PQ
	SJOXCuKwM4q73EjA=
X-Received: by 2002:a05:6214:3b85:b0:91c:15ce:66ce with SMTP id 6a1803df08f44-91f24194ac5mr80511276d6.11.1794640236685;
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
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
Subject: [PATCH 15/22] mm/oom_kill: compare OOM constraints against common memory
Date: Sat, 14 Nov 2026 02:09:52 -0500
Message-ID: <20261114070959.3490008-16-gourry@gourry.net>
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

Ordinary allocations reach only common-memory zonelists. Compare policy
and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
neither make an otherwise global policy appear constrained nor inflate
the constrained capacity.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/oom_kill.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27b..1ec22bdad1fd4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -274,9 +274,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	 * get_page_from_freelist().
 	 */
 	if (oc->nodemask &&
-	    !nodes_subset(node_states[N_MEMORY], *oc->nodemask)) {
+	    !nodes_subset(node_states[N_MEMORY_COMMON], *oc->nodemask)) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, *oc->nodemask)
+		for_each_node_mask_state(nid, *oc->nodemask, N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_MEMORY_POLICY;
 	}
@@ -289,7 +289,8 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask_state(nid, cpuset_current_mems_allowed,
+					 N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
-- 
2.53.1-Meta

