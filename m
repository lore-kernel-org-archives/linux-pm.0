Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640224;
	b=FEetSb6I3Y1hXviOQaKqTQo3mFhyr80JFs5iZrdErmqQRqSHg2nvnrCCshObDr6Tt4Fb
	 gBIfeHE+n0jzoKsBro49vACrG5CI3UBgxW58Qpbqok8jxcvpCixxFJyGqo/0dulkZcWQ2
	 gpsshwPSAaMYHrBdtmulq4R+Li/RBE8SGZ4nbYupuc0FETudpHHXrhmJF50NeYqEU5b/1
	 78f31WRQW/N9c2sfrkRrC/hSADruZ0igU26AnwEFgmIDNcymDCTF72UYXET/Pm/XUwf8R
	 1rEhDwK1CAmprVylfO33uZnC0lyxruTGmUJ9sZXNTuWpI1k8rdJ674kHSgDdEBqe/qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
	b=XGCiRjL7HAgtL0VyDktWqVyfEhjddmP+Pl2fRF4IuP7MUY2oGE75A4H4e1JuVo5XU0nY
	 yZ01TofOuo+FAN9rSgZJSAPpc5b1DGTxLt4wm31oVDKCx21Alivt2kNodbtTke/y5xbYC
	 wfWdrRGvQsjZ8O6rxzLcicvyrIPgiAkopVY5IqmvQxYEypwdEYSDX5FyPXG4FPMSQafe1
	 llpq4a/zao04N7Tb5rK7jJiiX3HqyeUHImkYJnn1lZuEG6XZwAclRaLUemx37+ZQVOuLx
	 GuVJKeME3ZANfSG31DRW3iv0TLVh2U3SQVYYLa85Mz/7R48T5CUsrusgBWvN9o6lk6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB560A5BC8
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CB560A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ea2e29d90so38111976d6.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640223; x=1795245023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=XlayBPV+6O94G4EvOv/apyiTo3m5/u93nKnLcvDMZ5IZPd0h+zJdRRruMsVEzi3WoC
         z+Si2hEa+Ua87rapVuCjiDYM3x1e6qBeqGGKaT+0sgS14MzxbWyx2Ucw9pF8mizmV1OF
         i/t/Oeuq2KCow2Q0aWnwaQcVV2jadem/GeVnEOD0NFZfkI+oaWFfXNpjKd+lsCUarnli
         6377+lF8LMdQhAtCoZ7vh4YMKQp23DrTIh9X0RMqS66GPLHgLk13lDoRAz5VubUIW3tN
         IQtaAGEJaTre22tDiHAkUzUrRrP/waHscFQx+6pylgrnkPGeI2Z6Qg3IFhDHNBbaaDlL
         nLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640223; x=1795245023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=F+jkVrMIPi8XUaXvPJ+zr4x4Y5W1vB6mjC1smlQduGMRlzmbxcSOcdRcCAEZPiug80
         LaBo0eARdZ8wthq1RO+PoF7j1iCueMTTOdAOeakaE79dkI2LsykEyPFLwTLBTLiwbOsr
         PYyhNcncH/Gd2dvDvpmOKP5TvHsfD/CJnXKbQhBhOqnBx97GRpuATVUYinIdJbAZlFV5
         db1vCeAFNf97SbzJb1X0R8zmCV+ahb9BAYZd86SEX0/kN63rSOkhE5Z+NCDJ3W+I4sXu
         1+dR3eJ4eDeo2S19I0YCyXe4rPRqNt1LD0K97hIDie0Qitp0qXOFqUhkss1dKaqN1Mj6
         ViBg==
X-Forwarded-Encrypted: i=1; AL+hErHqh8X0S9jlnKWPgfKWifsmBD6e0tlNB+OLkXTGAIo3SEYb43bYKdTfnvIYiG2Wlsv/q1pTgpl8Lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+jbLXHs5v9zWo4kiOOSHL9yp3K0VohrWjUUePAKPc1iKurGH0
	UT60FadgZR2WO9h65JeiqgEJd0QtkY0c6Bu2rvRdz0pwOie5Bi2mzWyn/lmv8GbGj3k=
X-Gm-Gg: AYBFou22HVB1CT80Dr6jRbYc985eockIB/BdAGEqwvcL+yHvZ1fhi0Fg6ibm3ptv1a2
	oHgCTa26ormWwvqAV4qvS6mOGuQ6G4VVn69e+9CXh9w+Kw/R7aiScHg63UqCu0iCUY6R8AEjJXs
	EXOd8qhVz4IbV5yPd0TJeJUY3wbT2IHq9+B5fWD9+Lwd3gu7xKGoBVKfSOGZLlwwp3a9xZHPDDp
	+282pR+Ip+0s0QnGyFcTeBbrFVD1V+7dKLIbZ1NCvVBBlffDucZ44yTYzTfDi8Y5dL7gPn8WCJ7
	u7qlv5bCBJRxiNBsgHfLcZtiAojy+8Ok1L1DOAOAE5+2GekEBpSSx3Fld4NzM+/3Rr9DQGPYFBg
	TyVJyTczlKaP9c8vP4WGQ8fZzw1Q2voVmVClq4NDSlLbNmGoKD2kCFD8plXe5zkGb3RtFqCiym5
	ezTYiounbYYOoOSPSFDWXKoDq8DK8Pxrrt/hAI/vC/jbd7flxWIZpDUuMbZQBYU8Wma19CKcO8g
	h9hVs/yy1fDKl6kjAdxZMlk2KbEDFb+cwx04AraEyBAcHWuSqyJLT1C/7Z75m5N1Gmi/bP5NtSf
	YCo+iA369NvBSI1j/Q6Ug0BBB2moYE451uApB2acgJ4OJcKM1FCb7kw6lqSKvmJOnMnMnJcgV4O
	j0D/LVxTGtA3ahVc=
X-Received: by 2002:a05:6214:2462:b0:91f:3182:e94e with SMTP id 6a1803df08f44-91f3182ea72mr35908656d6.8.1794640223087;
        Fri, 13 Nov 2026 23:10:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:22 -0800 (PST)
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
Subject: [PATCH 09/22] mm/ksm: restrict merging to common memory
Date: Sat, 14 Nov 2026 02:09:46 -0500
Message-ID: <20261114070959.3490008-10-gourry@gourry.net>
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

KSM is an opportunistic MM service and should leave memory outside
the ordinary memory pool alone - as it already does for ZONE_DEVICE
folios at each acquisition point.

Use folio_is_common_memory() at those same sites, which still rejects
ZONE_DEVICE folios.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 623a2cdb39242..25b2c2f944862 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -831,7 +831,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (folio_is_common_memory(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2571,7 +2571,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (!folio_is_common_memory(folio) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2595,7 +2596,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (!folio_is_common_memory(folio) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.1-Meta

