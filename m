Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640236;
	b=X23b+KfjEHnyauro44mijnizK/c1boVb6nQR3RFP0+EpKmKJC+2j83Hcmgll8ZcX4tLo
	 GqHN1PBnvDaZtgpy0i0gojNLYA13FUHGL+rob3ooSlN8anTivp7zZETUyiAxtgZFwpiaH
	 2enF0+UELILBaox/V5Qxx6/pwTSshU1puLGy+bUaWXLiNrfF1ovb4uuFtu+/E1bvnPcg4
	 J+ZjaygZVop7jaQfUb5K96GFmvljnQ+lVulcmGIkz6bJc7tGdyucNxqBNyirjukDiMnXZ
	 NfiIDLjhjbliArl965v1mnEvcvIZKsckRNXp2YS0yuebxpUG11adlOJligeHeluUWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
	b=bX5E6UO9dJY+dnES1OdTKcL4vw5OsYUNSDVvCKGjYiW8t3+IGPF0AatIs8MlLRS55mXb
	 jVz2Zb+mfay/A98Zy3lYBt15/YbHdpLyaEsTZfIFsn60B5tr/nK7dRsReUpLYQV85bbEp
	 +xbjiiQGqog8UsC9X+ObNHe4MdPG7n6f7oMSUXhs287QM4h/PnsaO8vOaUA76LBD5PPSs
	 XvZfo1Jt5IcCXJt1bT/h++jCyrclGK12K49PA/c36Ym254GJ4fMQohZas7dXEsFNei5z7
	 SVh18ZvgjdeR8eizdeEIKAIrIEGL005THKUUHt4xIGhRTryl/2xKQ+tvrTc5KABLccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDD606B414
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6FDD606B414
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91e8938fd01so29668576d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640235; x=1795245035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=NrD2qtKjeYgj8rGYN1fwIgSL20IT9bdCQHMOHTKrC9oC+X0gc2vtwbP/0pBFXO/NP0
         HQOX69QwWq4MNb4Li8WvfWTySx3QpG8CmXSfXqHpUcRgG3oSbMC6WqjxDT/m562PtycD
         KuRcCudGGIt3HNVFfi9LLJLq4QR7G6eDIkxjamWnnAZ3uR0790bOBXukHx5SFAIrogr3
         rVV/a3g+hhDNs12AsnzkGTsK4afWNTRGDAIlhg0fF/5oN9rABG187RlzqBsqM/hs+ndi
         B9r6nI/+MN40ZYs8ZXdDilJk4BzjEhxnTnlkpUl5Sv88KAYoSVQ/VQIkHc1QjmG5QWeY
         nXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640235; x=1795245035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=oTN1uMKcisHrlQWllkVMWtaG63IrwjWrBgkhMTfMtr6wmNyVCE0AZVNPE7eppaYL3v
         FTvmviOHkqxEzLpHK186+2wDXzGpS3/Kkz+8uD5TMA9P21eWr/10RsMN7SmOk+bXNLXq
         ZGFywUHh8JI5dFSw06j7Q2SONMmB4PHNpjHr7jNwJsWYTX7ZgOG9Ow1/b+gcbEQuSqiU
         qqOrLlJtCtJMVFCnfJISaWcUvFwiYpJqw6sE2UENYsiwjpfAUREvFyyUEzGWEJL/F1uk
         XwL/jdcz1X8Ias/aI5KfKpELpYqicASZfTFo0MrMBarRmxIOrEfYQUKyLOLekSPZk0QS
         9gWw==
X-Forwarded-Encrypted: i=1; AL+hErGfJ6SCwgzB4jdQbQpuqp6d7rEqP5puzMfEuWzRR34AKsDF1YzLca9XHE9DBYx1Mm11P3g9/L715A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OHpX31feunofKDcGSaAWi5zkEO3xCVJii5nWVc1lrr0LUdzK3
	4gyaPMxcu8Lp4kXpreol8pGkfL1q3N/9l58lrG/x5MmW8LH05yjCQ6WEteQIVQx7PSI=
X-Gm-Gg: AYBFou2TbZ7QbxUO84oyNKpkIliMvLre2nJQavewGGUkWqb5wOP6l5i9deRsktLAxxd
	E4OFYAykYlDvDJZtL2yWmDaaR0IZNgZnomGn06fYwJEpiurRUhtbkqsWOHhgjKIUqcVGEcigW+j
	Ody9OA6qbDncLXbTv3vvzj9u1cIK0JSh/+MTLESOilycu4ESrLoGwWbAgqoHJ6m/sivi/yYxz97
	vbTA/vdsEoumhHPWg9fMEgmdlB06WhBoyeMK94UIyvqNd5N+JGCVbQbITN2ynHtTjvZ3my6Hyba
	nQzPhEJSLQVM/VIr41Cq+ECC3xM9Y4Eet+W4YImKnJdYz21Yf+7hwXPAEDF2ikNwR3WCoK7p/sV
	yC/ZEIaDa8kdR7Hxw5m6YAb4qAfkG+GJ1h5VSSe/v7RaODwcWD57mbY9WC4aNm8NO54ytoAwF4B
	Rfahm2xyHZ4JDWQX7J5A43v1vRcVYnzWb2T6k8dmPSyOaTsuCewZNWTkVwQAgUwLpX73C6XBpMF
	38Lu581vc6rMWbGlfhHfxJm4xcE6Mcj/wM+kKpbTC7CTIgheh71Sm+CxFm0apsklSl41wJNmik2
	v6T+a2soRZ9B1wV3dkkSB/SGjYQXQy7E4e6eHhGR9zp9/4sKht5Q4+P8VZKGarXxImP6vuytT7V
	42boC08XSisfiA1U=
X-Received: by 2002:a05:6214:1d2a:b0:91f:17be:7c90 with SMTP id 6a1803df08f44-91f2424c199mr78511936d6.55.1794640234508;
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
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
Subject: [PATCH 14/22] mm/page_alloc: count common memory nodes for kswapd recovery
Date: Sat, 14 Nov 2026 02:09:51 -0500
Message-ID: <20261114070959.3490008-15-gourry@gourry.net>
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

When a zone recovers above its high watermark, free_frozen_page_commit()
clears a hopeless kswapd state if more than one memory node exists,
since allocations could then have fallen back to another node without
triggering direct reclaim here.

Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 580feeb608b7a..6d98e213460a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2949,7 +2949,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    num_node_state(N_MEMORY) > 1)
+		    num_node_state(N_MEMORY_COMMON) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.1-Meta

