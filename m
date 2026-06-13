Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BC3921E3
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333925; cv=none; b=rxf+sVM3etUHOeIM263BlF1LBXO2MJLTumWXSnE6vBJrvZsJeafPfu0fRp5jvXd9NmMxUhN4hLP38ChFSRTc3kECsT3a3twfCVBGFOPP9qHpHaLv2c9GUwT3sy/L+dmVYb1Oh8D2J2P5jjiHdLE6l3A4O+nFEiVzrf5rZCzAZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333925; c=relaxed/simple;
	bh=nPY3wv2mci8wkKBwmvFP6TpH+QPqSd5Lve4SBi0sdAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQRV2MYVaN+ULbP5OWgxjGJSMkh9tziXPC7sMnXktvkxrOgbiQKsocvM0N9+ga4J/JGs3u/sQw7jL+Vzz3wMh5W37Sez1sOKMyjn0Euvo3mgpAGPk6pdD0vSMX+FCWM6kUpjj5ZWzPnJT0FpGnSRNEbY/NtbM94CxJmle4m45+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6AOfF3C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6AOfF3C"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso12149785e9.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333922; x=1781938722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
        b=k6AOfF3CoM028XgK9ioM+RJZUwbKRCc/LPiJaAobCyTZCmLDSyvTVC3Dr2yzCdlhoM
         TPTRHfgG+MVI5nS2tonIMr3jQ7zSKV27xT96MCB2d5JNl0nFBUeb++pJ5KsJpbTIsvVD
         JdPrrXqOX4djH1gGpP9f908J+j0qPln/eI/RFCjxIvUrY7xDAqxpMPsiGZ3pfovLk9to
         96lBSPMcBV7VQGn7ZJpR9uG8p6jTm9WdrFpEGSZsxMEP78c5ZwzAPvtoXRSzuA1ItYZF
         /9+TDnXrRF3JQ6oCxOsYcIyTLbHy42rBQtflfRUO4vzjAMw/5EOaqQByixKntRAjPRRt
         lbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333922; x=1781938722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
        b=AfLGYPOI6/t2WilN3/miOr8wEtVlBF3URwjdfP7t/ypY/LoszxoPzm0uSvSNERwRfG
         nWjCBsT25uoUn8ERLXsMUmfKvQFTcrq4UOUEoXIodPpW73p4gClErlcxrLjs8w7ZYnOt
         xwJq1v+AN/CqcLReS/Yd7bktnejD7E1T4+nqrmNHFSvpUkUBfymbMdtCP7fh08HTZnOS
         DKpBpfFpR5UhBxyp+ZHRx5Ylu7IihQbuI7xvkXkUCcb1A1J00SRJPpgd0TJRz7UMuYQJ
         0gUuuQlUZ69GGXD0ho334lb+7/Hk90Bk1VDubpswdzc93dSXoTJViVxv/qrMy7hRxaRA
         ieNw==
X-Forwarded-Encrypted: i=1; AFNElJ8Mpxy3toI4V0TdhcsKOaK58J3b7pQdukmr1CM4mY8Q1Log8PdI9BdRUwK9hVOKm4FLNZzVGj7eiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpDx4Ik7uhbXoU7kTjK1mNU0Uvulz2ZGF7jLP8AXQd5BWY8zB
	WvmxZmoapJ6OgUK5ttsXBw7Em+WzFHicBdU17BNaUM83igA2HfxLZ4dm
X-Gm-Gg: Acq92OH0trwd2FKhyxhAU/k8Qa0O7wXweR1+9NMRlSWSb4usMAiQWS7A4GoYC68JIdS
	CvKi8ZvYFNsNEvwaiKDXTaU64yfsmY+Ti3PAWc1oeLbeZzlJNugZhgCF35SUxANhKno53PHfetZ
	nI2UoiINqpnTHqCSvWgcLROlxI5fPlYR9JebTDp2zLlomfxW/LfSFNmFlnflpBRuwG40l5HRDrN
	Lvcc0vfwtVadIlj4vwe6uEJBU7ynhJ6sgSKqtvSb289yRcWTvJcFKNmg8in2uK7XYX+Ax4zHQE/
	a8JYH9ybtbvGF3NdVnsC6Hg90oWSLEPvNBGorpO2kaomOO1O0Ltqr8OjdBKv/urGgfttyq5C8eS
	5f3aJzd7sKe79zMmG7dS9iM3oLufMo/mZvQPCu7M45hOop5rSc3eKenvpqgbg60v3aKL0+U5v9v
	zn9mg0o5gZ62ssidlgbi+2/SZUZo0tX8rxuc/a4H0kNg==
X-Received: by 2002:a05:600c:83c8:b0:492:1e36:d16e with SMTP id 5b1f17b1804b1-4921e36d1a9mr40797495e9.36.1781333922475;
        Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 8/9] arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
Date: Sat, 13 Jun 2026 09:01:15 +0200
Message-Id: <20260613070116.438906-9-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

Enable the NPU and its IOMMU on ROCK 3B and wire vdd_npu as the NPU
power domain's domain-supply, so genpd brings the rail up and down with
the domain (the domain is marked need_regulator). The PVTPLL compute
clock is brought up later by the driver.

The rail is no longer kept always-on, so pin it to 1000 mV (the NPU's
1 GHz operating voltage; the driver runs a fixed compute rate with no
devfreq voltage scaling) and mark it boot-on, so it is up before the
power domain de-idles the NPU NoC at power-on.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 69001e453732e..d3f9776c2bdc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -330,9 +330,10 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
+				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -787,3 +788,16 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&pd_npu {
+	domain-supply = <&vdd_npu>;
+};
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.39.5

