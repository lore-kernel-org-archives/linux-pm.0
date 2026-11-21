Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300703;
	b=xBltGFJmgIUkapub9r1f2SmLmJ3M1Y2DsCgfknhgTp7BNurFl+k+LhxJblU8yRwMtlMK
	 Uy+5EYHNK1hV8BmXbrGW0TALyCSygeqMnqtHj6IPi1r7TAPpQNRFacp9M65rG/pORQr36
	 8lIUUnHOtWOvWVtk3PVPX7mPbkbnJOE4JXkSiDJ36V/KovJTfE4lc693JpjgySFIxkQhq
	 rymM/fIOzAOy0c+HemlLos8nDtcHOLmPxz7CooioMVaJ9+kojF7E/w+nkgTSUdkIAbdWS
	 wKouGhg8rKafSrxspx7TNxAYvVNQ746Q0CTPrvNbFGG6cW3XVWLPGqXKCAxSfHvq/aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=13Dyskqir//9BHMMxdYCYBsJ2RlGl0LeC/LKP06Z4ac=;
	b=mnI6k/AADNguNgPAeqWto3E0peR4RKXWLQncmAhFYN1bC5365OtBvhDeTN66xZRh4Jr1
	 apulYqPoxI2Rt3ExZLVhpzOaHmk6LdCcBsk+7iae5AC0K5LUThAhojGno5unJ8qP7aDPD
	 QECemD34tIHXtqEALMiCvXr9KJ/T8aaP/ckauiHz/12R+7u13RXX84c1Hs9ie2ETHXjju
	 VutUZh9oc6jE4mrogS1v//s9jnXtyRvJB5FJ5oikEOsketxItk8u+G3Y8xFq5mndmjNGf
	 Rhp4rWqw7J9xTOme/WVjiClGugjgH4BIORUXZFAdneSdqrPC1FPzG4c3jVDxoaCDZyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv7QgaTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35149606A336;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv7QgaTA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300703;
	b=wiw26EtJ1YMg8SO1xqXA47FzTKoFQUR6U55LfhBpTikl9qU15lnDPfvUTr28DcoJ5Rhu
	 RoIJnUMXenZFzbyjPa4Dx76KDJsUzIvcBql2ilBiJxAV36PvjPnOpijSjioftf3SAUOcl
	 jFOKBAIJtjf7+NXZi/tbcea73EKD7PZJAqOSl7IsOjNFiNXVeQMvkSeF749LDZTVY0Yo1
	 ppqopGdFdQ6VL4kLjt3edkeRDdjkgsNJo9MgCUSnpEd5tPkHjsbcj9eCgAaA7EcY64Pa6
	 EhjBeMODZwjGfzw7PktZF9wmfx18C0fS+8RhF4IOhvsACZAfv58yQnr8MdlzAputjyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300703;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=13Dyskqir//9BHMMxdYCYBsJ2RlGl0LeC/LKP06Z4ac=;
	b=G1QUgFvPzMBj6BHiAsbRYDbgf3gTaO2P1xDBIhGNdNWnVR2+OhA2ISkAyvGjBheHRPvs
	 4szSxovzCSTKD+38jitxPXrI8RjoHLFB5v4DY01uLfEnnPrIKpDa4DxuYEKNZwoY1TZKM
	 XKCxdRyr5lHNxO5VCfq0KFtW/m9CG8kPZ7k60Agg5RdV1qycjtjYAlsxOA5reIRSyJ4TF
	 DHGsXqPAnKDcOyqTr8nr+a9JlbyGQtHAEkhVeBYUCNMIvL6mPUbH7EXeihBRHz5E7GpPK
	 luwh6AHbiOrSeIOq4wLsqTJDZ5+TjkJ/BwFaJuMeTDkZF8p9kPlO5B4eCChiCX5Agkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5E291F000D0;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300702;
	bh=13Dyskqir//9BHMMxdYCYBsJ2RlGl0LeC/LKP06Z4ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Pv7QgaTATL0nZ1Fwb/gHlEG2UudbHpz0bbd2hYklIM4Dndb/r3NODkrd9SGzxIUkV
	 jKRBkxdMJFlb/MH0hfJvl4FQ5uUGPoBI095PMUIpn+VjMD9+mcB/lT6mTl2t0/qgUh
	 Cly1fnQNV4BDjuAba8TJnLLtAFtDli9CCRKYahy+wIEGL1QvG/zTbYDpi6MWJsJdNZ
	 CZ+PHjeQYVZ2zjvpLUOYKB8L+C9dtRfmRSM7rfML5/pXO8rEO460dTRv0QE34nKJ9B
	 nD47uGaS6vkl8fi65w/N1VyPR16+IUCIsMsBlpa1taS4TLaMoWVwbgVJNvrEnvQRQ/
	 FaDIgtCM+gUdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2A5334BE32;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:37:58 +0100
Subject: [PATCH v3 04/12] power: supply: qcom_smbx: Stop clearing software
 control select
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
Message-Id: <20261121-pmi8998-vbus-v3-4-91ba2e61a877@ixit.cz>
References: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
In-Reply-To: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=6d4asV1zW1ZVePGq0BeaT1hbifcETG4K6ZzsSB440gQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1at/9Ag9Gs97NDXSbrqiKQfpjhzNIn6pcDx
 M26XnW6/82JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 crc4D/40jWzfWyb8sl71g/6Gr37FlRGj8Tmmw/Hd82UENxIxy2/UAPZhf2hQ5VWuYW5D62Geh9H
 bh/xyC9+KUPHzOnFXO0l8h+SrS83reM+TLefrq66/F1NpiHhlWI+iQIz1LEPWo5rHdyyQLs2aDN
 s9C+Tp2oc2Qa+McF2ISl6Dv216gkgiRWejHcQQJv57CtDLufDD4EH6LfbT6bDPqkVZ+cfTahJ6a
 bWBik00/sy4B/73XutHbY/IgKQ3nATxMTSe/C8fnzj8M256brgMkD/x8pmSCPL4fw5SbTRDk99j
 M0X9q52S8A9u5in9DAWelVOCUNzsSb5x1v/1Pn86Zj7eDnKGqSlP7tUaYCo9NJ9cuPzZoTKDIEZ
 VELT45N2rnw6nbpzP6KFPQfR6RgCQFL0VOwCSm8wTtmsOjGfq17QQHCGKdS8v5cWet31F/ZNI+e
 mmwAAuB/LYS3Aiep9D+bFDVdNL/dHcQ3Kck2NkJ94LFqP0ShIvQ/YPLnxWriL35ypMPsJY17YBA
 ytva9pA4/IdO/vjckbNf6nOIPvq5de+QvczNgE/hlrnCM5dY4kExg4ZpN5H6qrj5rordu9luT2G
 xozMU2gB3JkEhGNis0/pjfIequllMKgCYVxGm2ns+2FXe//eBpUttlUTuqvYcXLq1HKjkTOWl/W
 +xTJJUJtZghlRvA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Charger should not touch OTG block registers now handled by the vbus
driver. This change stops clearing OTG_EN_SRC_CFG_BIT (software control
select).

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


