Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com [45.254.49.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BF3AEB2C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974565; cv=none; b=Y5SRAzIAwsINVTHfkClPEfKLKyGyMHgG04jnWpkioT7TUebatrh51EibGNeHNQX/Pp1vA5SuoqqgmkeizJ0TF1QB77Y+1rdBmUbTKhoJFBGqJ04IUjmBfoTAmfMwBjHl4ZcjjvITy+Ma2kJuOit0Bf1W3qWkGlwPQFeXfEV1HWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974565; c=relaxed/simple;
	bh=JvuDnjHHIpajZaNY1cNH92wW6Oj8ZNY1iwt1kzDfu6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jFXmt0mVYXmGTsLT1p/ZqItI3mU55BSecIKCRAOzpSZe4lyQk1NKqnKIHCtwPCOZJMHehVoxxrfyNCwB4kGW05Gl+z/s/91W0V399EaKyHK/4Pt42h8o8qwJ+O5PGrFkjyle26tcw0QM0b56sdIZSRXWAoSksx6f2nMpMzM1Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bv/kN57f; arc=none smtp.client-ip=45.254.49.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bv/kN57f"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e88ba518;
	Mon, 21 Sep 2026 14:53:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 4/4] pmdomain: rockchip: drop duplicated errno from supply failure message
Date: Mon, 21 Sep 2026 14:52:53 +0800
Message-Id: <1789973573-151146-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c2be0ee303a4kunmfcbddeea30c449
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh4YVkofTkJIHRgdSx9CHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bv/kN57fZCgG1WfpTjzu89UurjYUV3pzn7VJM/DYW7nfmwmQizLuThh8coRnssxTg2pGdofX64eNudhGfLZJHIAP7MeT67pfV5ksTecto/YMLwqcGzS8sLy5NO9RHqyJdkVtZ9PlwRbYwJxOFHeL2a0Bn02WjD6iN9Z1vpR344k=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=4rzdnvxtMOwoTstWH7ONpLzJxlyzR6V/AX+XUQsnn/8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

dev_err_probe() already appends the error code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e193f97..dd5e2987 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -721,7 +721,7 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 	ret = rockchip_pd_regulator_enable(pd);
 	if (ret)
 		return dev_err_probe(pd->pmu->dev, ret,
-				     "Failed to enable supply: %d\n", ret);
+				     "Failed to enable supply\n");
 
 	ret = rockchip_pd_power(pd, true);
 	if (ret)
-- 
2.7.4

