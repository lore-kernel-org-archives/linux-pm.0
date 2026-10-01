Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562D47D94B;
	Thu,  1 Oct 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894359; cv=none; b=hzcqR1it7LbilDBZUBQpG3IoUdmztRe7pJEdX61svTQ6yWYpwUhU2mJIXKKQ7XstIZX2i6g3AdceprPIvzzv+hOBFwITueioOHd6iLzeb1kkI7xDnO+WXIRzt0W9c6EnVQWFT9KrmRty0kNV3yrOGbC1bB1+Z2Je8fQmz23nMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894359; c=relaxed/simple;
	bh=W4+zDCD30kAdsB7sD/Y0xRrPfRQYWVwwQ2ClFbM6oxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asMwshMkSxoCNMuEYAhxUUK8Afd7Yp5p2x//Txky9Tx/RclT1K/GxXTIWP758AUYaOBwKmQlH3RGu1w6up/sq4L2kwMYba+cx+i0rMHappvsDctRTpz43NTryXUoR4WWBxFgaYOG3IWICD6s6GIIVWLN9wxUxxi7LtjfWAlixZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=mdcX4fAV; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=82PHav4j; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="mdcX4fAV";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="82PHav4j"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894348; bh=KgQn6FFCD8XOe4FbV8qpCaR
	ZGI8ZH1PHLkYF98V1wGU=; b=mdcX4fAVNc20YZlqaqnTLzqCYXfdXnOsVq7Z4SZeH0xE1/A0on
	ynUvHuG6Hc+J8fC+YOIVDDXgUSo2w6MKr7zkCK6A2UyeDdh9fHwETulshZsSIfoSPODtoTUjXOw
	td1VEcpOGSK24XyJEQB8ttHNSKzteLhyWtmpgsS2HYrruBVvCHVFl0NtmN59Tv47rpnNgEoas8M
	HrIrAal8NeEeMGRPdNUweweeL648kfJ22vfSncMCEQRlwkpW36JGPbU/2iZTvi4x+q0KySEH1db
	G5JWseJecvtzI/QGWYv5WDtT4AzUnFp4pS/0WZcLUqs2YqknDSSrQHRyop2l6cRdQTA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894348; bh=KgQn6FFCD8XOe4FbV8qpCaR
	ZGI8ZH1PHLkYF98V1wGU=; b=82PHav4jgsK6wfle2inIsZXuRhZ+ZCMzcqLUtlBmjg4D6Iybv6
	zItkvWiftbF9eWWblOWLeldInB8sxZDUjqBA==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:29 +0200
Subject: [PATCH v3 1/7] dt-bindings: power: qcom-rpmpd: define RPMPD_VDDMD
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-1-95c47d0f26cf@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=663;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=W4+zDCD30kAdsB7sD/Y0xRrPfRQYWVwwQ2ClFbM6oxQ=;
 b=Oii8B6C+Eq/r1YuxMrIXvYL6gtG2Q08gZ26rR5OVQOfWoM6LfHXWquTWZVfjtjjGODAcEPsem
 N1rTe4JBJCaC67EGfP5yeE8Eqc+4WXSREzv2T2Mge1s1W8czRD6iPeT
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Define RPMPD_VDDMD can be used for SDM439 and SDM632 MSS.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 include/dt-bindings/power/qcom-rpmpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 4371ac941f29..beb066b3aa8c 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -15,6 +15,7 @@
 #define RPMPD_VDDMX		3
 #define RPMPD_VDDMX_AO		4
 #define RPMPD_VDDMX_VFL		5
+#define RPMPD_VDDMD		5
 #define RPMPD_SSCCX		6
 #define RPMPD_SSCCX_VFL		7
 #define RPMPD_SSCMX		8

-- 
2.56.0

