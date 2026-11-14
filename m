Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640240;
	b=PRDDkd+vedU65JwS7JzZwVSmDtxBrh4mhCsbCPfzFrYjfg8dF5l4Xedi+8MiUuEmhyGU
	 di4WYb6vgLrr+EWN9s4ASdrD8iEyQGIGJjfQXCuS+JcQ2QQ/NMNya0kzjum8Ex8K7xWPM
	 jbeQeW7hcNNTmnmBKriO8U4rqwTTzlXKpw1ovALijM6JosxCOxLgcwcwho46+gUTw8Ua6
	 VQ35JX+vIQrEwdkevgoPl1DkNr3seSspyzAw+wukYYC5sGNbK83Zjv5Wm8UTxQ6VE2WGD
	 yvZAMCaJTrNzgLXqxltdith7alQt6wOOGxRjzzhkrcoXAoXpaZMLa3Hk5T65T+X9Smw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
	b=yLplBV302FkOdo4Fc8YkSG+tNwmmQ9N41I3blpLF2Dqhgu4STxXTNHyf2BxTjwYDoyNH
	 1Y88WCvYcgdKpTQlQtStVXmE4Iy91o53CdrLqWGxcDo7GtZSTlnnkEmzizE7n9wUBBYIi
	 th8AM42wbWOh19xIrpVMapMmIFV7979+AYkv/L4VWCzVkBvAui8ZZbp/8umDyB785ZeoV
	 bGXpVXUrnm4aLwsFxIXoLm0bwZ7jiM2wGMfc02umVIILB6dvAysUvHmJYjmID6qeAv8gg
	 OgZt9zgFcNk3ruz6zKIEnLicuumCa9FXUiQ71rbXixuPMH2YYvcNi1P+luMkkID13oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F70606A8A9
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F70606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ebf4cd218so27850946d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640239; x=1795245039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=Q3DA2nkof5TccLKEKOkpoD4tlAOwkqtDIAn0I7af3oHWDqV3MDanG1m+HE/Hze03RB
         qgl3c5vxWVmkXsR09wn3vLHdDsQxs6n5d5kmh2vSTwdxhuPGurTHI/rf19CMjpalpwLk
         Bat76O/tF4T0TriwTFkD4rF4Myqr5UPy8AlQL4K/O+nVeq1syIpOIfYk8TaDUdAHd5w3
         QDiVsq+WKJug4sgJGFgXNDsZz1FuysrzHgEgwFF25lm8FzKJWbtQrAoKggIMdZvxF0BJ
         30S+RNohN7c+/TVaM/HNeDtJjy04gi9aW1TsyxUlWnJ0PK27ITnaJvWinVawe5+Yuzex
         YAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640239; x=1795245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=h5BK5ARE9rRLVQhyL4xCa+4wvRuEvoaXfi05oNUtijoUVhvJKe3MP4KlK5xmM/B0rk
         TZGfCL0RxoWKBi0BWfKK5cCbmdl9TVQR0DhEcq5RQ8SYtgiBh0C51nupwRZyRmjHZLF6
         B9Y+OEAbsj/X6BiWGs4qWHWkyhgzKjjT8tlCmj3f/3zFRSwK2ELmp2rDYL4WMvOrgZV2
         sCTGVF0HzVVBnEoLcNvykRv/kXUZTG1R4AgmJZmzv9QoLLu3W0xVLItAo0EDZUw0I9Tt
         a4QBa0zII+GxI2Xa+xtMZqp/yqLQheBA50cGbzYzzIu8hhK10Ub49UHH8phUvI4hOuco
         4sxg==
X-Forwarded-Encrypted: i=1; AL+hErH73pjNmtPVVOpCu/Qq82h8+v4USUsxqxm3tEPhs6th99vDXVbEgZotSa8WY5oiyjSetcV3jnGDQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xiN+5OSvFrVaUbCxbX9/JfIDdBsN67tejS3X3CIY3I/ji5JL4
	l73gSXwdENDSiHJhIEA/wtUzRg/EsjrC5/C2MT0kVJZiZfxC4NQe9agCnhSRsj15GYs=
X-Gm-Gg: AYBFou0euSdfliejnX+IQHje/7i0VMPcCEaoH2Hh964Gog7LopFbjRyiWdT2R8XX29e
	lvO04zSZKzx+pc4EycJ0z0ectNTvaa2aK2VZ40n/BKQgsLMJujK9b4grzE72S2I5BwJ3bqBL65D
	CfMgJeOwHkIkpePQUu+E7GhjNjm0V4FdRXwjCsnEfiHYNQg/ZDa/9XRgf26NsfLH0FR563Pwvwb
	aJ5s1RXkwP/L9I30avfhLeh9/a/Y2Nxxvy57kk/SIrXbIsLL3EJatPnjk5AIMB7sLX2ApPsi0/d
	4rQtKYlwxuX33VVD3KwpzjUfdSkUR/hCArd4irk4xjp9CHvCGIkVFO9XtQcpnKURbuYgC4zTyZD
	AznXbOUJ/gKo+TyT5JSHlVapvPq7fRTAT13R1Oc95q7Q/Qzw5F9sBO8mZvgvogzNhLLzDXzAifk
	ke3YTAuKbsqA+NhI8e0WH4xfsJw9bAP14fLTRU3kNVk8W3Z0h70XdKWK/R8n5vHjVK+5TRvagNR
	DhTkVs/M7ppiDiKTREu+m15sADZiEp2P0EhR+1z5FueQasHdQshiyacfFGnnHwgVro81Yju3b2c
	idN9si4oJyeev6ic51i+JwU0yhQ/xcT43gluGAF7ShymvHrFB0IJszIJ8QMHQ0QPmNSXQwG/YH6
	zjbkK/DJyBLlDHGXccmeP2Ayo9VnOVznlNOCJ
X-Received: by 2002:a05:6214:1311:b0:91f:2208:b683 with SMTP id 6a1803df08f44-91f2428c6aemr76715686d6.55.1794640238785;
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
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
Subject: [PATCH 16/22] tty/sysrq: use common memory for the manual OOM zonelist
Date: Sat, 14 Nov 2026 02:09:53 -0500
Message-ID: <20261114070959.3490008-17-gourry@gourry.net>
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

SysRq-f constructs an OOM request with GFP_KERNEL and supplies a
zonelist for allocation-constraint checks. The request represents an
ordinary allocation, whose fallback domain contains common memory rather
than every node that happens to have memory.

Select the zonelist from the first common-memory node instead of the
first memory node. All memory nodes are common at this point, so
behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/tty/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b4962..824f5836b47d7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -386,7 +386,8 @@ static void moom_callback(struct work_struct *ignored)
 {
 	const gfp_t gfp_mask = GFP_KERNEL;
 	struct oom_control oc = {
-		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.zonelist = node_zonelist(first_node_state(N_MEMORY_COMMON),
+					  gfp_mask),
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
-- 
2.53.1-Meta

