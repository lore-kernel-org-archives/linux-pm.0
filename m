Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411741A4E7
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734226; cv=none; b=l776vFay64dyywxV2i1yRWDTl8cMVKKr8QY58+mZYIOuhuncdt0t9ORb0dHr0J8sDdUeQYFhlDU1vTQd8gaOrUXJkyClmGFuG7NLI2euasdCUGZEMZMSqlRQoGCea13APptzbdUtvpCjawAKziYrGenW9bTZE6RaQA0i+UgKmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734226; c=relaxed/simple;
	bh=3iDl41HD6HD1p2QipT2yAlMYg3WNfnNsAfvMY+9A09s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qg8eaPy2ZD3R2z4oxdkSh3mKYy7IRIEnfUjkuaS841yqy5yw84egM2wrTFASujfnqs5p9W4TW6WuiJRmLTReSAYHsPAKg7yPdcLA1fLyvSMQsGHJVDZgA6UUKqDoPiTMhXxj8asPpNYzEqOPLsGDpFqwgNqUSRPkoXlSkQ/XXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NEbq007x; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NEbq007x"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e4c12fe4;
	Fri, 18 Sep 2026 20:08:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] pmdomain: rockchip: don't ignore clock lookup errors on attach
Date: Fri, 18 Sep 2026 20:07:37 +0800
Message-Id: <1789733258-10133-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b46ace9403a4kunm5c34220f164153
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkJLHlYeGBpNQkNIHU
	5LSU5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NEbq007xdkUOukjNBFMQ7SfxdWr1SQl/aM0jmDJGNj9k1KyYaPZjSXmVEcOd5BoW6qYKSELwgW6hZE1GO/9/vCECrcTW1rOWgEYRzi/mb4g2Cw6cspXqc1pImzOr1dZIHjxUUIvdRDKYEZEpNKO2Yd7utBZY/QV638P+ah4KjLE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=S0oqhM1xlrebsyl35WHqeNuFrQM79UrsFwqvZTMxkDE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

rockchip_pd_attach_dev() treated every of_clk_get() error as the end
of the clock list, so a clock that exists but is not available yet
(e.g. -EPROBE_DEFER) was silently skipped and the device ended up
without pm_clk management.  Only -ENOENT means there are no more
clocks.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index b6b099b..e193f97 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -759,7 +759,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
 	}
 
 	i = 0;
-	while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
+	while (1) {
+		clk = of_clk_get(dev->of_node, i++);
+		if (IS_ERR(clk)) {
+			error = PTR_ERR(clk);
+			if (error == -ENOENT)
+				break;
+
+			dev_err(dev, "failed to get clock %d: %d\n", i - 1,
+				error);
+			pm_clk_destroy(dev);
+			return error;
+		}
+
 		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
 		error = pm_clk_add_clk(dev, clk);
 		if (error) {
-- 
2.7.4

