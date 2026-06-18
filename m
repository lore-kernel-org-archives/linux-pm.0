Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A733F8B1;
	Thu, 18 Jun 2026 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758872; cv=none; b=t6uMxPKwd58ZtKka8W3nr+twWAdWNu0el4ungwnP8q4dLNQdCeH/mbXADJVG6vhrxwQOjrvzbbEzOvSXfNuFXip/Az8mDcsdS64bfJnYc7ev3nZEm0Cxjsd+LGp67JoiOjL90Q9gRxTYlqRwpkoy9Id1NKdJJwMBI9PSCtDcriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758872; c=relaxed/simple;
	bh=4ovtALgjE6UDDcoWwH2hO1j9+Klo5cNaXV7+hDbjmGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLHS2UFUT+ZG0GnzT+BqZYpPRWPIoedEIQSUPhxwWHusdmZN2R2VLahk8kpJfWB3VGcfLIxiPIigciqtFYoDoyZnU0LlSSNcrIljFc0UPrKUKozJbsHb8q/OX6HWBjk9ogUPUmEWskmUyfgeA3vN6iQVB+j8rfH0Zydv16FwbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf9YuCNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf9YuCNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48E61F000E9;
	Thu, 18 Jun 2026 05:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758870;
	bh=sHA1c+YTFswugOkwWPADK8MsK2KSP7p25UkONlDzkAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hf9YuCNAUeUoTaYomuSiK7BZprOo4vuTe3NF7zzGe6DmdhU3rkd/XLAqp3qldLZ52
	 L2VP7qnrZHPKkPY4vJoNHAB/eJLFLMWkdq7bXsfhjHSggJozLU/lDzGiBF5E9sQoGc
	 dZoHUnbilnMc2FaPuohn6nZdrh9O8F0p+N8ar7oT4XuFpuZQqys6N3UaXOYaZ9/UGb
	 1bzxAOzBDA2LMIY1E8XEKeBjWuT/K202Jsr3Wy+JA36GjDxZq5+1DMbDLVuMpziDSA
	 87t6hSR6ZDcd8M8LA1+8d/1NJtarxoSk6rrMUWTNR4lRsrJlfFol6CCz4PDFk0X/2k
	 hREGHsdwyKd8w==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:50 +0200
Subject: [PATCH 04/11] ARM: dts: ux500: Rename power domains node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-4-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This matches the naming used in the binding document
Documentation/devicetree/bindings/power/power-domain.yaml
It's most logical to call it a power controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index 0f87abeddc33..d76a65da7011 100644
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
2.54.0

