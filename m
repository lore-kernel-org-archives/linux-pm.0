Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9492571C0
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151324; cv=none; b=Av83FLwU3GPTWW4b0DClKFWFLEZnEF7oG8TO7zYXvLIKK0FMFEUkFsinir8O61sKEsO8tA6A5QriG1YGVKjVnGxgNuHrPBgOinnJkN/ukSudlWVuu8My66fByJF1JC+LydhbVyEAIUQ0Rsg/KK6Fex/HcoukguZxkRlDaDtnT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151324; c=relaxed/simple;
	bh=1YmX0fGkcJsbMLP5ma7XnXNn/SksmhSZbH30g99aBFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F45S5/+yqlyDzlFPEcCJcOEazVXR9XT1G3cJ8E/dgACyEgSmpn2CP8gMf3QLIkeejMnkwyaz8/IiezCfma78PPdqFhwICJeih3k1OyLRKm7P+2eYBnQXHz6kFd7cFvKHME49JxGqVTqR7yvab+U5IdGDYrSE8voidT6egLXdIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT84BESE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT84BESE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-838d0b7c950so2042601b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151322; x=1779756122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKPyDfzW/WAVTLGso+F2wDl5cgejxyDE1jm06Ek0+Ig=;
        b=pT84BESE30sdB+23ko1kTegCOIWgB1FyNUWsp73xr8bDtTd/qO8On6CqKUbKQ4xYNR
         iYqKr+MscXY4DWlxC0vnHEpmwxn4Z9KYxoVZkq2fomG/iHL3y9VP8TvOIq64ry3Kysn0
         L2XxXKgX+kiAdablpfHzTmd+jwTD8TbbfoYMyzv7YYpw0lniDx96L31cLi0zRBWyL5Lk
         aNO/eBJbNVUH8RGxvjW0/tLwFTVTSgag+20hoB5n150+WPjc5UEfainLfOHCWLILrtbF
         61KUTR8fW0V0MU1812rU1Ac06daQJ4Zzu3K9JrGATV9ext7btSdgvkAC7XyszZwY6uNA
         g1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151322; x=1779756122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKPyDfzW/WAVTLGso+F2wDl5cgejxyDE1jm06Ek0+Ig=;
        b=OSVhWPL/4GwY1Z1+7kyOWUwxQLIT1k820bdX05Pj/ue6kUUII3gFwLZTNBRu5ntD4D
         9cSwHoLGoFqGOvsxS3Eo3WECwFUH+QMkkXlbS3U4QU0E3LDjnaYFQBO4LD+7VfcoA8OB
         FAUoylQmERYB/pUrMQX8nqKkqA3pBJrmE/0oLugcCQBDhr+CJimrt3vOHCP4Iehp3UT4
         UCZZDMMcY5nWKT47EW7eO9g/lLbUtxxXW+AVZz7uZpLWg4NI4Jx9e1KXxwecF0V+F+kE
         7t2BRJ6WbqTsLpSfLZWceMFeXC9YV9QpFzp61QCU9HA19NuXxBOogcT8eaCROfQk4Zzy
         vxrA==
X-Gm-Message-State: AOJu0YwhslH6NmG8ie18IYlCyeSdfdxZsaQKGqesD349dElgoXJ6QzEN
	KYMu2zwKSRlc2+4aHm/ZNvT5HfAHsWkGypTgcTu4YUxgKl27k86RKdkHzJQzreXV
X-Gm-Gg: Acq92OGAIC+ilJocT9uCB3WE8SgQ0EJpBNIDziwboX/YLqP3+6fKpsE/JYA5zEd/om9
	ZjXF2WO5spwMFMOAV+mY/fZNU3sU7Ad7tlNcpxV6eiwCgkxjpXvhmusmNp4yWdRH4D2rTjS0UZS
	MYVxxZO7N8XhwO+ryuY8Eftud3WtYNKgibKCGZLALiySxIsFhWLdIf2z9WET34hT5orRC9P8Naf
	Mc+lPTadLskdMANsWiFBkgc6DzhcbWoqv8FmUxYHaC46GmKVM6RF50k9gzvb5bofT3xOi6yU/ow
	+OH2pox+N73DCW6T47XZ2SeHFPanaDKJ5g9nxnkU7rsVdpdnT62v5F6Chswmy85RXsznzUYR7zo
	Z9I38iK8Fq0gCu6G6IiIO0DeN65CZDxnjde3aN3W198bwPDVRpqphxkIUNjcZphjwSAsQ3/h4co
	cwUUdf0ENzKluKBeyBQK3g0HW0YzyGKM2wov7qWCs8Rxus+xjoahGdAJt6bwY5n/BPn3aP9QHMH
	p5Hn1Muphg24vFk//dzISzk5tSL3uwULCQ=
X-Received: by 2002:a05:6a20:9190:b0:38b:eadd:449a with SMTP id adf61e73a8af0-3b22ec635b9mr20395564637.38.1779151322481;
        Mon, 18 May 2026 17:42:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062941sm18819785a12.2.2026.05.18.17.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:42:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] power: reset: st-poweroff: Use of_device_get_match_data()
Date: Mon, 18 May 2026 17:41:44 -0700
Message-ID: <20260519004144.626969-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch the reset syscfg data directly
instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/power/reset/st-poweroff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/st-poweroff.c b/drivers/power/reset/st-poweroff.c
index 85175066beea..2c0cedd18406 100644
--- a/drivers/power/reset/st-poweroff.c
+++ b/drivers/power/reset/st-poweroff.c
@@ -9,7 +9,6 @@

 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reboot.h>
@@ -73,15 +72,12 @@ static const struct of_device_id st_reset_of_match[] = {
 static int st_reset_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;

-	match = of_match_device(st_reset_of_match, dev);
-	if (!match)
+	st_restart_syscfg = (struct reset_syscfg *)of_device_get_match_data(dev);
+	if (!st_restart_syscfg)
 		return -ENODEV;

-	st_restart_syscfg = (struct reset_syscfg *)match->data;
-
 	st_restart_syscfg->regmap =
 		syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(st_restart_syscfg->regmap)) {
--
2.54.0

