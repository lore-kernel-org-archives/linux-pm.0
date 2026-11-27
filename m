Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793330;
	b=g7dq/JIWz3fk5Fo7Wumh79N+Va3qmfRTfqg+kEid3RVHrot0qoKHKoqZ/9ddQ2rBI3tS
	 2Olgc+Pn4EcWXtKkkqF8Zv/ZZxqq0dgyikqCK62OgFXaJnrUJtqob2esy1WlGgPBKrdd3
	 eg2Ab8YFcOspD28op6nnN6DlHFLqzXnhHLPEZeOBLwl80jgwJhkSu0CcJ5N+FAGHzYAA9
	 ZmrMWqTtNeyIjv3HeiA+LoHHEpp1jtfF3SjZ4PiJ7JQqt0hBEXsMB02Q2iCYPbnyAfGI8
	 wfTt7FrcCpMrRVPv3TpsF1XAkYm7igx23Q58t9Zhw/IDnUZhZQbO99SjMl8n0diY/1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793330;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=blB7I9H5itj9dcyhem0SmQJrXn8G6etkGl/mmv63mSGVNFTvzNxaHpJ1py1e3U8ePNxo
	 lmBvrmkVBk86NK9hWidM1TW2y1Qiy+IW6HsnsUjTssSQHeBeyOWR6ENYgX68BufwhnaJO
	 cMN31Mfidye+ToHK0Eb1mXGZEICvtCztjJ2HaeBm8FwdEfF6aywrDUM5Qz0TAG8Hx0WfG
	 bxyKcGYK+z0JRPaZsopUY2GvPGdkkAy91VvYj23ZUn5ppq3jiqoaLH4IcMcd3avntepFA
	 Z+7GuesGB5GnRJiwz1+60A4pJ8unBZyl8j2TTUSdIefEm05AQM87e83RS5OuxpEwdYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sb10ThbZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3360A2614;
	Fri, 27 Nov 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sb10ThbZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793329;
	b=IywXHFGyuqLc/hsijVNoTJXETCpeuI8KyyakPX9tp4a1IdihoID4uW1m4lDtXSGZYop+
	 pfR7obGozR3QPBvaj3puysbuY3+y11jmtjCp4pOk6BJywn9dWQ/g7zj6+YyvGmEq0fHp2
	 hUcCwfwldRdcJWLDibjUzLUpl05NlI6RO5pNIVMUO9rmJta/GN7f76kO8p4V2ZEDUl1Uj
	 aSDgeEsIc1yn2cho2eWJ7gcY98Ps51t0U+N85la/BR8MMoL+WTUaDvMyU7cyv+XSZeTx8
	 f8Mm12PhwzTVxQYDB8tKvHiJq+4ExuKfD74Ue7wHlFWdBpI7wyq4QPMPEbVr8kwwr5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793329;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	b=SNOu6Gh5QFtXKmbgP2jSRigLhFDGuljzIHC0vE1SyTaAYEAJgXHQmWdMqG5jvpNra1+J
	 Vn+7jWcwZBf27qDu0ejFgQaoud2VUk3Avo9xONRc8fuUQZYpQAj9I4EYJMvqb2Uj1GMQm
	 ydS1Li8ySUgVGV2HY/jJaVWLxCm0DJDLswrxiZ7wXvOeETMG7mHYMAd2cPRfoCN5lvzVQ
	 pNlZMbNaBaD8d85ITEm3cSgOa2SII4aW5gMr1QcWkFSHVXixtw+Dds6qNcc6kctfHtTIx
	 aFezE+t74bMFgz3sQEyiUPFZjrJwz/hB4j8thwJU7pjuUIn/Hj7XaaGU6yaYO76r93w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 709E41F00924;
	Fri, 27 Nov 2026 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793329;
	bh=y8B3yYureNWw/gPn5TmCorzbaVWuAnwa7i0qf1DFZYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Sb10ThbZFg8I8BMpDHCO+ltMzwQeIOCoYtxr5RrmS5ubr4Jybma+NlB8Um1tUYdNC
	 ZzQ4AkRitIsT1ZzcOJzhM3FqPDGidmR9V7w9gR35tsd/f+1hy42KTbw3H8DyxgNULB
	 uc+ZXeGZ19yi6CEce9mlcg5lIvRgDiu8Fpd7mf3Dg4+zYyI4JkpAh41YzHZ15c4IwW
	 h4f8lMKxcMKVBwiwpzQrQrIAiYgSwrTBrGrZYAKAOGha89MSnpm0rpR8A5Qu23n1e4
	 rndYKOdJj5oUmrCCWlKLw/sgSzUKlGRkFvEdVJreyp9ouLlJ/zskSS8tCLhQ8MKEkj
	 TElR9PFdAPNdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96DAB4DC84;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:07 +0100
Subject: [PATCH v5 06/12] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 phys
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-6-88c43eb95468@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=gEM9bIkhQe1Q+n5KKc7w/RzPzlM5UABBv5gf7bLSb8c=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwglzElaKKM5o3jc1dV4fA8cnnxObWZ70/TmR3qwWw
 DF5XYBTRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCRtwoMfzh8WXmO/p0g/dOt
 3ePkm77X0oHXZCKbfnpoCBznueoTNYeR4bvj0dM3q05vVy20qN+/V1Zxu1rX+nzX7o+ZFdIrOAq
 DWAA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY now has its own binding and driver. Describe the link
between the HDMI TX controller and its PHY with a "phys" property
holding a single phandle, and update the example accordingly.

The property is optional so that existing DT, which do not describe
the PHY, keep validating; the driver falls back to creating the PHY
itself in that case.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 416fe263ac92..7ece4ea262bd 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -108,6 +108,9 @@ properties:
 
   sound-name-prefix: true
 
+  phys:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -136,6 +139,7 @@ examples:
         power-domains = <&pd_vpu>;
         #address-cells = <1>;
         #size-cells = <0>;
+        phys = <&hdmi_tx_phy>;
 
         /* VPU VENC Input */
         hdmi_tx_venc_port: port@0 {

-- 
2.56.1


