Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640229;
	b=ndAVju/KrAgyn1M/eSce/QrRUWWPeJLEuWWQsSZuW9AgjV+JpcvHjBErByNHSaZ08B0p
	 LnHEkOM3xdkoMWY5EOA9FtpFET53Jn4jw3EMzItq7eYKW2kgHQO7ZH++OlIVebantbD71
	 vK/459k1Erpv3t1tA8GyLa90ZgJ+kjNWr8leNJTGaXpFsqqNQtDIyAWJTBumDrjSaQ5W6
	 Q7aT2pBT9hCEzn1iv0b6cmK6McGgg3x0omW6iAvA5BmfbWV9Uk7HqQcTJTIg9YObWgSJt
	 z4IULGWuruvp4KAdBEta38Nc4UG2icpvulNIrF02zQ3WGQ0i4xsLS/0BsQCzYQx/UKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
	b=KUjH21QhWi2CxQpU3C8YQdw+/k0zps7l6QUe1MKCIm5AGmGh96hPI1uqPxxkzfE3/IxF
	 /UCJqfUcC8n3QtAN02LHF7nk4ySIWWAXk+COQOz2OXcCWhSwKYM2soeDaphYT/t1X5O/2
	 d+MD8m4uken/18zlJxNyiqI+rRcab1b4umoQiAjsFBGo1TmIOIjxFmSnwzzyrWdcPTTXq
	 BY6wsyTI83/pjjx2TzsSblUZj2QUyhgoFWlYTyRyCID4hrRIrvMaT/Vi9PZJVRqcEGJXA
	 bmvT751UnhlyY8Y+brbxY3CzGaLIaB7a4vI49m7f8XDjY4egSYm1UakwIad9Fq9t2Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2F60A6F45
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB2F60A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e8938fd01so29667736d6.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640227; x=1795245027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=e0f1NE1Exmdl9VHCTyMwen0H8NFFA5ewM0qJqz9IIPFvpUDfghWuuQsLrxK1SzRsz7
         hUQ5k4c56+KPd+CCYf2/vIqRWl8gHz2BKZUrM5Ij4T2/PSEWok0NnE0FUoNCiSoWO8Mq
         GMGUsUR317UBvVBakiAaXs2gi4djBungqVsPEPVmsCYYKAXaOtbrEV2mN7H/GYUItFZG
         FKQhip0+198HqCVpa7oWo0gCnkVC8uPd0d1wG9uCGO/6pyKs254gzQjdaZ9eM/glICrr
         l+E2ixDmEv243sGYSgL1CoNQGZsrUgbQgXYKwaNyBH+knN+wWZHgnaTTI9p959iurBvU
         zUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640227; x=1795245027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=t3eGfTJHxQpjpHWQBaZ+2He2iXZ5LJXccclnElbB8wNdDBllNEJ65khhvnCJccMkR1
         Onlvn5BH5IhBT41nXKUhL6Zjw/IvmWXn87SNWvHvRrJxzqmYwIQ10WhEv9F8qpaxOp/v
         Yq4WBkxDa45+FemEHNXmvJdF9w7kEWD5qIrf7ShFRInpliv7MFQ6Or+q3Ocv5OVeC89L
         AdIuX102vmJqqbuVUqO4Itc6MS3vaeX9zBgf3d7o1vtg7vvqYfhO1lWGacCv3vjJL3lV
         i/K6BVCxB0lFnTAzeAQ9Y0q8oj2735Hrq7L/yiqo5dY1SSd3/+sp1Nn0vbpJIAX5uQmo
         fB2Q==
X-Forwarded-Encrypted: i=1; AL+hErGgjyVjbPLfhgfCpehDoEieEdQRFJRfw1ZGT+jOgJIDe68mwqwOkvrxm+0dVkQZm0xkn1RdKAWRNQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cY4sUYYwZjNHAVgDhw1u0DggrMWFusqoAwf1us0zFP8zZIvoY
	y8kQPNbpyqyxvALTl16W8+ialxecw94qAiEd5WOjR+TE7lj0JZY3ZnFvFrdMT9ta5wI=
X-Gm-Gg: AYBFou2/2/5yh6deQzhO3yLQG624bPVMX0kZjo6AQEGqbWfzEzSqeVTk9WtVE5V3NN9
	hJ3vHzH6Q7g8H+hqU2dH9yODEBeVMpvH6xWbI+t4n8auwWPwu4w9GpG+2skwKG1NdeKKxpUGbF3
	/YUo7Sz6wF4mJATnGSzIWv/O6z+UchVEyzJ0nL1TYLFxeaYwprXAoFz7oE2sB+4f5m40tjaV9vE
	dPX3il9zLrQgsL6sRG9Y5F4ZltzTtQ9vWtPT0XV6blmkR2hojI6g3IieM8PKt6fIlbj88amXb0O
	F2zTgEgEkIdFHSyzOeHc8WY1r4qoj4CnrqSzApzkl6Y3NSgh9x0dBTud4SI2TG6Np9ljP4j3ixO
	d64V5t2fy1H0uC7xCSoBacrOnWwq54utxuA42reYMFlWPG4DQATxMnUnF7elk/yKdmI1vdmc4AD
	oeO4BE72PYBq5KPmALpdv/CKk8kGl0c4K2TG/6jtuWur9SvCvrlWjTDj938hmm2BI0H7HHy+PfS
	wuiI+DIbOQKKJFZGurqLFeTO1UryM56RBTOBIz84e1LmHrAxEHdHjP7WWOyc9HgGrAlAmE5xNYb
	VoUfdKy5cJi52kTz1wdfOOZegMCYbYLKX2XB2QWLwZvd0LtuvywbdIIwWJETL0igaaBcFBamanG
	TwpqqiDgZZj+OtWQ=
X-Received: by 2002:a05:6214:dc1:b0:91f:1bc7:b779 with SMTP id 6a1803df08f44-91f24251f4dmr78714166d6.56.1794640227399;
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
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
Subject: [PATCH 11/22] mm/mempolicy: don't NUMA-hint folios outside common memory
Date: Sat, 14 Nov 2026 02:09:48 -0500
Message-ID: <20261114070959.3490008-12-gourry@gourry.net>
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

The NUMA balancing scanner installs PROT_NONE only on folios that
balancing may migrate.

folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
hint faults on those folios or migrate them.

Convert the zone_device check to a common memory check (which includes
the zone device check explicitly).

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 662ab420fe03c..619970f0eb954 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,7 +863,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_is_common_memory(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.1-Meta

