Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669176;
	b=4c7XKrUTBggci7aLAUvEOawRbG+mFdlnTkIxrt4bSB+WwI1jU1IRn7ukhCi91yKkjxiM
	 wLgYgoDXQcN8n3e5ZdH8QaajnrKiqzhZ9SB4zQfBTWv+4TaFpJSW7dNJn5cDHfVGS932Q
	 3d9AeMx/cX9zb9qwp/PuaZGXvJswTA6omRN7sipt5Ka1mBFTtB/dMMJTQ5qgIheXVh2nR
	 33Tkr7BEGCFIE/lXKocLbm9Y0kT9EhORAv1PLmkvd4pjZx/qVysVqABmjfXkDW7NQXuRV
	 baidaGQHxTDZrzHJe7axf+8XusmSbLUZIVX3a4+ytRKGPzDIf/LIbO08jw0VDvKQWtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
	b=EU4edFNbLpB7flNSi9g7lROaK1DymccUnUS+Jh7LJDlPtBjrfZpzmcfJOvARRNVs3Mlp
	 nCdDTbQK8mbX8N9wmTfAQ/MlxS8suWDmXuCp6EW/Ef5iEIQup2Ypgu06uAY6aVvwD2K8g
	 CzJNfW7kzj5RDdq7KlrKjJpG8FXcnvNJ4oUaZ5WhvmdfQkg/bCq84qDpksLRU48FcOOQK
	 xdN2erZHygw++JreGAASOHl6PyxkBHot9cpJi5FYRiYPdf46qWhyL8yx36gL2pieglRKw
	 9+PyqXUpNBc8kH/Q9BlZoEF/ezuddQ7MomkjhCYHT/XzxtzAamE6ZfWApkxHsp230Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFzPJxa7;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC7606A323
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CC7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NFzPJxa7
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so10953801c88.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669175; x=1796273975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=NFzPJxa7EhtRIB8MazICb1dZm6fNciu0+eLItxW0oiWruoT5aOguqNE9G7jmzxP/nA
         RkpbDJiqDE5/e/XWOmDUN9BV9cSiaDUdMuaUhMM5Z1F+/uyFtVQotT/LTzXewNqPOcrK
         541FmdJagqAoifV30pAUDCG4f8L7RW4NhtqiSqPAIzbhUAc+6zECJG7U9IjNiZrzGU6Q
         t+0xX+hdpAo23j3UIy+7AbGneIcGJTSZpbhmnjOS00LsvKUAP5XNqSiAFcbuW89YxiVX
         0ifHTVOKgbf+QXew0DyLfF/gaqOm2d43nuwGJtKoPISb2Lrlip4DV0RUkvymXqVvE1aX
         1tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669175; x=1796273975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=IG3kSLUzb3t56d35iIlNkJ1U+cvuYVoX7elGT5IY+l+rr2+9vhL6t7POdhZKVDyJYw
         40UDCctu6mqjFS8oY6CWJXoMOOv0pEtFd4estFFOvxo/1tyXuGbrGDQk2AE9D+u3teO9
         0xLrRRtzTnvSB5Vy69ArBOtU27lLnrAmCwKhfpk1QU/nGHz8HRe/E9nFv45ldfZ4rzIB
         iL9vVzpBXDa2mSBGsvlG52Pl2j8Z+V6+sdsbb72MnqdBRmTUZxH8N/XRLIRjg+BUy/IH
         J9vfjs2vdMcpyHYwfBZC8y9f2Td39jTR73gd27rzOPjlxoDrL2cz+UdPokn0YGRGNF9Z
         ifog==
X-Forwarded-Encrypted: i=1; AL+hErG9LN+tnMhr5bkjidZSecz3kVtSw0T1ScNcnPX30wgpPu/oaiDV4yhOmMh8g0IdbYKfoR7yVzAZZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yb2VZ2fxiRb3jwwElC856C8NmLFGYcS3ANsjupR9Cn+4t1tnd
	eigU8AwGmHQZz2lOtUDuT5PIrcoGeus0tH8Za41OlRt7+/LTacbn2fQ0
X-Gm-Gg: AZFdTZe2hYJWSn7eTarFzofExNbogYPidj4qL5GNXYJ61qajX4MpBZ/VyF2RfYCFMMS
	xfqHAZa3utw6z/A/30QGWKPlyCxDAzpBrfsCvAixUJIhyI3Fxnem2QIztrkN3lRDsQNccrmVMvQ
	J8E57B9gYrXTY1JTV/ouUDhi5XTriJ19gQi4EOUKiYVPXH4UC6zgw0TREzN5/1UBuMXAXOlFLSy
	yARAtdIYr1XvPTv1IIAcIqDJAuUmGLB6TfhvjHwr0PaB4tQvnKIXIUlvUy48soxb8yhIX/MF46h
	LYb/giyocrtAK2jnpqvjNxYjp1fn02ttAOxaX0V+7H/6IAd4IOn0VzgmUTppX/y+2e0qqFvdzC0
	gQCqCruItRprRFvpRGEQB3Dd3MjWp8EUBulppitoDFVn8z7urgFMX2usnZV8M3W0xrYJLrLLeF5
	fCV9FSlveT6pGfNnxdCREEdqsV1JGlod/NfyAgvPdTJh8QADQY4ZPb+jImhVZWGLc8Fs2MQXhPY
	LqPkTJags1wY8JGQW4EfLzp7O6omBsb7YxaDWTcjQOvzmwguC4QExz3c9Azk/OeOI4Hb0GmB48L
	/y1xAXVloiSpWpryxLYmZe4f1Qahj28P3QHIhFGe7tfPStoMTTXy7Lqu7hPvF3e9s5tcQ+naAaS
	gmXHZINc=
X-Received: by 2002:a05:7300:430a:b0:382:7375:1306 with SMTP id 5a478bee46e88-3856fc603eemr27572642eec.14.1795669175490;
        Wed, 25 Nov 2026 20:59:35 -0800 (PST)
Received: from Sobhana.localdomain ([152.59.222.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54800362eec.7.2026.11.25.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:35 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 26 Nov 2026 04:58:12 +0000
Subject: [PATCH RESEND v15 7/8] dt-bindings: cpufreq: qcom-hw: Document
 SM7250 cpufreq hardware
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
Message-Id: <20261126-sm7250-v15-7-492014ec0a52@gmail.com>
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
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795669088; l=1157;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=tYOW7ZwAVWXKL25nNQ4vkjon/atY4Dhfdawj8MhM0Nc=;
 b=8XP+FxMcNtFvSYN8lg3S9ocnbk4kDsIE+kYG7fw3nlTEyPSnWVN5CZnQShpMnN17s5A1283xW
 e+Hz0YVjyQNCExYfLFHhn0nc2qpGwYHJGGrY6U07WfxPHY8D44hRghs
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the cpufreq hardware on the SM7250 SoC.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..f8cdb652f 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
@@ -201,6 +202,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
     then:
       properties:

-- 
2.43.0

