Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04554CF6B;
	Tue, 29 Sep 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706547; cv=none; b=kxUtPWB5HJpAAg7XU8BRpP6XkhiNMAjTv6Mzm88J9PfBOtQxIMxCaJNMgrXZt9jFIct/p099+jLkZN3fTWJIaD8z0cOQ5YXZ+1nBRJ27TUdxLLiZEKwjmbNouUusmEhlojO7vBk1F9Yp8DQwFr+Axkau96AJrdg6w7SntLR4FFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706547; c=relaxed/simple;
	bh=3vAGXnO0lRvCBaBUiz017dIsZsNypzeKSmB3TL39KtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IL9PLakOzcWp0BnTCctUa72BrBbMYLhqcNSzBFhQ4exRQFNgVTG0yr1tjVFcH9DYz68XzS/xCG4X8ghtak+cCqmpYDWDwIfJxv7HyZA1IRCyxXRXnEZV0r3iqO4y7lprao8lDvNFu0FXQBYHURRmS5VYr9nguMY3+CbpM+P6srI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Vgu+F3km; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kBd1aM2h; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Vgu+F3km";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kBd1aM2h"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706536; bh=4PcvDXv/+pzRbz2aXK70W08
	T13GVYHPvsYrjjRq1M10=; b=Vgu+F3kmmb+KscuuDmPt3k0XSa52ZqgMWXIc2QRJCLFq/NAYSy
	QRQyCetpJhQVAvTP0EIJCzOaaPq5x+jLyN87Z3IU9ykr+Xmxe14lOh/wZGa5aeBc2WaQw/KZO54
	HRMRp//btCbSZYQT0ovAr3BfvNcXXzeny6bUIBT2h7cORdkoEpI2FItDoHBt7VuNgOCIcsP9ktP
	jt6uPsgUPwzcfiWP0YNZm8Zt0ihjKs9FZDYkG7UmAqMzCevd8DcpM1Ij8/ie4ecdqKwCWTg+hZ0
	tHTXzAiF35YWYfJgHzfdZSSBpqVvITRP7+t+WxKPN49pQgUBp4owSgC/jZ9oKxi+W/A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706536; bh=4PcvDXv/+pzRbz2aXK70W08
	T13GVYHPvsYrjjRq1M10=; b=kBd1aM2h0LZjmQJe5mM1avusHvlEjXTWlMcJSbYHZgsQWq248u
	Jxiq82oNpbp+83kdj/FnrSl18zb10ISndqCg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 29 Sep 2026 20:28:33 +0200
Subject: [PATCH v2 4/6] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add
 SDM632
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-sdm632-rpmpd-v2-4-97ef8858161b@mainlining.org>
References: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
In-Reply-To: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=2467;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=3vAGXnO0lRvCBaBUiz017dIsZsNypzeKSmB3TL39KtA=;
 b=bvseJML5/pA0+dwZo9Pj91KgrPuXsefZMcCsgdte5vnNtTz5AQKS0vUIFGtNmvGblCXuTG+UQ
 dI0qWPe2684BUALRF0QSV+ygoi+/eD+duHR0ggAw0QO4r6D/aUGRnqA
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

SDM632 MSS is very similar for MSM8953 mss the difference is
mss-supply is a pm domain on SDM632, previously SDM632 MSS
was represented by MSM8953 MSS. Correct the bindings to
described it correctly.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml     | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
index 4049157dd83d..049191cad5f8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8940-mss-pil
           - qcom,msm8953-mss-pil
           - qcom,msm8974-mss-pil
+          - qcom,sdm632-mss-pil
 
       - const: qcom,q6v5-pil
         description: Deprecated, prefer using qcom,msm8916-mss-pil
@@ -79,14 +80,14 @@ properties:
                      (not valid for qcom,msm8226-mss-pil, qcom,msm8926-mss-pil
                      and qcom,msm8974-mss-pil)
       - description: MSS proxy power domain (control handed over after startup)
-                     (only valid for qcom,msm8953-mss-pil)
+                     (only valid for qcom,sdm632-mss-pil)
     minItems: 1
 
   power-domain-names:
     items:
       - const: cx
       - const: mx # not valid for qcom,msm8226-mss-pil, qcom-msm8926-mss-pil and qcom,msm8974-mss-pil
-      - const: mss # only valid for qcom,msm8953-mss-pil
+      - const: mss # only valid for qcom,sdm632-mss-pil
     minItems: 1
 
   pll-supply:
@@ -219,7 +220,7 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,msm8953-mss-pil
+          const: qcom,sdm632-mss-pil
     then:
       properties:
         power-domains:
@@ -241,6 +242,7 @@ allOf:
               - qcom,msm8917-mss-pil
               - qcom,msm8937-mss-pil
               - qcom,msm8940-mss-pil
+              - qcom,msm8953-mss-pil
     then:
       properties:
         power-domains:
@@ -287,6 +289,7 @@ allOf:
               - qcom,msm8917-mss-pil
               - qcom,msm8937-mss-pil
               - qcom,msm8940-mss-pil
+              - qcom,msm8953-mss-pil
               - qcom,msm8974-mss-pil
     then:
       required:

-- 
2.55.0

