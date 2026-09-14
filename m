Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0542E404;
	Mon, 14 Sep 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386907; cv=none; b=Y2ATMycs3p56KdMMJ99p2wo+8ygBgyweBnk9OQAJYv1HjxR9Z/ga92Nxxg1nFLzFfURx/mXO4MJM2/0mBbeW9r+uZS+E3y/8y5UiSZE4rhErENsmBFdmnKxOo/X7yGMnPXBiurQq7LgXiuqOwAQaE/8Y52uyqJrh6imSBNzQcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386907; c=relaxed/simple;
	bh=zYCfWemPXCxKc9bnVjmB4bia01decMQWv2CK9m0VATI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXOaQxVQ/qu5FOShSOMBDKFfuh8TIzN5CEPeHvfzoYZWYo5UIOFf3ajq8rPU5mqWzTWmtsVe0miJBLev8/QC+zfCLieDb089akoHKj0/RKUrPLi01Sbobc5NHpjjH0W+4JTOqBjFNmRQGPuIXqpmnRQCxNGkA1mzxRnJv8zxdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsUttVaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsUttVaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DA1F00893;
	Mon, 14 Sep 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386906;
	bh=7LrJiEVM95oznn+hJH8/9LEjNBqxWrIAa6YUnSAT8k8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EsUttVaT5bY5g2WEOBUok/G9cDulYiQRo8RrbBiDnAG7/mYzFOAKAc9TsMmB31Jz4
	 Iw+vllOxFNXSsWbbTY0uAhKJkxxUbpoX3mCJ9sPOpWdhmf/ZPOAfDOMScZX35JxZU4
	 6yzNlcZa/zSt22g8hqbsKPKAL96e23UDBhtjRra4Phi6YdPbuFehbhPaKR8uVKSntW
	 o29/JdVk461L+rWI8bVqz9ObHMgRZ7JRy3W0DeUgj9VVNwVJioCZuAUURhQgNJqXCy
	 3Vm+/Z7AMYiOcl6CgqLPTgxF++icQGhm7Z70gSUUJD4O0a26GVCTCiBPYX0SrlyspU
	 JUJFeGZMF/yNQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:35 +0200
Subject: [PATCH v2 07/20] ARM: dts: ux500: Rename power domains node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-7-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This matches the naming used in the binding document
Documentation/devicetree/bindings/power/power-domain.yaml
It's most logical to call it a power controller.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index 25a20fafc6b9..11fcae1904e2 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -343,7 +343,7 @@ pmu {
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pm_domains: pm_domains0 {
+		pm_domains: power-controller {
 			compatible = "stericsson,ux500-pm-domains";
 			#power-domain-cells = <1>;
 		};

-- 
2.55.0

