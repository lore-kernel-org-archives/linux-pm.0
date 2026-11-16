Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810576;
	b=qKlWdZmGCiySsPVO8KS94Y2xMV0xJMio0xmbbrJPZHM5T2uwTwP0UvavFOJyk8WHLFca
	 ezmKFnqNTLrBCwEr2NxL1mYjalmohu0mxefnh8RezeaoitHe0GxINLx4zXS498WQpBUwq
	 GULGh+UieMYoBEcVvYDusAk8/C02A6up6ikr1dqA4GS6PRAMIDVfHv4pTtMnjzFYQXaj7
	 GjlF11OodgCoGmGO3K5KlgHROxB1q6yDksYso4cMgxLtAWkMJVfCnqJJYisZNXRkHbfDU
	 JTQH8tIAizWw1efQ1Rz2UY97YrmMQHSfwcHl6Ro+e9Twc/sgzqGoBHgzBw4YDIr6HNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W5ubNBjYB7gj80s79SF+MJ9soJGkJ6wOwgYIYNtKFtg=;
	b=JPDMPHv8TzSYbm01jYPe+4dN0JWJMXQQqLagr4iA7laKiY9Ek+T5BvcSfZHjz+Bl1P2p
	 uYYS+2AkDNoV+Fgk/HdeMd/mnAkCQBgRJ06w6KR0z9ANOBj6ltCoE9p+tiXehH8LjQ5Wt
	 r9Qvzu4E93M046Oca060XCZts/alcAMjRV02TyNuZAFxHBZG0SxQVTWqaR22Ov5uGB6kT
	 vsJBvsWgNBYSdv+3c3XVAyADsOB9aznCSgyQVUiKrQZXvQuZ5atOK68N5gzW3+UBhqoIr
	 asKFfu0DeCwNrg5MSsv0zUtbmqkATG6PIP8bsh3ciR9ynCI6SV1rQjpJQmJuRL93O8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="in/mlC3N";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A04606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 06:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=in/mlC3N
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so2721859b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794810575; x=1795415375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W5ubNBjYB7gj80s79SF+MJ9soJGkJ6wOwgYIYNtKFtg=;
        b=in/mlC3NccXXcNXQfVbNv8b15JjccC4L1zO4lkVzKYVZJj7W/+0bKewQNEK6gZEhnV
         si7O+WZnM4lPE76uV3sbBxpDAOwvJVGHCtcMZykFdaWhoLAxtAbRXtqyV918k/z7K3kA
         O8ZqxMKQj1p5j3md4WKkcs+zBjwHEnOgKzS22bqlafc6tNRLxRFfnn2NHMecQkfD3z4q
         zr3vEbe9GIQjDwzobXjA/tDYObuCUO08H7oAM6A/P86XmUGrPXwwPuLMmMvMS5owSA6z
         QR1dhL7VyrjjUC5nNQAkaODzzCdhMXbtf5QoQMrc9EfaumbUJu1JlPUTcyqTmRaSnhYB
         MtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810575; x=1795415375;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W5ubNBjYB7gj80s79SF+MJ9soJGkJ6wOwgYIYNtKFtg=;
        b=LCHeFfpuTOGFfoyKapyTO4Wlh2uOZRP4KWEO7cg7+eGv9MYkY2Z1ZW0eyQgX1SbdLy
         wA2D6zkPjI90b5TUGX4U8wgJM1PFD+LqGGZUeKLtwr1QuRbixkipwV97Zf7oBDhw5ZnS
         IsxUPQFpcBy1x6Pj0pBxSgMh3Ely0mUhiGCNFyzwj0PqwxQfnHetEMQe8jtyDhI7sMbh
         tjfUUCFjUWETKBQZKy47uV/PS/v2Koq2XfM+JZp75K0W7UwFuX28xUqdwAqinmirhq6u
         w9Mq7cMj4Ke4ftjbYboN+2akPyNnERE4+PwUriKvXqdga5SyFnnfdHU6UcjuRQFhvyqT
         4r/Q==
X-Forwarded-Encrypted: i=1; AL+hErF2j86BUvmuJG20itqMuoXZx+RwllUjsO0cQbFnpsMewX6R+5639FTQP8jhNPYPGBi52l0IJwz1sA==@vger.kernel.org
X-Gm-Message-State: APuU4Z83FKhKb2znprHTpS6uxkgyoFC2skAtfC1QMk1+X20l9FgmFrM3
	Q8JynyiG2ANPm7ORMqy5LMTQ3B9DGwMB7xm9Nxm2x15e2xJCq8RjXTNb
