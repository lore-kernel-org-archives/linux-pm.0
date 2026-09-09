Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8952FE49
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997714; cv=none; b=hCptX+EtU+9hmU2S3Q98sckBCHAH3jAlqkQgri9tTMsMOkOdlktzjE9aroYdqTdNiHaFQ6xnl4TMs8q8Lxw8LZc25ncjqkfpSOb/JJRBgTivQjmMPXN5chwVocVPr0otmjEF7IdedI8biumQSZPPuiwJ4ri4I+hrz9HpGVVdQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997714; c=relaxed/simple;
	bh=e8dMr4f1lftzqjuMaGOMoLD/h2xtn1XixeP1l8uWEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S61KGS9SNZHOdw7s7r/VCZzUJgtMw+07EdBaaI5tIpBOzFMsxFjFp89ygeONnYro5+ckdIFn6Av5JJeq5RrGWaVtYLEN23ztkUlxEHWBOSl33uX1uPXzMSbzbBnCGI9T/JNkcS3RAXVEk6P1OVqqck0Q+6/BhAX1Zf3FRvPcSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRAbIhBB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRAbIhBB"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so5099755e87.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788997710; x=1789602510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXMJykHKFWPZ0jyTho5hTbIzJ+mvaOVStcU57671ubI=;
        b=eRAbIhBBrPWDOG94y2ZrSZe5NGSbcho5be8tVbFbFraegQHYCOrxv1EbkHN+H2QPLT
         BmOa/WCiduCc0EnBpkGGfCmzsxxch3lGvKOSVWtJ0ePOsNrZtnvXanmL/JbO9KN6mrQK
         enOcWUoWmc00+ifCRlvYBcphKHCefuNQN43lB0/TcN1qO+wc4yTQXVH4BlJWQ+qG9oCY
         kuqREw5QVTBcZLYagIABZ6JxibJ96ak3H1Dmbza2RFV/JUic4BXRGm/Juq/wC0yJeHTt
         Td501/bDGDF5sJCw8ENChENa2GuYwKCtCD7lOhGQu8Mn3SEc7pJ95sNvg8yCXHPGtLpQ
         n4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997710; x=1789602510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXMJykHKFWPZ0jyTho5hTbIzJ+mvaOVStcU57671ubI=;
        b=gEKzrdPRwtUphxzx9YngNUdmqq8eieH3Vo40mAIvbUrPch/yYZ7Bno9HDlzLDrSWi9
         r1AzTnc6oq8rln5+eePAmSaEwc1bIfS3Rvb2qZAhtaDliEJ3luuQxjKY3+ZFNit2b77Q
         AoS5+uVwpatvDeyw4EFs/ux72TD8xM8pa/pxFXPIxLeHBKRcAvWT+9Kho5g2QHG5l592
         XYjiW7KKhhRduFbTjzYKuvRjFiwWcYgCvRqSOWw7A63yVfNj9st06/w4ERYtsyyspe3O
         m5ZVcuhAifAF9EmzVzr6dHHPTXru8sRIyZlY2Nwyo80RaQ162G257e2tLPA+yfvELXF8
         RsNw==
X-Forwarded-Encrypted: i=1; AKwUvBxBehzqoqtHkzivj/vjTizQuJ8UD0cTS+oJ9azyawNqah+u4BRuoZlsySK015RpJXKUnKMgAXjptA==@vger.kernel.org
X-Gm-Message-State: AFuF++kJ1fMPQC9fwZwRoL94Z4nOH6yAkMrB8sZlTr2PJEGUv2dWQAez
	M5mvfc3sRWh4cOgS5nehh+EkyP9B7W/dqdo8FNvU66crbwknPsXUf3Yn
X-Gm-Gg: AYBFou3R095AfS4CvwMR2JvRuJyOLYuEdHPZLZzZTim7l245VDoJsZJQUVAXbYZ60B7
	V8hMQvCJgkttNQswWNy/pPJ1TJ0tZorK1ikLDV2bbdk3a1+hCuWMZ8LWYoj5VNm3tYXqlGpnj5G
	aL7W2dr5F0hVjLUd/bQ2kdAgCuGnmMItgsWWQyW5dh1exNkDlUc++KoKw7MrAze/+9eWiERYlXs
	Y0ZlhhsGQ7od2YiIl3lsb6oNoB1sUvOdJiUvusG0kCrkWqSbkaLaW1d5qlm6hUfoJnEAkJvyRDU
	JwIIiAfkIc5WxdEUkl587UWfR8GzZYOJhOASX6KzhqxbhMRk/p59fA/8dE2K9gICeNYFBlBwGM1
	efpfxC4kE5UPyDtiG0pH8Z6bPz5/jbbnQOQt9xlOPL91Yt7XMR803+PuD8g/BdzNv2U8Bt5anV3
	LPqPh79gno0UGueqiWCQtyhwKh8UUQZJjzISBZW6rR+VFyjIyz2oXfEQLifcn0kxCfEwcO6JC6v
	2+eRL6++Oqyjgud7I0M8kgJTFTov9RnVdUR5Nk6
X-Received: by 2002:a05:6512:b8d:b0:5b6:1a7c:28 with SMTP id 2adb3069b0e04-5b61a7c0215mr6090288e87.43.1788997709683;
        Wed, 09 Sep 2026 16:48:29 -0700 (PDT)
Received: from notebook ([93.189.200.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ed4cesm4153300e87.26.2026.09.09.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 16:48:28 -0700 (PDT)
From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F . Davis" <afd@ti.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-oneplus: use generic fuel gauge compatible
Date: Thu, 10 Sep 2026 02:47:44 +0300
Message-ID: <20260909234744.1177153-4-rinat.muhamedgaliev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OnePlus 6 and OnePlus 6T battery packs may contain either a TI
bq27411 or bq27541 fuel gauge. Use the generic ti,bq27xxx compatible
so the driver can select the register map from DeviceType at probe
time.

Tested on OnePlus 6T (fajita) with a bq27541 (DeviceType 0x0541):
after booting the new kernel, the battery reported 4.360 V, 100% state
of charge, 27.8 C, and Full status.

Fixes: 12dfb002ca01 ("arm64: dts: qcom: sdm845-oneplus-*: add fuel gauge")

Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 948a0dd..8c5cd94 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -790,8 +790,8 @@ &i2c10 {
 	status = "okay";
 	clock-frequency = <100000>;
 
-	bq27441_fg: bq27441-battery@55 {
-		compatible = "ti,bq27411";
+	bq27xxx_fg: fuel-gauge@55 {
+		compatible = "ti,bq27xxx";
 		status = "okay";
 		reg = <0x55>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index 5f01115..cf40842 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -44,7 +44,7 @@ main_cam_ois: main-cam-ois-regulator {
 	};
 };
 
-&bq27441_fg {
+&bq27xxx_fg {
 	monitored-battery = <&battery>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 7ffcad2..9436027 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -67,7 +67,7 @@ tfa9894_codec: tfa9894@34 {
 
 };
 
-&bq27441_fg {
+&bq27xxx_fg {
 	monitored-battery = <&battery>;
 };
 
-- 
2.55.0

