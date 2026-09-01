Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8819309EE2
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245077; cv=none; b=Eb+lzhLVZwWuqlnrRaqasJdELkraKv3O4f2FoYdysIC/PADHd1hf/sFRoi4J7p6qfBT/XU2crVpbD7fPO9FLgOPxkZxsMdIHifutUUTKZZse3TBcWeR4tswVDpokD3Kuv55W5xRkapzeq67bS0eGIaSRrulO65zLZXVsOGiBa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245077; c=relaxed/simple;
	bh=LO0HNWJQ2iffOvEO/jDwBG49x7KRRSW4adIk00h3Zhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+wF1AlSYYD6T82QZjcrYUfF2E6asH5fGbM3HJdGwMzeiXDv7Kxz1SpxGU8SVajcnC7TqSzQThXCWvJJVi2YcrSmzVCjZeowvykw4fhvx0iWR7XTnvuokkitSGZOY8ZrCHxmcaYC9SS2JG0mnsVzLyznGSb/lYYCLAtgXUJc9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuoLZkhX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuoLZkhX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-853c07a76adso4618489b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245074; x=1788849874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=kuoLZkhX0FoMYc4suTNrfEeEZbvOSZehTD2Hk5H6lbITmNxG2Qg7Udeg7xHCVzDJ4F
         j+NXxhuW9NoAGYC7DwPJqTESYk2a2dUJ3VVoluJDIF+SPCx21zyL1Yln3pwo8+W7K5Vb
         9AYP0tT+2J4T3tNGIonZ1s1TSCbTpRF12LeAHEmqM4zBNOWDFxt51MdgaKxdQK3nv7Ez
         LExnTlHQoNm9uuVxpZ1GJXNIFF+pcbleJwW77QNY7jXkakx5kp0k5SGIR0FxoImTgifm
         eFdCfLla9FEejyiHwutSw+amQzHXOvhGbJJyBAec2jZNMdaDx0Odb+ypba0aXJpczh//
         1n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245074; x=1788849874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=nE0oB6i+KH/7oJGWAjtp6mlwKaVAMJZBfzTcqNLT17fpwxC25Re6WZi8sPN2PzvUWJ
         v6+E5b+yzpo4BpUFR3krEvM7S69x7pY5MdbwEeeFiC+XrUdQvmyOipNroaa9bYRYa6lx
         KPrv18RtwT3cNfArliXZwqiYQrCtZ2gqKttWHS21iFmPM+7H4oBjzoiv7VN34382yHvK
         RRp3i3G8dg65hhp+W9D+mZUdj773oCf/bXLAuN8O1Dx0g1CvkyxNo4GctdOMkzevR0nc
         q7MtjuiPPMQRHb4CUPGgAfk3W1+/oOzwJy/QWZf1u+bL8hXyPVg6z66KVX8YYoTjsH2V
         pPPg==
X-Forwarded-Encrypted: i=1; AHgh+Rrx5RA2eQ/UTz8hf9WQLpmujdsVsqDe21Cidr6j0C2t3vCzerzxBB+EHhU8TGBedMZgQwR3kwPAtA==@vger.kernel.org
X-Gm-Message-State: AFuF++mIMoohDRXYvgz3O11a8HWmB/5AF9v6iEUVQgr8zO4Cv6e1WH/b
	sjF51afpER1b12n7x3y32B4kTuR6oAPIjiFKhCCsvF+6lt5LYp3vcjOY
X-Gm-Gg: AR+sD13pBpWbdMdmN98DDI5gehr4KasnsS16JodZle06P1jESBUS7nVdfubhAXgPFsq
	dUTFPj7ksErs3nIUD1NPWEh0OuEI9mw7JF52aAUUdc0aRFyrlQaNc77/FB2Gf2RvGpON243n9Ci
	/bnKQpWPMYO/WVVeg/EbcuSts+PNI1MF7h+dVsM7iTFOIuY5k5eXXgjoq/j6bgk2ewIyMN+Cphm
	m0ofxGdxUxRn3b6jIlNUKsUWzAUwCHu1E21ArpV6UjEtWmy49BV5W77Y4+pFDHoERn7Cpsz5Fb/
	s5bzTjCgH/BUrcm9JR3VrpHyvqJ79UZAdJXj6zoLUmxuMegvH1BG9JL6iq0PbJ5aGIkF7Rks/qT
	Ks7ol/TCerU94UlGfAyIZgjXq0ziVZshnnRHNYnNv34ZYQKw7r/CC6zAjXlEywRsYhsxEpiXr5o
	8uzudIIvOMZFhml6pDp1jj//tIRI4kadH/zlW7FhbrmILwuQl/LfBLoGjUhjNfI8pQwequI/GI2
	zX4g88HYuC5LXAbBqtHkyqO
X-Received: by 2002:a05:6a21:b8f:b0:3d1:54ef:e8e4 with SMTP id adf61e73a8af0-3d2688bd7cemr51274908637.17.1788245074075;
        Mon, 31 Aug 2026 23:44:34 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm37019784eec.27.2026.08.31.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:44:33 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 01/12] dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
Date: Tue,  1 Sep 2026 06:43:46 +0000
Message-ID: <20260901064357.20055-2-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901064357.20055-1-sreeshankar0910@gmail.com>
References: <20260901064357.20055-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID for the Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 2cf433f61..b63e4a0b8 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -209,6 +209,7 @@
 #define QCOM_ID_IPQ8172			397
 #define QCOM_ID_IPQ8173			398
 #define QCOM_ID_IPQ8174			399
+#define QCOM_ID_SM7250			400
 #define QCOM_ID_IPQ6018			402
 #define QCOM_ID_IPQ6028			403
 #define QCOM_ID_SDM429W			416
-- 
2.43.0

