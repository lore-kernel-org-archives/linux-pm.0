Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20E2FF66A
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174021; cv=none; b=GH0UVuZoC5zLfWvUaW/PTL3b9MNWUfhM+gGz5iZqx71+Wu8ZjgU4Geyz90BU+W4QS/qcMOCLf16xT4YsLW3eVSY2TDb85gwGgFrmUd9/XZgw7TKEXE9omi/SloIrQYz/PI45jaGqGUZ3tUbh+jj0Zo1vD2SQpDMAPM3Q9xaeQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174021; c=relaxed/simple;
	bh=ydrAIusT8AIuNM6nXU2snHGvWRPDet5oE9U7L2iusfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YivKALHAQLm+sPSX/ymy44Rf57iCn/pdXxQI1czPKMA+PlQPK2a4r8Q+EdoaU7jvz2tWD0f4FyYn9zG/CDDR3kVmK4rhh6yCxAHu8lS5ac0tUMUoUtMdl4f06svHyCo/Hu9R2AoQbexQTZKQKt7RLsatyTisHHENxLjTeGK0qt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SwxvQkoE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SwxvQkoE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BfIck/rT3+zK22QCpPHxg3Zn0YkqOsK6i33YZrX+1YY=; b=SwxvQkoEVKNzIOGqsyo0BlWs4C
	WSHo0ip6PZzcLEB3DxmTB96AwEwzUFeAR1LoXjR/BRGTrmRwCjBDwPZXQeDFajWWIxTFqqaA9LSgT
	Y965Fs92x/BxcKWgnPIxWpxlbneORSjUUzMBP+X2TXNT8i6Hpwiss2MpamKO3RSlmVtTf9anRNOJE
	GNbXWgydb55lIb1DEchC3gR+UULryEVrnidNhFpiH/dVbDYSDM708m4/mV7UchoNOr2SFuwex+ASj
	Y1U0Y3bR+FLV7c2KV0LVKrz5OaGA50W2eYOFFLIkx2BK42P3a9+QrV08O2XEE0uTto5WCMkPdml43
	UPqCOtUA==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTQZy-00AN27-3W; Sat, 30 May 2026 22:46:46 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to 100us
Date: Sat, 30 May 2026 17:46:34 -0300
Message-ID: <20260530204636.1115120-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 18605b1b936b ("pmdomain: bcm: bcm2835-power: Increase ASB control
timeout") raised the ASB handshake polling budget from 1us to 5us.
Surveying the pmdomain subsystem, 5us is still one of the smallest polling
budgets by a wide margin. Comparable handshakes in other drivers use:

  - 100us : starfive jh71xx-pmu, apple pmgr-pwrstate
  - 1ms   : renesas rcar-sysc, rmobile-sysc (power-on)
  - 10ms  : renesas rcar-gen4-sysc, sunxi sun55i-pck600
  - 1s    : mediatek mtk-pm-domains, mtk-scpsys

Raise the BCM2835 timeout to 100us, matching analogous drivers. 100us is
still negligible relative to a power-domain transition and gives the V3D
master ASB substantially more headroom to drain under heavy workloads,
assuring us that the timeout is enough for any scenario.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index b76d74e3849b..d507bb675e29 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	writel(PM_PASSWORD | val, base + reg);
 
 	if (readl_poll_timeout_atomic(base + reg, val,
-				      !!(val & ASB_ACK) != enable, 0, 5))
+				      !!(val & ASB_ACK) != enable, 0, 100))
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.54.0

