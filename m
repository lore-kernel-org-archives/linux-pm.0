Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459124;
	b=DtBkb2Qy5XcNdA52BST3Ui6GAGnbktbmh+ZvXp3ypk9XVMOuzKv8T5MGH4gjrj49kxlK
	 bRfWBQLhc4o0OE9qiwEx3EtsKfMoL9QofY48DARST5yWlgYrpwEf/WWBF7SPcIdvYD/U2
	 XH5nSLPmp2MdsyrzKFrHlaV4dWqAX1CJtzyU0ZGArAjG3z1+9BmCIvn9c4QLuuWof1vN+
	 fyU3lqJts9AjeBYcN+nhPfWONWAyJMLRaTBmB1dtOeya8SsHVLghb4SN3nBXVnvoKKw7q
	 V7c/xJlqXvK3hoNG0Akvl+GEpKQqO5LLieOSctBRYp4sawapi7ngu40tLrZXmSbqANg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OQ7srUuIftjup119qlM7sUBQxwd3uqhTJy8umEpMnLI=;
	b=o7/IqsPgNekjZlLIzafvs7jOjbFbc+hE+KJMtuaKzpIeJSrql8NbCEOVisiZXAjiXswj
	 K0LUddubbcd4gjVIhoT+oHNhWRPeSY1Ef/OIFtzYjoprPtYBFH5PkUrQ4D1GofydCC/aK
	 0Deuq2LO7mJ4ZvVWa91A/0tMsctT1MRXySJE3mCYu3PYQD2xWOAhZ3Xc5s/rhiPQDBhHk
	 DEdtTJWFEBqaJsfJltiMWGf5p8GwKXynbkj6rBCMIxxzF0znoktSBLEWKzfNQMeOnI9dr
	 VDCiIBR9P7pf2pVer+M1JPywDGIPMZwJnuJGSYGKVXl4VOpxgORP0/VAlARhkvB6vTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbX+lbev;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E853606A323;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbX+lbev
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459123;
	b=fFdDvcO+T7VuWNJkWuEPhg8q+8O7DWh9YXEdIwVVgmn3hCz398nfPgI0/sNy3SUJCGxB
	 dITm98C2sYHEHD0642ZoaJByuy5SL8zoMx8zH+hRJU/fmcALAC8gN1TIPFlpZokNvaaJ5
	 pwgxqOSvhkCL41nMbpQNioT+bWunKLjEA83CUeN37ew5GJ5pvMrqWWXH/oM5hBUCDXarz
	 gm8Oq6QzOGH8RJrLpgBWlbm5zQzEyrz8qU8ygCugMF7QIMZKyzJjXV9RR1QA+mzEQbNRF
	 1wc/OHAn7KMiHY30GGhlAMa34fRvOWV9Cnb6efiP6j5iQc03kDs//x80ePQCnyJtBoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459123;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OQ7srUuIftjup119qlM7sUBQxwd3uqhTJy8umEpMnLI=;
	b=1kemFHTxwoW5JSt9XTreuqckVaGv15jNcf3Ny8AKNTZ+6zWxGQ1UNlYhYdUeKBSHeN0l
	 VdUj+oAqyoZDEWqQdpNbLQgzCpqIgTl9J9t4wS3n/d/f9ruyPlDH+lwDNnlJiGz0KGoRM
	 1sPDfkm8eqeVYDTlg63dRL4LngkMUM9apRYUwLXoGP2DRhEwiLqNK8glqNSe3uekDELoG
	 Czkw/wfcY7OYTUF6nDrRHG9cZxM1cJCZPr6P2YE+rb6K4Y+JSr7icAgXlED/lyoQEMYko
	 iqisaA4t9FTdwOZj5w+b+o71BrWaJffpkPRnkJ+/M78N/CMTcMZfjt0lYuwKPPDehQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E91591F00A02;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459123;
	bh=OQ7srUuIftjup119qlM7sUBQxwd3uqhTJy8umEpMnLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZbX+lbevs4FPee9i/WqorCeWn9X0eP7+Y89Cyegr6d5tUlWBj9WrH37doAqvTRt3R
	 P6qz+XbHHB17l4etW/3/SrO+hV6bxQZH/DqlZqKDkTLfG+vTg8iubHDlWLucWUoyCv
	 Fl6PLT4aFX6AidK8ggT+mfwbRXyS3MpHvSSiADgqAW1ONILofiYNVAYcUNr10lg+L1
	 gCkhBc85wO45yUtantp1FlmJWe3GEnkMkCjWmEOd+YJ0fDkXgtKBTXiIU05GdiZSPs
	 F460njqZMbK9AJAB6FWlOSbAHRAP5KiTkEymcm7+5UiO9jXx/IK0YyEBOKGubgZUtE
	 8j2nzoN7iWEbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5FD8D45F07;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:04:59 +0100
Subject: [PATCH 02/11] power: supply: qcom_smbx: Do not interfere with vbus
 driver
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
Message-Id: <20261031-pmi8998-vbus-v1-2-4d805e5a0f27@ixit.cz>
References: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
In-Reply-To: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
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
 bh=dUkU3R9RyGH/loLEEUiFubUZ7mMUCTgOR92p1j1B+OM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvGdpqmOloYmuL0212waKARR5qo3EmQUcJt
 en3iUVZ5OCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 cjIlD/9rofNJQD8SD3e06jMVuKiEh7lpCYsDtNsDrDQne7M8fm6dHd7DSytF4OeDVKuHy7TojMJ
 4pvvBpNY+18QbCYhbGKmMWyBSjjvjxmZyHkYn0p1JGKmEJIlCGx3PPzQRwds2HU3RrrYBP3epBF
 x/5SYUuqAx/iOmPGVDoRBvFbJc8oTGY9JU+/kFJQEznKcvc13VQBbdopus3Vo0HatZk6lTbj4UU
 LzFQC7luRdogqVEjoAYAaQNibwZEnNR1pULpskULFNTdckGpIJzLajuiyfNvO02pquYoMr7oElT
 k4w2meJulMk2nQNNhtp1KFTgt5CtwvsV1woQZPpHsMjc92bekgAeVJgSg3Fil4MvEyT2fk3jpBk
 XYt1onoxCebfNj1V/2+kXUv0RVx9rEm/hbbAH7IxQMRGZbCdpwbh163YVSssaUY0fP9um2hAup+
 ovO3xAKnJpr4QCDEXHKau6u6XWToyM8Zajvo3YyFQOm7vtTd1dx+/Z87t7pjNbMRJRcpw5+bRYm
 ZT7qtx/zIN9F1M25UBuGbnfZ939o32R+D5DP/I1HFjJAb1+vAboGzHZ+CfpWywQq0KZLRzWvJOj
 KOomUtHQAJ2ue0EX1f6YxHBkNhMGuymNxZcdR/ZDVvJjYSiSs7z2vkYkfJ8oL0CF7owMgfxCsbR
 9Slqu/WinEHwKTw==
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
index 52bb5a6eb145d..9c071a79a16c2 100644
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
@@ -804,18 +792,16 @@ static const struct smb_init_register smb_init_seq[] = {
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


