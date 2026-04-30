Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB2472789;
	Thu, 30 Apr 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566797; cv=none; b=VhMx1Qx+RaYOQYvFQjsrH33y98rYDQaJ7O+DBnM88QmCz/39fwr9Dihe5qKxeRCE1bQvihmc67e1XiL3R4e2S/SFjK4jusTUU/J/L4gduIqF131vaOZljJ1SY5DPMxQI6aY+34vT6+OvFovvwXy06vewHgwlVUluRBzoY0jUUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566797; c=relaxed/simple;
	bh=3LxlcnS5Y5p5Z6K+rwjkNw6QjTHDkhYhq4FGmYnGRxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KndJdsFl8krSM4DEvTSSqk14p7TxbNm0VHt+/XAFkyYL7uyQBczDBqc38P571VKjdHyUuX9/yJtEXLy7n+wMCs6PolOYje7U/Wv97tAOwvzNpOjHbBJvkeb5I0NmVzW58PJ2CF084ogb5cCN1wiL8hRa8L1iRYeqCcxbAPUPX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O2vlRDAB; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O2vlRDAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EO
	m+xIFim33ZE50JFySdupaKYtgcplsaCUyEBJYxNUw=; b=O2vlRDABfff7iDWhqb
	LLR7JpxKC2DOgkjSS0CBZT7qlWyep4OdIl+r85WKrluQKt5qdd/OX8K2WaObbol9
	SIlOvMScwPTzjvidAdepagzCrhF9Qkv6bbhlOcSkjm2vl5pN80LGpDUSIbvCp6J+
	rOpUNph0lMSljdVDEBi9WBYCs=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3t7MPhPNpY8phBw--.45309S4;
	Fri, 01 May 2026 00:32:20 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	sven@kernel.org,
	j@jannau.net
Cc: perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	neal@gompa.dev,
	linux-pm@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/2] cpufreq: apple-soc: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:32:13 +0800
Message-Id: <20260430163213.44695-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430163213.44695-1-18255117159@163.com>
References: <20260430163213.44695-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3t7MPhPNpY8phBw--.45309S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw43JrW7Ary7Ww1kGrg_yoWDJrX_ur
	1fCr4Iyr4DCan5ta43CF1vvF98tw1xZrnYvFy0g39xtFn8AryF93ykZr4ku3yDAayxCFZ2
	qw129FyruF4xAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMPEf7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxR9IWnzhBScdgAA3r

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 9396034167e5..638e5bf72185 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -187,10 +187,8 @@ static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	reg &= ~priv->info->ps1_mask;
 	reg |= pstate << priv->info->ps1_shift;
-	if (priv->info->has_ps2) {
-		reg &= ~APPLE_DVFS_CMD_PS2;
-		reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
-	}
+	if (priv->info->has_ps2)
+		FIELD_MODIFY(APPLE_DVFS_CMD_PS2, &reg, pstate);
 	reg |= APPLE_DVFS_CMD_SET;
 
 	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
-- 
2.34.1

