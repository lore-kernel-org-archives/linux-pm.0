Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80B47B436
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254827; cv=none; b=K3CeyKboEuSHHF0U/lbu/3K/isP8uXUeg1i8bb6anveUs+JsS39SKNG79xsIiz8kZ5meDwuBEfJ3bDJAWVhljmAKFRdYhA0Ih8nrFhh+iOXWn1H2M5UJHFUiYpjwq3FNsPaEW+X90YGc33tkISfwyeN/bPzgvpZoeXKjVpxld/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254827; c=relaxed/simple;
	bh=0S9ZiRaNeD0ONuhBWck3LZ15qfVQqVd9GHb68v++sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5bsHo/fARGj67pEIrlDZZ4OIHeGhSzOt90VRqXleDouKfJiVa5rrUQ0YU7zcf82QSqOKJTqMQjN8XVFHM0HO9WVGNYYaTCOqA400olweKd+xOJAxC3WJdEFAg2WfsZ114s2OTPWvnPIyJec9otFDogvv5RYzYLkaTrOwK/4Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4RabrIH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4RabrIH"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso1038285a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254823; x=1788859623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=j4RabrIHhYV1Ub35pUQn41n1e6SX+9SUSz3Dmaqb7/V9p/jlYlcdOGlG8r+VYxK33W
         CqMcMhm6r20R2s/3Xdz92Or4lYLEAvH89AQmsSo0R++pl9FUppc5O8IEcsUy5Vr9Y2P1
         grDHpRYBT35lLiNAlwNI6REnAmY1Pa3YO0XzimZcUDJ57jjSfv6veYrlCJy3xYRZarrs
         rVFv7sX9Pix99fzmQNx0U8Vr7FivCzEjFj1auQsWcK+WRr+vkgjpS5/M8TMbO7rZHGAo
         gPHk0qzWrj/M165K1qo0UG/VzVVt/jqBhVJ1CNTY1o51lj1zymxwUqPHYzJDh5JR240h
         re6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254823; x=1788859623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=XzzAoiQgYbYFn0byycegRNsNu1CU0vr6LEJI4gYsh3OgdD6Z770DpIN2iVpZy/UuJi
         7hJBzKRwpAcuWMwsZ2o2j/a16QNCj4Y1vpSiOi3Qa97xcXSHFj6ScZhIHLoisrLYqAkT
         1lnxKhwJ2zYXTySdd9pVZtoqtQyM/xuCAINzTGI0w9KlyMdfd3qrnhrspE7QRq9yY7nc
         XavwJvdhmJwsHRRCHMQ7uWtwUwOgk7vo2o+hUDip88hXTpRqkMtacpzZorKRdIdHET3p
         Cu9s3saNzEsbkSlvsvknDoUVbelz6mRiE0Kc3/AYRkeifqceD7u+YmtgC1SZwuFrX42Q
         5VbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3D7CQxuv4h3IamU21UkOQZnxa+6FPl7M552W1HuoDw+HCTbkblApvIckZCLZBjBV/OSwJaOFAkw==@vger.kernel.org
X-Gm-Message-State: AFuF++lzAOGfeX4rc/arHWt+4Q7ahzSLO2hssFmw/f+CIwB+1Eo/kVAb
	n3cIza5w4v8AA7DN/fdV1Z09ooNxFVg/6q260djBa9HcXiEg20HDQz0y
X-Gm-Gg: AR+sD13qrLjuGPZBmCM1fvNEgX0WwtgPFP8TFi9jjONAjndWgh5EY2KJkUTzeXl7FSZ
	E2/1g+WFtjGG7K8e/2euzoZm1xvzhPMvLgQOPyRAnIo/7IBekDb+G3QajHAvOqNM7Q0l2fUMcDT
	hPIGAlVieHlI7+XvorjZVpGP85A3ZFeByYdd7FfByJhS1cvE+UuiFHa9vLDC3fkQhcbeohfdvW1
	XXKQwCtJvm8Vhrm7lextaHFHaBMImCuGB7t+PWKYc44qVxZgdk3zxLBxxGq8Kl9FhlShwS9zHpq
	Tc9MEnMfCab4OkGqEP+GbutuLp5ibkO/pkq7H9KB6rLCNrarj+oQLctYcUTcbXyZgZNUK4LTlah
	EXzhp6q0nGMFx0AFLOeGZDxTSISQwRxOQLV+5Foh4IL+dtXBvBMf6eos5gH0945Gf3Ms5aeuOTe
	mEwP6wYNK6d/HMAOMkGSOrCdy30aW8tG3eLZtRVJDa523Q285nhd/uCAP4UIXaeY4jyqsh0xwQ4
	aWnyToQmVdm
X-Received: by 2002:a05:6a21:7a97:b0:3c4:2b8b:e88f with SMTP id adf61e73a8af0-3d7ad992574mr11465441637.5.1788254823231;
        Tue, 01 Sep 2026 02:27:03 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:27:02 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 11/12] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Tue,  1 Sep 2026 09:24:46 +0000
Message-ID: <20260901092447.3028-12-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..2dc2c265c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
-- 
2.43.0

