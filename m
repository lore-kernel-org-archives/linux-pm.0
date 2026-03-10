Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416491DE2D8
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102020; cv=none; b=nYJSgihzHZVmUw6+px24rfffRAbGGXW5O75MMjME0Brnw29ayuGC1faqqo2ZK11IvjcAzKw1lB029FomEsFWCL27GteQqZCTYSG0fLQF+RzarL27UUDLKFqB+wNz50BDAOFvIAlhmJDPKZ6y/QAyXl8jhzAoARI5M1asmMuO5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102020; c=relaxed/simple;
	bh=zT7VHqFCzDwH7dsnqHKBT6R20zasdavK49rOXk8BcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ5IyIBeZXYslVoqmAOw4P557GJD4aB33JYG3RPeS1qUrVHDML+/ep5+clugR1jLxr/FWADjhR9b5JOdH+sVWqCBi5yBVm6ysFx8wx8BE4O7hMixmEU6XxGPP/Wsu/OZRNeNmk7XTduA36b5QfWsbltXx59F4lHaLzkdV31hiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0enkBRS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0enkBRS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509046c5c7fso29609621cf.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 17:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102018; x=1773706818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqMq09LrRUJ7Y1qu+vRwg7gsZM0+ELiCGik6jbn1EcI=;
        b=L0enkBRSntbBxvpcK3E5rFUtDs3tB6Xrq1rhI4zRfMGY/V+xRT/EvX4qbhUPLEQkaX
         lzX/aZZJl1YxAyCE/M2GL74Yqt46wbviJohIRk0GfMZbbrch0UR8pT1T1VrH5BbIBZTb
         /Rrj1sZENrzHFWoYOaPnkmmvwN8RvxZIzxu6aquQYg5+C22NIcdLYXrg/pzRaAKt9AEu
         hmpeqR9KZXWBWcqRxehkQYmKqCkFoXm6W2dqI/sfJRIQ3NZcj+rE4xC2YUKUGkAB0MVZ
         Sdx/x7hJW2ZLrBIhb2hrGSrbRfIVi4lFjkB5x6jKf+dUZOzCh4T8x18AOoLfHQAcbAej
         i2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102018; x=1773706818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqMq09LrRUJ7Y1qu+vRwg7gsZM0+ELiCGik6jbn1EcI=;
        b=TEh9UBXtej2CbMJ7iUKbIr21Q+37yrrgOY7FY8XnFGIPVini8wKAw0LRxe8pwOVMCc
         BTHBptvQpE6GfOx56BWZDUX01+vmcX2cwj7Jk47BfTNmrI0v/5B/5Txv6N+bVk+58XYL
         NpryM6Ssix1LWHV1QTNKFTQcGrcouSLtfsuTd7gfXPwm3quLL1ulWZIyRoEaesfDwwct
         eJowUWLQvWdikFMa9S6Ew16OvrjWcSb0y17DvXLKE1XQ/w7iSCw8Qe4CewDvwZkJrN3C
         fkYleuSogauC5BJq+OMKgjFpoJCG+rjU0G/GbN1hAHaO2QR31xDF23btKYSvLAfdejbU
         HVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwX4bHC+sxtVmV7PaaWfvuwf9VdspdFOul8vswQ1tHFUdcmC5ZNzPK2Z6b1COXG3uJ61krevwA2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyrCPgG3DaPMRLdB5P63N4WChvxwRKz6G9M10k9NNvRnHDE1J
	7YZrunzsjNhVwfAADiSQpPhxCKrn1AkkUIqvIqhwTMhsev/D1WcU66Av
X-Gm-Gg: ATEYQzzoZRh/3dI+V6cONd1MhRYG2XDQlQeDaBQu8bNBtW5FagiknrBrtJA7oWUMi5d
	+25e89Np/Da5vfB2fkNgiLWprTEy8N9ozI72QDHwtqySwslV4fslgG0LzkryTzuC7rhJ6jbdgyg
	vEbUQ1iEXYO/sORVex48T6S6FIrM/jtkdu99uj872Yxr7wZYXZ/FtnujYzPxzigcCkP6GkFuWvB
	c/UyxZubQWf9N5MYCr9bomAYorGCKWUGg2svnCJQfnnnojo40g/DoOYfJ3+MKThaz1OVxKbWddY
	bC9I0WfwOV3MsAmUsXII3o8NS6pBe1wNn5PdqVCsUU5c3maU6Iw2gtH7K2PYW4qn3N5SMzAHgiw
	9gqwjXYNgygcEnarDM9kYBTO9yFbx/1QpnUxHBZAulUAqHKfo+jWNBpBydG/l99eCqY8WmiIowq
	pY+TdZfYKproSkYzpk4GV302O1zw==
X-Received: by 2002:a05:622a:1998:b0:509:1dc8:e9e5 with SMTP id d75a77b69052e-5091dc8ed37mr53525151cf.34.1773102018043;
        Mon, 09 Mar 2026 17:20:18 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a1afabsm8615926d6.9.2026.03.09.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:20:17 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: thermal: tsens: add SDM670 compatible
Date: Mon,  9 Mar 2026 20:20:35 -0400
Message-ID: <20260310002037.1863-2-mailingradian@gmail.com>
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

Add the compatible for the thermal sensors on the SDM670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 3c5256b0cd9f..6c84f22ae322 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -71,6 +71,7 @@ properties:
               - qcom,sc8180x-tsens
               - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
+              - qcom,sdm670-tsens
               - qcom,sdm845-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
-- 
2.53.0

