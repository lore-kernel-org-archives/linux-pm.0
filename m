Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792995912;
	b=RawRJkBG2CERXIvMAMKJRdJQAbhhXhcUb0PRBSvNntip1A2oyRKTAtVEqnx28oqlUf5I
	 cfru4AVqqZDUS96VqTesXzFKxFhC3TJq1PPQiVKrHgkWbgw4N5O2BIj5O9vwVXrE/axAO
	 dZyivdAcgdtfiZkJxqoSI3MgWuBwXILGBnbKuQMlU5fuqLFixQDRcj0rM4ycU6Iu5X333
	 2pemg4daWgeFgXxk5SqkhegCKyl4mW/aSHHgyzrwAJSod+fTM1wN5rwe7wtBKgVGts4q1
	 wDqoG6wf4Skrdxpw465Z/T/zYNpFQYXsf1R2SZFMQ3v7D7h4/Oz4Fzb7lmax5RpGVww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995912;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RlF5DYnJRPEij6dz8uy7Tal0KbDHMRwaaUB7QYyMeOs=;
	b=sfZweMjJSSSXObBQGsCyGWJ6YlaAmkjhC8iM9WtpMx04srh8bqXSDxWjmpbiLCw3caTL
	 1zQ0pRCy4zQ0Rmkb2Q/g1u+3hc7uoQ6ukaklJC9idEvSsIAWT4dtPdQZ4VH1kzy25LC+i
	 H+CNoAqagbxElm/YaRDam11iJFekyBMvKxnCAyqNorsbNS+VAySYh0lEK7C63VpxqJyzx
	 bldmZX3Ae4MBkKknQt0EK/loTRPmX0DYcDsWHucIZrw6Vo3X/ygIgglms2fhLFyD5GiUd
	 w+q9YwwPHoeV9GXIATXD2LVjwHKwvjVYTR86ZQaMz94nL0Wm2NDpZB7ljuSiKsRvJcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jd0pm07x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C97606A320;
	Mon, 26 Oct 2026 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jd0pm07x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792995911;
	b=C4gk7+1ug5OiKnv5ld46GnP+fB2K6nyWUSG6yez8IiMTQxlW254dOj8CIHsjCkEyMoOD
	 uRRd55OrDk20j28JGJ3JC6AJe0aJh64sJNupR8niRvI554XXVjwKHm3yocAM2FtaGeKDe
	 aZnvLi31RuTcd2XM8nKyef/bOIjTKK9e3oiu721ZH2CI8ccPJDfswmoIyKhIjefPrmTcH
	 rxjzEI+8xuAjXFkrfgWVtlulYBmSjXkpsXe6+TSwecd7j4eQ81rd+UBxfSYACJnSbrEXC
	 wcRlENtcCtabn+uipSU18V71M6ze/u9Y07mqGTxc+fhODM18aZsyOKzxls6mFo7dr3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792995911;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RlF5DYnJRPEij6dz8uy7Tal0KbDHMRwaaUB7QYyMeOs=;
	b=Iqc9YLtvLS2jhYR0srMVokdjfQYZfHuSES9Ye01ref96efTef2ODs3OC/3D3fxsv+IZ6
	 k+5AUJAmI4VRyhNTVknLJYnkfHQQehLl9PyPc6s3dyqIC62g9ZzrxPcCo3ZmEO7ZEOEQt
	 p5hujbDxJqlQ/n1vBPvuLkKeZOm7Z+TZCHeTTUvl8ZL9zjK3oD+A1d70VOS6eaINDsl6n
	 LEqDgWFvhDVdBuWrbrWpDXCsnNo+WaT7n8P3SN/AuLMkEk6lqdy4RFzL1shuK8A+ZuI07
	 Q/jdQy1ZxZw13G5FLoCejQR9HCR3x+HPlnNkfcLo0eNK4+Sy542NgqG0Yt92QmH2q2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 991401F0139D;
	Mon, 26 Oct 2026 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792995911;
	bh=RlF5DYnJRPEij6dz8uy7Tal0KbDHMRwaaUB7QYyMeOs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Jd0pm07x7lR/8NofARUDwUgM1hNur1ZcIuk3NiJJr/rS+4pt9we/yG4VBaB0YGr2g
	 CvLTCjOfxmuGW013U7J9BPgtjJrUTG+2poy/iZjsUhMHtNT6fivExL5JZi3ddcIw2k
	 Qs8ZNZhrkTR17avonQ0sF4eJguBNfNuXcUV+modcgEFgXHbqXDYYLueZCdkcuOi0Md
	 utGEED4HkNG7nilg7FCqRXfV/oMlmSwBqmTeZAMCGnUmoLQXPE91ocIn/6pbp2ztXz
	 6AuG7Q8JaRQHn0A0S3F1ZWigVQxm0Ns/tALSRvgOFCKw3xkppKV+mHLnXGHr/WqPNv
	 CUn/mMbGDH7rA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 10C8F44C25;
	Mon, 26 Oct 2026 06:25:08 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Mon, 26 Oct 2026 07:25:05 +0100
