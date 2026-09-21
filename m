Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49A3DDB1C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975744; cv=none; b=EUk1N6rm6qx++mPAETdLKiBQgDYB9DYevSsTiOCBGJyfJLOuy74mOQMiTEMlfn9MWAcuTkdlFLcfotPX4a1OPDikMOG0+kAlPgu0+SWc8gZU+030VUxzTCsgCxo8w+1OVBuoLpiCG4PLm2PVpypMdtY0imUD0jxWyes7lyTDc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975744; c=relaxed/simple;
	bh=pwlUhuirmWdm3seD4fi8Iz2LdD3F6NqVGTb8NwNWaMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=diRrplFbLUi+2RqBB73VHqi6U2DcltIQqBwM17lxZFr6/ELRSoiN1fktjUAAqpjpRZtU70Uj9hF61MIwytkzdGi0U6OEOP/dnqLoyUZeF+2yPclIdAZqURGESHrbFLmlrtmoS7xD68cFw05y8JljnWS7/G+xDSpTj8rXXl8PtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LBPGYBdm; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LBPGYBdm"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e889bff6;
	Mon, 21 Sep 2026 14:53:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/4] pmdomain: rockchip: propagate subdomain add errors
Date: Mon, 21 Sep 2026 14:52:50 +0800
Message-Id: <1789973573-151146-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c2bd967a03a4kunmfcbddeea30c2e6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU8ZVhpPT0xKGk9ISRgYSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LBPGYBdmuaAr24n8dF1OXj6RrHKjT41icC3H/Ev+Xglpmcc4dfl85wJzN7futFWDmINYP05xPOTZ4lAhKyfZuzozDbxtgRd2OBPB2ujYTE8YGOMtBmbBDOMpULm1u3VlDKbe6e1AJLkK3mlWqdTCX5sjtprC1NOAV+xP0vMxM1c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3u+OLviOh+30Qgil93VMxj2Y63V7hMkpx8B2ztNwZHQ=;
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

Changes in v3: None
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

