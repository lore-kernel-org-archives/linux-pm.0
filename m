Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536987;
	b=vzFmexTcNrHKy33ByWO2C3Ko5/kRgnOwRlClbQvxDHU29Dbe2vQEK94UTjIxC8FKK+GD
	 eKNIW6ZCuP1Cm/m/Voe3BMME+1X+SRmwYN/CQTwDrtq96LNQWhA/XT9P2GQz75ygiBmqQ
	 B2sRoCJpk83go1wbhbXMQmuZo/NY1GGTqfbm4cjsvRSYZvErT8WD812xtnRjSrzCIGulI
	 CFw8nOb4I6iTL8LGlaskJoMq+kK1wNkrVYgCu+TZ+mkE5VOnEVSIWFZBOTSJSCJz2njij
	 WeXJj41m28Jb4O7AGAkn1F5aNC0H7Je6IAuHNWXK6uqlx25K9Is9bA1pwTaqJ+oWHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7I35fCoKkVfk5KSv8b+fmiXqz9ZRpBgphgxQccwd6TU=;
	b=v+xadFyoEYEH7W08vt2EqnYM9XK1rKX8ara3uAajm8b3OF3LRYMGkH7YAwfHiLkIVcZj
	 mTfqeJCckKbvfJg1jPZud0wheezdJVpr5xBbm1/iDNY3DdXmKv3ITJKyFYIb2T1FU+5H3
	 k2keuYtaGKhyMZn0XqcteeGRORAVBoJ8Bu4p/BBola5X8yPfj3WOF4Ywr+BM6ePF8gtA9
	 NDfJEv7IXQJSqb42glFC52sjwo9oX3QbRdDT0kH/115/XbIagE+9FGmtNY6p/uu8XBF6r
	 iuL6kWS5jV5+W8+j7vVN21qTXm2dFgvYnCqNoVReDlrE594E/ZQllWChxoIK0d8x0nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEe0gk9r;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695F606A89E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6695F606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEe0gk9r
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so226963b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 18:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536985; x=1795141785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7I35fCoKkVfk5KSv8b+fmiXqz9ZRpBgphgxQccwd6TU=;
        b=BEe0gk9rJJ/sCix7PNHn8gpFi2QFKUvMayh5qS4PioR+eiEtn4ZoOu9CULd/95dokj
         Wlf80o950cLiMHjUwJk5Dwjuh1ggHVwObo2kRFNXwKEzyck5lOJzCezS2W6SL2L0BsAa
         MaHeaPYM6LTYVPuVUECBkKc7XG8BjHKOBoCg5ETRKE6708q/37g+TxQzOO6wzEGl65jR
         hr5NoFh56rtHi7K6MG+rCVuQiXBFG8xY9E+kyOnTAw0k5nE8BzFSqRceUoz3Kb7SUn8t
         kf4X9jPVoikGWft+7yggmKMmkBOt9Ukg1iVw5PT5dYZ62dktmDOY2jxf0+UvtzM44t8g
         zbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536985; x=1795141785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7I35fCoKkVfk5KSv8b+fmiXqz9ZRpBgphgxQccwd6TU=;
        b=KjeKU+7bo0CplBv957f/teQRx0VA35a285qzj0mGmIEuJo7qEF1uDySSKiqVpHgZjW
         dkhKCG0CMoc88w0KL/sTendAyDRG6MOMZsxAADORXRe4amodwxVh1vd4TPWwJQXlZ+aq
         CNQXkEypEkJAB+J1T0tmh3RnePUGfjotqn6X2IiXVKDvuIC70M/q6Xa8HBvJ3EwFuKEC
         68klTBlfMC3SabdrnvAh0jxs1d6TfdkpMo627QdwQuQZpA3axxbd/2u2/GL8ZwdI4xXT
         +JzMZ6CpuXpUgVLGbgPNrDIYg+t5fer+ITkPauZA2/pVRpIgbKwaefe55LKU24Xr85KF
         cwrg==
X-Forwarded-Encrypted: i=1; AL+hErHxxeAvDnLUfMbqIpE3BKMRPnk5L61ARvHeRCcUUS8beHlF1tXVuaew1Uhz2Ry1ibtMEQP9AvLp2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/tINPRzmiZSaxr6wT3uzKJ6uoEux3bJkQ7fJbn3sO9K4faz+c+
	mkUR1DvJspbMwdLd7gmGuz6Zlcgu36fDneXuAB7kO86x6RlsiqNuKWRf
