Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA91E5B9F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041663; cv=none; b=mD5l8Mt7p1u4I4sajFy3tF4CWD07gp9DivzVgFEQ4KU0jDAgpQsXv97x4Y6ad6OAjIwBcYEhqFGnDucUsEAscEwGqIQG+8z0iItw1G/LprrO9XpU4cRWCALSXVURUO+W8dCieiHAXSA+amyuh99iYztRY9lbNsrf2uthg6nOBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041663; c=relaxed/simple;
	bh=0S9ZiRaNeD0ONuhBWck3LZ15qfVQqVd9GHb68v++sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHqiku1GmA0VCeYK0UxKcHKk04UL+VsufeHvPtaH3MTY84RuPsjJTk5UqJ60O5Nj/w5sdSn7/jh0JxpYL72ebIwhrllAJbfEU94xTYVBP8iQriKj85UXsYltKQWMejbr8Q+xH+JufzVpzzadVuNNme7+JPJnT3wRQW63L1i99X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOKD6Gr6; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOKD6Gr6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3035023eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792041661; x=1792646461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=rOKD6Gr6B9cKASFZKkpoO0knCcBMFoWivRGhQI7EMtT8PxvUVMicfWU8FeuERHfksr
         kV5mJ+lTv/QK8zY0G5af5Hqkk3iF4zLNQPhMszW2fzmyMohgZJUfWMPLOHlBNqBOsfV1
         4GdMjJgi4m+21sN5VZhtDSjzn2e27MQQpLaAo/eKvmWOdiVKplmiWGdrbQl4NpLAYmWO
         NAdqyUx7gk+l566C1UHDVXld6+IcdrBSYBTnBuHRqoF5Gp+2/k6mC5SDmAwEevvF0ZFm
         JEsBFUwYTm4CKD845YV8BSpMYj+9wQpxlY70v7Mi2/1hJxR6oEkeqwY5076k9N+Zjuao
         YTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041661; x=1792646461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=08cAPjCBuep1xfeFrUfSk9yaLkdfPOpwScs/hatixcrU2nVh1tr4u+3QKWKSyE7l5S
         9hqFgYzOvYKhpaPxs2Zit6Pm6eiSjoedLTTvJ3bh++cxAcWpeo5N9jmXOcMm+/Q4CTPB
         JhIc/Wi/tsrDFHeKnZFcSgCCzHdcA6AbUI21INridYO7Y9+2DgdVt3hFnoVEzA1aVUX2
         MEw0sUaPxUgVDNZMDKb6Jkb6sTTpb1UBAmPRLfRLX69fCgyMHPyXTwqLjn1L6ZkAq6Wi
         qL9xbkiApCAqKgRVtJKOhW7Q2UTP7qKGM7J0LBuodrrhMhBFSVz6Nid2hNZ0Hsy/QT5M
         8R+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIY2RVJKla4FpOQ6OFrcVayEF4vNyiHwOMjeX/FrVgkPJtUNjgAOZF7PNdj1dMdHASFHYyKfx6Cw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKeC4vYN2SEOx2bn9IheRMXvLKOVTQEduKH4EefX6sJpnHfVjUc
	zg1Izb8Rcam6324kESjK9P15jyvBmshPS+wiuwEzLsfTDAonxM1iDu1r
X-Gm-Gg: AYBFou0nvQc2XWDL6q9Y6ZSAKiQhQSfMRPnWh1VQMBVyw5HT1kFfPyV5CW/6yXwPJum
	1bCc4VdbitqqkE3XqrpZ9geD2V+QXNwZTFsLqIBrLBmB+9ss/ZtpieaQj5FB6twel6F/FRtoVvy
	HLAzNrVZqf/n4xkJzjS0x+Ipn1VVCIzI47r6a0RGLEgDjXdqmcq+IXmkJUwODWR7s7TS14K/YQk
	N9EVwF28KbnVkn8fkaPshIQucUclIL+1/N0PnF/MDgxBj0tn4x/9MvWvysNaiMEgIDrOCY745Aq
	Pfpf848B+/1yYA2WwrFpcpgJqDxnwEvWt8MSH3SRp8+4xfJknkGu+KEsvA8YQtjmwd/Hc/eVg0T
	O3+8uRKNyCAOTmNtQ7LgBGcuJwyGOMDYFBMPAAJGW1nKCLOSqYo7Ac5ur0HrvFu7K6+oNA6h+st
	HmsLJ0eBCE/p2RIchMYnTBLxfwYEEU3DHVOODltvuW8DAjfMg4PxKUiy4rutNzT1cb03aXfaIwC
	Q2c/qPJKev+5DwvtHxX8ft5BnYfSkL0jwrheYMaaPyUZfJ/J2twtJQ=
X-Received: by 2002:a05:7300:e5c2:b0:355:cd68:6f03 with SMTP id 5a478bee46e88-355cd687760mr24635134eec.33.1792041660810;
        Wed, 14 Oct 2026 22:21:00 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35de709d928sm12923112eec.25.2026.10.14.22.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:21:00 -0700 (PDT)
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
	tglx@kernel.org
Cc: radu@rendec.net,
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
Subject: [PATCH v10 5/6] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Thu, 15 Oct 2026 05:19:25 +0000
Message-ID: <20261015051926.13752-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015051926.13752-1-sreeshankar0910@gmail.com>
References: <20261015051926.13752-1-sreeshankar0910@gmail.com>
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

