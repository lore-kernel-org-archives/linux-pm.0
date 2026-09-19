Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247432135B8
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778456; cv=none; b=nXvsNwUJ0FIrdQESi9bZOWLPfHHm1Rxw8vMrmPz+bNuuDXOT0UlhtTdrVnrAeX+yBY5GhqVOO/WOdWLHzG4dhcd66eUHmfZoEtlvKUIofmmq3FcU3l3KQ8UMByiRFKn4/J3qP4GklWEv8u9bu0x9bpzj5zhmSvoQNvJovdr/30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778456; c=relaxed/simple;
	bh=PTMa9fUxoMasaUFE8bTBoC27Q2dUrvScEYpwBvws18I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T6trdKvy/9vQY0PDRi8kkRWVKfGbd/4imYrGVBDwsM55exN1z6A+QWgk4yzaxd7NnGw+qVcWMzKXM3Ns/ev0myTCLtmY9rWW4fMoOl2My6JL+ikG6xdSszCfe1si3rtWvSQuy0l6r+adBG/hopXSY1r5HwLqvKgfS1Ul32R6pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kH54/VFk; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kH54/VFk"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57cbc33;
	Sat, 19 Sep 2026 08:35:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/4] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Sat, 19 Sep 2026 08:35:09 +0800
Message-Id: <1789778111-173149-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b717036c03a4kunm44a9997f1a8f48
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUtJSlYeHx0fHx8aHx
	5JQh1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kH54/VFk6EvU9fU8EhdG14A8ceKlzrcF56qKf43MS6txJKjcSTTGtOT7sQG0lXg/YNI0RbVkDhLfFOOr0QlD6dNCMDxACvUGgHsAzOygZj7x2RxJeaRe4jIfpMKu1zQLZSR0y1Jmi91SMF9dPtB3mCOVdB2zH3e8gvVcZTIlPhA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=WLDykJQrp5KlPCvARAF3I/UtgiimZR4PVoih3I+nZLU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Also switch the clks array allocation from devm_kcalloc() to
devm_kzalloc() so that clk_bulk_put() cannot run over uninitialized
entries.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v2:
- switch to use devm_kzalloc()
- add Sebastian's tag

 drivers/pmdomain/rockchip/pm-domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 068dd4b3..43fdb7f 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -825,7 +825,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
-		pd->clks = devm_kcalloc(pmu->dev, pd->num_clks,
+		pd->clks = devm_kzalloc(pmu->dev, pd->num_clks,
 					sizeof(*pd->clks), GFP_KERNEL);
 		if (!pd->clks)
 			return -ENOMEM;
@@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
-- 
2.7.4

