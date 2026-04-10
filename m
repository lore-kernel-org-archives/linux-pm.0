Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1B3A7849
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827720; cv=none; b=CfkG7fUhnQHQZYs0XM5Xvgjew/OOqacjVjn8h6j+GTc1tnK2ebV9JSxRvsPaokpWBUvUr9A8V+zbxM/5QEO1u66mxPseB+SfTiyFANolZw9rNpPEf0ioDTp2xjy8Qok/0CA/ZVf37FS0xnXbmWNWspkcSen9bf0Rr7zNMYrNTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827720; c=relaxed/simple;
	bh=bmEbJ+C0CK1hYjvaUNA1OA2K4sEViTw3SlDflwepEr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8l830NJA6XBFI/TmuT/N8roWZXZG0F36XM0SpBv5AA8VoxOXx2KZZ8dAQUAhVAUGgBtmAE74q85mhb3UBbJXWQFJRCkqGvfzLlEaD6fanlLBHjoqhnjLV7KaCvfB8riOw1XJSCleulKLm7jMwtWKuny/fROAcMvSMR0jPvjgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9/6w6i0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9/6w6i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FC6C2BC87;
	Fri, 10 Apr 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827719;
	bh=bmEbJ+C0CK1hYjvaUNA1OA2K4sEViTw3SlDflwepEr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=E9/6w6i0KbibM2fzY/JyyWtZdVIpJ0jAU8jTcoCY44an3Q0snOjL9XclOawVtfppx
	 FVau/lS7O1L9Y8C/U6L+X0E3qRIFoW2VMKI7MEU9d2nRGVLs8CzZ9yeQr97I23JBvS
	 YE6SFcn5x5CdYLA/o/848mWSo+XpXqe2hbaFmbolQLasJhqF3JZn4JNrssxxoRVHS/
	 B/StVg12HeHaZX/Y7MCegoPQZmjTSrwZE4Vlhke06GbQ2KhYnJSwzaxF9ndMruZ2r4
	 drDziXqH7nYbbZITX2hC0ahrJN53Qdra9Th1VbOGds2FhgC8+OfEJ2yDH2oE4P11XP
	 MzxLdcQAbmiig==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/9] tools/power turbostat: Fix illegal memory access when SMT is present and disabled
Date: Fri, 10 Apr 2026 09:25:06 -0400
Message-ID: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260410132836.398255-1-lenb@kernel.org>
References: <20260410132836.398255-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

When SMT is present and disabled, turbostat may under-size
the thread_data array.  This can corrupt results or
cause turbostat to exit with a segmentation fault.

[lenb: commit message]
Fixes: a2b4d0f8bf07 ("tools/power turbostat: Favor cpu# over core#")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a2671c28209..ae827485950d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9702,13 +9702,12 @@ void allocate_counters(struct counters *counters)
 {
 	int i;
 	int num_cores = topo.cores_per_node * topo.nodes_per_pkg * topo.num_packages;
-	int num_threads = topo.threads_per_core * num_cores;
 
-	counters->threads = calloc(num_threads, sizeof(struct thread_data));
+	counters->threads = calloc(topo.max_cpu_num + 1, sizeof(struct thread_data));
 	if (counters->threads == NULL)
 		goto error;
 
-	for (i = 0; i < num_threads; i++)
+	for (i = 0; i < topo.max_cpu_num + 1; i++)
 		(counters->threads)[i].cpu_id = -1;
 
 	counters->cores = calloc(num_cores, sizeof(struct core_data));
-- 
2.45.2

