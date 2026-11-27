Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793343;
	b=Y8xJF5F+h7eWtKkeGVh90MUkXu8PUP2FLnINWGU33McZsl8waxQ462JjMKQk9WDw1inX
	 sg7bvIF6wheabz7F25Qmg2U7EsEQVvPV/8B/P+pKgcYwFKtFNknokNa/HWjLSDBYWMW87
	 5EkPtdE5KMHi35QLvFZWXNHA+jzUAWPVE/q3pzJqJdRGE58F5iZ7d5Y4tAbX9Rw/4bA6T
	 4ScPKAIh7di9kkL92RNN1C1zSwqy1drFwRXEO2xThuArfyiNAvi8fAo20W29GKPyIOonx
	 UplkZdepDk4PfoGDErAhMdVoxNGopqE55D4w6trQS63RTTkaLvB89DBpv6h1HDVoMng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793343;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=iG6MWaGCt+vyueHvt981FRS6FIYLLuWxrpJWK7g8jJNq9peDHe298OBg7o4rMh1ws/6t
	 dT5mDo87Q59pH6AQzOjeMySFlm7sXMUUpA7FlFw3lB8WBgMyoQkya6w68ex5CoCqBVLUG
	 WA+1Q3Rjxg0L+G+WEOTo04JdM/rZa+87h5rXpSwwRnaeqypK5UynS5iVfUUbIelm7zr4q
	 5X5rNB77IkKY61gXHZBq4TQoj84pr06CduocRO8WfVp4NdbWPmfN+mPWVQvzDLf+LE0HL
	 T2w7auioPgPwOw9/743PqU/MbBFKSgPTxViD3WucWhGpo3B5k9LYhAMU2TnlbxP/zZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjDMO9vk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027660A5BE1;
	Fri, 27 Nov 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjDMO9vk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793343;
	b=SvGdZ1aNzqaZ32HYtanRIRQ7uuCg8uUfZTr6kNOLDYm/6JHnRFoeaesF0xvaca6SRoUJ
	 HU9y0wdQyFDR2YQw9tQqmsGkLUVfeu0JEzpyZo5iI7EjVIiqeUCWCvwonl2R3+tOQBzrD
	 eKWvjCoQ+Z+RHevILQ8CisY+Ng7MncwyWXbFoKlfd2XONGoNahoOnNv/KX1Dbos5vx8Hs
	 FKbmBrYke2YYjd6CGrGbMAk4xMvKq4mt/YjPpd6XqLsJKBmPMeJlecYFHT/UiXMAJWlkG
	 kCHpYMkcUgb5bIdAOSsdx8FEqXaaLLvruM+ermZ+3CVGOFs8LBglqidpGbRMHUVcKdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793343;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=lHkOaEpz4cGM29Xn6uPCiBoL/bu/WO/o06qwKLZ4kgvlubTRiGZWCCmejVVu2vk/GiJ9
	 +n5FrqMrVU2XSDmxHYQ47rc30G+CUSRUPllI0OKu39AS2aw5XoXwTQapzjxX40juV88XX
	 BWRWmVjp0Iie1TQRrzswLzb7OvwFS0dLpXvEAZMVJNs6QG8PbFpJdYD4DEy9tr9LWmCy7
	 UPPZbgl4xRoTTv8Nf7/Fe9HcRCqybSieBw/yF5et+6yTtNJgw0ICrXHQLjwXCyTxMA66s
	 i8Ud7fhebKivFQMvS4Ur3gZfSEsTbqhifrKvoP4CLEfD5iG1ee4mAg3dS5FOf2BshPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D3FDE1F00925;
	Fri, 27 Nov 2026 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793343;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OjDMO9vkfL+uj5gUUtgO5sMfoySJp7q487ZkAd1uDGfsVDWFZgrdvfD//AO21NON0
	 7n8t1RiEtmdUjmjTCkOXX7TjdF5EMaDuFRr1+MvK+kjFbj3fBdOhXiwUmw7uvN8+DW
	 XozQfyzMsVdgM9btKfmasVa+cTY/XKdh/Y10HE5Xr6SAFL+lzg1oz8hXSYQxN4QziF
	 EOvpPWtCG+RxJ336TUqVkith3iI9Y4xck8AS+f2gxkaYbbRyrOZ0tuUF7Sh9DzQKKO
	 Esj+ujxFxhFoHmE7SnsNrmBOAQXqmcNxDTuJnsQgaa/Uabei9sBFEJh8VJEL5fqO7Q
	 KuZ2WnM5OUzHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2ABFA4DC94;
	Fri, 27 Nov 2026 15:28:30 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:11 +0100
Subject: [PATCH v5 10/12] arm64: dts: amlogic: Add HDMI TX PHY node for G12
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-10-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=96ezTxgocDNVGkQVkrXP3m6ZHN0B1G+z/JYBO9mFeTE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwukyn0847WZYHLn8/IcP0e8fVVe5+mr8MXxhJbxD9
 75Eh8vOjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiqy4wMmzMKQr7FN8T33t9
 m1j+nSBR9t3/NFQ637VIOW77rLEkzYqRYef+cxPd1j7YdkyyMPpb7w3puccuLJ+RbH1go6dM19x
 bLWwA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-g12a-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3135566df880..7f9eda4298e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -210,6 +210,7 @@ hdmi_tx: hdmi-tx@0 {
 					 <&clkc CLKID_HTX_PCLK>,
 					 <&clkc CLKID_VPU_INTR>;
 				clock-names = "isfr", "iahb", "venci";
+				phys = <&hdmi_tx_phy>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#sound-dai-cells = <0>;
@@ -1683,6 +1684,11 @@ mipi_analog_dphy: phy {
 						#phy-cells = <0>;
 						status = "disabled";
 					};
+
+					hdmi_tx_phy: hdmi-phy {
+						compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+						#phy-cells = <0>;
+					};
 				};
 			};
 

-- 
2.56.1


