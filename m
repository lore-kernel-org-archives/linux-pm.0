Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350413DDAFF;
	Tue,  7 Jul 2026 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419511; cv=none; b=AKVgIzQEB/eKlp6rGr686GFmW1VeYUIQ7gDoB7C0b4Rh3ajFRC7Z6+aeOyzNYkINBdqEjb1S9wuzMkTy03mU4Csgak9e/uAEk3vzFg3DxxLVs+8N6lyxzLj1mHRNi1OjvQxLliXVPWg4LN4nyVOAJ89Erfxxe3pw4eJlVnAiIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419511; c=relaxed/simple;
	bh=5XHG9mRRPOrh7Tu9kX4q/JsR3SeFMTY9G6JTDyva/fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp5nAl2Dp0Ru1ZpTdZt+QNXjKNKBICIQTnIn0Fq62zvtjoVui6hyF4iOZj9N9m3J8/XV+WRAF29UmO+iifgxYx4Hpbk1lbHe+PD4FU8GlO8D5ePe3QP0CifTxOqrv3+47v8I4rTfqzYzWoHeMIaex01rs2v8IWB8iGmGZJfAWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SodfrAFH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SodfrAFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783419508;
	bh=5XHG9mRRPOrh7Tu9kX4q/JsR3SeFMTY9G6JTDyva/fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SodfrAFHoMOa/TLv3XRr+7So1pgre7YIMbpdNFzDPsb6btN9ijrt0XFJ7gy38de9A
	 Q7jhpYl/sNEeGbJgCRgoJR0U0QzUYUBHH1DOrvk66RabG4krNg35G0kOJ8jXvA6xWY
	 h2bIRORhlqgcsr/7uxQ/p7obDrDVz7uwjepYOEVbhg6+Yx9pP+FMH2Cj6jX5upXRpP
	 dHNe65SN39W7v59BZ/eR8bSXBC4zOO4tVo8FlU1huv/9w1ymso3yUmGaSQHF/7zRJe
	 Pd/JKXLtX94WS+fTgsP52Kq1FOSf/QD1uvlojU1FKXRdIrorXbzdMhjIRgitsGbS3J
	 5bq3Ed++X8nvQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 857E717E0CDE;
	Tue, 07 Jul 2026 12:18:27 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v11 02/12] spmi: Remove redundant dev_name() print in spmi_device_add()
Date: Tue,  7 Jul 2026 12:18:11 +0200
Message-ID: <20260707101821.173319-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707101821.173319-1-angelogioacchino.delregno@collabora.com>
References: <20260707101821.173319-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function spmi_device_add() uses dev_{dbg,err}() for respectively
debug and error prints, and passes the same device pointer as both
the dev_{dbg,err}() parameters and to a dev_name() that is part of
the actual message.
This means that the device name gets printed twice!

Remove the redundant dev_name() from the messages.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 293e1adddcd7..9bee0cb3d9dc 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -71,12 +71,11 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add %s, status %d\n",
-			dev_name(&sdev->dev), err);
+		dev_err(&sdev->dev, "Can't add device, status %d\n", err);
 		goto err_device_add;
 	}
 
-	dev_dbg(&sdev->dev, "device %s registered\n", dev_name(&sdev->dev));
+	dev_dbg(&sdev->dev, "device registered\n");
 
 err_device_add:
 	return err;
-- 
2.54.0

