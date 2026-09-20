Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239D370D6E;
	Sun, 20 Sep 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944526; cv=none; b=pvT0W+QExaxhK0fXdSw+uPvKNGdYBwsB0C2dhPjJgB1P7ABumYtOJfMB7tFnlsUznJJK83F0qKvu+Qz94PVHC7qsj4NKLrt4IGPz84mMCTBejS6SsB+eWfgI3XfjI+tDULM5gOYwCAM2GAjRGv9TVhza6qeC8KIqlEnsrtKG3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944526; c=relaxed/simple;
	bh=zYCfWemPXCxKc9bnVjmB4bia01decMQWv2CK9m0VATI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3tGzIV1IRPWbzUWMSCrazqF2tLKqxjAutbIduUt014HMCVGPoXQSQEqdWrDkCI1VZU5Q37ONIFQEoHwxv9xTHCGmzxZ6BYAekvtYF7ZpoAQC87WDib+oIxIMk0hcVZQPihR9RDkX36BC1AdJYsxF8WBDkVF3vWCbDosBCD5xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP3gQLna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP3gQLna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF1D1F000FF;
	Sun, 20 Sep 2026 22:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944525;
	bh=7LrJiEVM95oznn+hJH8/9LEjNBqxWrIAa6YUnSAT8k8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bP3gQLnaIwo225Tg6gJB7a19mojGt4JpefiHDwZy5LPdCKWkhR4DZ6iQraCx45IJc
	 Mk5ODpyNUXSgpf94D12KnQ6ekTm+hPdp722+5vgpK0kt9qvIFz0Y0EHGNuNCi/DxQM
	 rDcyDTqK4ztRUrEh2gsi20HniBjKpJiqi1kAesQJbynW+UKWo1p5xkVyc6JrvBn2xJ
	 t71P1n3RIQH03UtOicaG5HoGMifY3FyegznEXTsebIN5u9h99CrcZY6syA0InDviV5
	 tcDR15GD2Xk9B7x7CuVwvqU+SrUhJOAMPOaEOymZtQ+fwSXMLknolh3TPdNdo3cFrb
	 I8CkkHOm0HdeQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:13 +0200
Subject: [PATCH v3 07/18] ARM: dts: ux500: Rename power domains node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-7-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
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

