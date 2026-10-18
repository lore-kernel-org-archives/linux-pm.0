Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCE3C109E;
	Sun, 18 Oct 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364620; cv=none; b=qofeLMrJWwLE+U33eVvPSE2kJuvCPW8p404kbH2074ZNlSeGjJDj1aJwGnJie/0xWvJ/xvVS2UwdClP1sAzqDsh9x3XUqlwFPVkhDV7ipG8jC3U7TSYCr9Pofx/N+Hi1T/cXA3sGIag6CSS7XkeOf2fpSSmGz6UthLU4lVFwv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364620; c=relaxed/simple;
	bh=xhHIDgUN1ghkEHSn+/XgpbvkEmRa63Vg2fDE1cxwOP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q5Euzj3h0QzYpR6VpQwP1F1sZ/s1tAshE3I//5mvNO4i8+A4+i4MwOFt7m4rCFGRx1bnEjufCZZXQ8LcyMi4ER58k6EF0qWVmYvUculjOwVvDfuxQYEy6ofvb5Tv+oNyWGvYb36K/J+7Pxb9S8CDeNB0CtFcF5HMR1F73hFOQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8ZbzLPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8ZbzLPI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17EDEC2BCC7;
	Sun, 18 Oct 2026 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792364620;
	bh=xhHIDgUN1ghkEHSn+/XgpbvkEmRa63Vg2fDE1cxwOP8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Z8ZbzLPIXAslQEeJni39s5feCjMrClAMkRO65kxfLV79XhoFIdyQTXd0/t9YhQ5pL
	 3yRMJNI68MoQRP2S3C8aC9NE7OuaXUJusq6SM4rKcysmNSC4+B2265WDJY+qaxRDwI
	 BBTJGq+lTN0B5WDvTb9or+Tcq0GhQWUD3PPU8NtKKoKX7m7JY81J/1gmbJtYEjFa0A
	 igafdRQODwGBvTFkROOqHDKWeEsr26YGzkX14Jax1Ipt3kLrHlmYt4pdS2oW8LZq7+
	 SbO3CkLSf2/qD1oEqflB6/UutDuRs9Za9HIG8s+07iwevVJ2OSVByg7Lv6lVbiLaCT
	 A2FPDJaZF8ODg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D53CCF2D4;
	Sun, 18 Oct 2026 23:03:39 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Subject: [PATCH v7] bq27xxx: support interchangeable OnePlus 6/6T fuel
 gauges
Date: Mon, 19 Oct 2026 02:03:38 +0300
Message-Id: <20261019-master-v7-0-a1fc488d9c77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12OS47CMBBEr4K8HjNu49hjVtwDsfCnk/RokiA7R
 CCUuxOD+GiW1V2vqq4sYyLMbLu6soQTZRr6RZivFQut6xvkFBfNpJBaWGl45/KIifsoXB2tthp
 rtpiPCWs634P2h4fOJ/+LYSx0cXiXkfvk+tCW05Coof77EVf+LeVxSJf7kkmVnGfpz7N0Uhy4q
 GQwGwxgtNk1naO/dRg6Vkqn6oWBgDdWccGFR9BKQYgR/mP6E7MvTC9YUH6jQVojAT+xeZ5vwjM
 vZzwBAAA=
X-Change-ID: 20260927-master-bd0afd9696ef
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792364618; l=1970;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=xhHIDgUN1ghkEHSn+/XgpbvkEmRa63Vg2fDE1cxwOP8=;
 b=q1vv3FtlbzSP9Lcv1IcVmIP0lNRubhiqrWaAMbm7UqF/Rgd0AhwgmtCBWIPzPMpHGrhsNnAnY
 wJyN9KuYseHDvxRwxLEt6tJ4zTzm1I8Rjz6kavdu5u7M483TbCGRmLC
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com

OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
bq27541 fuel gauge. The latter requires a different register map and produces
invalid battery readings when interpreted as a bq27411.

The I2C driver reads DeviceType while probing either of those compatible
devices and selects the matching profile.

The bq27541 path was tested on a OnePlus 6T with DeviceType 0x0541. It
reported 4.338 V, 100% capacity, 27.8 C, and Full/Good battery status.
Testing on an OnePlus 6 or 6T whose fuel gauge reports DeviceType 0x0421
(bq27411) would be appreciated.

Changes in v7:
- Determine the expected DeviceType through an extensible chip switch.
- Mark the probe-time list for extension with DeviceType-capable fuel gauges.
- Link to v6: https://patch.msgid.link/20261019-master-v6-0-c4b36129721e@gmail.com

Changes in v6:
- Compare the detected model with the compatible-selected model.
- Support both BQ27411-to-BQ27541 and BQ27541-to-BQ27411 detection.
- Document the pair of models checked at probe time.
- Link to v5: https://patch.msgid.link/20261018-master-v5-0-0be16441cdd1@gmail.com

Changes in v5:
- Report detected and expected DeviceType values instead of hard-coding chip names.
- Describe an unknown DeviceType as unrecognized.
- Link to v4: https://patch.msgid.link/20260928-master-v4-1-052c73ec1767@gmail.com

Changes in v4:
- Drop the generic compatible and binding update.
- Keep the established OnePlus DTS unchanged.
- Detect bq27541 from DeviceType in the bq27411 probe path.
- Send as a new thread.

---
Rinat Muhamedgaliev (1):
      power: supply: bq27xxx: detect bq27541 behind bq27411 compatible

 drivers/power/supply/bq27xxx_battery_i2c.c | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20260927-master-bd0afd9696ef

Best regards,
--  
Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>


