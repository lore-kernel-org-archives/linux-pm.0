Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DD33C198
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288735; cv=none; b=sVdIkCM76r1c1GZJTpJu2Du5jA3MCss61vBAnATTvR3M0d7tEdKpYZczYkVFRtw+yg97K/qz09MQwtzcPF1Y/IEEY+4lyZ3j2ARGL0ukK2x2OhchWnGsSSUi8E+VKEGpaUthRCb3DkfmSacAd4VqCmq4Huy+6ecd7qE7Ei7QJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288735; c=relaxed/simple;
	bh=Gp9rEZnBlCdYZ83KomJ1Rix6qPb0mAp0og56IEFZHZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq8zdDoNQ73ZdkSfZ2TLcbTeyW77kaEHheZ75xsGlYVDzc23psDldzScfhL8eOaViMAg059n95Un3woiS99oU7eFe3r39jo5Wb/uxVtqoatJMooIBrleWVzF51zyP9kVAGwCjsEEdrin215EZZWb8Ju7f3L1wm6RV7E45cG2rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wW8YZIku; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wW8YZIku"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954d383e64so809775e9.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784288729; x=1784893529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4pJ9iuKTUV6iyRj89cg8Mv/REeAs+Q/BrxX8LSxG30=;
        b=wW8YZIku8uWaR2+cXIHwGaf6buawK7buWuIoJGTv41YmztDBiTJnfbIs/h5e+Yfuj9
         N1OlwaWfP/a534pEIVhiD1hqUAkyRu9GRYZ1Vbq9tA3MCkbgAOXya7ONAwsYq0R9tisx
         00d4VhfAK7VY9JyQmmygsMgV3pmR7Qy8DMiLqKbKhmagSwFnQtHmFbxPU5Rp1q+OSZH0
         4CaacT8rZu5VZUyE6gpkCF9tLJnuDoOyBLrcC6xk/EexErt7upaYMYXwhbPpnZwlg0X+
         9LXlSZPAHM6A3JAk58+3gti9Jz0zmj/wg17vgUe3w1hS6rGztq6KwEsGgEjYeZwYwMXa
         3LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784288729; x=1784893529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4pJ9iuKTUV6iyRj89cg8Mv/REeAs+Q/BrxX8LSxG30=;
        b=sWYoH5piyavKUHw7KYG3xa8xEMR1d/37YmDH9WVZCXfVq6L8cRw4k26zMnMj5KpWoo
         4TEj4DcSS1lEdrrlhjlzTuOK2GbTcXwUAIVrVZUSrpTm+UqQ2Z+VszfEMX3EXnwtu2r0
         NNWYL0KyBp5BlfPTffoABRAZPl1tv0wTV3pWXse4yqPnfjPet/TY25miku2EYJ/ah1yd
         xcOGds1KnOuVL6xM+nQ5Hc9JfIpD5+/0tcVuMCXOzaseXivzf8ceGN544auNH1SJtMkH
         xoyvlnnydcbRrghQva3rKw0oDhE2v5fhLu2WPyHu0JPu00APeo/Q2z5Bb7eAwZxDTyOL
         koTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfaTDfxjFVBmPasU8kzDcpSMizE2hGnxoxjhsUgg/KnyBiC4XTw88bq+hQipUTWPZgT1lvRAQMbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKm1FUzUfBCTCj3Oc72dx2c2Id3ouIvVu6aKayY+M5qtpBsl8
	z56xLhT6nGwzKcArF5E+Fp7VA4SWqXAgxFJl/6v2kk0fwgl5cbS7SVN/2dLdAmpef7P2A7lGa3P
	eCbhGJOdH3A==
X-Gm-Gg: AfdE7clbbnSex9OXWjR/h9fjKaM0iYVx0CZ/snao0qNYlKPBEL86HPyMxw1zSvdn06v
	JbpUyZL/LSN5zViGUrryRP68HIJWcLhDuMfhzx3vdNPuhkqRENDyX2gck9jYiDw7AgME1sIp9Eg
	VGJynxXsHud8MfUpY2wiQ33tZO2S/+Hy9qqRFCNKo0HccIr1tVlHIjm5xI/z1jKz2BAh78d20m7
	c+ElhJF39hOoknf377GYy2NL2YCcTTVWLKZpol1NnUBgUg9WSyKS9yda7q5zlVWiiE7j7fP1SeL
	4EnrcYv7UnYlmUx/21hH4LwxPUxkC2MwwjIdT6wbiScNy0HugAdSXlMp1gWd7WgaP8f57NvPcI9
	oWaEsXdlpazlz09MDhVjFIsNU1U9qFiPYyLKtBNmfHRJvpLBge2zstwhAN23QQ5sB50cqev4Xuk
	Rw
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-4954a50ea30mr28928275e9.30.1784288729096;
        Fri, 17 Jul 2026 04:45:29 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm41353855e9.0.2026.07.17.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:45:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 17 Jul 2026 13:45:02 +0200
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Add Milos
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-milos-cpu-bwmon-v1-1-dfe0bac9898c@fairphone.com>
References: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
In-Reply-To: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784288726; l=940;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Gp9rEZnBlCdYZ83KomJ1Rix6qPb0mAp0og56IEFZHZg=;
 b=x5sMB4LhOoiMg6caeXJmg8aAp9bmLEHqIa7MZpv9P6PG9JcZmMQrCEpDiXG9fnuO9V391JC1i
 oULEO+qXM+lA9p1wYt8fOGCB8jyNQNP9+iHRbNR00Lyw9izp5e1ACE3
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the compatible string for the CPU-to-DDR bandwidth monitor on the
Milos SoC, which is BWMONv5.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index c0a5e925ff95..4e33c75d9243 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -49,6 +49,7 @@ properties:
           - enum:
               - qcom,eliza-llcc-bwmon
               - qcom,hawi-llcc-bwmon
+              - qcom,milos-cpu-bwmon
               - qcom,qcs615-llcc-bwmon
               - qcom,qcs8300-llcc-bwmon
               - qcom,sa8775p-llcc-bwmon

-- 
2.55.0

