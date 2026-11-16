Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864316;
	b=dm4U4obtet/qwSo80VbmkTYe3uswYXmZvdu9kGBfoikmz45odb+rh4/PAPvxyx7WyENS
	 zUgAxr/SN2gGV0DzpG1f9C3buMC6P1xCxigiHWoBjlpf97JX+/MMY8zjaYKxn6x6hBHzl
	 0EcSgzXEi+Q0/ZeurzbLC6heWvjjAOIq6Ck8UW1dwh+Ut5ajpQe8JycMy/4yTIPh64ZLH
	 dPZblxjzg1veBFySxd7KdBiGaLN+alzwXwRcP5YL1tHi962VYlxxbjPablHA4O4C+VX7H
	 PasvEFfzpLMFF7JgdSEeigkWYqng3UYb8wBpDTP6v0qwO6EChUSVhLE96MoEasDetbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=sqWf0ZqjfW7jYj0FTgNGieSVB4q6BkczPYaUBzocbio=;
	b=Wsos1EGyHiaeLyvXc1dbp+cuCLQspj8GLIHT5U0UWDg0vYz+gGo928HWsAeXOWYxfcPL
	 9rXX/QBjqgFAN4sjr+Yj/7qLiadw4hAsQkLB6tpe6OmzeOX9NhgJhXOwJ9/1MZC+jCjtP
	 2fC3yi2dtX1HUktqUjEGZMavtz3gEuK2JbY4/BEEOtAgHdBzw5fpBUb36FTrIIN7YsdAI
	 rua4IyBKg1Xn9BSXQB9A3GUpU2cK+AoUaHS3U3FrLkwvUMLFymnnOeG09sS7FXQlKQI6Y
	 ivkUJHm6etE8ClOLXnDQcxhqYIsOuuEmaCXbKei2ukt7amytqCtHYTNjzvHDw75swYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iseyRQOE;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9719606A336
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9719606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iseyRQOE
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso27214515e9.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864314; x=1795469114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sqWf0ZqjfW7jYj0FTgNGieSVB4q6BkczPYaUBzocbio=;
        b=iseyRQOE/E32bBmFMCAGUZXSR/qaLS4KuLAqOaM+SdB1JDnfrcopkhfWQ8b3jLTZCD
         qnnDF/TT02D8xCrqB4uYGpagOG6wlWE4ePRpg8iEyCytXx0rLcuO5fHP96J6BIpDA9gk
         iLegNl1FcpOeWC+AHGYP8S/mBYbuBSsoLoq1b7+0p3YSyh7zfJ3Gh365uu37gQWPYdx9
         sRQ1K/GlWzE328os4/xKBsZiUoCzRXcrQhKQfvT+wt8D9oV1SyfpnJHrxcPhviF8ImRF
         nq1pKotED9Wn0jay0acJ9SaPH1qUzXlfvAzx6TQMAmwR2F+FrUQxqO1IV8FBYfMkmPfX
         W99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864314; x=1795469114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqWf0ZqjfW7jYj0FTgNGieSVB4q6BkczPYaUBzocbio=;
        b=lZBkAHLhGoKhwsSd3+Kyn5k7IQ6VPA8cIW5OTP75/YFEEbRlr2coWE9K/eGv6hcSBf
         AZDWLI/bgrYCy0zA/JpXs2C1CjuYdyKUG9VPI20Emm3beXkLLHJ2Np2iAwCPu0xAjcpx
         Zu6EIh+Av/L2arn4y2plk/j1ZNHP96EK+La3mpECZ5eWhkglkw+u4ReiJxp35ITmwmwH
         qtIakCYpKaN5JQGSFbpdVD8N4M8HBzEZsP7q0RgR9aqJRa5vuDhs2HrBg1lTFaI8dru6
         1uZflkwBgNymDfeKT86JcTRhw0Ieup5ADqIMwhMuYWgRWoQCXrBatayM+FkSnylRbDeM
         nwfw==
X-Forwarded-Encrypted: i=1; AL+hErFaTF+XUmRbCqyUmiLz/e76OPAxD8vNpabWbAyRgae0MVUl7iKtkVYCShgXTiVE8c4PpHVGVWDDZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XIQNJagTQG7nDRs4fl2IydUOGMT5ukmWThj6r9N7BuSoQRp8W
	qX3vViGiDKFkNdQRqpAW8+4DV9KWD7lvOlv63OUaIy+n+bv66HRVtXeJ
X-Gm-Gg: AYBFou3SaO2LekgKfb9uhodN9HwavTtMWKzvGIaSEX3a6N9ApTdgPsXdXr2RFv6X/5y
	0XA1hwJ7nQGT9Pi4LQf7SiNuOpl/69618uFCQIc0zXegPGoWcuOtyFY71pjonHlyIlikkxoVs9U
	TQRBrqnBnwz1oNfef/teav0fkcpA16VAgF1j2T0gT72gGleEY9gpULhAb8EfrLx/DKSShGydyy2
	IefDpgFQ0U5QvjxvKBCywVyD66cW/h7eAjATzOMub+ofIJf0G+hV7AeqUXZKhnTgZT7GK7OOhYc
	+SqUq1fjsavW+2ii5jeM0g8ofgJ+pQC4GFTwewLrdj3aNvzSc/RNYYCjdFym0I+iBABywRtHwid
	62eJZr56fHUSlPdGWaLh5jM5IKeDBY43tJ1BmycEtY264N4BZVw2zJGQBfAcTspSanqcamfBadJ
	IJ+NcGezKsmdTAWVxQCHphH+weOhJ5kiuNVyN17eFiqPlhzfHbVewQUgQoZWDq6PtRjOna38Tfh
	eMLJ6O+fULM015IMYEpMsFbzlBTqIGeS0x7Rm1ZxCE9l827BDIoqYPHGKY/hND1QstXYvnXuq4F
	whzDgQTHbqAZm1rAqT6jlFk/fQVSRs+mDxmMbDE5HZt8NAx/tgoS5WqRlH4mMQ==
X-Received: by 2002:a05:600c:4e88:b0:4bb:7033:c936 with SMTP id 5b1f17b1804b1-4bb7033cd72mr93163065e9.24.1794864314291;
        Mon, 16 Nov 2026 13:25:14 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783854cesm26340475e9.1.2026.11.16.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:25:13 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:25:06 +0000
Subject: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-hw: Document Halliday
 CPUFREQ hardware
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
Message-Id: <20261116-halliday-cpufreq-v2-1-e518cc055457@gmail.com>
References: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
In-Reply-To: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864310; l=1136;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=/5q7xJNdAtVYNP2eKqnOFRxkwGs69ZAxtJgwpCpPYPc=;
 b=Nu0RqZZ5Ivs9eeDLVKmj50eQ2veH0BxWIj/S/nAk4YibWF4bJq1xDQ9cK7u9JqZQViYI1Hn/b
 VTSNe8I5N9lCjoKUbRO4u4YsnoQGGy5myEbsLjX4rzZ50PPP5EVJWt+
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the CPUFREQ hardware (EPSS) on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff172..d6040cd293f9 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -36,6 +36,7 @@ properties:
         items:
           - enum:
               - qcom,eliza-cpufreq-epss
+              - qcom,halliday-cpufreq-epss
               - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
@@ -135,6 +136,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-cpufreq-epss
               - qcom,qcs615-cpufreq-hw
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss

-- 
2.55.0

