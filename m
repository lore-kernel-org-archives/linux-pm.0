Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795253432;
	b=orP0iZ0U4TVaatAJ+xd8vxFRgJIzDQu32fs9wI3gBoaTSUDq3ZIAQlP+2pCvixkchSDm
	 5TbXITTVARuWaoawgjc1ZCGgLoJ+vGgTZ92x5RYPkJPrklYOI0I0r2fmtwAdOIkukTM5E
	 0zgxLUi5BD6nj2hPnlML8y2eMK0bq5m6SbnrskOhZVvyOZDeJhF57z9mP7AB+GMubmJfN
	 X0Usa8ncKUoUPSh3Sez9FEIs+ff0BKksOt8NW4kP+7NdFkjDZiOE1vtq4RH7EguCljDAU
	 1nLfVNLzqaT2SeLkVnDCI8Sn4dxOpn2FFYEq21ntkPqgZsEcw5MbZIfNVsICGKODwhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253432;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eAdfr/5c5ewYZBQasBs4poTZOB6DlWGZPneaq9mXxd4=;
	b=YKXq6azNeZKC0iJ/7autZefo2MnjRd/eui2Uibg9tAwbAWSVgGYMl+Ow2cp2BSr3Qsyz
	 DZpNqwdrpQUVZoqyzSA1wPicy5eGedqVcImPTu5Nc+jcohOWF5Hm5AAOxZlyFuf2JmHVk
	 eUgYuR1pnUvAOlkpA6Xt1ZwhhVy12Da3HN9qALzzyNEXIKCy+4dMaz5YFASuW5/VPW6O8
	 1ocEvGJLvSYpFHutm+Q1ddJWaxbJKC7ycEpOBcXXvvHFH5f52x5UK16MQ+W9pBg92fWWi
	 WBtdHMBaPZWo72PWu1NrAxIksOm3qV1zm/+FB/SJ1P4Sscn4kraXtu5TbfL0BKzvzWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfUzDZyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57B606A320;
	Sat, 21 Nov 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfUzDZyH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795253432;
	b=WtWqbaKgjZ2QpL2vpueVZVlh6/udKdf8bcUZsPEGHI+jziPKoMwFE/P+g9slS5yBMtNA
	 XWPdufvjJu4QOhQoYj9XA8ZZwsNm0iaCK/qnzWpQPv4Ar56VFGJN2c4zPlXkQiQeU8DDd
	 2sUOYBEgo3IN0syD49eTc3xEBEslVLXDCEuhOV3NrB7uHZ1fq9Ohczg6UYWZnWVXDvxmt
	 gdrfXV4n02hKbwPweDEf1H+9nbFBJVC4YSM9EdWjlnSyGrMqDgMn02Mxaqw5P1EMArNJi
	 YnhWrtD8MfZ52kdBSjahLE1ZPoFOdtb2elIQBpEnJvAr5csg2aouAafCosauhRTEjSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795253432;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eAdfr/5c5ewYZBQasBs4poTZOB6DlWGZPneaq9mXxd4=;
	b=dsKDWBJyQ39vSsfZgPLYS/lx7fTbY8//0DWEYwYuO3KiFvfpawXTUrE1mDcqtd25rq/7
	 3rAwnIm7p+4PSTfkabiHS2VkAJXK4a8q0lfVUWDNrw4XPkt3s/kemoFKevfiw+EZFMJGJ
	 kW9IP6nqBoI7TFH9cJbsqCPPtaBlOSLnT8ajkkXKlRTC3wVqBTuXLnOwXR1C1mwqPMW+R
	 /Z9ojnYqQpbRiocUvI2VO4oGL/0zz5NpDC5ChPQ5RSr3M84UZxHgMljk+ZBmMRO/2KCyR
	 Of1rVyaW/MhdyCdr0fQBzQOfqqYNY6U1mQPtHsWWt5O5GN+8q+dnqJ35MG7xOii/Byg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E2501F000C0;
	Sat, 21 Nov 2026 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795253432;
	bh=eAdfr/5c5ewYZBQasBs4poTZOB6DlWGZPneaq9mXxd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MfUzDZyH9vaIOLzKC9byvWYrJykPpgUM6mM6V9pnykRErgeDzip1dGT/NkJ+EbzSe
	 qBoM1akaoz4SHlzVoJbwVJ1BO7J/osnJV2TSUBHU4X4MQTpXpncEkbzm4T8DBMgC6u
	 i0F7rl520oT99YLq7VwZZMt5w/c7j5KfE+aKrSlzxz2uOVibIXVlDw/Dl4/5KfmBVO
	 Nny8uII2NS5YJMA48lk33rABnMMfc5HFM06rHkIKv+smTVqoG0X62PjtYJuGopG0Ni
	 SHm7FhUBCdb1TSoCsN95h79Tk81YtI9iEPzq9rkUM8Z50M60p8a2q6fqIPeA0Noj9H
	 JC6vwIoGlqTSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D18F14BBA7;
	Sat, 21 Nov 2026 09:30:30 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sat, 21 Nov 2026 10:30:20 +0100
Subject: [PATCH 1/3] dt-bindings: power: supply: summit,smb347: Clarify the
 USB current limit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-upstream-smb347-apsd-v1-1-ca46b92bfd44@tsv-stahl-riesa.de>
References: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
In-Reply-To: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Bruce Robertson <brucer42@gmail.com>, 
 =?utf-8?q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>, 
 Mithil Bavishi <bavishimithil@gmail.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795253429; l=1563;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=ifkvy1uzmYxpX0CrPq5nsb8+MrGYX8Ejrb1HsNv+EbI=;
 b=739a63rcbeB+QL7ELhbH759wYAFiDfto32DVJ4diSfd1pILRe4DM7Xk1AaB+7wm4sypmPeQld
 lsHfSn4memdBtAxZtBE5TGaunVGUjklhi950tb0U1zFKWewr5u+L7K+
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

The SMB347 detects whether its USB input is connected to a standard
downstream port, a charging downstream port or a dedicated charger.
The input current limit then depends on the port type: a PC port must
not be loaded with the current a dedicated charger can deliver.

Describe "summit,usb-current-limit-microamp" as the limit with a
dedicated charger, which is what boards set it to today (1.8 A on
exynos4412-p4note and omap4-samsung-espresso10).

Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 .../devicetree/bindings/power/supply/summit,smb347-charger.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index 65ed92bb05f3..67e6d4055af0 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -54,7 +54,10 @@ properties:
     description: Maximum input current from AC/DC input (in uA)
 
   summit,usb-current-limit-microamp:
-    description: Maximum input current from USB input (in uA)
+    description:
+      Maximum input current from USB input (in uA). This is the limit with a
+      dedicated charger. A port detected as standard or charging downstream
+      port may be limited further.
 
   summit,charge-current-compensation-microamp:
     description: Charge current compensation (in uA)

-- 
2.56.1


