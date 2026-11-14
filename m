Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640227;
	b=NHO3+l+2repHAHKr6c5lgnbSwxql4wbdCLlfc7LNheRbATdN/XOLCEwMaz35HHr1QGhx
	 A8tQTPCX0/oqb5gW9FJVnVtjW5qc5i9oCqAXmK6XzKd+aemi9QbvvuRl+pjkR2X6+1kEV
	 5ec3dGb+58kuklgolDXZMP36pTZJH6upMQmo39ne7vkQbFhoZvdS4OLVZLbOiElkTfL7T
	 4PjCJEFufZdoIASTqvnKR+0mAogH3DpVLT2PQC+ENJn7DN5bo3OxrTdWWjL1KITJgcRkd
	 DuBomotb86M0mBz/sHSXQD9W0HLpcDhDkyYRD/VA9d8yaOSnPw4B4CT854tqa7UT8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
	b=rDzfVN/FVNkw9IYDVYfvTptY/vPXZnUcp27NXue1P9sq0YHDO9YYuLUrZICIvYfUbd6T
	 /Ef5knAL5gYBFJpklghCuR11XQi3U7xIJXbu0shdOvkIg4tE5LnvYVXnamkPFK8dtx7We
	 wUAZvIqfXVQtb/UpzBYt+pqPvMyOPFHn0dJVQY1Mgv15TgUG8Fk2Z4hjWJXGLs9y8ERvH
	 rNHjBd7Q0uDxjarkuLdhkr5Ss39WpU5clEd3clCAg/xjtGFtPB1H34FZWr3vBxAgQ0O0i
	 7p85GCnDcNdatGOQIcNlOnOO16jZYM/03RFS+SlyTPaNrOMwSWL9wVPk+5dx6UN3a6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1639606A327
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1639606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f1e3dd08cso7449306d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640226; x=1795245026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=Wak6pwPFiUkKyhQgMf4rS7ScgYnhLHPu/BQFbJsFq7WKKXSUOmiu+EsQFsjVZ8zFDO
         FDrlS7y+5O55UEGv/kTSaX8dffsOnEXEa6/2U/GCtWcFwv0S/O1x4yRSmj13AtftFa/d
         2LHhZ1Xzh9y1vx57sBVWmEQqxXZeF/gRFDaivKFbqeTHuyd1MOWBIFDDx6qnA+nzwI3j
         f0FWi5bqe5XptEAAFE0ZLXHTalZ4ObmYUba1bTQ7a5ucsWoZ5b9b8qD9ay1zcLACOuUw
         HN4jHEZ3DD/E9fTfoTkj/qDM3H/u15Vo16V1SDswP6q5IvcI5vpIGBny10cK9BBE6q/X
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640226; x=1795245026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=P4ynwJU5oyprU4mjv4stcKSx6SsH72E3ND8NqIHXckb9wPHtqX52v4LhA9QnKxdiGh
         A/kHdyho4YlKBFYfp7XEI3njleEBlUS4n48bglRI6QLbbh4Ut+8UB/1QXYqNMoQDZals
         uwnTuLol4c9wLDSS84X95Z3WwOzIbZ4+0InbAnEsXManNsB5I+6u9Ycipmh5ePwNXd7N
         Es9E5YWEwpdzzgtT9CzTjY00jWfoFs7y4J9EZq8IUHVGC1LrI4GSuFxdp6h4jlYbZGtW
         +Db0KxBhTWBmplirHLA/60an9e/yI1ovpKWlLTHfUDpi5s+6yPoJRV8JGwSN8DAfX39S
         nLKg==
X-Forwarded-Encrypted: i=1; AL+hErH+OiaTl5Zkw0G0CiTkgrO58cvZE3dv8+ZPP/XF4YSbTM8rqlsX6rlCc0a/gBuHuXTDCvNJsV/xqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/9H5Cth1YAS+Bm5On7jVra7T7KJu8TqM8Bqey9mt2nxrzr1/Q
	CoHZ69Bc7YO9de7kS8fzWr4lDaJ2MA3LiklMlgeAyX58mhLf2/9FEZVbc7wYS1w10C8=
X-Gm-Gg: AYBFou0lRxltguZoP9qGp6f8H8410R0/WpAycxVyNq4l8Raz54nV5w936iQd4MxLNT3
	KnSNqn0XMEbe0QQFQuDoch8pokL+BafeQA27e2FcltWvibci8PVoqdJtWbHjtZy8QVIEWz1x7y9
	SrGb/9Kf1SIHzI1L/5zVMv0DvV2zkJet9K/cDW1b0JpN+mJr9rq+HRS02gEbvFDIvBSN2OE25x4
	qLpvWPtIYc1Um7Y+6/Krod7rdfYLw5S7iuFp5lBfeaePkUQvPCxkkIOPr4Oig5D3b3vosVatLSD
	ddE0O1l5nPYvtVdKNulaad1ObUQCzvoaQF9N/sxKU8Xr8BAvCWlLo118hwucgDA2mjTDvB1NnIy
	F6J6eY7Uze5155+fTQzK2z2+L1Tf36zhgMVSA+q/x0tLm02WJnpoC7J2/3hf/5hI4kXLYjEdKt/
	N45E78HRdswd2+Es7Jnm92vACKg7985V6b0a9SEh9m3w6WkbzoaqiGhWFBwcgR/EHqCn4Z/7ZsE
	VSr/x8wy5SZk7fnZdZgtg2CMins5bernDqCBmlFAXoX4LBwWhB6dUapdJzG+D9fQTM4mDMcM6LE
	fd+pqHT6L0Nf8yJg1Flh5/YDkc9Mv6RK/eitjq1IgTXcf/OBa8WPdGgatz8v2C1r9Dz/JRkcB/d
	fBciox0uOXBBEvms=
X-Received: by 2002:a05:6214:e8a:b0:91e:7bb7:fd65 with SMTP id 6a1803df08f44-91f24292699mr81332616d6.56.1794640225203;
        Fri, 13 Nov 2026 23:10:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:24 -0800 (PST)
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
Subject: [PATCH 10/22] mm/khugepaged: restrict collapse to common memory
Date: Sat, 14 Nov 2026 02:09:47 -0500
Message-ID: <20261114070959.3490008-11-gourry@gourry.net>
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

Collapse is an opportunistic MM service and should operate only on
common memory. The anonymous scan and isolation paths already filter
zone device for the same reason.

Replace the zone_device check with page_is_common_memory().

collapse_scan_file() gains a folio_is_common_memory() check. Page-cache
folios are never ZONE_DEVICE, so there it only filters memory outside
N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319ef86fa..b4bd29f25c145 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -628,7 +628,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1673,7 +1673,7 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			break;
 		}
 
+		if (unlikely(!folio_is_common_memory(folio))) {
+			result = SCAN_PAGE_NULL;
+			failed_pfn = folio_pfn(folio);
+			folio_put(folio);
+			break;
+		}
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-- 
2.53.1-Meta

