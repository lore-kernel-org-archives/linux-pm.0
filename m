Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462703;
	b=fbY2DNfXUbk6cDeFKLORt2UXQ6uR+S6Cd7+jEydeFcCVO1zfhWNubkV4NoFWjywMT09R
	 yTi2IhPgbOyeUsRf1IrC62G04NTC4xGzSGSvWHu1y553YL6mFdEIyMSJDnhmnan63cxwl
	 8zKTfBWoXiFZJfgfmV9MXW75Yo5lw+yPrEhDq7XjMzG0sPmJqXFJ+GYPYZrRkKbwZYu6h
	 9rvMcJimLNY8Sdt9XnQ+up4SMTlIhCurqdDw4nd8kBdLcLUiGnzLxKNuSe7q9X5OpaVNS
	 g7oJ6D3vHEq8L+CFiPkxYH5M1TrWzECQZtXZo2KcBZqmugoDH1sE1X11PTqSfGG6Eug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=WCakZos+mfiXFM09wCe/FUxpZgmEm+7Z0/UDYavhyHsKdTwNOLmI6Kqka7woDJTRWqep
	 qmUs2Vmgzotp+LuSK0obgcrUT5Zs7Wea8UhE3atx3S1e7fYxOpOenS99+ukpiiM5Rbu//
	 hQZ22QSzbI+CJJr2gDuStHzX4wRsx4qh882oak4k+3NWjZ5eObJ3s4JKFtbn+KiIwTv6B
	 yOex/PK0EP6ANFu4cYr6QpcSSCN0Kgy5t7C1yjdw8QKFl+g6+5l9zq0cuJF4Ty8gv17Ni
	 FwFfJC4QnEYC0Sa1zGfmYRWRSmoWv4tT5zCo/F0ZppHsAhdFh5LSZxqDkAwMoP0QHhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbH1LX1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0C60A263A;
	Mon, 23 Nov 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbH1LX1U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462702;
	b=amVDTO0E74ANGtSbVrojnQjQcprDo1mXLEf8JClPIwYd9L+6krEz0GuvHubibin7XHri
	 OZrbkDKdQB60+rFr5sd0wXjqD8uv1NEA445FUxeZXuPR4Xd3Y3IyFmt50i1CzhHA83pCA
	 so4UOqfBhcpiEQVCbmlu06vpjUcslhy5oWSGo0qL2Jx7E1rdQ5dwK1Ffs761f7qUt0dne
	 7HcehYoaFuN1kuwRNStXd+qDP/1FgvVKNDWbXWikxpynmKE05cyUb6aBDUVsb3K+Kp3w0
	 6Vd3NzSrgV1rZtniCQf1GOOVHotITF59XbZ4PclDY89Qqu1giZ/owCTBn1jfA8EBcKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=tDXaKebNp9D4zZMzaW/xNX9oFHRqbhqxWUvnAtHBL6d+8k6B7VzaNxRZOR5tDq5UFoKF
	 T0neu3TivPpzWkUwDsy45I4b2lhSZNMVWe0rsjKUAyqdhe/DCOXxXD38VbjiYL4fnI9vc
	 aFZX8Cmnl9PR2iPkwvAsnV9zbXiNih86ffDDBCPLJclRteA2W9jaOCTJgAi64QyNaEuYP
	 GZQoBZAl6T7NcmDXxXD9+GX/9I/+CsHCvSRPkqXr2MBRClfxpNqIe6/pxLhYmonJiHKYT
	 qC5z/vJVOlqwN7ZsOIavDG53rbUD6R2/gJ4XADUmheNaPZbF9hKJMcMeVy9BI/0XzZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CFF171F000E1;
	Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462702;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DbH1LX1UuAvhs3qSDLLn9iJFfOOCR2M2Ayg2ghtpQ9ZvEd4Nd9Dtrx5ouwbeXA6Ta
	 P/i7p2XiqvdsViF1LbgypYUzAH6zDk3Y1pEaLm081O5fiC7ycln8YyZU0Qb46n3tCg
	 Hmz7irqB2aOCkWznNzYS/Qe2GgkpiOoU000NO9Gj9rovYVotlphjUP6Hc6cDxIW+lN
	 XSVXKe/DXn3MLIL6SO7OiMwMs+D2BF5PAG8XrIIMUKpdlO/DDySZmUcgtCIzWM+ayq
	 QdY7GzznoNAFGodibWhYn9wroLuo7iooxIQ6i4fTHJrT0Ehcw6EJ57hB1o99vvIrah
	 Tq1QgPCIde0vQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A7A494C6AD;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:41 +0100
Subject: [PATCH v4 09/11] arm64: dts: amlogic: Add HDMI TX PHY node for G12
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-9-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNOH42B+lxb/Ml9z/9Nlq4bZFganfZs1J25zL7pNqn
 JKqPqe7o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZjIIi+G/+kLXXdrsfHVHHHT
 V2M1DP65dcXNgGOVXd5fVKW9vyzNv83I0GD0jdWPtXiPT2i1iY1G7rqgjgsn22enJ5/YbJKSOHc
 9FwA=
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


