Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE741F7C9
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208383; cv=none; b=GauXpcC+xlPkBQZMs/sUfDbGRbMA+psZaKcilEdNGtYS0DomzNSnRktq4xyc7x+iB5ehMOrA2GDhmSWdbOzeqFqwzOgPhTOJGAXLit3iN9TqRzlFBXsFXQiGmKK+4Qly9LyJikiBKUpB0Wr0n3boj1rQcVc0bIoBrISOE32iglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208383; c=relaxed/simple;
	bh=NHARLWYGn7PxNM5VybiPt8610aUjwy8ufPU3G4O7DKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTzV/JkLdBNbpZxu+K2xiFxkLOEiUQK1l03fYgSb1ntY5mBpe6UwD9ejkLidvcLF3l6jHuMnaLqAw62d9v+MVCJXf9ElnCewd8HCjfuP68pLvtQ5CS69RKPt5Izl6raue3aEB6o8jMHh675eh6Li1P5DxPnrCWAvhxfjjW/XomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mCjg2nd2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mCjg2nd2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4759b4f0897so1891682f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784208379; x=1784813179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFzMVT/fxpUw3oGY/5v1mJvn+DMLkKwLSq2ofWAuoMc=;
        b=mCjg2nd20F/THMiI32AQHvA6G36LBSAh0bfIYFHT6ndBY9LY0Zzx6T3Xy90YRRsGsR
         e6O2YFey7cmcn5AqvznXOHhdn0mp4Wuhg1+e0NXBUmCBWQAkVJDKqSfFyLmSLsPHu6Fy
         GRV/1kA/eJzGl7SaC5z8aCnCnPp5R78O7KOQ/YHzULEEM4iDqxIvn7IpvRV5VEKHPsKl
         mJkn1mOjUTl2Jmagwyc7XVg/pbXWToeTba9N0Kgk038XYPyC4MPCgHF5KzW7FegsbqAF
         uZkxkogkbs/w4HA4uGxfGv5YWI5i3UgOYWR3RaimQJoXhI3nWJsNPeFPag5bzhLfoYxH
         tQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208379; x=1784813179;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFzMVT/fxpUw3oGY/5v1mJvn+DMLkKwLSq2ofWAuoMc=;
        b=DY9gbxHYRRYFv+U5MXJzUBcelg0/VvYJ5iGL0m7kRjHAYVMb+Ssmrl+6AIu5Zvf7S+
         dAj0IaWsMZMchzlHaWrTyWxsNVnXtPIKAm3J0yxYOjAw124i+RfJpkRtWVGd3DLChfbk
         tW+9oT0NyZDg/P9pcci+FiriajLuw4dqMa/noM8D24GHrNnU1ccStXBrB7OiF5R2EIdU
         71o0vfJDX8AdI3aNpltfHOHPc9a9iWXnw6UAciNwaBqvqGhzz1k076s+Z9gHdtBkSCjm
         eHuYqh2aZRsuYa+m9FDUsfwTjRS93NkdYjT+g45JljFS/hq3GOFNVJUBLYD7HDVktTg7
         ud3A==
X-Forwarded-Encrypted: i=1; AHgh+RqnpA7mq0GvXahgfQw8oWZpBsZb9SjoxfxGNvO0OSxjMaHciOOmXOt4pr73TN8wOcNKoBkZeW1xsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcNAO+ktLwvg+4xWEc7jsYOa2dPGdfHGKqr6UCVsBacsa/kJB
	AcOAdQBf5y8ZJuEo9xmpRi+86BeqOVNDAItZVEIdH6loy59T5iha7mHEpFtgNhZhNHU=
X-Gm-Gg: AfdE7cnbq9I/AKbmoQ6yIV2XEXiUK8cfgGZxewJMeNNcbTzKBKdxP1AZ/Jm2ZT7VHAP
	jth+RqLhXNNThrNLtKmzx4HIX4a2sJ58Hd6dpztnR6pVmXkkWfpizhSpD4paIoLf8Tq3qrl3Csp
	Y2UeInwt3WyYB7fwX3AZVIZRjFZz0mbHQDMRsEeci7KkcS9xYpJ0Uk4KYGnxJynxGE0G+FWccvx
	vQBDKW21oDeApGCNmdY/XcZR9ZrtYylFE2K5IiBcVSvjdKKSAd7F2of6Tm5QmM3lESWth/qZjA3
	PKDUSUurJvmAsMxwKBrCvaeRts/PJaErLJpi2qPLprgbXAYWrLZgp82xcuPHd58j6Kw61sfPF65
	9PzpT1ydo8Qa2J9TEigYY317W7l9RRbzVVwjCoFHgk6FVyrLir49rmCbTydCgZwZ+Xfd3QTliSn
	V4x33a0jZBrfYJ9eRtZqmwFhsuLQPnM0U43+8USt5miN9t5avDbW76/Xc9GvsX6lqRRg==
X-Received: by 2002:a05:6000:4020:b0:474:d7a5:4b7a with SMTP id ffacd0b85a97d-47f2dcd7881mr26682749f8f.28.1784208379566;
        Thu, 16 Jul 2026 06:26:19 -0700 (PDT)
Received: from localhost (p200300f65f47db046a548a0537ec1e67.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6a54:8a05:37ec:1e67])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f4635c86csm24865590f8f.16.2026.07.16.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:26:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: imx8m{p,}-blk-ctrl: Add MODULE_DESCRIPTION
Date: Thu, 16 Jul 2026 15:26:03 +0200
Message-ID: <20260716132603.2327847-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=NHARLWYGn7PxNM5VybiPt8610aUjwy8ufPU3G4O7DKc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWNvr7p362KrSgGq/MwLyX8ePENAWBwuUho0S1 lBUfqJ+5pyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaljb6wAKCRCPgPtYfRL+ ThA4B/9DIt4u0eyuHj/nw4Z16VgiLTd8MFcgifqNi2C8wE6iMPf1Zrnp0omeMA/j5+vNpgbrl1b 4kV0Lnmg20mwZG+5yg7Ql0i/JqOSnv7SsM1fuhOHM19Hj8Gma+5H8Rk9T8aZtgxA05fXFrRJrRY wHgH3WWKLd6+TTw/qQHH+Bur8l+ACjmM4uKMH5t/5HmbwkrIQ8MlVVS6ETk8MwfWSVeq9cOjFHq nxA8HWCFjQBuoQQBICzPidpgeR5Lx+otFs9lV6TzFmz2vYRuOg0x0D7q/Ar8H267Ztm8rJFHFPZ A4FQIv2xwLveDoTdFYFpyClqJUquC1pZUib48KBQZ468YQ9F
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Without a module description modpost emits a build warning:

	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/imx/imx8m-blk-ctrl.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/imx/imx8mp-blk-ctrl.o

So add the required string to these two drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 99d100e1d923..479789009c7f 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -953,4 +953,5 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8m_blk_ctrl_driver);
+MODULE_DESCRIPTION("NXP i.MX8M power domain driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 3f5b9499d30a..d255c20f58e2 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -890,4 +890,5 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8mp_blk_ctrl_driver);
+MODULE_DESCRIPTION("NXP i.MX8MP power domain driver");
 MODULE_LICENSE("GPL");

base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
-- 
2.55.0.11.g153666a7d9bb

