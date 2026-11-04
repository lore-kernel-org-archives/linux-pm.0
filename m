Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810874;
	b=kn7G/apY/yfGn5kn8nJSlTR/xqvGYGowJbjl7vFpjxnNtGVNbxp1YFvQ1yvXkQdVZafX
	 q7XQbSUtyvicfsHCvNZmH9yBrsEk637FbBLqsSjjCv+Aj2CUCUyA5Vxz0XY5v4WlaAdVR
	 k4Kybfi9tetFA57Y7sPVAGHTwMmLIroF1+OHRo9Dk2xL7bh0kr+KcgUtTW7viDd2fIKGH
	 vfdrFuoiDcRSmCGYj36GrHTcC3ld7O58e9Tqesq1DAnyf8GoVqIF2Sw6xKafDDKoJfBVh
	 RtMjCWZk+CB4EmePFgEF7oECRh91dtcRJ0gXHYn/TDQ8PHrXNwDcoi58ZlZES/bIaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
	b=w3qDkAPDl2yCo4cx4guUwW3BUzBgzVNviVRwG1f+/WYbxjKKd8lRXw6bgInSymqhkhfy
	 fLYI3/XE7pNHf4BjhtCJcpwyFKiOfTt+ze1+P7laxpzFoVv/5dpo7WnD0+mFYE5yRgCJk
	 y7eGoWOSsThKR0GXQSl2s6iha2oRNImrevN0FQnqa+k6p7zA7vBl/kBsIsnXU1EHJKsUi
	 gk1RkmGr/Y00Dek470Qii1hh0An0TCdarJREIiwf30u1HZNHAQZ2brKgs/qZguRhe4+6x
	 iAS4qYB3SYbCNFOtkfRkw1BXS6kWVr3py7PjdrrLDAvFYH+HWik4aLU/yZ3y4j1TZzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONOs4D47;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CF606D829
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 879CF606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONOs4D47
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so973826c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810874; x=1794415674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
        b=ONOs4D47G6dqE/Qb40F45Otu1UBvZCRCmCPEKocfpcbZqCvSNlBXHBerYhItVEIbmg
         Y7ZdBRreRAhQHcdUZammYaeLXW+7wCAsiMF5J0x3HDr8EhjSabCJsMdggUOVB8Haxe+p
         0I/cAqbuJ8N/5vS1lyvYAwDWXbQSP37AmbbAY+zjtnhCIu2M8IRYL2UdBwJlDC1junfb
         145qvg9naBCNpwwSGwnym+e9D5Q6yQltI+mH2d8EaSN/8kKa6arGcWXs9ogEmghvV/7a
         IPH6wseh/tHEGdw4uXSTm+9Qwu4t28Z+HtZ93qbIyJ7jua1SSc0KjmCL7sz4BhncdqjI
         MDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810874; x=1794415674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
        b=UtCRqRvKAxzTKuRUBEpjmtHQrc6Ll3RiFxCn/m6iNbWxfzvwni5jjnKNxVHFVi0XK1
         hvEUYVGoLszzbJS59uxVe2MwmoqoMP3/UlFgFmeG3ewCGtWoFZueuqIuQUn2NRuWdzxO
         be0l4VPYkE0xQCmWv+Aj5i5B8WDG4WRGf6/gkrh/UIlNYWfhojfz6/TOhfPICgr9JvVR
         icP2BOZJM/CKIC/YRFOlNK7Npa1FvUOiCtfJsSg2096ux7N9UtZwpwvUHD0NszJE7T/d
         UAjrD3aH7WVxq7casK12q3seRncNM60nX9sMEuJL3adFi2Qk0hu1S1sXzsw3hQOJUF1f
         CPUA==
X-Forwarded-Encrypted: i=1; AKwUvBwjPJE3u75Cu7FM8radYeU04r2ZUuJIlKehiX0qZesch8UBxiI8WK3BP6Uu3Pe7zRFjRDtL8RMCoA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tbTMD2sGN4QbV4NppsrldcZ9r9gjHZhZ4iaC3N4h5evSqjnKb
	wKRUGOVnrevK0bsamtDp3uxjA1PkvXW6AzRCjZvQv8dOTt9yzG4fJVGU
X-Gm-Gg: AYBFou2gqebmg/g9+hGYisQ8kdesJBM86dKwZRADZPUWTx0TENVDH7Qk6RbwxcbYhyp
	Cib8Z3D2Gp41ZfqYG4MJjITRlSYdXoWkkuVLzA/zW2NPWbes2BalM0DMSK5wm3WQXZCdz310Nc5
	5xC37LLxc9eu6+Dx0bg7tRU7tjs0q/Kpx+PiAJqWCnHxA307Ig6Koofy4Sev/l19GtBBvGngeek
	VyJHTHbTWtB9hXUa23TCs3qgfs19qd06Gq459EMPlFLxtFAx2IbRsbvV3TjvoDdBPhfji9SBua2
	P+B4antxlimtcG65CIWWkVrsEwwj49v1tCyss6burwDLKBM2H+dG4mNN4p5FgY8WvSMrq3wIR5G
	Wu+tWg+iX2PGuF83pckW2P9h2vyKxuVG2Vlyt4NnmFiopeQX+l+OGWXeMHZhfJiBzhMkvDeY1mW
	A+M807TxzsIkzVgRZHcnv1UegGPQrrPnCDuJrYVrgWEYJ6magNOfG6TzDiL+/ZOmgIHhhTRw5oI
	KfKsLpPW1CmPz4XhOp/oVsM15wgRIcUg0N9EgVwRdyv1B8qqqASRguyg5kWksVimpYQiDsc9WYy
	4Koxly0aHj9t5sA2EOaQgkrYSTGCF5CbIAxBbc63ibL2mG9vOpAVPB3h+U1J03Ya2RDhyljuYQ7
	uij4aYu8=
X-Received: by 2002:a05:7022:7e0c:b0:147:a685:9125 with SMTP id a92af1059eb24-1ac574556abmr25831860c88.2.1793810873589;
        Wed, 04 Nov 2026 08:47:53 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.207.207])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm10839666c88.18.2026.11.04.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:47:52 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 16:46:39 +0000
Subject: [PATCH v13 7/8] dt-bindings: cpufreq: qcom-hw: Document SM7250
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
Message-Id: <20261104-master-v13-7-355b65c6f764@gmail.com>
References: <20261104-master-v13-0-355b65c6f764@gmail.com>
In-Reply-To: <20261104-master-v13-0-355b65c6f764@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793810796; l=1157;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=C3ow+chGT1NNdSip5xA3Ydc5tLXGcOB+9coWbmZJeQY=;
 b=0gSOTjAaT57IzIzDs2ys8gXMuFwlQSYBUyrknvzdEMuCtxzuwu4EGZ2k7kNLvFUEfhKoPMpX7
 w7QqxqnrPSgCDIYxCy4duxqgXgLFgE4j4KOPpGEsEqWdkLXATzLOJPl
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

