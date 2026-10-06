Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D84A014E
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302585; cv=none; b=N0sQfRqxTmloW7sM6ozPtd6tWLgB+YRscP/h1KbYSjugTH9CNTxYit1MhBP5gVSATyzuxrO+CoG+3MoZ/L7PXzG5HQzSWa2N4yWXjlP/Q1gPr7lqGCf+hjAGrCS13ew6GNDvZDuNir8PwfRv5gcJIOBugfUoZk7H3xId1LIK/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302585; c=relaxed/simple;
	bh=cuF3exscH8i6nh8FMRwgY1X/VW9bce/DQsITl0lqfwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8GtpRYTJgwW6iGo0qXU8gdnUrmzTJXGelKtwiz43XhMv0sotXXL34YG2oSERIALn2x2WcbVN1ZvvZQkhlvNMDLZQbe5gegRLtbFJsB9DjV6mr+sI4t80qrKhUvjCu3iZd+EqKwgXMiV18qMrZG9KyQP6fZ9QfBVIN0GBxYvY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=KFFE6kyo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="KFFE6kyo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso6909455e9.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791302582; x=1791907382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEGvXsceU9JxGTr8iEGiHxb5w1XSn5I5iKljd+zrlDE=;
        b=KFFE6kyo9Ydx4EnwtalKmQOebIl8TUOkfsF45R2S/sZb5aSl04mIv4xluzXxMMIKRW
         bASYMXfwxTL0DZvGZPwaGSTH/aDgq85/Qzhh9lrX8wkVaMIigifiiGTI/Js1IMS91xe/
         WNaoL2KBTekmCu18Jpa0AD49iVMhw3ESm1gWGRyEgGMNtlt2yvo2XQ8AZmN3Wb46xsaR
         brhQcxq39PBw3b0Pk83R+o0SnStqkHY3jnM4BSHfmBb0IMRKxp/J1Gaxh079QnBjMzYi
         h/d5KGdWaW4N+DgllF6wOZeFU3EqpB5u5N76xIG2zizoxjSYy8Fa3xB4eIvhtCvhGB01
         YBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302582; x=1791907382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEGvXsceU9JxGTr8iEGiHxb5w1XSn5I5iKljd+zrlDE=;
        b=bWiJRuoIJv7wkPUbWzmIPRaQJ+g3w59mFVOJLIleaMaIBzqLyPFilDgNNJujsx/9zz
         0x2UW4qyV/mkij83YCGYLMS//q1TxpJtXaV5Q8pyXx0BaiDJhaYQppD/38fKlKBzJDzZ
         qZfc8G3dw9FflR9sLhOROiZ6oLbqkDscOJjei8Q07YzJNHlLrIAkkFRoLZqx3nuEuB/q
         Fk69UQj8ft24A7EE3RhlAe19ICqhpa1PlWVNR5cVET3MatG2dEmjBXcYdSHq/2evtrA0
         o1ePzATyOvoiYEqtbrJ17tuDCrSMt++5HYPotkSgLkCFSf1Plgtc7vpoubJVDqVHIp9T
         4niw==
X-Forwarded-Encrypted: i=1; AKwUvBxifr5ev7gLpW51HsPprzkzTVhHlK1ZfhWW88lsFE9+K5D6YpTmJofKom0mvmuB1rVev/8N3Uz2vg==@vger.kernel.org
X-Gm-Message-State: AFuF++loDT/cYJcWbXNiieAG9XwJr9Zt6qS8ksY9mqG7yjR7lQN96ba+
	nVeDh7POxhzfD8fry6nwUH6V50KCrWEDU4DRPxPbT0x57YK02JiBrccQmrxrJCHMnMU=
X-Gm-Gg: AYBFou0naQvduJPmHtrt+HSdNNwkyzn8Bm83VFu4Eh+OqoCw4P9AoyWzaBJEgRwtD0m
	Yk+IctOZEjc14kMxAggBCe6/SbtMeMmU3h8pS4UTtY72tdjstoBRvEpRSdyovwyEcV7JHTp8bqx
	X+e9S/8H1ARoWtnjcIvSHlacAoF0hurgeepHneSGSvPsOTjcTJjYZDrJaKPqYEI2COyU5EMSJLx
	zw3gPmgvoGYvG4fpkOK+VyZiU917CcUe7s6Hp04M1bUEYnCuTgbkYei65axDtyEWjTQYGoWBDkx
	msPwwXexTr5FYDRNHupeAL3qesJyaPqAnl/Wf83Bosgre1c9sN94vTRvmDmPInAluu2QkjKM9dL
	GzU8r6S2/8EbmgJ67EqIQogLSONAJKerACr6EzSAE2tn9ENZRpmyqMeCFfUCMFZijC6TEs59Kom
	KSJwCWY3Z5YscIVLrDDbGtUsiGY+jQXdcLaTtydIBwNXU+LwJSzENHXlsEMJbW6s7m3rCsEn3Bs
	W9R5DIylJioFJBiRw==
