Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807278;
	b=s2ekSXChXtpJ/t+tMH9ZIODdgfq2bblA7aMO96Ci/TTawLYcE/KP4LpwEcWXG7xZwhup
	 aNy528IeZd7Wdjob5KvF7FkeKeSCctXEE3UCAS7Qpc4RMIACC8l9O8tIKSpKVaZ7Ypdej
	 NDrJzbPhON6/Tml0akhq1L2tt9+TsE5MLHf+TRHCyobWzU69C5dojyHJfFSnnZMu7JTXc
	 2/m1uAVsb/OEEPm8RQC/dm/Jr+ka6t0YQbXDvrDBfT180s9tEcLgpSbuZ7oUa0MgIcCO1
	 EHP2P8Zp1yA1PVTIYfSoRPRM7EOy022hCXWykDP8QJ0CpCwZ1Tw+n3cxcCK7rxQ7nJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
	b=3R1Qm06drqxHcIJrSF7MHbITLY0fJNNgHAoP027KYrR+uZj4wCjLaZABZ44CqpTLNuO8
	 t70ppwVWKPQEu8wLOZ/kvpQRCaZOL48gElFh0vlU8CZznAn7PXuEu/iBPCeJlG6JePQmx
	 55i9sazeorplxJA2yQngndIFLayQPQNUoBEm8jmCvCODikzQDSINz7efDVxdAvliaCyjS
	 BWaamG6FWGcM92D0Z18K9ciKe115WNCv3tbYaEctS9+5sGJbyAsC8L59yess/+aBRLSOv
	 Xcx1ZVTwF6i7Y0lQWWkaoIHLQSn5AWriPmomBBG991DFK3EzE2jhDhEH6EU6uzFXPYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9kf1Z+x;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B13606A323
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B13606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9kf1Z+x
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1438d9363fbso1436888c88.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807277; x=1795412077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=A9kf1Z+xZAI+O4NImLVZ1du3+v+O27Jx4WofylUUmF9RFtoG1LQXRwitighsJgZfqi
         bDR74J4ta2cYOj1P2ia7fjprfYCcH0n1C2DO2PrNddBsf7xBT0cgB9dK2w3zZzUoM0Ui
         E/9AaBdwIG6dyB6jPetrfXbxH5tuhm2jMySWBXeq31wwhMcVnWTGXqcUEh3VQ92gZT1E
         uUvQAD7M0or+QQwUMFB5UcDyDCDYh1tUKryBkM+GVGjD8XLlEgkLdp4Z+WqAuRoD8e3J
         uOQL7Rh+OzGltnWJp+mA166rBe2WF+QZiMCx9T8a9xYT3dOiOAcJwskNuwwlQG3WySsX
         e4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807277; x=1795412077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=HafdB3sG9FPVhv+QkG9RwkpJcOYm3yOeASyCgsIY512EBCnJhjZxfa/CgtWNulWKIX
         rOmujM9oKa3yitE7pg/aM48bz0NSlEf6UNh+DYZwuKhkjYTOgUHPX+9/Tgst7rod0d1k
         aaNXP7CS0iA/K0sn6DRnaAdn/eaVN80MLtI+gHh5GMI/kSmcbjAcxqETFsU1ADY9mHzV
         03rNoDtpwZoD1v3GVSS3jT8EKfqvfhyViUuM0drl4P+bX3pbsx9ZVUmElgE/hWBdaq1g
         9XgLYu+SnE2XSMpxDTdKn2L4ix5nn8D9waiQJDp/tuVa9IXddeojxe2jvix5k3GTqb1S
         RZ5w==
X-Forwarded-Encrypted: i=1; AL+hErEwIUDuJ9ScGwqcgojxoVI3NHiojz4rt8IXuwRpEQsKSASw4GIv/LapP1UbWeZu2dhZlOul3nxSTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/i9pkp9sgPT7uKl5VrMNn2109IBCsbS9eod7IqWf5dldOTB81w
	hXsLyHi2i6MGtJD6Rowk/GkLjO6AwXf1nCbGO++VrtAy70lsysE7I5R2
X-Gm-Gg: AYBFou2hx+O+/y7ZzAV3O9mF/vSBhvqrxjlJnwQv6eJho9WQ1pQXXhKzwhW2LCZm8At
	Ivcf8ZO+7+DEmV4esDPdZBulV+5ZpF20BebJ2d+ZZYIhWxYNLHiUpj+OrwqD//HQAtEwfbvG7WH
	a5Wy+otiXXKKdIb692rMlELErB5KXBK21YC5bKd4cQ9km5jNZwYrdtJ/3qdx4Ijt+j9m7APvRbK
	62P3drQds6dh0yfwzEdIown0W9Znd87dQAQBooieOagNbASPYeR1MP26+K4p39cgQQAC++vaf9y
	lRNFXprnysOYeyTnEUDOylX7NNMwlbtp7CDqDKwyMnuABrUpcekzPTRKPJSLEqtRgjw+irwRMWa
	Q4WYhBvYJyFS69cpsE8uB3/7r3doJ1LeBySryPY/x9nQ2mx2vD2kVWw2PcdulOfJaXoNnnSJ53M
	duVKjnHckNZdXojDPdfaQF+OdVB9cWhhwZoVZDwJ2TLXZ8jwkYd3NBRgv5nEzaRBDQWI4IWUyBP
	XIKGsjBqYCcdWC+d8utEOFvWtA7n/GW4lA7rp/JPoHjhbnMKhkbQdrP1+BiFQWerPtPUfwrRqt3
	eE1uptFHZ3houiOkrMWTpnNwCg8bK+x4xL0lOktQifC3o23FieKE3WVyNugTKgmvT3QQ6SWiTa8
	4Kd4U
X-Received: by 2002:a05:701a:844c:20b0:19d:233:989d with SMTP id a92af1059eb24-1b5030ad3bdmr8391819c88.14.1794807277352;
        Sun, 15 Nov 2026 21:34:37 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.206.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm33463380c88.5.2026.11.15.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:34:36 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 16 Nov 2026 05:33:48 +0000
Subject: [PATCH v15 4/8] dt-bindings: thermal: lmh: Document SM7250 LMh
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-sm7250-v15-4-6acbb232fef8@gmail.com>
References: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
In-Reply-To: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794807229; l=791;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=VBYR2sSJ7gPSfZ1zDIlxykyMXb9GohC2X09rRKZ3wIw=;
 b=GfWIYZ4Rdr47qL4uVzwmq3cHBxuZuZfauAK9SuR+lb6tJOGaW7G3JO5uex+TMga7n417jmp6t
 uDxoG1lyLysAGDzg6fS3Jl0jgyrf7wGrThcMpQTEmnFiL14C5GZ0vFS
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the LMh compatible for Qualcomm SM7250 SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index ce72347e2..e1d5cb871 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
+          - qcom,sm7250-lmh
           - qcom,sm8150-lmh
       - items:
           - const: qcom,sdm670-lmh

-- 
2.43.0

