Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640250;
	b=yq8majj1KHuw+PLWa5rRDdzb0reO+sgJXLBjeOb8Yv4l0gpM5mR5iB6o/AsqWuYzAUQZ
	 6r7WMbM33iDJJ7r7L4QobvAWesgvviAz5davRZQMK7RP5cZe09HrYdeVkQMcPKscuas6y
	 IHmqZpGJjGW7JmzNDz1A4E00FBUDPRZt2UFtveOJjT3mrbKvv9PFHu89svtm3Bv7dSbyM
	 6/VG9JMgAFnw7wugf3c6dkOpXSYQH97XCp5u5V/8984e7cPcUYS8eawhW8Xsjucw1YKW2
	 4dmN0m64qACfXzCC7zXftusEbBH4+N4PPEOEJ6xVAZjvXi1IYNAYuKUUWy0DR/supaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
	b=jpdKJw8UH/MrUSz+1aqyW2WZFHuHBp03HnXiikBBFhWKeGA0oXN82uxs8FL+5L8bDMEW
	 pCAhTvyg3Q07VJ52asnI9Zds2dLWZDDBM8OrDNTP4vQzWAIrnm8kA9EYuL2cWlZWWXQ8X
	 hP0q+0yDok05PoFiH8upVUpZ6+J9AM7f+SZh8QHNeahO65L7FJGZTAjmY4GLItvqWUNg8
	 sl73chpOFxcngPpg1DCG6y6QMW35KeG9geHpEUDkOrigmUZ9diXLP4sVKy8TFzge/K2KS
	 p9l4g7uKBORZCz7gONaUxXQ5+OazmTcDLYAnxbcC60WolqfU3Nv+1AwzBflXx0yRAfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DA606CD9B
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB6DA606CD9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ea2e29d90so38114886d6.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640249; x=1795245049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=nUe3qafv9syivid2So3rSgvuH7DZPXQ+C2hNnSKPxSgCSgNstQOq5ZauJDPuC8EzGe
         EPc3rvJ8i7VX8Vx4z3rdkuz4b5/v9ZapBbQpvdki/go/ijbQrxbYSU1NDWob3cDW97LD
         LnMvjnQ9of22Wo+EjgkaA7b+zyM2DJPnxYp2a89EeFLotBMzHlXVjFeFCTHrKTeY5NcQ
         91ghXJtB51aOfQmHtaFyRmryRQlu5a3ABAK7+f8sC33jgP5MHGfXKYht3G8gkN0Q90UI
         KipjlM6Ftuf2DaQAouZwIsVVWwkNGIDa3kAx+zcyykQArICxW/XrYq3vejy92XQ0eKEp
         S3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640249; x=1795245049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=qwaKavudTaW+0Ed7a4N6l7F0DEF7WeV32zx7MecoNvEBCC09GsUOZ+o40RtjoNMYF8
         5Fh9Cx57FYEjELFfSBjZc/OY5MEYJvbyMW7RZ/5tCixRAHKOH/ZjscQl4vZ0xm7zfoel
         Jd7602Q1gQt4hqyF3TY3g9Z0fzfnL2f763bCbJWMt5iD6JK/AqlsAPMR431XAFcLEjsN
         Jl+sAX2WS57PkD3lPFj5uaN+1ALsUDPNSsxeoPjzQWntJak7nNBQqy1L47gv3v0OwU+n
         fsYxSGz0nOIRNkjHRf/mLO4UUfKHBEOP9t3hYmpCv402Bc03nOYDI7C5YJ80F4SR54PR
         S1bA==
X-Forwarded-Encrypted: i=1; AL+hErFzWWOe/g8PI35xhfDhpMH71FSl0h8IbqnPdArILsd610npNK+MfD1Kl5USGt3K+EG4jhBlqyE0ag==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nXXxCMfSnCWacq7YFdeP3rUGwmvnskF6T4BVrIsLTBj88ODJG
	WzRFWoS4UN4VkPAaVpsBGDqpuEwk29kKVeMIttPMifvFfwt6YK9E6ZfnyQ8ILY1YYj0=
X-Gm-Gg: AYBFou0UShGOLeRUIZnF+1zOO4w4yJLobEpkAG9I8+EMkpZjQXLq1orfOjKW0EGePZ/
	3zRCFnhPDpBLoQbP/wf+6Jwl4qALcfaYawXL7jXoB/GsXqVHmBZejA/kZbyOaMpReHSGC5kd1yx
	6Yu3atVOrMeVAQuqHA4mCOgnvhne1MXtbykfEcarw1Iup608gCz7C3A9AVzFoPhIBolknTjrRae
	t1P+IpjWrRvi0zgjCQFVKvLnIcKVj4O+cCVC55KFTN67c9OZuVr+WFpeNIUUpcAzoy2gRzcvAX/
	UbYHd4j9DM7MTU8ylNK11DDJJtzD2rM+LK50nmrb4zdoqf0Wz+9aR0kDFOlxyrw5hO9hTWNfWco
	0sb18Uykktp61EUPkri7zk/gBydrD09AJUVy20QrdKQ+lIPLw4HcD79zuBK2+V4d0nXtkBY1J29
	xrLEZ3mFhZjIMVMeXN4D4rcjzXYEj6ZmtnUl6Na0JlnR4qhKmjRJlCAkRiwvW+DwL3IKrbxjmTB
	fKrAlSbnnboDKgHmgyxMdyQzX4/6HT6Mvt20pOywvPdUFi9yyRFCFSDbNV+4O+5DX7AOstoBUeQ
	PRJQpZmtXyXM0CbPrb77vq1x7zWkcYCiUQJR5+3Qgz61EuMcRBxwNQKRVF/+oXwAtU9WWKjtp5t
	LqwpEZzkGVy/FWcZj
X-Received: by 2002:ad4:574d:0:b0:91c:913:462c with SMTP id 6a1803df08f44-91f23f211e7mr73834306d6.0.1794640248788;
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
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
Subject: [PATCH 21/22] mm/khugepaged: base the recommended min_free_kbytes on common memory
Date: Sat, 14 Nov 2026 02:09:58 -0500
Message-ID: <20261114070959.3490008-22-gourry@gourry.net>
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

set_recommended_min_free_kbytes() reserves two pageblocks per populated
zone to help THP allocations avoid fragmentation. The reserve serves
ordinary allocations, which use only common memory, so count only the
zones on N_MEMORY_COMMON nodes.

Every node with memory is common, so the recommendation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b4bd29f25c145..fac314b89a234 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3149,7 +3149,7 @@ void set_recommended_min_free_kbytes(void)
 		goto update_wmarks;
 	}
 
-	for_each_populated_zone(zone) {
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		/*
 		 * We don't need to worry about fragmentation of
 		 * ZONE_MOVABLE since it only has movable pages.
-- 
2.53.1-Meta

