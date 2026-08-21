Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351242CB05
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326906; cv=none; b=hrnLCRQNcyUwf9QbjsR5p8ewdgR0j7MY08BZhSYJywxzXczwmmDQVjmHhS0Q3lmANy/HX5W6m5MBYfOBTvLLaQEmEbg/SnGPypuEKBrG32urFA7kWbL26c6lIlTMlr3niS8qrTyXnufZfi3q+yauWzzkQM6s0u0YdzACtujMaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326906; c=relaxed/simple;
	bh=KyU8fbc7e+jGln1gvgBbCQwRZ+9nqq3IhPL/wCHuXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGgdqdEfCVdIUp4H1QcIdeEBnlg25XX9GXnyQp+l2PKfUlFl/8Vnj/boTC2YfUgzigp6OrSnH/ZIBz6M1wwaImdo2kzY4osFHCdDhb7mixqVfGNZNAZtO/BkpUiu2YIarTwZAwMhMHrZgWWP1QE92AeJOe4ngGdJUg1ugSB8fFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfZa8lZ9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfZa8lZ9"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1484766a12.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326904; x=1787931704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=IfZa8lZ9PycC8jSoR907fRDQyTjFQABCttu0WhztUQRphxNWZDMAdIOyAqHrQOeG7s
         nK10sco6LjDjLW+wLXVtq3xUT9PVqP1jVxakBHusUZYw604X16/AWU0Y8RIeXhOFPZd7
         minTh2fHdu+Urgg7Tuqz9+qDkcLv6mHUVnv1PQwDxKUtgiEZUZ/V4nH/UaUSHH9Te6Cy
         znUEocWz0fc/4TvIvP+yfhXKi/IpuAM5d+rIIxnCLXmRaq+961QqQmrIBRjU43C/JUNT
         HH56wz/VLQi0hV4xUcXSuE1CoXpTgBIJe3O9jHZ1s5/ihuDOXGETpQMvJT2lWwHkIJ5A
         92mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326904; x=1787931704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=EPxw6uUAepttx7cYNTR9qd23SD1pVFnoYpFudBMd6rCr3cHEKl/Smw5h1AVC0AxR7m
         IsdtXrQSkGHH0smgAID0/wDFzWkEV7Z0z0C/L2YFpsfNY0UQyY0FskU9hUpDvzTWG7+u
         DXLyTNivIdER5CEwdD6HeunXTm7EFrI6Fv0/S0cv4yMpDd3lFcl+X8CpYuymjXuBRMyB
         WiSuBC9yaEehdSIBTGCxCfP1LXzTNeyIrSajEFnMJ3PBYf6zYKWXn+xl50Ll/RX3XVwN
         ljdJPebZpvj5BJE0Sj3IjRgPgCi/EGNH+ELk/D1tejLbabcpv4WFnWWE5UTHLbCsgGUr
         cSfg==
X-Forwarded-Encrypted: i=1; AHgh+RrxhOx3VOUlA8OtmqeQdKMheP4LcSKwKmqeC4egcKTByf+MhckRaeCVAbzszDtjcqgeQnriIzuMHA==@vger.kernel.org
X-Gm-Message-State: AFuF++mYh1WkbGK9js06qCNmAn2pl6d1qTbndDLIGsxqQXGDczioPNUT
	j8taFhX2Azy3BDSmaV/ykxDmLdOyzdAnrg+1QZffIsngK0s9I0zwyOLT
X-Gm-Gg: AR+sD13pacC7nSaXlCXx4WOsIT55jF01gaSuDRWKs69CL2WJRnCxKUarNx9ZygkJ7dy
	92tYPrWfZfxZtjbwy8gRlgejo8OE+rMgbo6w6q2lHOyIiIIG4BgvKKic2IfeMoPBBc7kfm09/5L
	pK/MvcrHH7HkoRfacWVW4wdr5HIdueVFCD9Avp7t4VKjP33xVop8gn4bkz7beQ1uAmNCG6xJkXC
	pMfpJ95zU2T0O6uMei21vST1HbBlzhGubLnI03Q7GZNlsm/Ymr3ncuuK1uR96cGcfbuZxWNqwKz
	+k3PJo1wnOxWoV8xh6QxzKjGOVLTug191xH3eXHFx3oXt+fs+V76y7jyN7kuz/7qFtwZu7+VmEm
	6TKKosYvo1YrnspvRFIsLKQYYCsnb4DyeJxC2W4GNEbFsjJflM1xTqbu+JCmaTGa5hhxVyG9db0
	In9z2nJtwuuuXl42a7cYCH1HPghz5MBN90T7AUS+Xbj4uGP033k3748yjfHOnd2e4E4W0i/4AGs
	O0e/d1Z31Fn
X-Received: by 2002:a17:90b:3902:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-395a04ea8f7mr17227356a91.8.1787326904238;
        Fri, 21 Aug 2026 08:41:44 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:41:43 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 05/13] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Fri, 21 Aug 2026 15:40:22 +0000
Message-ID: <20260821154030.2514-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document RPMHCC compatible for clock rpmh driver on Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index d344b3386..df9e37f90 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -38,6 +38,7 @@ properties:
       - qcom,sdx75-rpmh-clk
       - qcom,sm4450-rpmh-clk
       - qcom,sm6350-rpmh-clk
+      - qcom,sm7250-rpmh-clk
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
       - qcom,sm8350-rpmh-clk
-- 
2.43.0

