Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669142;
	b=M+d1N77ShKFnGYxhmSyPTRg5zhMwHBZqgP4Qih0CsqsVqpxGALoUwVEu2oSnEcaG92Cd
	 chXELY+QvLwvATn5O2WvWn/5ge4XC0TfOL8sGm9UDN8Nz5JV7SB/L8ufTT0OFfGAq1LnJ
	 w2MU6/Y3RZ8gYWo5Y/d93t2e/du8MDsZsQq6a5IWZdrhjjISjMaiPfOMXVlPfaZQ/jIVF
	 G3cAWOO8beY4iriIcAM8g1kzjGYSdJ++Hg+oCNTS/85fs2njnbL92qt2REZCV+Z9OM3Jx
	 V7viWluTv/PiGj59y2tGXbu8DfBWDqmvsgiljC5b2bOVEu2ENrgX+cfjJkmmHnEL3ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
	b=y+gHEdATXIysXx5HE1+85e863hcBOPvl4sKGSPMgzXKDjx9gJGtKqbIsEmOzFiIlnlNs
	 Vpf8wBYHM2+I3J6TzpvQYOc5Y21eCZSpvkKfwwW3P45mUP5Z35GYXiGVyPGb/kGj4rXoh
	 O8GGVWGkONKFmJa42DCq6BYPCv2kD1aG/Tq3kM8/q5VlLhkywjVyI0OxYIhV5T3V3pYjr
	 UuRkz7fh+o1kl7xtYfErFn5C8U5W8XJQ/i1RF0CVIpQM6cCeUEvYeLnph0hB6Q8vBm7dp
	 LEB3iCsoXFtecWJyGJ50XJClWGhNHtgKaY1+V36lH5be3ty35qIZS+BSHrbsktFfFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kSCCzsYD;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189F606A329
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0189F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kSCCzsYD
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3869f03af6aso5780649eec.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669141; x=1796273941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=kSCCzsYD7TTe4A2sL6/ycJJjMHyhno0Gm7v4rEASckt7CADBOTSYdgZolwxbk5ly8G
         ysTH5v0qRaf81Vg/CLag5o9PIut2u/GrMvkWnKTP6/Pwm5gX0B1XOgvF9Kk1F0NPMw/A
         gNdqG3H9A56JnEPxB/tym8sSNQ0xdU3BW7VyEwNal/q9VseZZHzJRy4Hn+HzVqHdVpwd
         9Br4aEBGYslbcoSL8Hl1hFXNBFMqN6N7lLK9hsyUVcRR8xaSvrr1nSAMTM4vJ3kRNapb
         X/dkNWOYyYezCQuNUgyh6p7lfHzVVhmLBUcQkl9dZhBG91WDyReJ581nLKjT8E49GXHm
         rX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669141; x=1796273941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=CZloLfYVLmrlLD1hgRfBDj351IAmg9s60zUunKaQ973kjccnn1ra9aK7AIOzOEZH47
         zGLVXJS1H4Mmgzt36dEsI/qbLEWcsAl9B9R16rgXj/z7icNkTTtdZgYkBGEPi8z+ty0M
         BKkPH3wPD8GniQu2SQQ7mAT35ziMeuxxy2CpZqsWFTrJ6xA5qThjzalcFSlVyzC05WR3
         U8FlK/YA8xqZmrW7v/coVrRCCFnxQpRmwrII4e0wmynOhNiXMMTIX1AYSi8lLkvY0lLX
         8GVTRAnjCB04jZRdT3ZOKOs5Wu/nqkvqmca0mj4OWfMoizNRw15BymfrR04CzIcBziXN
         Gzrw==
X-Forwarded-Encrypted: i=1; AL+hErE0Fz65sILEld1/EWUg6xqDlNFRXLVvHwi9eNpns4Be+QLABZpsRyI/wAYC7JzMRcY4/JEJTuytbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+bzloItBVHfj5brRY0kucrK96hZHu2SbyTy77uAuJ6fWa0NiTr
	oLGJPY+1UURFtZRRwC7q5IkfceBzRN96D1akBrsVSYg6OHjdrp65GIIF
X-Gm-Gg: AZFdTZfIJOcwXpNz53Whw06B+S9+SYEGNNxPbw8pM32xt8++m8AzAeVcuoo2W4QhS7n
	bm6RqnoJ9H86tmCryIVB7++CIgk0V9HUTB9xnmZAry2q6dv2xVUH9+5oZVRB6aATcqvzIl83Eii
	B3U9+MN2jWxg67AhYsf6wxW8dPO0sh4oDPKThWonGiAfvuVxbnDa02cWLxMt8Xm1hmSEQU9olq0
	UsNkyh90c6021A2kSFLOruSpLOM4NtKF/NuxB/14whF6w7IkJtaegzieCM8w+oRFqw5Ipvu4SK8
	/ryLM+uA9UcGa8YlYKm07vrdNkMyk0ZLraYgbz1X3cqvotw4fYNlP/lTNyUz0NIwI5rIg0LAgni
	gn3Rzl321csqg8/gf9jZVgKAsoGXu5hTy+3V8uOLIqrVPJGmXTtLjOnN4x+md9u56dR97oOH+23
	UcK1+9DpIhSfIjSFuYhvGYKg3TInJndhAOt7ifPuRYJRgKBacoeUWUpDScKF8IMtJFdkuIEkTch
	Qxk4bhrtUMymRPx6VaNujmsApJpJtpOnPZzPKqN8M5pYH36MM1rIko4JNK3cCxbZRzvSlWzzo2O
	Xd5xtwpzp9IbVnIjc9w47X+mrEpyWcOQ53+t57j24MwSqf2teoFv5rAiXe0o4dC872eH3Fz06sC
	Wot/GBGY=
X-Received: by 2002:a05:7300:cd86:b0:36c:a3ae:936e with SMTP id 5a478bee46e88-384b398741bmr30143044eec.5.1795669141005;
        Wed, 25 Nov 2026 20:59:01 -0800 (PST)
Received: from Sobhana.localdomain ([152.59.222.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54800362eec.7.2026.11.25.20.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:00 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 26 Nov 2026 04:58:09 +0000
Subject: [PATCH RESEND v15 4/8] dt-bindings: thermal: lmh: Document SM7250
 LMh
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
Message-Id: <20261126-sm7250-v15-4-492014ec0a52@gmail.com>
References: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
In-Reply-To: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795669088; l=791;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=VBYR2sSJ7gPSfZ1zDIlxykyMXb9GohC2X09rRKZ3wIw=;
 b=buX/Uir1r9Tf6tM9hX+yZml9fjYOnCxBqpLAg9mgfqPDutjiJqzrSC7fD/1Lls9r89OUWSfqY
 4QvPYYL9spzAIblrGWW8QtgGHnWwsrntmH5gOADX0P6V/5pn1RhOJOm
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

