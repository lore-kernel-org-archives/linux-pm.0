Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022747;
	b=0HqLj+ivqZ7JKI3/L9pP5oyCtMjAAaxbCEBOUvKG+c6eFu0SDSlfeEtIAmvMs9lSfvNG
	 iwdHy0FcxvJxapHqZd0IjEjF/HJzoRWB3MoWcYKQsqJe9ANyQilRdai32XWrNjiygnl4I
	 hqWDB2bdUgIKulbYDghE5j57+YSvnCPBVc8OLj6EK7CEbPTt8icKvB9oehzp2+W49fPf0
	 pZK6/m9dL5TCV6sKfngnfCWM/Zx6zJ+dQdgjDsSsjgfRtkqIbRcm6/42M0cBQqadhqx8A
	 31H3JI+32lg/4lBxKxECWgxIxiwZtzKLWI2aiKMUoSKsqUTA34/Y853OQya1z2kNMag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AwKMc/EqnqgDybL3cRF4Oi7rVRBolnPSUkDLNrsEu7Y=;
	b=jSe16LpwiTFZg0IfK9lO7l5c0lIRI1vj73rHz/4E8lhi7uoYIjfS6fKytwahAE3Pgelz
	 r9RsU16RWxqND2AzutRd1sqUuh+MnlWetNlmpjAC+4S6A01aPcEkxRAenD2TV1n55CC6C
	 Cg0AmSLlylHYLnyHE8G+8OJ2TQrcNmGM4GQ/vL9shk/Gu7Qce2D/meBdG6B9c7WW/oPab
	 Kio0HqOFpXhTit4mGK18rLxb6LD62Y90IFXX0SWGq37lABCVNXheMDoBYYThmcsK9Wf4d
	 Jc08hpYij6dp5mr6KKkBfDON9yKYykZYOwWtV3k4xv+YMhcwMWn39tYKXMMhq9iRSTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT0DBUT7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F060A3815;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT0DBUT7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022747;
	b=YhSt1JGBRf6t2Ek1G6oGqhh4MuIeIRPcEBt/fAZKaS2Ta5Vm/kBw0rR0EXKTgjM22y3j
	 FjDQAlfTBaXHYUDUYbb2CB4hn6k0oU0skkYlwTargxU+KLQLG/DaE77HS96MdWVoX00a5
	 vmVhhj5NtCPn8V8tn5ftm+yofTGCJKKY8k4WWkvAiM33UUQD5qv+27ViumufLCGqXGwVt
	 JJUQ1vh2WxAqS+quZo6Yb2lv1BqzWM36+F5hiaLLtWmGGQyK7Witpu8nc8+ic5ujwKYho
	 QMW3jfC0KIEcwQRGt3rZdQiOUaYcdGCskT9I4/nGZns0dow5Ikqf3c8UkSVFpFTbDKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AwKMc/EqnqgDybL3cRF4Oi7rVRBolnPSUkDLNrsEu7Y=;
	b=0kaUH5UenIA2fmpBYF8zfAETUyE8uz5jIbXTb7vsiVizcU++yGTRwt8SrQUt+lUrpCIY
	 SDHNtckvEcOvYZUvc+ewV28jvVLpNgzpEB2QGKernUZ9ZAswRUOfcjlYGp/C7VlMnmPbl
	 K5yVEl45MRin2sWYbgYae74hXdVxwozzHFPx2wKzVX0Va/olATNceUCRQNJgj+p2fV1MI
	 uCnZ3EHM7WLNGHsud1Hx0Q4ZnL/esXhYhv7Yyz8ciGGwSUobfVfdVUylbyjjVitSJ6zCX
	 0j9fRhNBLXYHLAJnzbFGfgiugEQQ9ceh63P1GAcBVx3zr5a0u2FK/mhGjUYtEh5OIsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8A8BE1F000C7;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022747;
	bh=AwKMc/EqnqgDybL3cRF4Oi7rVRBolnPSUkDLNrsEu7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QT0DBUT7cAariim/JjGVx6IpdPsouvfrByzUAk2lB74kVMdOzHnwQvAP798K3u7KO
	 omVcUF3MjImo0TI1Z+zl9edUOGLdH1PExRh+YMcQjxHCWxoinewAN3ctQPCUkUD85+
	 saWjaDzgSBzi7YlL61DWykgOWr7V255KR4+Wcfrcuhj/LrwdBY/nWkiO2Na/uriyj8
	 1/fRnlAGv9TIHP2KBJ38D0JDtTFKuUfRJ3KakWwl2oH/5pmpM+Lyr4RI8RyeNfgcp+
	 tui5ySN/2h8rUort7XAe2rJhKphsRzLN12Fldm5aA9NtTaC78p5haSIKaKsKSuZ5E+
	 OvE+q9X0VEnpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 170AE4AEE2;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:36 +0100
