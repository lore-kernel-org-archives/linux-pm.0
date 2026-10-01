Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557D47CA74;
	Thu,  1 Oct 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894359; cv=none; b=ZZNzlWY/JuwBcXFLyJryytkNaWSeqHhehUgIUqMqful3xNxikdoiWQbIIXVgW7Bi+BSa8NS7RxiZNMNfLWeAr689URIAgqdFb+G0amjB/48C/nOO/3TozepZh1MSTGlm5TzwKt6+2bNUXzbpVj0Ce8ZxWVXLVdqEjK16CHX6KXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894359; c=relaxed/simple;
	bh=2RGRNeAAXOyVNaG1ySuLiyiJ9LWhXcEJmrLKm5yEslM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxuPXS7UHgXuRtlG0eva0p9gCa2sBPAybdcdrTe6ehylL59PCXOP73scIQPpHYaAbE+vbIYIDhuzNVHFlTZLaQ3gQ9zWcDLNIejPrKtzvGhOkrTgIXBlo8eznvCRib0xEW2vJy6T7pZl3//A1M89bAQy/VXF8hufR9JPvRKVjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rzOchwtt; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=wQX4eQx7; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rzOchwtt";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="wQX4eQx7"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894349; bh=gxZPHmkRT7v35KkDnbR+Pkj
	VHOxwUuGnV/V7Md1RQpo=; b=rzOchwttuREub7AvBjQdU9bXjYxS8mQiq5NcIPbn99rt+/en0Z
	YqG0ICkWkmBRNp27HrYcNFw6amaKkdIl1rKLEj1QUohKppyx6K7z5wqhEe53g7ZlO2QAbGB42YW
	clHJHmwr71QR8Fp9KZNWWBhC7zYc7vBXMrQZxMBwLDAC97ww+EkC+3vPx6WatpzxfpecrQk6rVI
	aRfiivBTbBbzCqUPRMtW8G1ThkJPR3xaRqx24UczxcjpX4X1JF3Rd7HuW0RwzBqTiOJoJ4bElB4
	fvgfnGJsPm6TtunoE1uvrfwoQyCHwxF3kZDz3Du0gvBxWBtGgUssE1tzd1Q/S/J0Jvg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894349; bh=gxZPHmkRT7v35KkDnbR+Pkj
	VHOxwUuGnV/V7Md1RQpo=; b=wQX4eQx76l0pzaw8RgQy8jK4pNVtn7lFhDcWqGbcKuMbuTt/Jd
	qXsGzaZqvSpUc0ELkJ5ZqnC+vQsRAX801PDw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:30 +0200
Subject: [PATCH v3 2/7] dt-bindings: power: qcom,rpmpd: Add SDM632
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-2-95c47d0f26cf@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=779;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=2RGRNeAAXOyVNaG1ySuLiyiJ9LWhXcEJmrLKm5yEslM=;
 b=97bc+x35Qd9XJ4+NOscPAkKPtnqaIKSdDK1V5UcyQn8ilh8bdvvstpZ9Wdtt1xKeZGChVDakE
 wPjq3PpZV5bCXoUFvDNbubNXB7nkB1US66mnO8lgcRmPqqK+kXW034H
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add compatible for SDM632 RPM.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

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

-- 
2.56.0

