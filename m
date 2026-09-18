Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674034E50DA
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733608; cv=none; b=XG8cJGA286x4HFW/GWX/qUmxciFPgTOnW8Fx6zp5ykhg/xM2661rvjMgb4V3S7Ev5BDMaPacAnlukNLcbfvqyi23lS0zS/FJ7ys585/DA7fhNp8CpclC232w6d9vKa+a3J/JuwACdFFBW0Ojar7MD8619ZVFVsJ1CvOpbnCmGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733608; c=relaxed/simple;
	bh=D3VOLnj8CsJBHAdd6ZivsxISikbOnSVk/aCgt6aSdGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ta44/IBgmtlE7jegxhlAN3XCuDkKYHeJsvmdEQTEThQBL8Em/NkjLQyri/EjRAqzEZl4gDi4teEyk1qYuUNVyIzh9kZxv4tSZW97PtwFfh402H4ynqbmU2j2FIHSNmACz0HMzISBfaI9T04hnI+c+h+/kEc0mtb0Z6fW/GvBae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GGe077Ti; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GGe077Ti"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e4c12fd2;
	Fri, 18 Sep 2026 20:08:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Fri, 18 Sep 2026 20:07:36 +0800
Message-Id: <1789733258-10133-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b46aa43203a4kunm5c34220f164111
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkJOH1YaHR1KGR8aGE
	1PSx5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GGe077Ti2GRusO6ujOO7ct4Oqt6QXuocoWQnBGaNG2oDd8WIV7w3J0eQ2qFTRZwDBp9w/9OItKkkxaVZMivEVsaSFmHO+fnx7vdRDAB2uEY7TgxzTeKbKkQ/H1RZh3XRKgtfOufGoWyOYVC7jyCcMtM+gbsTXvObvD2lgMA/afM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=vyiGmdwYuCiYWaT86c455RYOSqUK1NvHNKSSaModKpU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 068dd4b3..b6b099b 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
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

