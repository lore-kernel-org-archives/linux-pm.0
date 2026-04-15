Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77556392C40
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258634; cv=none; b=RSWqIHy0A+Dl7CPEYYXOffktq/Oa06LzFq8FcFeo/7ftQNE4KS7pFA1JFKA8KO/E0X7nvRloomT2wcDCFgqb61LT0m8SepsIfCxl9hFb2CQewZd0NsIThU/CDWFtXR+elB/mah7+V87/I1Rw/BvdJ8JIriW+aJuKWz+pvkUXCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258634; c=relaxed/simple;
	bh=TKihPKu1wRQ8mI4Zio2465s/4R0zt/1D8Ib7m8Y/KFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SKbpc3+mH9i7ejwzBIClDoUoZjyF3wjGPPmFKyK94HPX0N+DCdwktA9ZBUQNRteUxF3x8mzDvexxnpaYgi0FYM6s5tze4ceqLpwChuPz17fW+SkvQ6jYU3aSXH8QMd0NKzNeif4EXykSModA0vtuVUquG+YS341+Jp/HDFS6v6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDBLJ+DE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDBLJ+DE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2503753efso58577365ad.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776258633; x=1776863433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij396v/ARQbEqIfPoR7kjIiJGCWUlYIBuo1ugDzDJG4=;
        b=bDBLJ+DEDIFaHXWEKlmDHuOXvc5BpuUAmMYESOdO7VTv32QJw/T9UP+RxRFfQT3XNB
         XvKMFbpFbGCfYNvWSnz6JRVKxpQnv4RLris1L2jj7uX+y6IuAH07WDRExlag3iOzGMtu
         bf7KrjCd4K+JEQ7XP0sp3yyu7l37gL4D4z09dSvV9bYnVjLUR0ECcpjcMzUxb2fJHaHc
         vkBHK+fev3a0O2L1JceRgE0FKAUrmLgyiKc9aFP30ncov9YfKeKejFE7NvZhyfFEgNl7
         8cDYCBxcmUXIn+RIIz2jgSp93gw+5rUYwUiN9e0ihx3DtEi5CtYCGlkGypHt7bwZWceH
         u9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258633; x=1776863433;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij396v/ARQbEqIfPoR7kjIiJGCWUlYIBuo1ugDzDJG4=;
        b=OHm2P8WCCtVbNwM2WI8cLZmi9HRxKsdl6C4/CahYpTOkm/q7h1XnsuQGBdko5YgmcE
         Wcq0ggt3McBa7HfFGCL2Kj+9gO5MJwjgAuoYQPkMemQaSh0JaeE8iH6uF4+OzLfju9zA
         Be15w2ndhVKTp/SgoHfVVvHp4Dz5LSNULhGInFCkW4NISkwwoSG8J1kFKANl/3rc7YC3
         e5qLuRUk844leuY6dRyrRW5auMv6mcVP64jbgfRp2ZHVWfPncU7hdgCJ77syZH19LhM8
         MIFxg7SQpNsDQZ7mlHWW2lGPsLXFg+NY+Wjfa51jJD+Jrufc8YteTFH7AkJ2GzjUceU2
         tMJg==
X-Gm-Message-State: AOJu0YwKnfSR/umRlnd+bjtVFvMgdFyQKWem31StOdFUY9GQDlF44dw+
	kn73H3IQ8EmxMP/2IUo2qFI/T5sGCbDarVONbfzEhbgFJnNdE0OSIpeo
X-Gm-Gg: AeBDietvcNpip/3UB8gU+aVbzY+9Rah6OOhJfh5sVraKNo98PlC3izqOgyvhDV5f4b7
	HXnS5QVjPJe4C8Un1Cr6GYeEpsUyLCiii2EhuAJ3DCe7hg9PwNvku9HNXfHFBtlZCjsZWf5zwxL
	hWpNNcMSsHUvuct5kvbgK5cuYIXZPP5KdLA04NJzgeZUmusEPky4mAdVV540/5rg6xEWjx/wI4w
	EC4zYCNlIBm682qZ+h1lsCBz6nv+73P0BPxhDxNMqQCq02A9Mf+FuUMEfbxkwewXDRA5ytVeBaY
	ofFEWaCAVrCNzbUfRw+61LKCdXCWHYZWJ5kkAV0QZnYhjXCUqeR4LX3QqvLlVJ96/5bjWkO0f1x
	MAWsWna0IHnjAmIULcBQsFLKnPL2OIhdIjufhOYxWV4zzDa/tbGTWE27T3Gr+xYmIKCUu0dOL0N
	ZMyACYzlBnjr4rHnbTF1xt4jQoHxVvtEsEu9gAmgr4AnpqDvLvKP/Oaksl3adDRBKOeW70FQn4m
	wHlpvp9n5+8wh0HQyW37QLoHCfR6K0=
X-Received: by 2002:a17:902:bc86:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2b2d5a5aa5bmr174065115ad.29.1776258632397;
        Wed, 15 Apr 2026 06:10:32 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478292053sm28062555ad.56.2026.04.15.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:10:32 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH v2 0/2] thermal/drivers/imx: two fixes
Date: Wed, 15 Apr 2026 21:10:26 +0800
Message-Id: <20260415-imx-v2-0-aeacff9e72b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKO32kC/zWMQQ7CIBBFr9LMWgxDa7WuvIfpAujYTiLFgCE1D
 XcXSVy+n//eDpECU4Rrs0OgxJH9WkAdGrCLXmcSPBUGJVUvO0TBbhNGKnUekDSaAcrzFejBW63
 cx8ILx7cPnxpN+Fv/vqp+QiGFta3pTlPfXhBvs9P8PFrvYMw5fwGinG2rlgAAAA==
X-Change-ID: 20260411-imx-b022791ea1b9
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776258629; l=726;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=TKihPKu1wRQ8mI4Zio2465s/4R0zt/1D8Ib7m8Y/KFM=;
 b=CNdQWFIHFiTFWs0EFl3Cyentbx1WrOppKyZSwi6EDSUAdKVfXJN9zmQWrGvs8MCLKZnyaH8h5
 t9sOioC0Ul3AJOtUkP+wRYpj8HCr5PgWeahKcvILQyj3kbtcTmive2S
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Switch to use devm_thermal_of_zone_register() to fix Frank and Daniel's comment.
- Collect Frank's Reviewed-by tag for patch 2.
- Link to v1: https://lore.kernel.org/r/20260412-imx-v1-0-cc3b45d63811@gmail.com

---
Felix Gu (2):
      thermal/drivers/imx: Fix thermal zone leak on probe error path
      thermal/drivers/imxl:Fix runtime PM handling on early returns

 drivers/thermal/imx_thermal.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)
---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260411-imx-b022791ea1b9

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

