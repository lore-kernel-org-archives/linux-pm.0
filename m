Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F27E767;
	Fri, 26 Jul 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975706; cv=none; b=hoWqz3R+LNIC/fouTqgGsqs9bfbQk7JjHHSZPepN89Apl/fVprpeq8JDk24BJEU9UVMYE/0nu71bgryEcW3x77YRJi/HYoGLH//210rqx6sWLG/mQAqtEGP4Au67vXQBwEjK/tzIeQ54MNm7qGEXmO/sJS2rRQ8X+jBnYfy32Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975706; c=relaxed/simple;
	bh=LQjtAkmKxV9m9StNUoFtssLQCtwn1Jy3zEp5yrqc88Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6JHv5pUJmjb5AZ/+JD6ZkwIBjsqDo8YL+QeqR0kv/7/upOvbiKYQs8k5ce/aQQbg0ZhPfF+SoTtM5UBjQIrQ/dvMcGlpE21rLcAIr3R0h3FlmuLuHE57/o0KMy3fuswU04b+gvoFnyR4eh7dV5oMLqXlbfkkIaD8hNa6wO94mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nYpQ8DI1; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nYpQ8DI1"
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A53BD3F904;
	Fri, 26 Jul 2024 06:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721975173;
	bh=A1mPeS6hLTlzr3SyHyP/MD9cQNKLZUbeMVkI9QOlBIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=nYpQ8DI1a+SoLhqjYXL1na6IcPbbzdBGkNvTX9Rov6crr2fGTsregl3eh4fOstbmY
	 hc35Edh83plUzNpud9nma9im4HS0LfggAhaQ7fLHrzC3AJUQ9y1gDhhwJ1rsKVnrY9
	 hQ4yh29Tfl0H1o4T4/4uDAe48MU97TblDAJettMCwqVRBNc+/aFekA9mr6kOXcKEWi
	 u7mTGlOhcYXe3phm+bmnDJVXVwA6d2mFTRDK8BQAPpvl3OENubxU0PQZtbwQ12tEPT
	 EDraMcgrjghLasINmckw/lnd8JrxBbGGNzA3nphGvV9zmBKatxPgVVzvU4VXRDLvUF
	 aJfeDqDubxn2w==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jacob.jun.pan@linux.intel.com,
	lenb@kernel.org
Cc: artem.bityutskiy@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
Date: Fri, 26 Jul 2024 14:26:01 +0800
Message-ID: <20240726062601.674078-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without proper C-state support, the CPU can take long time to exit to C0
to handle IRQ and perform DMA.

The data collect via wult shows the latency is similar to Broxton, so
use the existing table to support C-state on JSL and EHL.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219023
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae9..eb6975a1d083 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1538,6 +1538,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&idle_cpu_bxt),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&idle_cpu_snr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&idle_cpu_grr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&idle_cpu_srf),
-- 
2.43.0

