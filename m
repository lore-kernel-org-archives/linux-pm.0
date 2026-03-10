Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7441F4C8E
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102022; cv=none; b=oI0edpccI6xEbHt0e7y4gL8dYzeJ/5kpjHL+PfCUQGBzve6l9Llgu/pE5xe51ee7O+J8cghrRdgn5LMC667ytnji597p5IlY/RnYQqQEnV3MvAaEZDOVm9P9tidOjkQFpk75XtqthVLbMEeGG2/Xg+AColEu9Zm0Fl4Da1412LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102022; c=relaxed/simple;
	bh=YKU/DnmNIxKk/G4FaBPJrYaaIFx5k+4NkZwdBNpIKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhhd/NopdbNPF0TRgvk8wosIc7sZhLPzmqdlkireLCqPPImJGTLTWj0BR+o8cyza0MOD1VvM3aYHhJ1Oqzmjfalc4EFk8w2k9v7gwAnfIh3Nceaw82DGycptx2L2s5jrlbJR4f6xh+aPXSjSejEP/mIAXSldrKuh429X5a2G2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHHU2RzS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHHU2RzS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd7aab92dfso267222985a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102020; x=1773706820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=SHHU2RzSC2Mu6YlbBUcacrRXuPhA3OuWqD91DYfVg6Vt/E7rmzH2ScCNRSkM5Gi9p7
         26Kq7akmT02jkDG4ZOj4ECsc3OExDNHLFVpVPUnsV33O852xJwXuPLAfWvNFbcXLqXJS
         +slJlNnRvRVO29l+Xc/k2fClgge/Z5d1ZiOa3s5euFwZCTi2OQl2nMz/wb+9gT5YbfA3
         S65C9MUNrLmN49sfhEGz37cQkQpFXeKD4ZPHFej1+45r6K+wBSPQmAfMiYm/yamOgXZi
         fPe5rlx1A6I+NWpvrFo5b/4rRKTAFfC1Rhcu7W8zh9pvM/1EgWIpCfHSx8CqQzDlzqrs
         NE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102020; x=1773706820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=H12+cVS+NDPtxAD7IPyEIj8JVGoquO68ELd1/0vBFTl44UXcxCMlKWnT2VpJ65y9Sq
         Wh00jhjE/rWg3nw7LqjFpw7K6laJ71+rhOJXKhrWEl9kAdueC5VlO4aXg847xeSenfjg
         yyp8Czcn0eY75LpxCUFjZLiz1o+Ivg1FM7nkr6guo5Dya54MzBP+xZPDp35GMRXmf5YM
         x16P59E5kWPzO3ejEzIBMuoUL4nHFl6AQTHBKl/TZiJQRXuqy0nLjlMswkWMVPchTJTB
         g2hqP6nf+oEHw3wh3vbeqR0xW1S1mHQfu+/C4MbAhd7ufvbeTbiGlGFcJ0XaZnR97SJo
         RfSw==
X-Forwarded-Encrypted: i=1; AJvYcCVvVZU/wTgJg65UpiWVEuKLOJrYV0m4BG4FjEjYVw9DB5Pmvnyur0oLXA+ibxMWcqkM88LWLP4p+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVROnLDHkYYBECGz5pO9eRAUO6T/qxgXbcMUO89/Cb+hDYPTJy
	fJj43sXLMoiojpyfHhzXhSL+0G+TGxKp0g16cktSt4eP8Ei+C33A1Geu
X-Gm-Gg: ATEYQzxbQBghARFbO6H+fM2qv1qk/uqIDl/1cmI2ZCbd1VXQmoQIknZcPa2iQN7INJk
	kY08GD8k+lbXF0nwYzEbbFqsam7DKBvKx0ryEEcqKYsKKeXIAXI/EO31JLoTodlsnamZCgXpAnk
	Vr2jTiVgSlUJyamLBHejOyvK01Ux/Wrb638d9GbJ9vs3TKsbHy5PU2HJGrOimGKRvWJ5V4xmsbl
	Po3jOwtwRzmKYGOxEODnkcb24RTirOVrAya1SrLur2iooWZxTKOrzAUMkTkADP0+qRWDrfDcb68
	9RoiMdMr2biLiB8d8EHhLoFxAk2e+mn+PwBjwM52U2n/ODtyFMDKrq1/3FwDNov0Vk3zw8fEx9U
	eRSrS744CGcS2DUTzSHDvHH1I+s6hulSoVR6T4qovLA/JNOWaPn1BCY5SYc9i9reFcWCi/To1Y3
	H/hzLv9BaKBDTJx+b2cqhW33hW8NtAm9VoqOXPXcZQmOZZ/ayIoztOTPfPmXafLexJWCOicRhTE
	+VXzfpnqeLkh1Y=
X-Received: by 2002:a05:620a:19a6:b0:8cb:5566:c947 with SMTP id af79cd13be357-8cd93b75c2fmr191017685a.17.1773102019844;
        Mon, 09 Mar 2026 17:20:19 -0700 (PDT)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd870433d0sm330913085a.22.2026.03.09.17.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:20:19 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: thermal: lmh: Add SDM670 compatible
Date: Mon,  9 Mar 2026 20:20:36 -0400
Message-ID: <20260310002037.1863-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310002037.1863-1-mailingradian@gmail.com>
References: <20260310002037.1863-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the SDM670 LMh.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 1175bb358382..ce72347e29d1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -22,6 +22,9 @@ properties:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
           - qcom,sm8150-lmh
+      - items:
+          - const: qcom,sdm670-lmh
+          - const: qcom,sdm845-lmh
       - items:
           - const: qcom,qcm2290-lmh
           - const: qcom,sm8150-lmh
-- 
2.53.0