X-Received: by 2002:a05:600c:8518:b0:4a0:35c:8953 with SMTP id 5b1f17b1804b1-4a17b527b00mr31622365e9.7.1791302581769;
        Tue, 06 Oct 2026 09:03:01 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.85.242.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm369641f8f.38.2026.10.06.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:03:01 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 06 Oct 2026 20:02:42 +0400
Subject: [PATCH v3 4/5] arm64: dts: rockchip: add reboot-mode node to
 RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-rk3576-reboot-mode-v3-4-6edba064693b@flipper.net>
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
In-Reply-To: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, 
 Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014; i=alchark@flipper.net;
 h=from:subject:message-id; bh=cuF3exscH8i6nh8FMRwgY1X/VW9bce/DQsITl0lqfwI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQdlV7DaTPvZdAxBeM899Qjj3Pj12YwbN22u+lOXHPA5
 I4fl2f4d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVd2Yw/LO6u7U1UbdilniM/ZxXqR/PzAiZ7dGl/P1G1CuncE6d346MDAtD+Ka
 cmsEsf3HBspjQ/6ZLjr6tXHzlFOcipY3Myku2TmQGAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The RK3576 boot ROM chooses its boot device order from PMU1_GRF OS_REG0
when that register holds one of its magic values: 0xef08a53c selects USB
download (maskrom) mode, 0xef085a3X selects boot mode X, overriding what
OTP or the SARADC strap would otherwise give.

OS_REG0 cannot be written ahead of a reset, as it is cleared by NPOR.
Instead TF-A takes a request from PMU0_GRF OS_REG16, forwards it to
OS_REG0 and masks the reset outputs so that it reaches the boot ROM.
That register is the one U-Boot uses for its own boot modes as well.

Describe it as a syscon-reboot-mode node, so that a reboot can carry a
request for maskrom or for a particular boot device. Under Linux, for
example:

	systemctl reboot --reboot-argument=maskrom

Requesting anything other than maskrom needs a TF-A containing commit
2a97ba20e901 ("feat(rk3576): forward any boot ROM boot mode request on
reset"); older builds ignore those requests and boot normally.

Link: https://docs.flipper.net/one/hardware/rk3576/boot-rom
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 9d9e9d7868a0..b40f4176f870 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -881,6 +881,42 @@ php_grf: syscon@26020000 {
 		pmu0_grf: syscon@26024000 {
 			compatible = "rockchip,rk3576-pmu0-grf", "syscon", "simple-mfd";
 			reg = <0x0 0x26024000 0x0 0x1000>;
+
+			/*
+			 * OS_REG16 carries a boot mode request across a reset.
+			 * TF-A picks it up while resetting the system, forwards
+			 * it to the boot ROM through PMU1_GRF OS_REG0 and masks
+			 * the reset outputs, so that the request survives NPOR.
+			 * The modes below are listed in boot mode order, each
+			 * naming the devices the boot ROM tries in turn.
+			 */
+			reboot_mode: reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x40>;
+				mode-normal = <BOOT_NORMAL>;
+				/* 1: USB */
+				mode-maskrom = <BOOT_BROM_DOWNLOAD>;
+				/* 2: SPI NOR, SPI NAND, USB */
+				mode-spi = <0xef085a32>;
+				/* 3: SPI NOR/NAND M1, eMMC, USB */
+				mode-spi-m1 = <0xef085a33>;
+				/* 4: SPI NOR/NAND M2, eMMC, USB */
+				mode-spi-m2 = <0xef085a34>;
+				/* 5: SPI NOR, SPI NAND, UFS, USB */
+				mode-spi-ufs = <0xef085a35>;
+				/* 6: SPI NOR/NAND M1, UFS, USB */
+				mode-spi-m1-ufs = <0xef085a36>;
+				/* 7: UFS, USB */
+				mode-ufs = <0xef085a37>;
+				/* 8: UFS, SD, USB */
+				mode-ufs-sd = <0xef085a38>;
+				/* 9: every SPI iomux, eMMC, SD, USB */
+				mode-spi-all = <0xef085a39>;
+				/* 10: eMMC, SD, USB */
+				mode-emmc-sd = <0xef085a3a>;
+				/* 11: eMMC, USB */
+				mode-emmc = <0xef085a3b>;
+			};
 		};
 
 		pmu1_grf: syscon@26026000 {

-- 
2.55.0

