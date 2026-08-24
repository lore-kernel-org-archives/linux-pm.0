Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56725782D
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552198; cv=none; b=cToPcH56B846R28k/YPhfLR3AY4j+7wwqFUZRsCyk7Jzr9xK4xYUEpRxvJNDL7M2VA0ocavO7mpxZW78yJqLqe1w8GJ6TjajmgftjcQZjWOeVf1XmNfEzbWBAQRcIPXYWD4KoOAfmQ4ery4jhFQlG92mwieVZWZGIN2cGGSkUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552198; c=relaxed/simple;
	bh=hCifVbDGqOxrFUw4MNslGn68BFtV8IG53qEmLcBRpUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQZemU4vhWFq3vQBu9fd0j2kWHxsIfpFSfKXpmBJ0FA/lwaZW2TdgxOroER9CUzABtCCmge+BebVBiO08fIrkJFUDbL+XSQ9pAWiGJI0TA3d3k60TETk4pf5pWkbyiN/5fiHgmy5p15OAijQODX7bY2N++4sx+MF/DcEUQcdWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz6mRcC/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz6mRcC/"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc11a30a259so3150383a12.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787552197; x=1788156997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gC1jlPM66qYJRvbEK/CdgJJpi3r0DAb/vsWww3jhyUc=;
        b=Hz6mRcC/9qsaB9dXHwtBIWhsSBRW3xDnCmkXnHj5gsxDyePz+opaLXsHvZekTMNJv0
         VZ3Q4R1CGdgDYu1V4xiGLL4VlobtNv2zCsWbznSldYAFRkC3Ix68I5V09LHjMb0icVph
         BVA/soIB0ZaeXr+pYg2SWpOFMEkPt0sdaVZ8hXqTBPiw0pULL1ykWBax2rSiz5EGC7k/
         PJcEfH2iuiGPRfpJJEKuxAvqHv/k7hkA8AL3x+LNzNZmjJyXTnTf66VrZkynQSHQFLPf
         0GKDLfXmUL9ihI73DBsKeKo3/OBI24nlYfaJ7k02lsRwKfKEbnImhHod8QNmogpa7BS2
         9A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552197; x=1788156997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gC1jlPM66qYJRvbEK/CdgJJpi3r0DAb/vsWww3jhyUc=;
        b=imVaUHjlqSsWP+BrubXrEPidTgcnDKkAu2sO9fYtk7ZOmGMXpDsbOFy9qqX3SR+dk2
         WKf91HEF8wc4vhX6C7Bs7WTr0m13Ss41CIrHC6wjx/I/6P5fuFD9o8bTC+XKvXF9DyAO
         PRwSjFnNcwDQNCvQy1OoHFh6C44jg9WpsgVq9WwOpwMHieOdBFLjXVorO3OvWSRCl0ok
         Vfp+0cax/lt2vXmCa1hGvWhYl227zkDLX69dBL2yrKQGeOnqK8bD/SeFbhrJ7rbCg12y
         M8oIGhJ+3Dn4yU6r0Z3jFCeF3mmICIvcGyRXHS1ztx51+wLzrO8XgC1Jy9qjE/a7l5U5
         Q5Pw==
X-Forwarded-Encrypted: i=1; AHgh+RqI2ZhHXWiKC4bsOaBS2iwlD0w2WbMnmoh6WHADPD2N2j/J5vFPPnriSkRi98QZbgUsgY85lgKHAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ls0ImOXoia64QLViBXI+gKunBSPu8oBk+CAZpdnbZLDjFZIqIR
	iiIhuC5uvR1ZDI3HmdOIhpAi6RqspRJerSn7Jw2oPlNPXNs2rmJOrHpp
X-Gm-Gg: AR+sD119IPzgByJxRRBLHZv0mxlM6O/b1tb2vAGfjURsTfiWCSQaQDhdDxWlp2DiyYM
	ljP/lo2vtNsjhriw0iXzQmzlHk1XXziZHUB0F9vWZMb4mB9Chxj9ZGRtiFamLoP97sHa1LbPCR/
	Y69tCu0/bwksNds5YzFjVR3BnpAxwv+N6ODOyx5qee9kM4kH03g4cNfAiwzUfFVLJyGh3+jlfh7
	8i5SFm1VasDwTaSEBOUAqCScorkmfYfepm+FbY6rBMC3NcvUiGDa2o/dkPDf0qUzRCnPTeJkr9J
	wR3k71r4lQaxSF1Z1oDVZN9aLzl+WBsSefYnEXXarq0LzEUt05501BRCXmRsIe+Zn5cfebTQi3X
	1zyxd7N2l56XN7zb/tUBz60jpyRcFJ6pVy0Ooj1d1ivQ6Gzf9LCFR8AwPMYkCD3Y1LShpIEoDG2
	trSbgLpkGcw5KTVuiIrCAmxGb2CnWOfn72wwAv8TZFW/I06k2CDUXEKJbpPj4zflhi+vbb12OXK
	g==
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr32028018a91.15.1787552196838;
        Sun, 23 Aug 2026 23:16:36 -0700 (PDT)
Received: from Alone ([2a02:6ea0:d33b:6282::14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42cc144sm8514697a91.0.2026.08.23.23.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:16:36 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: rafael@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH 2/2] driver core: power: Fix "sucessfully" typo in comment
Date: Mon, 24 Aug 2026 12:01:21 +0545
Message-ID: <20260824061621.356483-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e82..3b8ba2780 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
-- 
2.55.0

