Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BC345EBF;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480516; cv=none; b=bL9RoRPV7VwTe7MdBEK8jI2OGSDtbAAX4HAZUVcgmOWzpYByTsyYBaJCMzlLWW9ifjWahVNWg0dddr7xamz1gw/rrnu4rPbkigKbflYnXEDMhoGnq534diwqOZ+D1OrRUzxSFUceVR6q14tsMVcRXOvyO5QkU4xInHHK2+j+ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480516; c=relaxed/simple;
	bh=/q6sFHhFLpno9qM7ZXdnG4oRJRbNjKO9vu4PxKxhL2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMXoh2XbqpQnAV0y1GIU+xa/+lDEq3efOsXExg++eoA7W2+vKfyuDp/d/CsWYJvBjINN+xYiqUxAJSqdaDB7S5BclDFUlGyqlDMCAdfsFF9HTrwMg7bRKgivWJ8aQspFfeQICBjP2M5ZTY4hj892Nl5dsjJKlWu8csxhQu2ca54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7bv3/LF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7bv3/LF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 647C9C2BCF4;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786480516;
	bh=/q6sFHhFLpno9qM7ZXdnG4oRJRbNjKO9vu4PxKxhL2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u7bv3/LFW9rSc2+VDX4Qq62ueW+/6GEy5MSDQGvDd6D2CDrI55u/mfuKx41p/9Uqg
	 iv3zWTupR3ucIzf5bK4l5edCA92MXPX4FJUdh34LsroCC6dQAXAEJHj7wjokxXqGim
	 fuoH4pcrAjX2UaJY8LutVAEJTFLHJNO3nh9Ej48uMC53XR2klAqig5hth6vp7umJuo
	 TKCnZ+kwrcpi/k3JU0lozN8gO6FX97tFz65EePXaewQjpc0ltyLap6nmL0shcvOZld
	 rIAfUglQ2IsLvLszLFXZcvGFewEq3XuA4VHxLfEwWz6dpYWVCV/5VUEJK6Eln03Z+h
	 ptw/TIj77GwxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D3C5AC67;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Tue, 11 Aug 2026 22:35:04 +0200
Subject: [PATCH 1/3] dt-bindings: power: supply: qcom,pmi8998-charger: add
 SMB5 PMICs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-submit-qcom-smbx-send-v1-v1-1-feec6cfa123a@snyders.xyz>
References: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
In-Reply-To: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robin Snyders <robin@snyders.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786480511; l=939;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=EYGMyPfkRuuk1QHQrRSaTrAt/JZBY5TFPUfwjprLJoo=;
 b=2zjhn0rcir35V690AgI3vmDGAQrUmO7XzcAqZ+hVyAZytBBhtfX27vBplyTSo98tY/LqROTKm
 yfITkTgkAncCRUOYpk9JJD3BerrASJ/Qgk3rQA2AMeerhPIc46udQEt
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Casey Connolly <casey.connolly@linaro.org>

Add compatible strings for PM7250B and PM8150B, which contain the SMB5
generation of the Qualcomm switch-mode battery charger.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 70f5cd6eaeab..9e200ba3f3a8 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -12,6 +12,8 @@ maintainers:
 properties:
   compatible:
     enum:
+      - qcom,pm7250b-charger
+      - qcom,pm8150b-charger
       - qcom,pmi8998-charger
       - qcom,pm660-charger
 

-- 
2.54.0


