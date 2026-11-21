Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288906;
	b=y9Us1xYbteKoF7Il+uKvy+tkoyAZRey28+Multl3qaFnT4aPHteTvFq6qA3kaPYhAAWU
	 swCPC5eU+PaoYz7/4dGVkc4Ggasfo7X8JMvnObbUBe0lLEOnbpIiXcWGoNec8YHVPspju
	 XH+aeXFsjCqIQYjAXS7Z0GScrsAc1vkTd/HYpWDlVghcnpXNGJXJZg6y+C3+Doq86Uv/M
	 2UVi28f5fTI8jRfZr7aeMobk8xvpeQkYFGAJCSTIWVIhmuiv4DHIRiM3xPcz2TzTDbG76
	 VUFHZRIlNv1fZ/gJUCP/8nuK+qsAF9K9U/SiNekvOJnY5Ra9seJjExz7uSpfl9C5DDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288906;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	b=rcyTbKaooLpEngRec7dpAX3VQ2eYTPW+pEauUvv0ldEhQCIEqcWZ2Qx2kXIzUcfOg7Mv
	 a23PQbDcRl65uLeVGuCJlVNESP5nLcz2uKv95YFhIsKZfk4LJ2q9a26dDUvoW6m4Rs1vh
	 rzjSq8spX2eiDDDFCjiOZsGL1ViAvT9jf0H8rYbtmCcVKlQxwWr3173HBbuxzehdo3623
	 ydP4kL3GbJixAjL+Az9h8A1NlIW5/4TWqg66GOVg6R7kLJaQDddDu9OBXGS8Kk/QlTB6C
	 vDq0Fdv++UceIdsniBQe57GU8WhHGyzs77kHoCoFDLsYdeCeDp/2ZGVZlU5owcirPgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWhhZ8Tx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D960A2605;
	Sat, 21 Nov 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWhhZ8Tx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288906;
	b=JRI2hHvb8B3SAr63wKsi5aNi0e7XxfYf+iIdOwmTR4OfyRGVq4hiNavKu0ZJjj8rqC4d
	 DNHjkOUMmr6LXBEpbnRF7d6/ytH75lf9bKPyPgmH5hAaXCoZVL6E4UyTHQDGA8E0qQVPN
	 u6ij3R9oZKY1V6emPLa3CJxuvOhpyTKIIcrtZ9lq8FJ43WWM+gri+i1lXBxnIyqwpBwkE
	 f+lsamH0cX6x20weIZt4SbY6LZ1hJAn4KQU02TYcqrMpdR4oSR49Ds4pFiLHdIvYKoLbB
	 eIAX7heL4Pcd5BEYCEtIdAhPj+85JzJONXjrvTpq4Sm0W3DIJCxzePqstzQ1kQthkcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288906;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	b=lukfTTr48vAw4iNlV5IWtq6Ue3gS6DXHpaBsjf8wP8QoB/JhXEsVksCOwDzn7buqTRve
	 IDKIokkJo8WsfbGUbjLkBkmsIgjMXQn5HT/MqK4i7thKnIkVWlrzYamO6Rp8Tqp2vwRcw
	 pL3eF/kv2JBy/SYkDq6hKdqMkBt3iZS0ABD9yH0J3X3gQ8cCDIFtTEbdrYSdY8lUDDPK0
	 8z/Guh7h/tBkK3LRiMgBXMFLG07QQnranGqhpjOqgmLINXPDYDLpf3uVlU4+64vn00jT1
	 95FxlHW5/NZp0pgDrIdwb3Utg2Bek9Cr8Y+bwm3GMn6HdGHmR70V/u6GsEKGaTFBsFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0A9DF1F00AD3;
	Sat, 21 Nov 2026 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288906;
	bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NWhhZ8TxIs81wdW1Fy4yXuk26SrglkNzvDmS+Tldb5rGmbmJZs/K9MjKYYxFoyRXh
	 RRXbNkYOcdrP1qem3wGnqCJCZnH+u3NIDi5VWIwNkCOIx6JeooT4tYkFh8j4a+Ip2C
	 g3zTmKIAX9JA+E6a/7O6SYTTrAJsrieqEeEdi5GXrHOw6n3/Mu0+kTIdvlURz+3jW/
	 wMyxX2gNYQBG67iVaNflkrRRBfckQJiogtOzAfO/69n52ZX1KnXE1/uwkxcBppr33t
	 ceAk3KZbOL9K0SI4o1wnIu6W0t+Bwwh7+uucrPHGuQkUWoZ+ucaOPGMshEGpStbsyl
	 YAzocPve+BXHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA8344BD8E;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:13 +0100
Subject: [PATCH v3 11/11] arm64: dts: amlogic: Add HDMI TX PHY node for GXL
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-11-f8f471788076@aliel.fr>
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
In-Reply-To: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JP7lAwalWZ4HUjkBJydQfX0hMiglUBnijIXqwFKtcOI=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje/vf+uX5V92qrFhOTbM66DQ/fFWce6/zjVxHdl8xo
 bTjO791lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABOplmVk6OwMktjnz/e14YbN
 05PHN65YoHK99eNTJ4apGxPnuvmbqTL84S3ns3obu9m22l7e++rn8P7EJqVrLwzYb0p83Fqj/9W
 OAwA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-gxl-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index f257fe3860f7..d205eec1cff7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -328,6 +328,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -342,6 +343,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxl-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


