Received: from outbound.ci.icloud.com (ci-2001d-snip4-11.eps.apple.com [57.103.91.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051F21CC5A
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509934; cv=none; b=LvMKBlLg0JjRylp9DifAYI69tsmv9Lwp6e9u0cl96qkEjatnhCNScsUldR5l5FKVHAkNcTp8HE9M6uvIL0C3Cw1Ns9iGcdT+27dYAX0K/K8YTKBhcyPTApscqNzff4H9Z8EpUFA2M212QD4fod1pN8Zf92JAmJXucTGs2NnoR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509934; c=relaxed/simple;
	bh=25uNz86ljg3bAGG/Z1CmYUWk0Vh9f7VnCu0jiPAKa64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6K9n9tPp5jTk8YX1NB/pNRBGDDBDAW3GxhJcxvQR7f8n40XMu4WFcbexR7Wj93uNW5F+o726n2IV7UKFJCe05ojMV99j6SFvwvNe/5KI3K5S3uy4gNgOEi0EerzKiF5Wl3lMvATdsxWTsv2YuONO1EhGVhUa1An5wo+TTb9bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vjPe9IWb; arc=none smtp.client-ip=57.103.91.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vjPe9IWb"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 7DEF518000C4;
	Mon, 20 Jul 2026 01:12:10 +0000 (UTC)
X-ICL-RepId: 019f7d14-9bef-7f93-a50b-7015c6ec7745
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEAJSQJcA18cQQtAA18GUh9FFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784509931; x=1787101931; bh=aG9BUpp65slEM0N5VcuPtHyAP0VgGPDHQ54DkQFv1ho=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=vjPe9IWbbrFoQ1FkDUm6oaYbWG9tm7MsB4Ob49ihQcSwlZb90LfKMod1GC+QLTqo3YMRU5r4DoBc0CkTzXyNKimANBu68AGMRYn2HAb+yKRLGxYGiNB3Ut1gniAo/0FmorExzeYrToIMx4BOnRw0VvjfL323HndJ1lQuslOD+wK9zckXSaVuBJWrkJjvtcF7Uj3Sg446kXchaAe641I/fjsWvXxAA6om1en6shUwK8XfCfL/mE2cmqLe+JWIVmD6Evp7cZkhMwYRatusrqfJ7j0ysOJCgkmSsdjLyz4+h1M2JOBUkyE1bidysU6+hglnWMgQ5uXZCLuwkBvV0XBirg==
Received: from bigre.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id B01A11800134;
	Mon, 20 Jul 2026 01:12:09 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v2 4/4] dt-bindings: power: supply: max17042: Allow monitored-battery
Date: Sun, 19 Jul 2026 21:11:40 -0400
Message-ID: <20260720011144.1280219-5-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
References: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOSBTYWx0ZWRfX+CCnw437nyiv
 05s5Bo9VjNgWPeq+TDKarJINq2yggAeNrYeTfK1Zh00gSAaA6Zg5ZabDRfmNX38wCrwXN2fuojM
 sBOPGsdGxFbQGtDPSQIzndYlGet0/UK6dtqA1h97R5UyDsZUGijC7AH4oY6MDkO99IMu5yJb8Sd
 2GTQ0wzYCQCmVq/C4i0VNeaxKqc2sbASDMFBAamAYSVrAi52sWJtMxXfHnuMOTBXCC8taNLvuyD
 FIMUPXSLhG0WHEwJldxaw58lQGuAoJWRMiqKL1cCGfHBh6HBEbQR+wi8qcRZ3MQx8a2Yh9t+L0w
 cbVUl72OZegx5e/jcSV
X-Proofpoint-ORIG-GUID: 60VVBBptR9frvyUs-UTawgJtqfbMp3Sg
X-Proofpoint-GUID: 60VVBBptR9frvyUs-UTawgJtqfbMp3Sg

From: Vincent Cloutier <vincent@cloutier.co>

The MAX17042 family binding references the generic power-supply schema,
but its additionalProperties restriction means generic properties must
also be admitted explicitly.

Allow monitored-battery so these fuel gauges can reference the physical
battery whose characteristics they consume.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 242b33f2bcba..ace684159e0e 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -67,6 +67,8 @@ properties:
       Voltage threshold to report battery as over voltage (in mV).
       Default is not to report over-voltage events.
 
+  monitored-battery: true
+
   power-supplies: true
 
 required:
-- 
2.55.0

