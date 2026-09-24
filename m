Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA975485923;
	Thu, 24 Sep 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245412; cv=none; b=AgJO7mB6DPA4bqHXLPW7A4jGsWPaMcujv5vfW/AwWZCNVDTZI7/cvDV4swzv4xkVRGIBmoon5scHf+yFoQ1NyXseAoNV7ISmdpwV94b2hCSO6najSnJsrXeOcSPobtA7AJ/sZxmQnynAw/9OTqQUj5PV6Z7UQPGforFxkiY62wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245412; c=relaxed/simple;
	bh=Cgly8TEKopIKvpKWWaWTagyw/SJr76FFoxn1wZIvCt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h38MEioILochmX45I8zG/HJZzRgaoTYN+O9jaXNfiWteGtnlr9Kx2OnWkkJLQXRdHuY5bdfbYhzGAeoEyZm4Mt5bOhd6ifnwCSCrKDyoJ0M8ZJjP6xuKbG2A3DDbkmLJbMWS1bTZ4lXxs4sEppY3wQqJXEVBlEryKvHjgDGip1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Fq63dGEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kye1lHdy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Fq63dGEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kye1lHdy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 317F57A0050;
	Thu, 24 Sep 2026 06:23:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245409; x=
	1790331809; bh=fjZXWoZZip19sL7tjkZDc/7/80qtiy5qzznuNuxHcqU=; b=F
	q63dGEVWBd59WbAw+7ATFy/E+UvswBd+aNBI6hpQ0NtwajGNXIK29fJkSnlbEaE/
	TFA6gzNnJxigeZMUZ4mwNaI42Vaq7ObXR4qlO/ocCvS0W8Tjrrg1xZXFRRxho/rh
	F4J9kBy1zdKprJcE9U9uKaRd/hdz7zLf5exu3DBaravGWOtWyUihSNO6nixN9B4h
	ZtpOVTB7ssTI5+/Ty9Q6PfScyw/z3ieXBOWv30AZebH06fbPHTlTEL+S/xaQXSnN
	fCuqQorE2KuRwqGlOg8NC1hz3jl+/+3HV1FrB5oPzrcyUGixvfZvUkRKJ8ss2VQd
	q9m6g3WyzrRMMBvoquLbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245409; x=1790331809; bh=f
	jZXWoZZip19sL7tjkZDc/7/80qtiy5qzznuNuxHcqU=; b=Kye1lHdyHcem6fy4m
	BFzQm/TijNMhIH5dLXddKNwwGSEywn8iQILwh2BRUzxvql9myZVVABIhYDexFOnI
	m0drZCOT8UOOeD781YtQ9p2QGbNe+sC/ncqzlD8uqnvH9FTxcuhQWxvE3mc6cFte
	fslmhwK/bi0e5qMj8BwOdKtNpdakoRecOj4IsHz7Bxcb0zaJV2xk0hMLq8fe9XfW
	h2gQ4CWiSZumRFoEwyWROo0/NeduT70ofZek3CO/HDMKewqSX4RNHcdWiv/ewkLQ
	IkpeFxl6CDJGNR3HM21DeQtFGZgYn12GTtZCJqvMw0LddLblQ4qxNhMpP94+hutu
	a2zhg==
X-ME-Sender: <xms:IPq0ai5eAZjQmzymTLb71kBNlvExi2jXHihpW1P2X3vySWxAfQ8YSg>
    <xme:IPq0ai1vLaOuYIGPv-0WSaRWA2BqHT_ud31s1vxHPr2lRUnJZTqYBM-6BR8rx5_-G
    6Xdur9hEaJjCiUKpI-QNyYceV6jDDdJA-01zbUmZn0lXStT4z9Y-VWN>
X-ME-Received: <xmr:IPq0an5vd1tpiZzlVMJOHhIa5v3GRk7N0MunXdaw07Lcop0UZcWNsNMCe14W9NX--j6fURaJSw>
X-ME-Proxy-Cause: dmFkZTFedTl3F1DIrTHCICe4Fo+6yuH2iIryXb4vaD1hJk5uz+D3fdxBaPEGleMmtjQ9jj
    /AH1EkwAh8wKmQiLT/9bSvDiQhW+TZmRyikvMLrEzAS6A5ogRqUhM4yxUxSgAmF4L6zbNq
    JU1CrDOUHEJdjtSdpDsxEskFn/aWSY8EhEM69IoGnovQNyACerECRpwt+2pE+OuDo6j5C2
    BOOC64LiXafVGJCK8SqFHoQAP2FF+TvLHYjrI91po4XURVMn1pQeIKHxydNlGe/KKK+FAO
    2AUxd7OWs8ZDGv/h0aNNMjxPVGQhrAw5D/31vFjHI5S7swl3HoagxPlYCWUyU9dgrzlHjB
    RJUHNTh36M5zO2lB8O6hX9mz/Vd7QUw7+seovWFXkLE0AGE1xPXo9RLDfRxiHNN24BMG5a
    NUYnGvjZHAvCZyFOb3T2hHkeH2nxq1cBok0nON8r7mTzs7XGV5TzLuMjH1LPQiNaYyf5e1
    okRmeK+9QJ8M9P9tdmvrZxuutH+hHr6Hj7P0uJmAe/ZihOhJoKG0gtTzkZ4J3FrVv4zFdI
    W9VJERwznATm0wfijV6hoAwmHBqOULWYp5wZ3ltU3b+URfxScB6rZq4p+7yj2BKTraYKup
    /z2lTAgcjlFn5aXOUfd3lqjjrGote5et73FL0Vn2O5irAm1dIZWpVGNejt0w
X-ME-Proxy: <xmx:IPq0atq1oI0bd4tr7QV-DtZIe1NLHE1yQH0l_9Iwi3TIV6owzt-2hQ>
    <xmx:IPq0anV5jI9bdGMNpgRYe2XWnVubPW4ATZABltZCzpY3R5YH77PWJA>
    <xmx:IPq0agBraQe0lJtp823JP7K5H69utVamiS5trHbpNiy4c3rMmrVi1A>
    <xmx:IPq0aqTR1lzIR8eJePNVUb24Je5bSFGetdL4oNwxutHNRzks1KSK4Q>
    <xmx:Ifq0ahb8m4jVfNOOw_7867ZexrO922JHEOpB3TGLvNsXX-oWEwU_3WcD>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:23:20 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v14 08/15] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Thu, 24 Sep 2026 22:21:28 +1200
Message-ID: <20260924102135.92217-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
instead of two. Give them their own compatible and pin both clock counts in
allOf.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11f..83d7e7c8e 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3576-iommu
+              - rockchip,rk3576-npu-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
@@ -42,14 +43,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Compute clock
+      - description: Convolution buffer core clock
+      - description: Convolution buffer interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: npu
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   "#iommu-cells":
     const: 0
@@ -72,6 +81,25 @@ required:
   - clock-names
   - "#iommu-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-npu-iommu
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