Subject: [PATCH v2 03/12] power: supply: qcom_smbx: Do not interfere with
 vbus driver
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-pmi8998-vbus-v2-3-3c77a72b280a@ixit.cz>
References: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
In-Reply-To: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=1RAFhqxbLzWvkajdEIS51cyQ/wOX5d5vQdDgirzDWBM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+WlU6ezqlUSvyrj59uaeAlbkXY7bU0iFj3b
 E9mR2ttLgyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flgAKCRBgAj/E00kg
 crL/EACYL2H4LarFjAhJwiEkEYgD3uzceVKZjxaieYLNo8zrTHYPTFLrB+UhSHFhR1v30iIYRuA
 p0jJN7dW3fQ1C8EZM66LtNZs0NKjylgPK+Erc9QWCD2l9upLWdxaSZweun4AXOtCpAFCUAG5fMF
 /89B7hnZewzg6oQtIkTwMFACrPxEX5vzqHKjuJ9JxWJG4oOdjDHWgEx00J4Ppqb98YjOi2cov28
 rZqsJbzTkeIIXjetvQ7shYB0l4Xc++KsySh9iUg0ZAXOXsjIewPLgdVxZyWBpXOeKFyuQQ5xx5W
 QglHr1pqJXF5Yw/O+93R2vJwitYG+vQ/zPNWc+hDVcsi2ciGz7KENMGkXAko9KQ7CeOMYs7s7nV
 2UPHHzR6m4apn9vNVJlAAbN/N9OS9LZuM7naFfLtg/y2piVGZIfsZSwbIYqBthX32FlYa1Pdfx5
 V5WkqCP0/gIMn2/Kjt+sjlV7Zw9hg6CnsdakFm2NJvSUndA3YBlRTjN8VV5bDrcW49PEyXEkxGz
 pYVFtjAzoan1rueejsAndNs0LbGP8+Ou2//4rJSPUFKycSeu++F8cQlV+PuTkA/qG6kxlWKZ7L2
 dDEabAZWsd+t/ntHUoKGEprEY/aWxCjKyKniIJeVNOky1qD/vXYoz4cozC0eC3iSdtQFFPu/KTK
 ho0qUmvlFwBIezw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Charger should not touch bits handled by OTG block handled by the vbus
driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/qcom_smbx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index c6188c915703a..a4f5ffd3cd6e5 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -96,28 +96,16 @@
 #define USBIN_ICL_CHANGE_RT_STS_BIT			BIT(6)
 #define USBIN_SOURCE_CHANGE_RT_STS_BIT			BIT(5)
 #define USBIN_PLUGIN_RT_STS_BIT				BIT(4)
 #define USBIN_OV_RT_STS_BIT				BIT(3)
 #define USBIN_UV_RT_STS_BIT				BIT(2)
 #define USBIN_LT_3P6V_RT_STS_BIT			BIT(1)
 #define USBIN_COLLAPSE_RT_STS_BIT			BIT(0)
 
-#define OTG_CFG						0x153
-#define OTG_RESERVED_MASK				GENMASK(7, 6)
-#define DIS_OTG_ON_TLIM_BIT				BIT(5)
-#define QUICKSTART_OTG_FASTROLESWAP_BIT			BIT(4)
-#define INCREASE_DFP_TIME_BIT				BIT(3)
-#define ENABLE_OTG_IN_DEBUG_MODE_BIT			BIT(2)
-#define OTG_EN_SRC_CFG_BIT				BIT(1)
-#define CONCURRENT_MODE_CFG_BIT				BIT(0)
-
-#define OTG_ENG_OTG_CFG					0x1C0
-#define ENG_BUCKBOOST_HALT1_8_MODE_BIT			BIT(0)
-
 #define APSD_STATUS					0x307
 #define APSD_STATUS_7_BIT				BIT(7)
 #define HVDCP_CHECK_TIMEOUT_BIT				BIT(6)
 #define SLOW_PLUGIN_TIMEOUT_BIT				BIT(5)
 #define ENUMERATION_DONE_BIT				BIT(4)
 #define VADP_CHANGE_DONE_AFTER_AUTH_BIT			BIT(3)
 #define QC_AUTH_DONE_STATUS_BIT				BIT(2)
 #define QC_CHARGER_BIT					BIT(1)
@@ -811,18 +799,16 @@ static const struct smb_init_register smb_init_seq[] = {
 	  .val = VCONN_EN_SRC_BIT },
 	/*
 	 * Disable Type-C factory mode and stay in Attached.SRC state when VCONN
 	 * over-current happens
 	 */
 	{ .addr = TYPE_C_CFG,
 	  .mask = FACTORY_MODE_DETECTION_EN_BIT | VCONN_OC_CFG_BIT,
 	  .val = 0 },
-	/* Configure VBUS for software control */
-	{ .addr = OTG_CFG, .mask = OTG_EN_SRC_CFG_BIT, .val = 0 },
 	/*
 	 * Use VBAT to determine the recharge threshold when battery is full
 	 * rather than the state of charge.
 	 */
 	{ .addr = FG_UPDATE_CFG_2_SEL,
 	  .mask = SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT |
 		  VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
 	  .val = VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },

-- 
2.55.0


