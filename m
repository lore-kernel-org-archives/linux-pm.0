Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807308;
	b=Drlq3TilblOVEVE5a8QAsPU+fNON1zUVAA4YByAKzrwSecX62P8wx3A20nPfmM5JIzD3
	 9V+4aIbPc4r8qFUq+nQUgWh6WbTsMSg2oScpNCmUf778z/7uHrm42nCUwlrZjLIxKpEqY
	 xYUCk2hEqu8uDgJdxazowq28Je8p2PMH09b7j0EjtIIxSuVul+W78qM3TlRQsdkU64r9r
	 7ta76j9tzm6/GN3AF2y4IWavdMjuvXc7PrtbPeZOXxd1Rz2mD0Qb1uylGO9QzfH/WVbLe
	 28QV392E+6vb23XYX1xXjQUIaEh/mEM2hrhfDdW5txSHgNn1mpEzVktraCaMtGP94eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
	b=XRM6UZhRRgrbBjhDwKrvMDlFAANcVkVZ/rWNxRA9JlaxQNxQdvt5bCDD2axt0zaq51f6
	 rE2uvn3IA8lh72GY9lmbYNJHWzTVqqzCZZV+wvP9wgGMbF0bHLlJ753LJVxX+hBYjYd0O
	 VMb04SQyHPvtBqaWi7NESgt6Th0/vAgaO/hUFVoWXctqRMkTvyg4mzn1UJr/vHOg2WxPM
	 Gct75EmKRI/mDqAQfjGWfJ2LYFqr3HALawYDp4Mw0W3E/Ff2iI2ssFpRlAizUUoRaOzrA
	 wFMydsdmCw3Zsoo6b4oCi1GDmzwT+PxL4jc7awCHb41zQJzI/h4EAE8AtSYi0601IWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gtmcJfzq;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58F606A323
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA58F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gtmcJfzq
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so4836072c88.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807307; x=1795412107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=gtmcJfzqFlYh9d0VyRYPkwL85gT8VgY6z67ijGu0jwBTfoh7XzAVMXNXtbceVD7vBK
         f/LFyzuhqMPw4pUswhDVWBTqw5YAktZY95axELCGP4ZJfLye3mbWg5PqX14PvIfPXvFD
         jifUYkREMx9ZUNpGakCHIaadFE3zXgmzrZ7cbIY8OJpF2ivHHcKk9xQ0YV24MUePsMW3
         T/PAG/AnY0bCp/qwlfZoGiCYv0exUXKlbnNLJpEhnGniPB+aIcHv9/sVgWo/4jL26N2Q
         sr4YXYbzvWguag/oMlcsj1W3t89G3muDcdGN9bywCRTIqdRkp7RJUsRbNEOtlHmxO7l2
         3mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807307; x=1795412107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0rPbDJDlkerZ4MNM0EC/3GcwzUG+YsiEl+gjmvqeKs=;
        b=W8eWmnmcCBLZtlbsQEKAacJbT6w8N4FiUr5I8m09ksrpTYWs9mFVvBNiZVmyNjcJF2
         j3P7lO6klNmnndnkyV6IdAoswu4hlmMqi+UE5E521K7ZOWZZ5XzlNyuBe+8XSePFTv1z
         nobzVXprH7vY6DwxbFlQzT1yR+qV74sWLxeveebQvOfs1DHp0mLYldPiZ5hnCL1Tkyq4
         PYJ+3VmYVRg3h7YZzlQRG1VAR0Y3ibYIIsHW1qXbm3GGgK4+9IRG18RGJbihD2pjXzkl
         mywWTUfuO2aj8G2AQQs9tj3LrKC8GwXyjgTreXhwQHoLYkKt3Z64eWm5A6S8MZwb8EeZ
         /crQ==
X-Forwarded-Encrypted: i=1; AL+hErHo+5HImrk5neol6+jdX/8yLXLnq5REK1B/3W/16dQmtAZcSeFD0/tu7a9AA+ibuOZ2wNebEpu6bA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/SrQM6FK4+9y6TXaQ/6fhVQONe0Z4ICk2EOxKhbwCJwyHXVRe0
	q9HIMBuB9k/SiVzsXnLjecY3OTRPl54w87EmxjyPUSow0Ou7yd/DWzzT
X-Gm-Gg: AYBFou1b8rJ/VlCL/d4bgftaokzYq5Dx8E4aMrB1QeqaKJK5p1QkYUz6rRHbL7ZDxrU
	XmrwBRDH3QiB1MKSg1HjFqDztw5F3wKDWtAiSS9ROPXNKdOJYVueY4LMR2CMuT02NrZLWHP86zp
	3Dm9mvYv/989czoIWaybxH/80p9HaacC4OcuDrYyGZn482kQXgLokJy7MnfpAyzyNPT+jL0g4OS
	LaxXF4N1Gq237eleECRN667WYLro1ZAcnN2FfGaNuUwQwglyMfdaPMLid+LvRCR2Bbuf6Bbe/uD
	bM2CY85yahsp7GPWYV7eR1vELashjVL5FBZdTdUWApSiMc0VMoqTiSXuLs4qPWgS4hYk+KZZ5d0
	/qMYFeaAwjPfgL+XP9r1Xy0oYl461heY/cSAqp7y7Tr4GXWd49SyzLvTEyNw66suYr4+JWge7lY
	brN2rMN0GwftGWSByrD/l11z8moC4WgzrypZKrIBWA+7eczIKgojk8cciYCM0hQMCE7GHQYDytH
	2cVJvEu5SRu0b3mHpwrcdr/nT33xif6HbN21TZpDABC2ZiYA2cC5MiZia+hbubvbJgcdBzt7kDA
	nKF/m7hSN43Z2vXcB3AzOD3rg39g26rRTsqIimFy8Xl4fY05yMoVFTovGZSWmXiEA6RZ6d0VCPd
	IMEpW
X-Received: by 2002:a05:701a:cccc:20b0:1b5:32d7:7d73 with SMTP id a92af1059eb24-1b532d780bbmr1029121c88.30.1794807306985;
        Sun, 15 Nov 2026 21:35:06 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.206.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm33463380c88.5.2026.11.15.21.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:35:06 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 16 Nov 2026 05:33:51 +0000
Subject: [PATCH v15 7/8] dt-bindings: cpufreq: qcom-hw: Document SM7250
 cpufreq hardware
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
Message-Id: <20261116-sm7250-v15-7-6acbb232fef8@gmail.com>
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
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794807229; l=1157;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=tYOW7ZwAVWXKL25nNQ4vkjon/atY4Dhfdawj8MhM0Nc=;
 b=hoggoWb5jYIyIe6oCAJ+uw0gr7l4FQRLq2gxxhWWrRSTin9c8YLMUPS0qAHLKvjnJhZnO3guj
 zwZPzqxzYjzAoNywaOEbGWxmFGqS3ST3v5/P7mGL67kEI0MsM+mhyK6
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

