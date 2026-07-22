Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1B23C8AE;
	Wed, 22 Jul 2026 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693512; cv=none; b=PpWm3aEhp538FNlSFcn4h9ArltSeXG0fq4ON44znZkMeCjmuN08FErfIEsm3m66weHchoL+gM3SAI8S8ApkR29vRAygmUepIt1regq6/jt2OL5uwZI9gLWfTjU1Ux+pHAskV4L7vWunAyaVFlucNKO/FEvml68T+0xzUplPLT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693512; c=relaxed/simple;
	bh=MePh0sqzq4a+/ssR3YJm9DFwTmnwEvu24IsLfvzvbmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfkHakveyTyR7lxMCDyWaz+kc6hmRv7iPOmTcsNePDQUI3GGNFmZemjMPo9ptqN/A9zBalKBVjYYPTofBYd1EzV0TyAQyigW71c5AcOo2/MjRpSTAB4TkeOFM7RY2HM4BM1/2LvCtZRuPNL4XV+uQbpwpi8rEMA9KZ7cq4hl260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB35T_+QmBqYBe7AA--.34013S2;
	Wed, 22 Jul 2026 12:11:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] pmdomain: ti-sci: reject maximal power-domain ID
Date: Wed, 22 Jul 2026 12:11:42 +0800
Message-ID: <20260722041142.95204-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB35T_+QmBqYBe7AA--.34013S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1Utry3Jw1UXrWDKF1ftFb_yoWkXrg_Cw
	1jkFZIkrW5Grn09r4Syr43ZFy09FWDuw1j9F4Igry3Aw1DXw18J398u3Z7W3ZxWrWDG3sx
	tas8Zr1fArs3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Each power-domain ID comes from Device Tree. The driver allocates the
onecell table with max_id + 1 and later uses every saved ID as an index.
If an ID is U32_MAX, the allocation count wraps to zero while the index
remains maximal.

Reject U32_MAX while collecting IDs, before the arithmetic and indexed
store can diverge.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 949e4115f930..5fad21c317c4 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -251,6 +251,12 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 			if (args.args_count >= 1 && args.np == dev->of_node) {
 				bool is_on;
 
+				if (args.args[0] == U32_MAX) {
+					dev_err(dev, "power-domain ID is too large\n");
+					of_node_put(args.np);
+					return -EINVAL;
+				}
+
 				of_node_put(args.np);
 				if (args.args[0] > max_id) {
 					max_id = args.args[0];
-- 
2.43.0

