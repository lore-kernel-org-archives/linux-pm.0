Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC3382296;
	Fri, 12 Jun 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301210; cv=none; b=NHJqhCkkxrkmaEsHz+8FaIG+iow7+9BcxwCQ7azKhcO4EPIudu6BPBnlUxpQ6sqoONp4Z7yGk85eh5lWUYekP4oRiwfhFHvAVhrjD6hoEWXmiT91yx2CMsd75v+DNneHq5e5hKMxLuvVI64mCwIHVvlYPNxdHmT1MCAlM+NqrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301210; c=relaxed/simple;
	bh=T6lXSMHwSK00ztQm/23qm9ExXrdIlbwRCSgWscFjB+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3qTjmVI+6hpclE7GB0n22MRvgOj01ZkQayVMlgOSW6CrfISgHpqmLYKrLm2HrxfaTyw3jHSYM/QrSt/Fr68osQwu/MjRaksLElSuv2ugtFY6RnEF+YSF3sztS8eyqxgB8lFT6A0sy6g5hONiXZe7tpXv0N5clm4LpqQBqrF3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUpWyTTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUpWyTTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0351F000E9;
	Fri, 12 Jun 2026 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301209;
	bh=XYDG0j6qq8jArhBq2sYs80s05bkLzbRW4bdbKDxJ6ns=;
	h=From:To:Cc:Subject:Date;
	b=jUpWyTTNaziw8eoOa6MXCscxRA8/YxdGCBv39vfHfPKxLRO8uP4zdK0k0BE4bCCdA
	 Zf9JddPPQ5S2LtMCktkI88qDAxw3Y+t116Gv4tbQlQfCCRBfP5/Z2Wh7LNnhEtLNzN
	 2lCkQYB8UgMvCqdFGO08iw8W7euH0kE0zateyhvZCCktsgnDEtKOI7ug5NrxxAwuYY
	 SPe0lqxODNGGfjDrQLsTt+Apocp1fO7HLuqo0TWdhBq5EXpGZEdu2+3QjjC4bRVM0S
	 W4Z4PAU3dXRmsLthEkW6FMvBXolQP4k6xx2PmTSScjrn39IkeP8wRvMLFuH/NkuQXm
	 JUF5uoitVq5Aw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: Read "priority" as unsigned
Date: Fri, 12 Jun 2026 16:53:24 -0500
Message-ID: <20260612215325.1889302-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The restart-handler binding documents "priority" as a uint32 value in
the range 0 to 255. The syscon reboot driver stored it in an int and
used the signed DT helper, which makes the helper type disagree with
the schema.

Read "priority" as u32 so the driver follows the binding while
preserving the same default value.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/power/reset/syscon-reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 2e2cf5f62d73..60e855cae68e 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -67,7 +67,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 {
 	struct syscon_reboot_context *ctx;
 	struct device *dev = &pdev->dev;
-	int priority;
+	u32 priority;
 	int err;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -81,7 +81,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->map);
 	}
 
-	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
+	if (of_property_read_u32(pdev->dev.of_node, "priority", &priority))
 		priority = 192;
 
 	ctx->rd = of_device_get_match_data(dev);
-- 
2.53.0

