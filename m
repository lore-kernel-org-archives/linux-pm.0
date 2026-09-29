Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26761545DAF;
	Tue, 29 Sep 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706549; cv=none; b=BFozkmlnIDLhhhTN3BUqlWRg2QJmMVgoDCtZYzShnUD4YDiBL5xwbK9NjybReoprdgJeeGHmrvg0Z3ACxca3ncwqkn/YdzZygFICTOhm99yaVNSd2a6gudU9RZsmnDmJIE/VXTNiDRJHn0sB+J6uxCw/Ut1Nck0kNtGJ8DqNFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706549; c=relaxed/simple;
	bh=oxkAfnnfUHZLCN1LsIX3vfohY3GBL9Qx6kRG0WJioMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLmWiWWa4zRcye+aFq3rIHWL99shWd+S1eOWA8YzFfgcp81joOZsebSuvTDOX6JPkgjR4vtfg7cSxYvu00pyeXD2UpQ8aolVV1DRr3BQR040X0rX/2dHSznkur2DyI+c6o4321FCmtctx1YOPZrSbvIkdgIEez0+ZvPoh1Yt1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dIVo02SX; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=x1Vg+25n; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dIVo02SX";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="x1Vg+25n"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706524; bh=uyLBclGccRqlV/1Ed7yjAWa
	or8gd7y11+OdY3H6pDgQ=; b=dIVo02SXZjiXYdAJoDxKe6ZgUPbdKESQWuyL2bKNXzfk5fRbLo
	w6qrYvFudYIPCOCKxg7OPT6HFBC1cCE2CoXUUq0rahVkbTmTquFi7rxvH+F1Cdt+C29NHRPczQ2
	Bw19KSx0wwpnTD20gsi+ibOM06vZq6yOaFNRULCtgNFs2EY8BuMQADBIVBDan2Xh6xuI3B0Oces
	d8afrl7Kk6SjzhGh5LmIp3o6ETCNlpiyUWaJnBezwf6u5HLOhhZICyVb3LUM9m0fSEJSY/PSSoy
	mzV3ljPYxWVe3AAOcnxpyWt0KRf4OB6kWVQbXUPBjEs4dgcdobjw6MJsUGdWueK8MKQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706524; bh=uyLBclGccRqlV/1Ed7yjAWa
	or8gd7y11+OdY3H6pDgQ=; b=x1Vg+25nC+gqOI5w0R6SIwmNJDEVrOnUek8aM5sDy+YoR0tvEZ
	CLWMr+geA/+KTVelmu4ZbO2uqHyzhLYrXBBg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 29 Sep 2026 20:28:30 +0200
Subject: [PATCH v2 1/6] dt-bindings: power: qcom-rpmpd: Remove unused
 MSM8953 indices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-sdm632-rpmpd-v2-1-97ef8858161b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=1718;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oxkAfnnfUHZLCN1LsIX3vfohY3GBL9Qx6kRG0WJioMA=;
 b=4mGy5INwQZDh9bueSuLa7B8mFN8FN75ToDgFjyjNlj9QG6KbFHvxwbuLKJRknJwnNuzD3y/rm
 wPbD4GXOsbqA5lfecpBp7n7xPilQ3VCd3KIFHpW8KlBnMUExAmeL0qn
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Remove unused MSM8953_VDDMD and MSM8953_VDDMD_AO used for MSM8953 MSS
because it is using mss-supply as a regulator.
Define RPMPD_VDDMD for SDM632 MSS because it is using mss-supply
as a pm domain.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index a70bfacbc5d1..4b263a982fca 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -51,6 +51,7 @@ properties:
           - qcom,sc7280-rpmhpd
           - qcom,sc8180x-rpmhpd
           - qcom,sc8280xp-rpmhpd
+          - qcom,sdm632-rpmpd
           - qcom,sdm660-rpmpd
           - qcom,sdm670-rpmhpd
           - qcom,sdm845-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 4371ac941f29..120f8855b427 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -19,6 +19,7 @@
 #define RPMPD_SSCCX_VFL		7
 #define RPMPD_SSCMX		8
 #define RPMPD_SSCMX_VFL		9
+#define RPMPD_VDDMD		10
 
 /*
  * Platform-specific power domain bindings. Don't add new entries here, use
@@ -84,8 +85,6 @@
 #define QM215_VDDMX_AO		MSM8917_VDDMX_AO
 
 /* MSM8953 Power Domain Indexes */
-#define MSM8953_VDDMD		0
-#define MSM8953_VDDMD_AO	1
 #define MSM8953_VDDCX		2
 #define MSM8953_VDDCX_AO	3
 #define MSM8953_VDDCX_VFL	4

-- 
2.55.0

