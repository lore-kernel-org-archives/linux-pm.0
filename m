Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842D535FA8;
	Thu,  1 Oct 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894363; cv=none; b=ecrO3alhO9KpAz9wH6ZHz4XSV1+r4qyp007P3+8CylJ1+XkPymdfhK2zqdJo7h0RaSXYsBelBlbj9LwVNceC5OA7cqOjDY+3+erRrT6JOTRxj5VpGiXrq8X+BiucTjkLyoJfJtMLmPlVHWn04pwOpKDYTkpGiyJemTjZ26PXHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894363; c=relaxed/simple;
	bh=nUxViLGM7VTHEq2NnrXE86uHtghQzQYcpY/Ui/wtM5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwfH7Jj+b2EonwoDS5HSGukUMPVT3jCj2zkdFwYlCUGlEEGBZ+cFcJDUygcUs9a0sOUIfVUra4CG4GzXVM2wMZPx1cYPCl1ZI2E3B3v2tc+kaNGKwFzj6sk41TGdKorj8hm92RzG8CVOikDOEdnJboX/H3+Biq/TejGnYyugnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WjO+Ehw7; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=F3BVYk/b; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WjO+Ehw7";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="F3BVYk/b"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894352; bh=yZomCPYLKXEwFbULy4+mNSV
	7LaBabbqjfwJgdXv2jr8=; b=WjO+Ehw7JKlLizghsoJ/552bjWn8fYGhqKqI89oo2+hXZ7v56z
	KSb26JEnr9oiz02gL2ZTCw6gSDBcfxTxfkAaAv8rF3SF8HiDKaXGmZ8dsTp3ynM23BzwIMs6M4U
	1wxeDzeuN+RvGtYh633dz7jwQg258BIJr+sHNgpUJFYZ+dy0pVY3qUbTnr4DOA97uUF/Yp++HPl
	vy+vAsfILBX2VBAihGmkS8lZO6UAdX2nxc0J+TNmmvbcXzzeDxSpHqF6RdmBqlS1ThIEgGIBEGR
	sdEYL1BJJun2JkYuhmvijWgfg8Pmadr1T3DUpzFvzKtVUPWplR7huOKZbBeJ/NNn3lw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894352; bh=yZomCPYLKXEwFbULy4+mNSV
	7LaBabbqjfwJgdXv2jr8=; b=F3BVYk/bMxl5AQKY/aYICTF0lWMJQbukZLF0CH22mzNeSXJGao
	v+M/J2n5xYnOHcjxYcjiFT58NmEreYwdx+CQ==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:33 +0200
Subject: [PATCH v3 5/7] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add
 SDM632
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-5-95c47d0f26cf@mainlining.org>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
In-Reply-To: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=2467;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=nUxViLGM7VTHEq2NnrXE86uHtghQzQYcpY/Ui/wtM5A=;
 b=shWcYLS9s0d0Rr18DMuuX5+/T+4rt4gDQ/LFuVfQ9VQmR0UBLnRHpHmpACAq7nUy9zPP8j5iF
 Z+5wdXTGVcJBfPmmDK8rpAS3L7S/4DGaC69c58lqnSh/So+rIBkeZsz
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
2.56.0

