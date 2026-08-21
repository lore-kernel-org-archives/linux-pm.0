Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D4430CF8
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300031; cv=none; b=IUj/lljBL4udTleDQ6pPylcZNW8EsjbNZS1urKzWHV8N/2l0LYtwZudTLLqiP9UFIrYxdxwnovgkkpXoqJwnxc8HNQ3D6nZaYQFb27MBACG7nO3qYICIZimq1Ey0m6p7wxiSk4HnQhEVtRbQ4Q1LHkVJ4bl8Fw0ga7alspIxnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300031; c=relaxed/simple;
	bh=S4gVIUWwuoALYuzwzRm82WuAYzYN5KLWtNbqZ/oM/+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB6YY6tTE7N+PAMaUBGJL3vY39RnKwLzCK4xTcoHO9sE+MjwwQ7qFY2REaZtvogfbHPSqY0XrG3lBdbXBvnTwcsywMSbLSnDAkT+1w0y+FmEXi0LAmCt/12m2DhSfhy0DgaITyssE1+8W1vOMYWvOeiTCgfWclJHG1tPPzf9k3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJoK4GYg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJoK4GYg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacf197759so10715585ad.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300029; x=1787904829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3FdfDbvToHSgtTrj8YFlW83QqqTfihaw6vnLz7PZc8=;
        b=EJoK4GYgFSAzpEh9YFNwO5Mk5s9sNwBHyWF80DghZE5kc988pKUQnL/P/xAfGxEphb
         Vu6zPWJhXpiSGypkiAQnv/q12VG7AULICtGMcIL76VD9rYJFtG3gdi2zdj3sxmi57AHk
         iQ2ojaO/6l+V/Zd7+h8eIcitIlPnbfRPmWDPX5OtKnY96px1juK9wbcR68npe3/q8woN
         oSWdb/AILgHZFt/pVqH3sgDEvJc2eM0AiJ63N6X4bIuexU9fMdq6+irjcrWmEmWIK8uW
         9Dkt+TwpHjTZePmkTaqR82A/WjVa/4ZfD6CbHw/VEt0KSb4OC50k/uDP9YU6DZrIfDFq
         NCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300029; x=1787904829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3FdfDbvToHSgtTrj8YFlW83QqqTfihaw6vnLz7PZc8=;
        b=F8hOIHeGjjfNaR6D2Lux8sR3y1YIlq/BfbZjvW5mG7Bsu8wMruWhIdtO1bAp6kyznq
         O1kzZVlQ7Ha+g0nbaDhWAK+5f9cZlW9/5U2lntGP+25JdP/w9dychohIg+wVIvIRvKC6
         oD0hD8yIau44K0psA40QWfWf+/cMT8pRwW8SS9lgonFJXkN7ycneVoKO9fT2QO5Mmm7Y
         y3MiAWjEU37xeyI3S1W+hyi6N9P8MOoGnqbLNJ8wODmGaeIIWllREbiV+JPzTLRECg76
         VqnyvV/qvSk4bs6m8i0fFW4AijGrKzBjPH5C2SjB8ERqkX3K3dQbyAWNGKUxhv1bZ+Pg
         /GMg==
X-Forwarded-Encrypted: i=1; AHgh+RqUJf6HcBkgJIZoB0dDz4MNtc3Yx6Bony/JKDxA6mPCef3W6uzKq1zodDZOp7DqMgRWGqbiEiWE5w==@vger.kernel.org
X-Gm-Message-State: AFuF++nwMSe/ccY1o/u/gUjt2YgffhLvcFLQph+RyaFlmI9DaiZCLoI4
	eEQaLk645baconIHSIE/TyLRI7RzhqEQUbljQHEHMzUibfxFsjLUF72D
X-Gm-Gg: AR+sD12A1LFc4kR6y2O8AD1McwA7Vrl4fruvBj1vADf4rDjm55JPAtzgheLg1ZtgUAd
	t9m0ZyOQxukst6713vyF7Wf0a1achba2FRW9sI+juEJ5kLIn+mkGvDtWAD1UDB1ftSV7TE/lQIG
	tnp90B0B2CTOmXoPyxCANpXDElA1xycVzcFCY25m9MEuQBlA/xUGNz6DCx8yrBvQC59+YFdNEBR
	DepvcOHJYbT6pLws+7ky3fCd+erDJP+Uve2+OhQOG9LM4WXBPAcawKH3zW9jkaJkZCemM7V7cAy
	jHtw/97OfHoTwaUp6/KqCqUh4YldRN6p8vhGqqbwzbaeU0XcEE+aa6t4oQhWV/+FRQnhLoMOOFL
	EsH2NyfAW96mFN8j6tR54f2XWs/3ZO9ME+VSbkR8X3ZCPTWSLq8Ano3LgSARZAneKwfwKAnnhmj
	wNwXy+WkIuDZ9jQvPEsJsY7hgUb88C9ism6xyNGg8B9jlQbx30fcsokV6B//jFTQ38XO5Peh2ba
	Gl+hczasQXJ
X-Received: by 2002:a17:90b:2d0e:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-395c2f65bfbmr9339432a91.0.1787300029568;
        Fri, 21 Aug 2026 01:13:49 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:49 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v3 11/13] dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
Date: Fri, 21 Aug 2026 08:11:23 +0000
Message-ID: <20260821081125.4522-12-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081125.4522-1-sreeshankar0910@gmail.com>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the PDC block on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d4..c30b88589 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7250-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
-- 
2.43.0

