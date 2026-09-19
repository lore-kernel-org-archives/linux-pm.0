Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com [220.197.32.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F6381EAD
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794698; cv=none; b=HWTCfcozGKWPzDv8LhGViuThIJYpwztcBmWahkAAJKRUFiur+zDRaKA7B9d2Evk1czxojGAp5BaQk1svx+KrOOtOuykir7mANqGIHxVMi8S8rj3UQMGTNXfAak08uUXFiRy3ri5xsVMglah2hkZ1DBRllTtbLQo8kGJBWdUmbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794698; c=relaxed/simple;
	bh=dmRmergz/gIXLlqQ7b/sZyTsFeN+9N3tXGtFGZ33AfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QHxEKzQzQADqLEcK1z/J0rZZbZf5RS/QFkaL1VDV/CCsjR22b6aELLfq8nqM/qQfN8+xH57htroR6MQmTsBtIUAB2NpcpqwxRFQ+HH4VrnBCeK+Qo3r62vTvvFAu+VQvm+/WpLzIpQ6U5N15EpD9LcaWtzdPGonbEUsRY9OlhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OKko05HT; arc=none smtp.client-ip=220.197.32.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OKko05HT"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57cbc16;
	Sat, 19 Sep 2026 08:35:24 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/4] pmdomain: rockchip: propagate subdomain add errors
Date: Sat, 19 Sep 2026 08:35:08 +0800
Message-Id: <1789778111-173149-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b716df2f03a4kunm44a9997f1a8efc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGk1JHlYYSUhITx0fT0
	8ZT0tWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OKko05HTPzW7zYzpvMdt5TnKlB+bXqBgGk99BYIlZ7o04ClzejjZoTxVDTwnFUiEUFGyNIt0ZDj2IMhk66VLmvmvXvWV8daV6h5Zs1+5URfF2d4OZts43Ye9/9jtaet1xQxpmI+Yf34wO2JYQ9vOURmpzpEE5T3QYuu3E51wubI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=xs9Xyt9DcDUp/WsLemhxxmoMv+x9NzL0ngcQsIgJ4Aw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

rockchip_pm_add_subdomain() ignored the return value of its recursive
call, so a failure deeper in the hierarchy was silently dropped and
probe still succeeded with an incomplete domain tree.

Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae7..068dd4b3 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1018,7 +1018,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 				parent_domain->name, child_domain->name);
 		}
 
-		rockchip_pm_add_subdomain(pmu, np);
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error)
+			return error;
 	}
 
 	return 0;
-- 
2.7.4

