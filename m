Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF663793C2
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005049; cv=none; b=PvG6wK6Q0FJ4BcFXe81E7887WLiP5+AVCbffcHldl2oVKd7o4tln4OPpvIFqLjcx2Ns9Bx/weDMxtzXgXozSCn0MoBqjluxch4JxRtgjbETQLGcg4kklDktxCUnPt1KVnIUi+2ua+blU7lFjU0UtSfPJUh8BEZhi1qdlj+9Ljso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005049; c=relaxed/simple;
	bh=psXMmI1AnrTNmbUPhfuPxpMrDFwww3OT+Tpf52rUs4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B4qVzU5PwmFhVmWNC4bbtixOYmeWljwTDzfwllZk019EUvFLHyJARHKL5BCOagiTVFffqPGydOF0girelegfg1yU5+4Fjne82N5ENdNcx9htj3YL/umNYQub5HD+zDdc9fdKaQVHCEXpJ8YNyeSc/sIea6UUt/Tdy5ULOsVsj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhMSEd7B; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhMSEd7B"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c4464dfeae8so4100722a12.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769005047; x=1769609847; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKrrqjcg46QuFiM8rQG6H6noqywu73UQ7w/zxl2mM20=;
        b=dhMSEd7BL3WsHYxwbkQQ6e6uBBMjTOALKtoY64KD2c2n4Y6Vqyf/vvPjarH7NW+UrF
         E6oVRPWKbvJQnvXJM6wBUKqg5KpLSkPgr6i10YOjWowqduvFYJ+U9n3KA8lDC+V6XTZ6
         bet3TwUcC4jyfUdvUGmcPAQJxab0UxOQpqhtwrBVc49m1k/26vlPOZQBaMcbuAt3kx/x
         iSs84eb9UdxSg2O4cSbaxbXCyAfLGfPH4H6NLOvVBDHMPoDvZC5OEpSbNCUurGZEgLog
         KNRaP9ahkw/zyVYlG4GY4qvJjWZaPsgRt89vGbKhVhDwk5uhS2hT6oZOvsPVC8U4m+dq
         he8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005047; x=1769609847;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKrrqjcg46QuFiM8rQG6H6noqywu73UQ7w/zxl2mM20=;
        b=mgKfFyfyh+yRJWcVd40kWaCJvG0IsXEUmYP/KPjHAVEFPmxQ0NuhXG6lv4t4h6ISEH
         eAslEMsWIcRRR70DUZnhj/9aYVhSLjsZX+pUOy/Ck+Bzlx2ssfS3TZbaY0hy3XhuuodT
         SQuEWK7kALa1eFW9d2ydgxfoEkNfJNXvziwZr3NdOF/Lto+jrwEe7oX58yu7tD1QmI2H
         P8p+GF/aBQJpBef05ifygBESuj9fc0iX3xBZhrOq1n7lwKhBDeUUEa8nBfH4U6BcOCrz
         GGf4spH2QxhOnSzWrcZSJHT92H+nQ3tP+48wQo2OWfU7e6iRcH+OftfV3S8hoU6VNxA0
         kA7g==
X-Gm-Message-State: AOJu0Yy/zJIDxkOFB5Vxd+dcDpeK8p0T4y1KxI+tDQozp5YjJSVMWDLc
	Y6tB6VcsEvS7j91WEL+fucGLu4B73FBaZmLcjrVRJGAspDsY6ZiM2Ghr
X-Gm-Gg: AZuq6aI7kTmFXwjxaFJWH9CfPVlWycy94leBcZUmtsUT0HGNdFUb41G7Hw5Ij5aujQ7
	qkgoUGe37l6VsHT4v7UnvDMXXNHIOZslxSb5tXsKF2d/yDo8q32XzHtrOdyF16gKIwnLfvkPl7q
	Z430SgFxw9aMTfu+PibMo23SfwKf00zwuF1sWD9xCjZM6DEoXU4pEejc42FYw724W9s/qjHIC0Z
	Oo+v427bjCOeLPZndTPXF/fsKf4Ptb3T9TZTFg4ZO1HdZHmcZ36doywOFoPOaDZi4nzb3tva4Dt
	3+STXsSfY9wsHmB8UG9J80Tea66U1Kkz+1xTR+saPe0g2y+ZinNV6ARmgt+LK26zIKfXvlZg6Ra
	FJCsQBkIE5cR/iwkUni9j0EmpDDCPNoWJFxmoshc/lYof2WX8y5Q/RmOg2I4Kz1Pz5Z+X9GbQSE
	6fv1p4M2ksSC0mr5IdyE0863A4
X-Received: by 2002:a17:903:2f91:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2a757515da0mr55304155ad.12.1769005047012;
        Wed, 21 Jan 2026 06:17:27 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190d14cfsm158144605ad.38.2026.01.21.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:17:26 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 21 Jan 2026 22:17:17 +0800
Subject: [PATCH] firmware: imx: scu-pd: Fix device_node reference leak in
 imx_sc_pd_get_console_rsrc()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOzfcGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyND3SQT3eLkUt2CFF0jU/NEy0QTg1QLk1QloPqCotS0zAqwWdGxtbU
 Aj9diLFsAAAA=
X-Change-ID: 20260121-b4-scu-pd-257a9a40e84e
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769005040; l=967;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=psXMmI1AnrTNmbUPhfuPxpMrDFwww3OT+Tpf52rUs4k=;
 b=UewNA73STZQdwpe60NY3QQLvtNzecqxLwUk0xLMEiSVclZNQAxE+IH3eKK335EAGp/MKGyHZG
 wY4gCGmtTJ0DRQcZJY1wETuCJmC9PKgZPFG3SozHPeDF6CexTqIJ/lk
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In imx_sc_pd_get_console_rsrc(), it does not release the reference.

Fixes: 893cfb99734f ("firmware: imx: scu-pd: do not power off console domain")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pmdomain/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 01d465d88f60..3ec33667a308 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -326,6 +326,7 @@ static void imx_sc_pd_get_console_rsrc(void)
 		return;
 
 	imx_con_rsrc = specs.args[0];
+	of_node_put(specs.np);
 }
 
 static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)

---
base-commit: 053966c344dbd346e71305f530e91ea77916189f
change-id: 20260121-b4-scu-pd-257a9a40e84e

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

