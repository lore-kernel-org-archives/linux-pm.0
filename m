Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4743DDB18
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675379; cv=none; b=k5XAFMr/i1KYQGJYyxERk1wWwJcD+XXmXVd9AnmMsSM/4/fSelkgPpDd0nP99JWjjKS3vJMepespAt6WyRAzOEYB00ODsw62pRcbVjazwMkuON/lwmPQKs3G2tWft6lO153eUGzwQVi2vGoJgxq8L3CiOaQjGcORYC6hmQ2Pp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675379; c=relaxed/simple;
	bh=+1KKaNTX/P7/V53JMeGAGQ8XdMuCS7KUkR2X20QbUvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjmGbLJigufgpFz5aU2vCCV0bt6oqJ6NkUajVRlDTAuQYgeCaTds33uDVPJCVav/MOABbrTAYlnadsftPeF+DFfF1OqvcYpZdZtW7/hG0kKi1yr6CUvKAiGccaLos60dohtoJqSm780uvRBo1f/jnDEe5xpQJ6Vp/5Oz56p3akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ULUXSBda; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ULUXSBda"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15f6d667bcso98674366b.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1783675376; x=1784280176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqGhNzdohMFEPYe7rGIYSH65iapoiPfmEbyHAub7vT4=;
        b=ULUXSBdakKBgzIKKDtxc9hO2VcEF5rjtdCxiQsO0LtNItmWo2M5wGx2KbkkVIy1M7f
         gSAL88ZJW/R68wXxoaf7+yHfwLU+L/jL/kJZLRdmcoxkOJcpeF6Mti2j4UlJKZTQUWXC
         QCOll0caRl/lQphqeVkQyXT6uaBMhFKD5JsPl2pOwAMTR6wGU7PNhJL/shSZ2MYNgr/8
         U4RybdnHk4/Y2gBvlCbY7eyXte29fra/4dVE/NiEPKiLHkA2rJD1sfowNMxMW15yh4cW
         sQmPlCCd3k1T/4redMfj4hhoMsnfeWXIjVsdF3V1wP0pz0QVR5QdVvVpHyTydkIYdKvr
         fYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675376; x=1784280176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqGhNzdohMFEPYe7rGIYSH65iapoiPfmEbyHAub7vT4=;
        b=aBmu0rVNvlFQV9OUg3/J+j+abxMqE0yVnyE4SPYZo7hw9FOH1mPbHfBxlVSiIMgk4B
         voRyemluKMn+OAsuk3fQt/8UvsVZhbjuxpSRW3epYV0VE+eQwf6f5e7sOltG9TT9CR0u
         LWZs2hpa55WIDE7dXouF5NUDtAmsXzAPvR8fkl44hVB0hjI38UiP1teDAhkYPVF426aa
         GXoc3ENQmEIAPXVYXZnusa8quAJfFMoBM+ydOPKk/hUK5/naKa0Lc6bUkymNHUfdVQAC
         FaWIDNbd4wEXcJTaYRmkWA7lP1gH22ujEv3XMYGkttVzjat7+FTZDE0REyTWB+rdWl+O
         I8bA==
X-Forwarded-Encrypted: i=1; AHgh+RqDL/BSaSZLB/f4MaiMank+www9qOUXrXT5SEu73sTIQKrkswsjlTPhwFilTuSJX7eIQmA9+pt+5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzSbQYQXxJsf6FKNjB1ln06VqmpKyJuSMK2vh2f12YcHrQAoM
	KSwFPivOCBvgRSf45v1YiuZdFFH/K6OAAfF7NDCe0CFVkDahT7OQ2Pl5Skb7GmI4uN8=
X-Gm-Gg: AfdE7cllfeupGFfADqSYz8UTW5MmS09L645ZLhAw2ptZkDj9qAaZJjAX1dhIQBYd8s/
	/mo5cNeFAKJPwC9EkW2RE3vX1FdXrER1DqOkClhFEDb06Y4nduiTvjT7TyeTXbxzMTyBMMEUzNB
	wLmnsqKTycFQSnNfwRCwR3rlmvhltLw0VExaL9YMGbKGQq60i7miRI/T/wd7DkMA2RD00ZqaSxB
	3ic4Af5RKJMi2uKhvrvhIrUA8yVGvspRhD3HlU1S0716l2kNfuyv71/oJUMV0zGsvQy1p0FlC80
	LY9wMr/rIqZnGpN4RliBw7TrFwCWdfSFZn6Yuw0I8GQIYMT1kzd0T+Wfb4VtOcUc15v4ZFLgyQu
	DpEuvJ3l9b/RLaOvtG/FAZ5aFzaL2XTXqeYUjN5u1gxHxsKL5mkH0KqIEwRBk805UT+y5mkmQjF
	x2uWNOHbUuAijTEvlDSLiLnY7Jsm3IupKoZtuZGaQRIpg+fjRq8OsU6XjvdRfkp9I4clNGcRUsV
	G7D1w==
X-Received: by 2002:a17:906:7303:b0:c15:dd38:7f26 with SMTP id a640c23a62f3a-c15dd387f5emr361970666b.31.1783675376105;
        Fri, 10 Jul 2026 02:22:56 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm261785566b.36.2026.07.10.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:22:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Jul 2026 11:22:40 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: milos: add OSM L3 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-milos-cpu-opp-v1-2-ae7f4b09bc77@fairphone.com>
References: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
In-Reply-To: <20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783675372; l=931;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=+1KKaNTX/P7/V53JMeGAGQ8XdMuCS7KUkR2X20QbUvM=;
 b=7KzlagRFrXe26etPJVuOlzaav3hBDxk223iegLY9WRmoMroFHuylAyvI6EIEvhMaF09DPfOs4
 kH+zUzLWvF1DPyPHaQf9La7JjzSfvsNwTKQIMTt3BOFTQ5qTJFmhAAa
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the OSC L3 Cache controller node.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 8c9232988953..1172a4f6adab 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -2639,6 +2639,18 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		epss_l3: interconnect@17d90000 {
+			compatible = "qcom,milos-epss-l3", "qcom,epss-l3";
+			reg = <0x0 0x17d90000 0x0 0x1000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPLL0>;
+			clock-names = "xo",
+				      "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@17d91000 {
 			compatible = "qcom,milos-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0x0 0x17d91000 0x0 0x1000>,

-- 
2.55.0

