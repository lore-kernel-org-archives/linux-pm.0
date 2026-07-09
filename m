Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952F3AA9CA;
	Thu,  9 Jul 2026 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575921; cv=none; b=SqzR474Njr/CJ+h47wQ1xZm4gr/50cGZentN5BuLhNqtvjXq8wRD/+A2AxVioZLZb6pPe0fSOTgcKNPcPLI0x16hdPwD3uKfOQnGb/7HB8JUitwNgQYaPjinhvMxi4LTByQ4Nlk4Ps8SFTdeTUL3doaWnEBr8w1HO3mYkNnO+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575921; c=relaxed/simple;
	bh=Undh417amuoNmnWjoLPCXV9xTq0nyBGyg1m4Fninpcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNGnNFIu3CGF0Z4wokztONt/NPCsNsPzchD1kXSIBkK5gkG0q1Suv+hd+tbS+VStzS7a86XCoMgZWXJk16Gu867dL1st2kFZUwUoPTKvsBkJhYS/5Z8wXXqzHnzdr3O/l6ooxvNJQnNYScrg7jV9qJkTQqB0Yd8e1EPa8wE9dfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwDcxqNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwDcxqNv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F626C2BCB7;
	Thu,  9 Jul 2026 05:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783575921;
	bh=Undh417amuoNmnWjoLPCXV9xTq0nyBGyg1m4Fninpcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cwDcxqNvPWa063pvfvwJ/gclokj0bXUE8jyw3/G7pTAj64XPZXsL4LDCFvVDFcczc
	 3MMZLpwsE3oj9aZnL+BVvMIaZMNv4B8xzM46vk88xueE0TolxtS/7lx8/XF1urI/TA
	 vsOSMbf0+4g3KE5b+zDs8/hPq+xFMae6TPaMvyryLL40kpX1prU7QJcZGtddSrMJrR
	 VaLJainTFmttsTKBnB+ddHyhPAuE0E9weDqIvK5cRrnIKSGpnG/7Dk4H7lgf0kf5Gf
	 Mkc0M60B7SJX+hdxEPVC/2cJvn9G4E0TAaRdayReot3WRJZ1dOV2+VB1+m1iue+b+D
	 E84h68Y5H7XWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D33C44503;
	Thu,  9 Jul 2026 05:45:21 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Thu, 09 Jul 2026 13:43:27 +0800
Subject: [PATCH 1/2] dt-bindings: thermal: imx: Document calibration offset
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v1-1-00f88f42930b@cn.bosch.com>
References: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v1-0-00f88f42930b@cn.bosch.com>
In-Reply-To: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v1-0-00f88f42930b@cn.bosch.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783575916; l=1688;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=+ktspic5FuVpdH2DPCuQLJE0m7veRBsySegdaHpw1dM=;
 b=9c10GNPVKYp0qiKdERsyCTSST7+4HWR2poW7/XY9T67HoBwQY6V7VQVACJGkleIp2do4a6DtH
 R/6T7kj1j0FCnoBsfnK8taIGOvJVRe3xgbrRqKmj/vn4nPiLeePeARl
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>

Some boards need a small per-design correction to align the reported CPU
temperature with board-level measurements.

Document the optional fsl,temp-calibration-offset-millicelsius property,
a signed offset in millicelsius that is added to the calculated sensor
temperature. The property is optional and the existing behaviour is kept
when it is omitted.

Update the binding example to show its usage.

Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 949b154856c5..29bdcb921a96 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -59,6 +59,13 @@ properties:
   clocks:
     maxItems: 1
 
+  fsl,temp-calibration-offset-millicelsius:
+    description:
+      A signed calibration offset, in millicelsius, added to the calculated
+      sensor temperature to compensate for board-level measurement
+      differences. When absent, no offset is applied.
+    $ref: /schemas/types.yaml#/definitions/int32
+
   "#thermal-sensor-cells":
     const: 0
 
@@ -109,6 +116,7 @@ examples:
             nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
             nvmem-cell-names = "calib", "temp_grade";
             clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+             fsl,temp-calibration-offset-millicelsius = <(-6400)>;
             #thermal-sensor-cells = <0>;
         };
     };

-- 
2.43.0