X-Gm-Gg: AYBFou2RRJTDV9Baq6vI2GMYVRLEi5bqpkhlgQtfdX5RZ+QYAb69uc2hNXkIZZGfuSd
	qr78blOenbZjciRQC48qNcSzgOIq6LdoHkRQmJB1pU3NzQnglx5pUQbnPl3UL3SFnlw62AldV5/
	/XzH82eoNjAdQcxtXUrZRFCR4zQGN7117efu59zqtWxoiCaxAHYLf+rEACdZmjUGlzc1n1kciho
	+ppBniG0oSUP1Aj8InXJvezO1lmB8bp/BXuqdTCkMN7hbL7xxKkMXZ5gnFGttnnOnwfDRHO0Y6W
	Z38PJB3C8xDe1cX3INp6KHm3Aul8ipNkbk/Ai4nvhYN8MAPX+G4ifZplykrL3u43pn3Eprki4cr
	Ir8eMZ754+SuHffRSZj2NyWkPJDLWNvNIj1KUF+CQsdlm2WqiejgEUrdicNf7tYcL8HYhV5+C18
	AMufnvtfCwSRN+tO2XbpHwIi9rhyzGQY3gS6jrgP45l386/5c+dtYao8axxRUgTAfaH8fbMO4xC
	4z9UqTLdYLu6uE9Zh9fT7PI9UCSxOplAtmSaOaKJqWKwsIfFHMJMu+WI1/CcfxaxzXuOpFq7Gzc
	WG4F22bnWCwd+nQ7WFMa3rJZVWLHEZP04Mjd/6yGaCsoiO7lIPSPmIScCgmQmTU3KIMZ
X-Received: by 2002:a05:6a00:4b52:b0:89e:df2e:cebb with SMTP id d2e1a72fcca58-8beb7d1ce3dmr10000964b3a.59.1794810575158;
        Sun, 15 Nov 2026 22:29:35 -0800 (PST)
Received: from linux.internal.banvien.com ([119.82.142.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2346e73sm3387975b3a.40.2026.11.15.22.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:29:34 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>
Subject: [PATCH] thermal/drivers/rzg2l: Fix precision loss in temperature calculation
Date: Mon, 16 Nov 2026 13:29:09 +0700
Message-Id: <20261116062909.36618-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the RZ/G2L hardware user's manual (Rev.1.50, section
44.4.4 Procedure for Measuring the Temperature) the temperature is
computed as

  Tj = (DSENSOR - OTPTSUTRIM1) * (165 / (OTPTSUTRIM0 - OTPTSUTRIM1)) - 40

The driver follows the same grouping with integer arithmetic, so the
fractional part of 165000 / (calib0 - calib1) is truncated before it is
multiplied by (dsensor - calib1). Above -40 °C this always makes the
driver report a lower value than the real one, and the error grows
linearly with the temperature, so trip points are crossed later than
configured.

On an RZ/G2L SMARC EVK with OTP calibration values calib0 = 2902 and
calib1 = 586, the slope 71.24 is truncated to 71. The computed value is
313 m°C too low at 52 °C and 351 m°C too low at 63 °C, e.g. 62382 m°C
instead of 62733 m°C, which is reported as 62500 instead of 63000 after
rounding. With the default calibration values (3148, 503) the
calculated error is about 1 °C at 125 °C.

Multiply before dividing, as rzg3s_thermal already does, and use signed
arithmetic so that temperatures below -40 °C are still handled. The
intermediate value is at most 4095 * 165000, which fits in a signed
32-bit integer.

Fixes: 673c68bd4839 ("thermal/drivers: Add TSU driver for RZ/G2L")
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/thermal/renesas/rzg2l_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/renesas/rzg2l_thermal.c b/drivers/thermal/renesas/rzg2l_thermal.c
index 90e2ba378a4b..3295eef12001 100644
--- a/drivers/thermal/renesas/rzg2l_thermal.c
+++ b/drivers/thermal/renesas/rzg2l_thermal.c
@@ -75,8 +75,8 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rzg2l_thermal_priv *priv = thermal_zone_device_priv(tz);
-	u32 result = 0, dsensor, ts_code_ave;
-	int val, i;
+	u32 result = 0, ts_code_ave;
+	int dsensor, val, i;
 
 	for (i = 0; i < TS_CODE_CAP_TIMES ; i++) {
 		/*
@@ -105,8 +105,8 @@ static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * Tj = (dsensor − calib1) * 165/ (calib0 − calib1) − 40
 	 * where calib0 and calib1 are the calibration values.
 	 */
-	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
-		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
+	val = (dsensor - (int)priv->calib1) * MCELSIUS(165) /
+	      (int)(priv->calib0 - priv->calib1) - MCELSIUS(40);
 
 	*temp = roundup(val, RZG2L_THERMAL_GRAN);
 
-- 
2.25.1

