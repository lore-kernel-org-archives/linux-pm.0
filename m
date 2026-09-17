Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97152B1E9;
	Thu, 17 Sep 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652970; cv=none; b=oV3t1Vp5sBQkEbntiSJGGTPcVA4cNjCFJgODXiQkQU/KR2FPuN5jGHafRPZIQUO72ylpLSRblBDHUt/mLuozY8QrwzL7aCi66xDQPZWbuBP4HR/49sSHASeHJ0LsmKkX8g5LCkZnniTNF98wIh9gG0/JNP/JfVxI7pB8n8WAgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652970; c=relaxed/simple;
	bh=UNAUWNTqDPEuEuXC9mWoAT2pgMMEmi++BoO2+4ivAP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/vJ6bRAYxOqR9AAJ2xtiHY4kZPiEg4E/1t6z6Hs84xRD2B8npKojppw0o1tcTq4VyPhOZJuBa/HWCxswx83DtMmN0kEaKJUAloXPymdiSviEcCAU//sanN3Jh+59sPgbsj5n4WNLwdNUGj9zevMIy8lJ+8Gd2Zy7iPrjUXnLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QWtL5Hv6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QWtL5Hv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652961;
	bh=UNAUWNTqDPEuEuXC9mWoAT2pgMMEmi++BoO2+4ivAP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QWtL5Hv64RSxvsWPTnFge8bSBeiW7EN9/oozxPtun3Kl0YtP1o69BpM3NYl/+XIuX
	 fuPVXt5eUbwlXp8GX4/2eRNuC6RuD/guFJF8xGSf8XEyVfXSMQse//35ODOi9+LV/j
	 PNbYM5zLPhmmENuQKahj6FbE/bBdeUyuRPGdU5mJQBuX6ns8RWm+9FExgLS3Jx+YmD
	 xRaJtDMuIKaNaXM0q6QHdecBYOcN01+QP6UUI7Sh1Xpuq7TnqAq7OU6YDFxnN29Ve/
	 tdTlMlYkBHDZ2RO+XCZZRQ6o/Vuj2Y3JpKYqsNW+9Mt6xpxhufGtH2BR2tpJOmV50e
	 vTQWC5moqS/Lw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C4EC717E01C5;
	Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 7B372480029; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 15:49:13 +0200
Subject: [PATCH 1/8] dt-bindings: clock: rk3588: add PCLK_DDR_MON_CH clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rockchip-dfi-cleanup-v1-1-4f00a97a69a6@collabora.com>
References: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
In-Reply-To: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=C8FVn7J52GHndEtJHzBBi/WU5EQNwPsmo9I3eNfLHLk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr7+G5gRT1Y4SWiCAXtzY+PZrOUVvQFThyX
 3ZOnEBDhOdfyokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PI
 O/qavMYP/AzsS7ugEUE3K3xXEw6TD5yZa8uBWSquhlmiqN5Auuyx7WMZR7HIeQU9Af+oDbqsDC2
 UXrIuELVmKvxF3F9Sv4+f2zmLKnHIrbvf3Oh8uCeEPHcdnkudRDcSLWg+2Lv0dUY12kSgiZcDtv
 USUDx7WRjKSIvE+YsbDk2NtRU9DidmeWVej7Q8PvLsBGGfyola+lczebuEtXGy0n1CMvyUGLtkt
 QXRz3elKmfN7wXLnsNWN3SKjC/CF/9+2vSyIFMMMXwOR4s2+CsUKYa4XgMci7wO5W0E69gMWVim
 bx2AuSOKFt4mJgC//ARlzq06jEkPd0cRghW27LkxLbidVkV+qZIgezz2I4tN+Ca1QoP5dqSlWME
 vInOIo6gYPC6QPp9xSNjRB7UE3GCRybgdsVu5Zm9Cla42FyCawaHm2Hs3a4Z82uB9pgK9kmNvP/
 DDi1rJrk6RFK80U6tzYweqPeA2nPJTqn5hHZXfyhmriUtpl7eevmcaoKnFBu654dajaD2xCoxlb
 KifHY7ABV09ioBEeIWoNckhHUXN7Zj0E6wc9bBsVftPnXz28shCDyDBRTS1IaUfqkOyXf80hqgN
 bH8PFnHB9vINmMI9fJskWnt/aI3XogEB5MdEWI+AFBciiP1r6BLK+2YU5TbLF1UN1+3vvr8rr/Q
 bMc/s/Ix26Gbo/6DQrTkn5g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

On RK3588, each memory channel has its own DDR bandwidth monitor
silicon, and each instance of that has its own clock gate that drives
the monitor logic.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/dt-bindings/clock/rockchip,rk3588-cru.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
index 7528034cff56..6ea25019ebb4 100644
--- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
@@ -738,6 +738,10 @@
 #define I2S1_8CH_MCLKOUT_TO_IO		723
 #define I2S2_2CH_MCLKOUT_TO_IO		724
 #define I2S3_2CH_MCLKOUT_TO_IO		725
+#define PCLK_DDR_MON_CH0		726
+#define PCLK_DDR_MON_CH1		727
+#define PCLK_DDR_MON_CH2		728
+#define PCLK_DDR_MON_CH3		729
 
 /* scmi-clocks indices */
 

-- 
2.53.0

