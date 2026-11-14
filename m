Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640252;
	b=o3w0oUuIU979mC4UuCNYC4AB+LRDuL45XwRcm2uftKR1cXNj+nHHZ0dsgXLzoWHUttwE
	 adGjA+nhRrGRWBV3eDd7LzSY2TKjr9b3t6ecFEEcjPZ0UjnGo2e/Y7PhLFk2UVUf3DTdP
	 nbVHF7xEGqynwCACNHsodeHEmACr/NdsiUuPoIvZI7iXOk/ZTQx5grcoZZJdwYaYrTS4i
	 7WGIVzA1BnqSzhH4etabPMOlP0mUPQcui65i2htISsdmBKYpJGRaumrwDeGRPp3ahR2/R
	 O8wPHg9BZgD0iIKlpRhptE6y8i7srSWt/0OTZ4Pp/1rmmREtnBbE0Z78oK/jDR0FWsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
	b=YAKjSA7Bb01UxC38R9NVEIpKPyHEr8lipK9v7/+FA6w+fnMmh0sicumWWtS1Grc1sBP6
	 bhkbI8J11qx3w93Rdf1jvz8wrB46T38HxmqxSkRpkkbGW/O0g7SH8afm3JQMZUhKtauVG
	 Fuz91vuxg2ol0IHhfsnMFBjq7Oh5ZlipH4uqMfpCzz7nenPhJb9jWEnFC5fJ9fuFGx1nY
	 WOvKExM8+T2sQ3FSCdaH330yuxZ3cHrYBf5SEeBk0vMdevkL+43j6NKeXMZS8IPa+Qyjv
	 b808ygm2VlakSLGrxahV9Awlz5vZWgAjZQonn4lMp6y2149XkAH+Z8i8aK20Dz7ll9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA9606CDB4
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EA9606CDB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53fdd2fb171so30461611cf.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640251; x=1795245051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=Ok0h8iL2T10cI+PFEuVIRGMDCQ8NRP8Fvz/7tqv55sIqhrJCRGSWcCpReX+dtqSuP2
         ju0VM52/CASXF7CQSnL43mof+7dO6XSHI47KpeBuNSnTQDrqrEnd3GcKgPAUVOYGauxT
         de4vnDF+SMAr6UXzmWg3c28ZY4rCoWGd8RqnhDnP6NM0npTcE8VtLbuilixq0g2CEYxs
         +svzoJS5VfpJRygWBIcrxBCy0d2NU/KdVMysL9vxlhdsh6BofY6ssX6fsKSm1C5oxNGX
         mwozWZkGrlxN/J/oH5CRgxpsxUUGABpZxa67EC7pTOlS0qAduZMHCi3ioVdjNWNK0FG5
         e9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640251; x=1795245051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=NdCvMeiNfG2wnwl2fGCU07y4TbZ3ejseC+JTkVqXrJQkW/l5pAsZx6v8whsJUT/3aI
         KNqhX1dhAougNeGk281/0s02MhCTsSlZj2z+jySCwN+M71bDTRkp/yscfJ+6M+T82X/1
         pxxXTw6Dj90jDDLCesr2MInGC9gry3Dll5z/F3bRg0uD5vYpZLx3gDuVVYW6lBd67Z7t
         yfpzCMWoL8fMC+Nc/06TdPiHq9Xk+heQlg4O8Pym/nok1oDnA1NuvwPYKSQ5hzdJnDTv
         Wpdte/20a8oCGH4+nDWIZlohAiBg2PqzryB28sER/1ZTlRnx8jlUoUWAYYC1ZwHrtUNz
         cnag==
X-Forwarded-Encrypted: i=1; AL+hErE1Iq8Igmh/cOwC+wxZ/Oc+xLTdjmGbxkIGjjuvvE6ieFp4IN+fEOxpsrzG5HQjRCCj5DTDb5jTcg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WcJrLUG8BN3ck3IV+sITRwPXGnpYFqkleQSACcAkBnNZQjdIE
	uAhN0W1p08xR589qaPduB0h2r2p7HdvaW5Mrjl1h1uyGzj/Fd+5b00G25UjyH5/4yGM=
X-Gm-Gg: AYBFou3Sx4E5HzYX9ppoLZP65+I72kOrJgf4pk/SJ7h3zAD0UhkZPmChtQrDh6k/RYd
	ktX2PTPSc98L0FP1QJvW8MPI7FsZWKADtJpB/Jz2Nr5Sl5fLWT0b7zJg3eKbUWwuHCKHAeUT3Fi
	mg9f4GFIBW44rs2XGgRzFnA2pymL7X5FwIu+22V2wqKAwEPyueZU2ViHiaKl/+1sgb5536RnxI2
	DZkMCLfQEmni3oUGd2Jk9Kq3SYU1t7g4AU7WdFVNtQ7MWfluEW3Wdgi70ybbh4Ri0M3rUtC1Zb/
	wH6d2Xl0fjGPIk1WZboaBzPiB/p9Hx/6tOi1Yvvv3fdy8KFFpaOn8uEdiqsj7F+so4Lcf4I4Hv8
	Fqs5HjWyClcebff2ogBUcCExJlszLHU+R8K97+pMj1N0EUQBDPfoi0MpnbhVa8kUpapFxkg63kk
	wUp3eOY8Qf/RpTmSUJrwim2Cr5LJ+URkuaMN98HfnILycE44tp9ygfvFGdzo6WUyYQE8aEQb+ag
	m3+oppx/eq9m6ZexxrqeY8bXkqBTwQy2n4vY982v+440ed9X/oyr/tQpLgb2+JV61rtHqtFeE4N
	GDgIyTovS9FqxqrspLXjU1GvEigw2AJtN3rqPCW8cEDM2rCynLBOGgC7IZu+SYbWCgIVWAWj68z
	tGtP7tjOcA1qnWqw=
X-Received: by 2002:a05:622a:191b:b0:535:a5fc:3b58 with SMTP id d75a77b69052e-55ac8b9ba4dmr73074831cf.68.1794640250752;
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
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
Subject: [PATCH 22/22] nodemask: remove the now-unused first_memory_node/next_memory_node
Date: Sat, 14 Nov 2026 02:09:59 -0500
Message-ID: <20261114070959.3490008-23-gourry@gourry.net>
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

Both helpers hard-code N_MEMORY, which says only that memory exists.

Every caller now names the state it means, leaving no users of either
helper. Remove them so new code has to pick a node state explicitly
rather than silently getting N_MEMORY.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/nodemask.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 7ace610bdd654..eea0ff7601303 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -457,15 +457,10 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	first_node_state(N_ONLINE)
-#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node_state(nid, N_ONLINE);
 }
-static __always_inline unsigned int next_memory_node(int nid)
-{
-	return next_node_state(nid, N_MEMORY);
-}
 
 static __always_inline void node_set_online(int nid)
 {
@@ -509,9 +504,7 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	0
-#define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define next_memory_node(nid)	(MAX_NUMNODES)
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
-- 
2.53.1-Meta

