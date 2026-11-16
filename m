Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824293;
	b=Y3Th3D6U8uhW12uvh7WV9raRl97Wd05Fp/zRfRNNIPoO1+alpOlt11I3ZVpRHAvpCFoL
	 XxWd2Sq9gnnA2SndymTcT1qlBJzGlD0a/tieXbZqUSB+5knda3v7E1MYhudkSN8Wax2ZW
	 GeobhwJ4yG6qrg6U/UQZpLBOYdo9cX523a2st+ApiALkH2myNucJyjHLAmKyz4fBlzJHF
	 rWEhS/kdI8vIH5P9Ef6Jrvwafjpx4GRoJ0BzLjwStpNMDhs+0twnJ62+QNFM4uDYI/BhQ
	 I/PW7Wbuqy1Af5LGRdHINoQhBM7oT6KTxHzPZaVsnFdXufAjPLiD0eM612M1Z/EKo8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824293;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gaVuKFdtIle7JKOMDQ/wcXTfl8tFDx4LliF2md1UKpw=;
	b=Yl+vRtRlO/PmG4DjQ6ArJ2rPkMcL86N7nDaVE73QjzbY8J+4n72uhCEFkKK8fDtDnGmo
	 zsVETCkZQ7kOWzOLzxiLMVdcCEkllgGFvTqx+4DUuHcQQ2wZ258K0LdFNeH5EGwMDfLhR
	 Wcj5P7Z5nDr0EbNuNne9ciDVE+vLcpwCqqZHaLU7PCK1PeH7sQg8E1zB65s95EhZMZP9L
	 /QMnXOsalR6rJKWd1QBx+TkVug0nskEyX26j6nJzpIQU9ohJgJQ4tImEVQLBzttzuZa+/
	 LV+XrSUtyqXJsHnuOwA19Ty/Ya7qhpujfxrF3uz52h9JCZSTyLpTDR4rmThogfy5E9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS6UdBKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926A606A336;
	Mon, 16 Nov 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS6UdBKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4E81F000C5;
	Mon, 16 Nov 2026 10:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824292;
	bh=gaVuKFdtIle7JKOMDQ/wcXTfl8tFDx4LliF2md1UKpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kS6UdBKNRiz6+pU4ndVMPIn6Gy3EXHZWifC79HLVWf3YBVT9yormhp9TNfzmQMmc/
	 2CZw0AqFdyTJVs/UzlOnSqByVjAZdpQielYdGZoGLQCY3BstmAtjQF32oiXfxKNxYY
	 TUQh6IdLj89A4F3EgHRh2aS0LIg9WokgM+jBPW2XB1SlONOKLMsVkleztZkvp6HIR+
	 hWMkinrDWVvpYxTn9OuhyuAKikKc5U2NI7jRi/7zHti58yREHE/oLRc9PkTs8VOH0T
	 b9q2MuH3lBAPKWdCvtve5ahyMV7Asck5EZita4YJbct1udes+2ZVKDCiYugR8ETuaG
	 anubmRpUTkARw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:18:07 +0100
Subject: [PATCH 1/3] ARM: dts: ux500: Rename power domains node
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-powerdomain-dts-v1-1-e0f4459c3ab1@kernel.org>
References: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
In-Reply-To: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

This matches the naming used in the binding document
Documentation/devicetree/bindings/power/power-domain.yaml
It's most logical to call it a power controller.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index 912d2505318e..5b2b4527a472 100644
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
2.56.0