Subject: [PATCH] power: supply: bq24190: Fix NTC status decoding for
 BQ24193
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
Message-Id: <20261026-upstream-bq24190-ntc-v1-1-fdc12d795a99@tsv-stahl-riesa.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtok06YryIetpppBOtsuiGMv
 bvVHb/D/69gklUMTs0KWRY1faUKf2gg3vt0E9RrNZCjo3fEOE9WsvRPHN4UfOcwlYgjtxKZiUP
 ooKZTllE//+35stvm4SGx/F6wbV/toK4teAAAAA==
X-Change-ID: 20261023-upstream-bq24190-ntc-f35ec3323449
To: Sebastian Reichel <sre@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995907; l=3658;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=BUokX18EXdA2wvDNW7+3GVSpgzTFB0r3Izc5EIZbi7Q=;
 b=hzAhsAG/gqezLRrjScN6/AElzUocarO12tX3xX1U/ZKpX3OVKuK2zrVTLUlJN44sehJCsNbIa
 m9e658IV1dLAjA0xNvtuLq6e6ULTNjTHlzfY13AaOc5Xh+9tidgGgBa
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

The BQ24193 has a single thermistor input and applies the JEITA
temperature profile. Its NTC_FAULT field in REG09 is encoded
differently from the BQ24190, which has two TS inputs:

  NTC_FAULT  BQ24190    BQ24193
  000        Normal     Normal
  010        TS1 Hot    Warm
  011        TS2 Cold   Cool
  101        Both Cold  Cold
  110        Both Hot   Hot

(BQ24190/2/2I datasheet SLUSAW5B, table 17; BQ24193 datasheet
SLUSBG7A, table 16.)

Warm (45-60 C at the TS pin) and Cool (0-10 C) are not faults. The
charger keeps charging at a reduced charge voltage or charge current.
The BQ24193 uses bq24190_charger_get_ntc_status() though, so a warm
battery is reported as POWER_SUPPLY_HEALTH_OVERHEAT and a cool one as
POWER_SUPPLY_HEALTH_COLD.

Add a BQ24193 decoder that reports POWER_SUPPLY_HEALTH_WARM and
POWER_SUPPLY_HEALTH_COOL for these states. Cold and Hot are unchanged.

On an NVIDIA Tegra Note 7 (P1640) REG09 reads 0x02 after a few minutes
on USB power. The battery keeps charging, but the charger reports
health "Overheat". With this patch it reports "Warm" in that state and
"Good" while REG09 reads 0x00.

Fixes: afe5301bfbaa ("power: bq24190: Add BQ24193 support")
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
I kept this a pure decoding fix. Two things stay as they are and could
be follow-ups if you want them:

- The interrupt handler still logs a change to Warm or Cool as
  "Fault: ... ntc 1", as it does for every change of REG09.
- bq24190_charger_get_health() checks the NTC bits first, so while the
  battery is warm or cool the charger health hides a charge fault or
  battery over-voltage.

Tool use (see Documentation/process/generated-content.rst): this patch,
its changelog and this note were prepared with an LLM coding assistant
(Claude Code). It compared the driver with both datasheets and wrote the
code change and the texts from my register dumps and instructions. I
reviewed the change and ran the test on the device.
---
 drivers/power/supply/bq24190_charger.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4bea6fd83c36..350cf79a0744 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -999,6 +999,30 @@ static int bq24190_charger_get_ntc_status(u8 value)
 	return health;
 }
 
+static int bq24193_charger_get_ntc_status(u8 value)
+{
+	int health;
+
+	switch (value >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
+	case 0x2: /* Warm */
+		health = POWER_SUPPLY_HEALTH_WARM;
+		break;
+	case 0x3: /* Cool */
+		health = POWER_SUPPLY_HEALTH_COOL;
+		break;
+	case 0x5: /* Cold */
+		health = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	case 0x6: /* Hot */
+		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	default:
+		health = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return health;
+}
+
 static int bq24296_charger_get_ntc_status(u8 value)
 {
 	int health;
@@ -2013,7 +2037,7 @@ static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
 		.check_chip = bq24190_check_chip,
 		.set_chg_config = bq24190_battery_set_chg_config,
 		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
-		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.get_ntc_status = bq24193_charger_get_ntc_status,
 		.set_otg_vbus = bq24190_set_otg_vbus,
 	},
 	[BQ24196] = {

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-upstream-bq24190-ntc-f35ec3323449

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


