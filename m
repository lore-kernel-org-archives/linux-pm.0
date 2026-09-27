Received: from outbound.ci.icloud.com (ci-2001k-snip4-5.eps.apple.com [57.103.91.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8F2FD7B1
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520963; cv=none; b=Tml48ttqChKRxDfnRMXtPlGV8FXeUHm2id/KTvjpVMWUALRBV7H7xnZZ0OOYtvLhMsIG9UEycJLprmT9A9pXOCpunqydVvSZQc6Qk9K9C7T8SPHDwK7+kfc/gOinBQyBOd4fWJANqMVEYzao2zhAhuv9jWCt/bod1Fs3QqVZVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520963; c=relaxed/simple;
	bh=Z/UD2u6sFVRQ99WmPmXJfPHo9vF5oqNt39mZjGaiDiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiF/Dw4cVYyYmPTC3PnLjwKBr8XuLmohJksXrcwVb/o5TSWxUawJXmdYrbVNi1ZfgGBIeQWpeIeySz/kuzfou7gMIpdECBICJfF7lZca6nLfJJhZe2jR6aHqOaB2PaoO+TrlO+gJ7JdtROd02eWvL8jjFtMENDEg6i6H2iOIaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=M/G3kwei; arc=none smtp.client-ip=57.103.91.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="M/G3kwei"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id 3D6581801068;
	Sun, 27 Sep 2026 14:55:59 +0000 (UTC)
X-ICL-RepId: 01a0e35d-a0e2-7ca1-b5a6-946884500313
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0gZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdSAEcITAZYBFMcQgpLBlkPRgFdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790520961; x=1793112961; bh=PhYOgaxRR7j4ejOJFgl1IvOss9RYAM+ujwKR+cXQZZ8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=M/G3kweicwFEEfe2xlpl3zsCBmHu9HjLa+G/bGYb45v61+uNErHtxe/O8jwlQo4t/olmmJoXbK2eBl90Lo1FGPThJQVcI5N1e4zpSLXMoXg8/f24YAUgJbW3blIkNA0JJF/3Y63kj2AmZCJS4/CFtJqvl8BrTuqCMV8l0jhMSLr9fzSjhnzl7KOT6/Vjc8IvwcHpBOiHoCu4JLAx5j1opFMHXIntMwLpje4WZdDbsIiucH5KNfFzJVNBMw3AFdusy8numDGUP8Z8bK/wxYpLnlDwlLcTduBa6T/c8Js4/hO/XuvFARFd92Gmu1gDinwLKlP5P3ncNQxltw0mX+yt6g==
Received: from bigre.tail98293.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id 2083A1801064;
	Sun, 27 Sep 2026 14:55:58 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	daniel.baluta@nxp.com,
	shawnguo@kernel.org,
	agx@sigxcpu.org,
	angus@akkea.ca,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 2/4] dt-bindings: power: supply: bq25890: Add input voltage limit
Date: Sun, 27 Sep 2026 10:55:36 -0400
Message-ID: <20260927145538.233548-3-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927145538.233548-1-vincent.cloutier@icloud.com>
References: <20260927145538.233548-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P6pgAecUhM4pEb_rI-AEGSwQPkMH0dde
X-Authority-Info-Out: v=2.4 cv=FdQ6BZ+6 c=1 sm=1 tr=0 ts=6ab92e80
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3-V7KW_DX7Zo5MS4syoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX+DE8PropbEAA
 VCPkZNVjSwkwH0Nhc6hI07FGmcZorApVbLi4sCmhOiqxzn7fhhSsrwa4FQE4qAuPvRpvWjbsofq
 l+809hBV9bjBMyIdSz68WGzwJa0unsITcUxhPbHAgvtjCA0QSXJrxEgozHtt/jieZfSY+6hktHo
 Di7uX9DBHdCn2HtXcB2NikI8uqvs2QYodaIfTVaDdpEvHM20bI4s/DBaoemr96Qp3+5cA5CHl10
 51UmrFx2vxbTMAry32bOIE/S3SNl9Riea5EHwgSi8hAr6I+asr3boX2FeJt41mDJZj1me1WTF/7
 yT2CyMsFFebkrD++j6xyLUgAoZfail+Tb2e5cEd0OX7JPusHWamv0CuLjOzpyo=
X-Proofpoint-ORIG-GUID: P6pgAecUhM4pEb_rI-AEGSwQPkMH0dde
X-JNJ: AAAAAAABLirx1JOWFPvAiGSg/j+EDim6HyyuQtU2itYCM7VRT4nVBTyQoKsY9qHb3C4SQ7bEZddzQPzCAO8BLGqZb4OxkL0llBEGPFY906JanWmSKzubulTXJ/dLGKpDwd4eg+9jwwGUbjCAnuF3P8xr6f1ti8uATyBPDpmNjOweOYXW/ZzgQUOnfGKtvZYkFh4yYp7208dqdkMxvUYNm524qTU3PnbuTD+mOtZoEq8ti3MM5rVk0bUbw6QpP8JVtzjLciKzaFEgLUTJ8+78KdOqd9lKy5MN37SzWtwrVT+eabbDgM5Xg2Vz4uUp3qlH3LC5EurE9vA0R4x7CVSEzbMtzt616QGp3j85TKf8tN635ao/G9ouF4TfIPOS24SAwJGmayiJGeFN1OQRECifyGl3MO2CyKrg1aTrj0xwjFFLwxeVTG2UaNejDkjXmr5NBBvmOi5qpZLeixsuaM18xqXWjCH4O8Rclu4U10NPfgZk/VyVtwXVMKEi4hVwJNZRQ6bIQKHtYhIDeFXESLJRG1HjAFfEV5JbyoIl40jrW1xPPC5Agzak7eyMDK3wXrCnf0q2atW0jtsgmuRUMs26xikj7HeqqbQZFRLWm6gtGWL/O1MuqkGPTt2yG8J+A4mkYJ6nnR0RSlcIdVHTyhdywl7T/iHQ1nGXYK81bWQtvGW7O9CUd8GJLc3Pdk+Qo7fdFwj2smRNZ0J/G2Gw2otZoxSWGqUdKkqyfSyt8UHXn1n4z/5CGD73g6fdmu35V6X3GmCXl1wymVMBvBBnjshTlCdCQsqog6SgyEl9XZNU0lcnPoVjWd7GPV+QJRnx0ACqGfTR2MDS9drnhEUjxM0qTs1opvplCwmfqhixYDdJAkhz42D0f6vlj0IIGKtlmlDDbM9E1F4JaJk25RqvH4Z8TkZDN4I++MWTfDZHSnjnv9/juAZCpX/GXKZh+KT/v4HJBfHGKRQ2Hh4kiw==

From: Vincent Cloutier <vincent@cloutier.co>

Document input-voltage-limit-microvolt for configuring the absolute input
voltage dynamic power management threshold. When the property is absent,
the charger retains its relative VINDPM behavior.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 .../devicetree/bindings/power/supply/bq25890.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
index 0ad302ab2bcc..8d1f27447cca 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
@@ -31,6 +31,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  input-voltage-limit-microvolt:
+    description: |
+      Absolute input voltage limit. When present, the charger uses the
+      absolute VINDPM threshold instead of relative VINDPM.
+    minimum: 3900000
+    maximum: 14000000
+    multipleOf: 100000
+
   ti,battery-regulation-voltage:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: maximum charging voltage (in uV)
@@ -113,6 +121,7 @@ examples:
         interrupt-parent = <&gpio1>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 
+        input-voltage-limit-microvolt = <3900000>;
         ti,battery-regulation-voltage = <4200000>;
         ti,charge-current = <1000000>;
         ti,termination-current = <50000>;
-- 
2.55.0

