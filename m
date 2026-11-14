Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640246;
	b=2d8xDaNbgSGDxrxUust2xPGk3/gziIGpOl5FHyQelM03lhwEQ6m6bQlTA+rZqEGljbZq
	 PH/uKg5Wnk9Tm9WhH/7fgAvzHyllgy/MPcjHYd+k0FoqocLXUZvUPI9Ehf8WIZ1K4Nmvk
	 squXY9oh5v+9mWFHcfeHNkO1+gaZmptUKwBHtljOH5AtDf1a2EhWeeEGMZc0AREIwL1RU
	 4DLUD8MJntZ47ohZXwLixtLy7Q4Mx/+RLizUd/+71I7P39uuwgzPS/GN3K0Mq60LF/AEg
	 uJ4H6q/6ssq8qa1Bm2ExzW5r6W+IV4y1nWERJBd0u7uYvkSjZ4jRtiAkpnXNuWH3qjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
	b=kG4vwWHfeBPgnm7J5GiRDXi/1VLZ6DS0k0+deZlwBqiYkE9wvrYxJAj/NGdaDz+bhuqB
	 70KN2vUgQkAZ8c/CNb0lBXYQ2vKDU6tIH4x/RVMVHrUtRturAaOWVaR1QrCP1cXRGcSzt
	 knZ4csiC9lQEofdIGEuaVvSRAmo9ACcx+GA++tOFDT/4EtLRXDQ9Cvf7rdgS1Eb4T4IBf
	 cbEkDArLhpsDhherYQ3GkAXYNwZv1UyYNBMdPMaknDtf1E0JyTqkzQZaDzEMGAyepgEYP
	 bJMQSNuWTc6m/fyMP4khFwBL6724BaGNTMiPVVaaI+9u5PSHAlgJ2D0glleME7Ti3Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD671606C0FB
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD671606C0FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39952506d6.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640245; x=1795245045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=vA6Z457OaKIInkkgqCLFmLHWy8VkPxMPUJrmpqeT4EKmn4j55dJGJtm+KTlKszz4wA
         UVrXxbHJUqTl2q4EWTfsddFD0AVrEgctyu7/vealCMDaACIsjVaRi6fltMovNlc/ghTa
         MZxX0LaX68Na8PnWlYi+EO7zzd8dcS8Jgcy5MuKBon/qrGxyjrHOWRez095sA3iW/r3i
         BnupImPHFtuPKI6KKpj+dxkyO29yAsiGaFeOIXhXHt/49b+fLZ6RmF7WRM1rxS8LQxHZ
         Z3iuplIcBrJiSL7Vvv0lbDuimSfZhQq6LtlRDtpKViJ9Yo9UH/x4VBFOcBISh0iqvNYA
         6IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640245; x=1795245045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=xwqngbrtGJ5A9cvEJmjccP2810CBZqh/E9Tk8DxTodtTC+Bu/4svySIr6Z3VSRiZRM
         fKv8OLs0O2obDub1DOWPb3g79GVb9/ZQx7WkB/ApFVd5s47uthwRHH+qoIjiMCFj0dgN
         E/2LtUV20kBW8hgs43G++EPVD5shNH0+B3rCtKqvmEI4rftJ1dOs6g8CtClweVA1rCLU
         jBzrMwMkPv+KA/lFO7aomVohTKgCP4gwPztnBeG0VK5lcz1DgKDwOw6frbPUxPjH13Sp
         AsRHZ7eCU3dbER2dJkBehXTHXYt/pAXbeTZmIURWxSkxhShZV4d/pJRgnO0V+ozHCZ3H
         BEyA==
X-Forwarded-Encrypted: i=1; AL+hErED7yQDrhlMDeEaMEWc1ex4/JDyzPRPnjjg9Z5zbD/x87s9mkCOq3+J5YAfyAQJFVb+Zwctaf74sw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8uZ9Y8TDB3xMLo8ZxWbXwMYi4wi6Byq04wnp3Imrj5N3NxqvXn
	Py0Vg3VFj5cga8Zp8royaSdt4JCM13lytoPVGGnnON8Gck1lfGm7ulyF6aSNZM52Mog=
X-Gm-Gg: AYBFou0jtbbyZPxr0UkIB/L2PIpApyhYc6mr9SzjZ7w/QG/JJqYlBlUe4szjBmSQtM7
	4nmG2cHxstyVwKT1K9yj4Pour9l4BrATY0Ocid9KUWTCt/9wQvTW868LFQnbXJoGrOLly9c3g1O
	GI7zcRNVwkTWjL1/RTmTj6HjYyC9JzmzJS3Z93fAMr+OBlMZuXY9EPWrbNWbqVgFJka5noGyRB6
	kJJr5G8AON57Y5Baxs7vjqcudwoAXyU5XDByz1D6Yi0J3o3Sgl0TLT/4rSrff/94h3zS1IWdGcj
	gfja7UeFm+47HUvLAxywsDXyE8mGXHqhHCO4VAitP6zdn6sFDPXViBj813iag74RQ8NkFi76KQI
	Wd7+qJxzhyEJUHf0XnNH8sQNsufK2JFZZnPcXC1EtGjm5tw87LAx0dyJMfB3mVRIALopDYS12CS
	TfIIbZxDh7upcmsPkUG3BzAQsjil0mHYIEEspo6o3lQhwUs14HJ3Km8y6VhP7wMBQVMP9hDF+Ih
	jtcagbMmJaOPkV0rib3ao6Pba6YNA3Z5Zuc0SViOUfoQE7Eh7gCD1p7xDpblriX3C9qaYv+YSHZ
	3MFS7nmMuJe1TVkB7SUm15zA+s4p73WkAi9cmMLGJait/2wu7aHeFt+4h8Dc4OsQyUcuyGfL6yb
	Ura5ul4RBLnBT65Y=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr70448086d6.28.1794640244861;
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
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
Subject: [PATCH 19/22] mm/migrate: restrict move_pages() destinations to common memory
Date: Sat, 14 Nov 2026 02:09:56 -0500
Message-ID: <20261114070959.3490008-20-gourry@gourry.net>
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

move_pages(2) places user memory on a node the caller picks. As with
memory policies, the destination should be general purpose memory.

Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
the same as a node without memory is rejected today.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735b..fed910c9ba9ee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2400,7 +2400,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
 			goto out_flush;
-		if (!node_state(node, N_MEMORY))
+		if (!node_state(node, N_MEMORY_COMMON))
 			goto out_flush;
 
 		err = -EACCES;
-- 
2.53.1-Meta