X-Gm-Gg: AYBFou2H4UcBS8gn45fgLNNaydRN/AoLhRgxLDUYGCOyz+f2WLdKqvgqigxpJrJv4Hw
	RvNFrCQ3Sk4sgNgb7D5G4lJZt7diKxLTeHG2XaNSGtiHdrv+xQXllxUuYjlImou3jy/k0zGEH8v
	tN3cRENRPlpNSYWP7CCo20dR2aXe+s9HI29C4iZyzMgGMxkiMASRviCFlCfyucs6dfJ+v/wLkdg
	LkjC2E0MmNbOEbo+jALIP0D/cBod9nKNPyogG343L88uBuGOsvTAAW7NMq4vRbCLpx4afJ07Qkn
	rswQcbVhK8Vocbe1t0H+hQHb0qm7eJSiMqd3vS88a+SP1C0HmTbSZYQL4I9yvtpFF188+TYYxq3
	9qI+BucnYtVX6NjLC0U6HgSkCssIDA57PGOS0n7yj671zQCk1tzNUKuVjOk5kbDMKJuoxbkBHwJ
	NuweX/9ZYve8LBPqYIUs+jFUAedi1YSe+Lq1wsDPB6goCKdNOkkDWA4h9o78+F7WA5waw8HyggA
	vYnvEMiH4LDF+UCZUmklKzuIHOu04E8c9qMhK9oXqPL5Yfw3neyr/E/7HOokfa6PbbkTSK8qPQ4
	MIawdhfq3q4/CICHgGVw7NzUWfU+0f5bK10KHpx+
X-Received: by 2002:a05:6a21:6444:b0:3e2:2fb7:844a with SMTP id adf61e73a8af0-3f7a9bfa3c6mr670282637.61.1794536985497;
        Thu, 12 Nov 2026 18:29:45 -0800 (PST)
Received: from fedora ([2601:600:cb86:7af0::c952])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8682sm335547b3a.10.2026.11.12.18.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:29:45 -0800 (PST)
From: Aiden Hecker <heckeraiden@gmail.com>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aiden Hecker <heckeraiden@gmail.com>
Subject: [PATCH v2 2/2] platform/x86/amd/hfi: Rank SMT siblings below primary cores for ITMT packing
Date: Thu, 12 Nov 2026 18:29:34 -0800
Message-ID: <20261113022934.13397-3-heckeraiden@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113022934.13397-1-heckeraiden@gmail.com>
References: <20261113022934.13397-1-heckeraiden@gmail.com>
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

On heterogeneous AMD processors (X86_FEATURE_AMD_HTR_CORES) with 2-way
SMT enabled on both Zen 5 and Zen 5c cores, amd_set_hfi_ipcc_score()
assigns identical ITMT priorities to primary threads and their SMT
siblings.

Scale secondary SMT sibling ITMT priorities slightly below their primary
thread sibling (7/8 of the primary IPCC score) using
topology_sibling_cpumask(). This preserves the SMT > dense-core advantage
of classic Zen 5 SMT siblings ahead of Zen 5c cores while guiding
SD_ASYM_PACKING to prefer idle physical cores first.

Developed with coding assistance from Antigravity (Google DeepMind).

Tested-by: Aiden Hecker <heckeraiden@gmail.com>
Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 86a7f4332..d7e35a2bf 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
@@ -261,11 +262,26 @@ static void amd_hfi_remove(struct platform_device *pdev)
 
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 {
+	const struct cpumask *sib_mask;
+	int prio;
+
 	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
-	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+	/*
+	 * Rank secondary SMT siblings slightly below primary threads so
+	 * SD_ASYM_PACKING fills idle physical cores first while still keeping
+	 * classic Zen 5 SMT siblings ordered ahead of dense Zen 5c cores.
+	 */
+	prio = hfi_cpuinfo->ipcc_scores[0];
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
+		sib_mask = topology_sibling_cpumask(cpu);
+		if (!cpumask_empty(sib_mask) && cpumask_first(sib_mask) != cpu)
+			prio = (prio * 7) / 8;
+	}
+
+	sched_set_itmt_core_prio(prio, cpu);
 
 	return 0;
 }
-- 
2.56.1

