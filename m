Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD73EF0A6
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303984; cv=none; b=usO2k+/NfakjQCVOdb0v9Ax30jOkE+vKRAAOkIfsTvNwfsKjL5Tb/fWNopiJ+fUeIh3vdcpY4y5mKLes0Ins/GnHVGHFCuvPCNRfDTuetJOMZf4vmufVrvyFpPOznApQFAGCZQKIVZ89LytXgdFjlsrwmsB9zem7XQhrKWIXrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303984; c=relaxed/simple;
	bh=uqSZ9vaYLLr+IlpI+wNqRUJ19lOtB5XlEKHqPxDiWeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYAIhnk7Xrm8TM/l6ufGfus/OijcKFxYAt4U7f1mB/AUlRj4+Cui/dEPqs5Tn4GDvJkflvm/ulSzaLKIdm91KNSBt4k8T3p+K43cOtGjo27dWnyRWSU7091dkP4bdOxn4tH/RRPFiQzGFqoUCc/E5qb78BrPGxD5KsaQkkyoJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouJNpdD8; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouJNpdD8"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso11250521fa.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789303980; x=1789908780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjCp7DsLa8JOzDd9QVc9nOTCPNziCux3eLTHVXVPDfY=;
        b=ouJNpdD8I11bkZFl2GYdEx2p1znfZF4lskK/OyWMEuhnduVqnlbqU32osjRApFaCBh
         Dy6/n3g91MXmVXfbECEf6anBgHIhvBKzoi/jtg4L+eCp1QCK/OYqlMPRLjhlmf+BCDws
         K3KavWc9QzikLiXxEIX2oJCTKQ4gCAZ3Dd8zrO1hoZeugtU3yhuWKSi4mSIn/Hkx721+
         9zg2/2csPEFsSk0zCHPVUTQ6kN8coWxkMJb/tq7rFiQaVLCcphjCv63JIjBLFx/tplnh
         B59Kl6rr6G3BGil6YedOs/OR/1fPNeX64nEyqLCauJ6y1JMViN/dbqjz58o4WG/bg2RU
         iGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789303980; x=1789908780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjCp7DsLa8JOzDd9QVc9nOTCPNziCux3eLTHVXVPDfY=;
        b=XqPgf59chhK09/2HJUxC8AjuUKf32/uDv0HM3bD6iuIRVtI7+f6IMKc0VZLNeHBES6
         qe6OBv6ykWl96dOW+5wcksWf2baPZ2c7HRKAI+rQKaMtTtzRDc9MyodEiX42wa/vdizP
         jh71XCtCk3BXWIBu11+vwiuTvFKMm+ka4xGq1xxH6U5gDyBW1v87c0X3NbaRjFW5mvlu
         Emg6mt2TtiG/9PWSIVGhBFAjj+laI1DmMXWZBrOSnBt6x3Ts7aBW7MSjiYuBTcxkvwf0
         imi0gq7m8I6m6QMeDMmsroPmQtxgzHJjKKEdBrOMXZaClVINh6L5/9dO7ILJVkXHAZmw
         PoTg==
X-Forwarded-Encrypted: i=1; AKwUvByk1Do5TsVeotYguZNi3CP+ef3TEsmIyMpIeCeyPUmVewYEdtQjo5YV1xWgoJtHWOPRWkZnDrcAXQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lJ3NHhuzIdekURxIcLASUgqh6ujtMRAazx74jCGCqIBRkFY4KV
	YQdOnHdQlmANCwjt0UMN/+DczOlu8qrF3Avj6I7waUbKrADqf/NsRI4=
X-Gm-Gg: AYBFou12BH1UT2EyNNBBDn8e1aZYP0x/a4EvX/24sc+R1tIZtvsRERmN2NE1vsVRE8j
	uFKKJ3ygLushIWBVxdcHAlqURcjKz4cBuxqBBYaSC6g09EoQs56aA7Q81gPDCfaJ0ndy36Bub0r
	LLWVMqcKzZWkYTE5/4IHYaOXUFD9tCT8EDFEDPC4Z7Hzl+F0QVaGegY4EbmtQ3d6Mwrvt/ORk1P
	vStgjYb2UBFb8NJWLgltRJ6F/rLjkeMzTKKYHvPB3C1TnZufdozhcjh3lOzVEyFrrSfrma3sAt/
	HbPu1kjHjvorMoIP3J/Y3E8rL28qx4MbLjVrmITvHWPPr/VpMHzMWkGT/Yp/PVmFKPMX8gFgo/w
	trBkxMC6+HQ2xsG9jcEHclCx6YTFNkYew67RG8OjMnJNPXRQ1eq6jjVAQSfXtC/6JMnNeEm2iva
	TG6/Q3fFhVOZ+C6ReUcODsAcSoT616SxRN1h8UVMFm/2Sm/5k/qFEFXKLOqd5OuqG64L253bSn
X-Received: by 2002:a05:6512:2344:b0:5b4:ab2f:5bd5 with SMTP id 2adb3069b0e04-5b8a02fa1e4mr5509677e87.8.1789303979805;
        Sun, 13 Sep 2026 05:52:59 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0469a8esm1762844e87.50.2026.09.13.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:52:59 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 3/4] dt-bindings: arm: airoha: Allow one thermal sensor cell for AN7583
Date: Sun, 13 Sep 2026 15:52:25 +0100
Message-ID: <20260913145226.34643-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145226.34643-1-sochnev.v.74@gmail.com>
References: <20260913145226.34643-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AN7583 has three temperature sensors behind the chip SCU: bandgap, GbE
and CPU. Allow one cell to select the sensor. Zero cells stay valid and
refer to the bandgap sensor.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 .../devicetree/bindings/arm/airoha,en7581-chip-scu.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index cc564dc7b414..da159b7572f3 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -26,7 +26,10 @@ properties:
     maxItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    description:
+      0 refers to the bandgap sensor. 1 selects the sensor with one cell,
+      0 bandgap, 1 GbE, 2 CPU.
+    enum: [0, 1]
 
 required:
   - compatible
-- 
2.55.0

