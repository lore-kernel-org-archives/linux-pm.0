Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979975;
	b=xJgLgD/X0DfGq45hoz5ztZwdQx2OQ19OKK1Ignla3v5zEywwW5xX3pTc9eKjICqRoiJ1
	 cNDWtvnoPD4/qfOBas3oFnRMbzyWnnfPR9zd7wZthQXlmFSSWS1gegm+2BCsEVQE9aY23
	 JOgdIiPbvRrvJMhFK9vSTw+71RwZwyOHstuPtHf0LQUd7ECs5uZzWCmv6gHbyQ3f6nRyt
	 YjVIokaQ5c4rJFDS1fEhtbSAySx0aPdzRziigBMMjzwrqsE5wSMMZ6M8wSwPqBDUNhPCP
	 dFAs6/BCi0zFuD6J5Td14eMVc4+MfxhdlYOFH+Xbp0PbxkKHskBECfVLLLDqRIiFRrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979975;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bGq0VjgLVI/dTQDqrPyGTM1eV45/XEi95CQoU8WPBvg=;
	b=R2mHYXMKmwqU36mENgUHXYN5SSONK73agHmlFSf37n1LuHfdc7nqSZtgAUdzmmH0A4v3
	 A/8iYM+oXl5d5xeuHWWNIFnzvkpYsjmWE2EOj0OsA0LdQJwdb2DX8ZB/CVb1zc77t8N53
	 fZ4nOGw0eVAuLhlyJhGVxfsBPxdba2Ms2TIo6gAKTdrUu5Lt/hOcYlLbAMG1e5KEe2hBk
	 zDeL79uFLwnAmcES4Vl2Q8EZbLBijhFTw47z6pwLzi+1CmtvdzrqhITpIybO+bCdvFjA1
	 8My3pa0OpXYAucEnmnntXaCLbX+Fzm6iZJewnshWBpLupmxUL6bJ4X11cxMxFFBVWHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XzN3yVpM;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14D606A31C;
	Wed, 18 Nov 2026 05:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC14D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XzN3yVpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bG
	q0VjgLVI/dTQDqrPyGTM1eV45/XEi95CQoU8WPBvg=; b=XzN3yVpMm8wSm/HuQ7
	kBCk29ofWB0/yUcZRERph5V4+U4lp4wDJ6QH33dvHXeJ8sa72eg/Z7JRU/el2SmP
	W58yEgAjoOFu/KfmnSgJt7MgQH3ZxKwGjjdvuvFH0KUHaz1rdhwgDA1lK4YSelic
	iXGLqhpR+7PM4ibPpeIeUVlKU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD336RuOP1qqnqQGg--.52641S2;
	Wed, 18 Nov 2026 13:32:31 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	deepak.sikri@st.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] cpufreq: spear: Fix clock reference leak in spear_cpufreq_target()
Date: Wed, 18 Nov 2026 13:32:29 +0800
Message-Id: <20261118053229.2066011-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PygvCgD336RuOP1qqnqQGg--.52641S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7GF45AF1UZFy8uF15Jwb_yoW8JFyxpF
	WUW3yjkry8JFsIy3WUAF4Duw1FvasFkFW7KrySk3Za9ws8JFy5Za1UKFy0qF4akrykJF1S
	qr4Ut3WxXFW8Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pir-BtUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hBEsmr9OHCkMwAA3A

spear1340_cpu_get_possible_parent() acquires a clock reference with
clk_get() for each frequency transition. However,spear_cpufreq_target()
never releases this reference, leaking a clock consumer object and its
reference on both success and error paths. Add a common cleanup path to
release the source clock reference.

Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/cpufreq/spear-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index ffe5eda82f0b..7f3fd6eca854 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -136,7 +136,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 	newfreq = clk_round_rate(srcclk, newfreq * mult);
 	if (newfreq <= 0) {
 		pr_err("clk_round_rate failed for cpu src clock\n");
-		return newfreq;
+		ret = newfreq;
+		goto err_put;
 	}
 
 	if (mult == 2)
@@ -147,6 +148,9 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 	if (ret)
 		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
 
+err_put:
+	if (mult == 2)
+		clk_put(srcclk);
 	return ret;
 }
 
-- 
2.25.1

