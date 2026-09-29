Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816D50C2AE
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677739; cv=none; b=YiCXM4Ciy/4pnQXpU6BYcd6QHfKwhyD/NY00VmulCOAhhXLV2bxQZUrn6qVjLdJzecyId0pEdzBWJHEzqeyEx3ZPwKSBpt7DYO2KQRvOzsciqjNu0R+IRUerLxFytGrFKhOdF5kiTR6pWrolnssT2NffnPCQRW4n1XofhqWbIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677739; c=relaxed/simple;
	bh=7swkMqPaYDA2lMwF80q1xxmYZJyUeDGGLHz75wJEGRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBw3qtuPl8pcz+fGc6ukBB9fIsXSDwWb47KOUf/tVq73aO533WqwYY9+5oVUeb69HdnCk1bAfccFsmRVsx2iP3vtPC2QL80Rg1xSv4Zym5Q+4aOTdtc10vrxUENnBlvsYTx1lf4wPfmM3ndlCR988daoF3XBFdu7Z3tSoiq8L88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=hM+OmhG3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="hM+OmhG3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so22481855e9.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790677724; x=1791282524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wqp7f3x5gi8Fa08DrT1eEvtbc+6lIp3fUU9P0chtfKI=;
        b=hM+OmhG38gy2wsXLbh3lHQdrwkdkECZS/h/M8DiSWdfLGQLYYmJ/x0aAjw1fKiZAPB
         ikQhF9UeVH+/XyhGZyyrqbHEHJMGMM/fvCxwzBaFg1jhVvZWQDAMFFDwn/kCDQae07fe
         MlyaN5qlKn6k7OOmvmqMnWYIb+QEuJQXg7VY6oj0Q85dP78xYCG2g+VQO7i7g1Pl2DfR
         cVcm9QgxhzEOZNY4wOU0xkgf/DZ9nKfe3aTULFNB0SgsO4BiY2me4xe8hjRJpwSsCmBl
         Y7nUBZASLNknnVDlqIGVvSRCItyHVWs+ATMApybvazrq6i8LG9IlARAop5SgCnfgtN4X
         AWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677724; x=1791282524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wqp7f3x5gi8Fa08DrT1eEvtbc+6lIp3fUU9P0chtfKI=;
        b=avpgLcyp35/UdDvuG6KG5x+hh8fUO3DWFSXnHK2HMETJSlVrbS5kSZQs6m1ooufihE
         eai+qyp6zTBJtM87Ia2R9+maYnvP89XQoZ4UTSfQ+HPdMd7RiG/aa8WKSaKYoOdyQ4U6
         Amlw7Z2+MuWfnbwyd2mxTsoZaGTRvK1FdYVnqzaT4HBZQFfkl+HEfYEIT6rBROzu5Smf
         xBQ6iHdinHsL5STw6jMMLD6i5N/69lyLrC5c/RQ1cEpmnArzVTKUjxk5WhQQzefciS0H
         Ox9IF7vuF0MEeojoL4uLiRoM5N9iYAAhTdkO/UGO0Mf39AAODsnEZRtMHnNLTjbtMj7J
         RtgA==
X-Forwarded-Encrypted: i=1; AKwUvBxqJp3gDg4/OgKltXW2HJNenbzXO+wn1E/o8wQfT/nNVHxhfqykosva/DBAvhuZx7g49p1ajVT5Hw==@vger.kernel.org
X-Gm-Message-State: AFuF++nZ9r6Tbx4DCqVAmEbwNwqgxvsNAPvTXzoLNUYsT6XwOVZseWq9
	S1Yb6CZ3IK6b3t50UYzYQ3JbF1NUL5/4y3MV2D9ZpIqJFRWPlQ5hIf7+tFTqJ2YH48c=
X-Gm-Gg: AYBFou2YjGLff8rD2sj1YbFdgy38ZsgU6oxe5D8MyGy7JOr+GOQuumRkhSzGFrBohTr
	DoW/9RyfDFp0WnkFdNQ+D6eOet/iMkOtnGj2kQRTCPntd0cuOdBTvaP1skzBGMoA8b6X/+ehfwK
	OPbgtVbxYO4P29gf7VDOfD/M0qQxvYEyg4qkxNCu8j7JuNiBxZwAxrbS+0Ak0VjMRd1kur0uugv
	j/etQ/KBIF+FrVUYa/rUXpXM7KTiC9swv+y9SocUf8DOEIpdm/0nc9YjFUk5FoVhySD+MNQZiTS
	c8vogMv1ISIdL0mRnm1Z6baGNKPFHvh8o4h2oveo170K9vdjbXnD7g1z37B2iGbq6hZ+WwS+n7e
	HD+XzeKJHFgmcg4zvjIeuKdJaMjnYURSkVzMEcjzl2CyYW9bgsLfvuefP3QrcUDkfQW7zsy6t5F
	SfHinBuk/JXMkYWY7DvGpI6cmAGqEDA0K6+Fq2gyIh7g2b8Yc9l3rf/YKwcR4keseW+zWxcfUu3
	zuh90oJ70azAYwPrNc=
X-Received: by 2002:a05:600c:8718:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49ff06f8316mr198386125e9.31.1790677723751;
        Tue, 29 Sep 2026 03:28:43 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfb479asm66579305e9.15.2026.09.29.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:28:43 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:28:21 +0400
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add reboot-mode node to
 RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rk3576-reboot-mode-v2-4-5a34ca72065a@flipper.net>
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
In-Reply-To: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014; i=alchark@flipper.net;
 h=from:subject:message-id; bh=7swkMqPaYDA2lMwF80q1xxmYZJyUeDGGLHz75wJEGRc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtnnRxhxTnvOtxPyRcGQ3fxJrWGafOslgb+c/oYvNpi
 YgTnl/OdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDV+14z/FP7sOKDnOvU0vau9+kKW9L3Hsl2X/Byh7Dif8U1fSfWrmZgZHiwzlP
 pbIz83R18W15f8n6uNun4gvXfzbv57ewEDBrM/JgB
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
index e87ace5d05e6..c938dbcad712 100644
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

