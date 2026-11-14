Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640248;
	b=RFlu1qXCifFQ0Im1uw6jK72G9/XjvCDxKnpXUmKjQ3Y+j9qDMa1Gv0Rk6bUPWnDUoEhL
	 Pugle8cVCdHS4JJizinjYukhSYWhPCU3XByL8ozBG3p6yFgf6RWlpWq6xaPx4PMxBdPDi
	 EA6OV5dgNSpaeYzKaS0fpOPkBlOmsgXntnwHb00zgN5Yaxq/n5V+tshH6tJKdwP/90vBL
	 nt1aNc+QxIiNA7a84UMYcap6mNcOmQ4LQqOMFf//JQ3u0wX3n1tfhTO41dtfaJkkseJ4O
	 Kfbm9W1wQhizj0gP2LPxdDw5/NwkRJE7OMqtzgJLyfbdH3F6Rrlm/KpEulbdnj127dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
	b=BBhgBYgxeIAdeyHAT+nkRl0TDdwhDqJ90vafvkuhyZ8Z4Q+tAbxIwCqxL9PMoaJIh20g
	 FS1DQcjaFpgaSqosK0KQPsQ2KM3UipW6hSSH0jcaumuPZlStFbbqJFBgNCLNkdTF2ckMm
	 v9aazUHHD4zFTvul3Nw7wOrDmqSx5zMngbUF6G8TLyhP76Qk8fR1JK6IfwUyZ1E1y8sCt
	 7zADyx30qbGsJTrGF6P0d9UsWj23OBHr3lFsigX3sisZ2tGGwOKnbz29QH0WDDNQwdsvP
	 8NfT0rc3GrxngMNVoMqNmCHcBynETJqGazZP04EW51LPyaHOGY0Gztb9uimXlQyT4ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209360A3825
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4209360A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94959217274so235902285a.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640247; x=1795245047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=BLBdnt0iRNFdOZZN6B0cCDu/hXyt7k9PsSJY3QJCW3ekKrAX8pBPAbkT3WVRuWwYMw
         zSddppBa0D0C7Cm3/JDK/25sp4KjGdI2ObCcZ3l+uuVPtSgiCU952hXfESBUlw1mczJg
         KHLuORDxaFQGrfgG+HMb2PbJ8MbRDgOlPMNKfZQHAiNb7/kvjLe5uSwFHyHGL1c1Wn5u
         n/yf9bUliz7p0g7CF/tctqSCoW6EGDPz3Wmzti2CG/xreKkeI7Dz0p26HxXLxyI8SqoP
         jC1f5E71FBV3WJAhSXNNIB1HwWVEvPiiJHfQHn1hk40/DTFMdowDbXfXF0FkV7eRjWMi
         Jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640247; x=1795245047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=GE9VgvDA7CQXg0OHrj/ct3BsqJv+USyusKMvANrDbfVfqhjM8kQs4Nbs3L7OPm6dAl
         hlh+D1E/g2YZE9AIaz9NObyBC97H7WOAtmM31H6Qqv8myEllDB10eDtbYexQSglG4Nd/
         zPXUxcr21E8mDUif6cGkGa6wDpNtGgSsSdVenWuIC7XGPtoAXgyWVpjHIzfSDWbmMs2U
         hW7FA1zuUADWvjp/8e3nn5yiwHXdASLHIbSm6YEjMT0Qr0B83REPdsMoZJLPB5M/OgoR
         M1GrPi0kPD7bNM0xl26+suAUC3myShXPQkUgeVBl09Olm+fOPB6rjXEdh3LKGpcsj1ms
         5JcQ==
X-Forwarded-Encrypted: i=1; AL+hErH2b7nGTY/xouBWztIoOIcyzk0+CVFD8lmv3Jb7kgh+U2DkSsIRrG+DjoieHEwLzXL+rXJcYqUhBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fX6Sb+qENAPPuBQ8CvjXkZdmXLBmyx2/WjWRLK/I2wj7qhIbZ
	NlZZ2kHlmxIGi1sUlE2Tir2NPRRWtupPpdu3un8m30oyagxgVciAX5mbElYXdKpTrgQ=
X-Gm-Gg: AYBFou2dtiAorxJWxfraSLRSkR5HEwY3hKvPt8sOv4zzABBIiiRaUES12f0wGtWjm6+
	LBWqRVwfyx8356TujX7HdvTh5/44Pm0jxp79ooK5kyevHFfzHPDhKZYpqdkmrGUWIXHMe9VV2ar
	2qIVdLYHYSl6DtC1S35MfE7mAB6PkACgMYP3dtn350zzSaDb4kPguVHMFdX2PWXlw1GmpChfVCK
	zNHGOqQR2HhlIF4C4kUB/efvSpUAmpgjjSXzy9Z9eTSIG4M1aqzASoYO2YYkLZaBk4fEisorWDb
	+zdW3xu645remUw9cyMUWjrIgG9MYXl5VlNhBnJ6vv4mHQPPlSWDLrBVZQ4GksowNVS/8dt/H9j
	EKZq21LpZiZ5V9S9Vd8HGvGcd3piotxHbRJcDNLMUl5U3FM0156y8XXLppInF6Cfjc2T4HdBZUB
	Mwkmig7/i6864SCb9jtIs81n49S0Jt3p9VCHWeAM8ZaYG7qTjh7uGx/9YxLhO/6+F0VzeiQOHeO
	4g0ne6fC4ynUvDWjbj39oYdg4Y4iSZU7d9qX6JBKc0qWEhK6mxTgFa8JbQGLKxH+vMdOunev2EP
	k68H0mP1l7JwLbCRwzkLJlzMegenSND8Q5nWkUQJNfk81+4R/+5docIaTC6h9G2LAEP6As3ltUD
	kTl9grx3XU79HKQQ=
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-9494bc76c5amr813866785a.68.1794640246800;
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
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
Subject: [PATCH 20/22] PM: hibernate: size the image from common memory
Date: Sat, 14 Nov 2026 02:09:57 -0500
Message-ID: <20261114070959.3490008-21-gourry@gourry.net>
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

hibernate_preallocate_memory() and enough_free_mem() count the free
pages of every populated zone as room for the hibernation image, but
the pages used to store the image can only come from common memory.

Count free pages only in zones on N_MEMORY_COMMON nodes.

The image metadata estimate is a separate sum.  The bitmaps track the
page frames, and every zone's frames are tracked (regardless of node),
so that sum still needs to be calculated for all populated zones.

Every node with memory is common, so hibernation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/power/snapshot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2eb..8aeb086a3fd3d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1866,8 +1866,10 @@ int hibernate_preallocate_memory(void)
 	saveable += save_highmem;
 	highmem = save_highmem;
 	size = 0;
-	for_each_populated_zone(zone) {
+	for_each_populated_zone(zone)
 		size += snapshot_additional_pages(zone);
+	/* Image pages come from ordinary allocations. */
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (is_highmem(zone))
 			highmem += zone_page_state(zone, NR_FREE_PAGES);
 		else
@@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 	struct zone *zone;
 	unsigned int free = alloc_normal;
 
-	for_each_populated_zone(zone)
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (!is_highmem(zone))
 			free += zone_page_state(zone, NR_FREE_PAGES);
+	}
 
 	nr_pages += count_pages_for_highmem(nr_highmem);
 	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
-- 
2.53.1-Meta

