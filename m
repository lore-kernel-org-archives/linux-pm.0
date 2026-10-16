Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C593845AC
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118080; cv=none; b=LhL/g0QOtqG/0QkQaW6s+gU84p+qzpWiH8e1Y+vtl6cSaGWuOFNE48of5rmI+MPxfWUZeGi+EqHA6D/Lw4kpszDONy2LXgB3gWbkhXzDCX54TweF8gLZA2MFfbWbsvFvSRNK+Rc2U3RE1KGgZ6U0DEt/0Crl5Ys5Kp8chJP11Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118080; c=relaxed/simple;
	bh=Pr5xAIu0MxvNLeiU8vK6icLPvs/OZauFDuqJMoK1UYk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BvceXDMS+ewQMFkzR2cXykV4AjdgjzC6s3ZGF/Rv7vlmALk6H4YRrfW+/HSN4dYgTzL73uvY6sn2P+udgwWsoOpBk37UtPGNQMFwK0/1iMuj0yjlVUwtwlgmz79/IDts+rFBLfJFmjDmbQiniwLV25FvFcTuAI5TKdJlC3HnchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jplxtfv1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jplxtfv1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-918f75a68f0so94136386d6.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 19:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118077; x=1792722877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFt+NkiDlD6gbaWYo0pDmycQ7qIWrP9xpnL4311ehgk=;
        b=jplxtfv1UnWPwnzH1CIyq8OMgGve3I0c/m2kqeNlkv8CMErZgvYshsnO2tqSwU+0hk
         zq1AS/khOMBfP5jxAHnSntn+L6LPubF+MTT0ivK8dKOmFuOKXe9ezvhq+aIVoxgh8G8p
         b60Lp/hyGpNT8X2jtzGpWNCHB8zUsSCKgv9CjKYK5SQoof4Okc0naFTMcm9WWaLiQWMv
         1oAccASQO98S70ACX8QpKLQ9tT4XNCntlSmr7kzh5chgJg+oe+B50bvGLmuZUgpN347m
         TkP2hosaxmOj8dM24Cz5WyfeLYX7qaCQZPQASV1yN6AP1YQhRck/Evr1wCqyggQzBsYg
         fKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118077; x=1792722877;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KFt+NkiDlD6gbaWYo0pDmycQ7qIWrP9xpnL4311ehgk=;
        b=VRr3cArfZVz1VgmLI0sNuOsaRkRTJ/hpLyxd0okaCadHcYzsG3BMqOvAJydnVSrlhy
         3r2ABsTHbu26+LScw6FpLKcSPEGIJJ8w1CMoWUS6C2h0ENpp7uhOFVSlBfW220oNxbWU
         r80tHwuONzdIiyAEAPxoGG6Rw3gaH/EqoQdHV+M20ardtqQ8HVgjwv/NqZBud1zB2YXU
         pTzVzSGyHoWIlEq8bNx/VnpJkhU6r7abhRIcs+7LYzAZyGoKjTgcA/nw3OsVuB7y/u9y
         lt3IZRjc4R1Rf6y+eKuGxgpkmXiYWhN45rLfFNZxwJ6tFgutI8YOMI9q0BAM4LNtZ/Q3
         HiHA==
X-Gm-Message-State: AFq9FYIMc2B+vpsLy9m396sFsChOcQYIc2zUB+JJDHjZOCp9YhkQb5mN
	ErBEpEycfckdL1pKigoN+nIyrG1if0JlVgiL+7aDfrdNNabonBrbDdQ=
X-Gm-Gg: AYBFou1pw23I4nu5vJ+9eKMxbi5AHhWUjg/FB8N1tjryuWIQqwrWaJtg7yswDceyk21
	0mH4MSPf3t6AbG6/k5pq2tCA0q/Ae9JlMkUdLnoiQm0juKH6cEopOcvcHFRcS8SMYOyn0EylG9b
	6Keq82cbYG1PhdHY8DT+nT1aMOWTHP8dSElkW/5mlqPAszbaXs0HI0/YbQeAYMN6aZSSUCNCA/M
	1UnrbU/ocLfzJ4FIFBlTzwy9dbA4hVD2u8moRHGqv+SZAk2rEsl0kuAct6B0f9JmGl/fje16BVV
	TwWjwrgS5nVRg3e5FNhQgCc6Yo3cQpr8heoyx94BgZCrhA+bfhDNnY5wiNS0C/8TIYqCHOTxQwz
	QKxcA7OOUYaQ2dzblHSSHtDSDSTPG4TkXvnw+Iqb8pB0p+oj7t9UfdwN2aN8qBZmpMdxxvIEN1n
	F4ry9rlUSNuQFwnsIT04eSn5p6HIYBUSphsyZ/nsIM40GPtViFQyXUrBFy3sVWrtetSxPZMN96q
	2TK3O7u5QWEqtqDPIViGl58pfRlQrGxP6QjpwbyUwvWHapFTaPiTZDtFtKPrJYhLkw+/5VSCzs0
	Nx4Ax/PbjT49GK1M0/NghG07pYjS
X-Received: by 2002:a05:6214:ca6:b0:914:7df6:ca80 with SMTP id 6a1803df08f44-91b554c3d31mr370932266d6.20.1792118077081;
        Thu, 15 Oct 2026 19:34:37 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb0b231sm10907126d6.31.2026.10.15.19.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:34:35 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] power: supply: act8945a: Disable status work on removal
Date: Thu, 15 Oct 2026 22:34:33 -0400
Message-ID: <179211805459.3650807.8742309660995961596.G171@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing init_done does not synchronize with either status interrupt. A
handler can observe init_done set, be delayed, and schedule the status
work after cancel_work_sync() has returned. The work can then access the
power supply after its managed cleanup.

Use disable_work_sync() to reject subsequent queueing and drain any
existing execution. The charger allocation remains valid until both
managed IRQs have been released, so a late handler can safely attempt to
queue the disabled work.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change update support")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (x86_64). No runtime testing.

 drivers/power/supply/act8945a_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 7e4b087..61381d2 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -14,6 +14,7 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
 
 static const char *act8945a_charger_model = "ACT8945A";
 static const char *act8945a_charger_manufacturer = "Active-semi";
@@ -641,7 +642,7 @@ static void act8945a_charger_remove(struct platform_device *pdev)
 	struct act8945a_charger *charger = platform_get_drvdata(pdev);
 
 	charger->init_done = false;
-	cancel_work_sync(&charger->work);
+	disable_work_sync(&charger->work);
 }
 
 static struct platform_driver act8945a_charger_driver = {
