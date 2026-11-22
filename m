Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369597;
	b=RvgA/oxyoywswlZBL8kQvMY8BVKhzeEb6xa5cHQWrgJOHQmYbeF3hDwnf8WwqeRQN4vx
	 yItSrEwMAEmK03s+S6EbAhwwf1fyrA/VVTQcW9NR2aUrga7M89P5Juo0Boo74edUJpuO/
	 7Rc3hFZ0xX5MTmpb/WR5RMXRcj+4UaB6GDKDhe4R1Z9sfVenp4PvJqErNF0GT4Zyel+6w
	 jUbt0brjxwnTsBCBibynYIKBQKjlsuVKxCcN3bDcu81Fcx5blsLBh0rc/OdXVjarpTaR5
	 2WBYclqhXlc3QJF83MTEm6Rc3AS9Ga3p+FyLXVcGt4heNjjla6Yv91vFm4D+c+Y+IMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369597;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mVOieMnt9xLSwzv3k2gMzam8wECE7mYSND8WyMrSV2I=;
	b=JdfLvG9pl25S1SVW0g4WOQjPW58RNQZ9O8wlc9yxapj/46m12K8+tJYtNmkLXSywxob1
	 9U53yKLjSkreE2tNENp3ulRhLVS/E7Oy+/Mc/Bouri8A3ffXiAp6SyFUJm6qFGyK9/ZOQ
	 YeWLhyCgoxCRsHBVfiBbzui71KywPszvhwOA37MVrN8sqceuPDCpc+/7Quk1gQZ2gNE9w
	 WJQQJaUJWt5Siax9oVqVG3Jznp/xS6qTwpCwWkuQejicHhIclVHCGmVU/4CdrYsmsk+Ap
	 jVzZ1Y6un1sCQrdJmRD/zpoDnjmRSS6DL47MKyyvq9yrAXd6pDtfk2CPpEzecT+nDgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0F606A320;
	Sun, 22 Nov 2026 17:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D474D1F0156E;
	Sun, 22 Nov 2026 17:46:35 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 18:46:21 +0100
Subject: [PATCH 2/2] dt-bindings: qcom: qcom,ids: Remove unneeded ID
 constants
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
Message-Id: <20261122-qcom-socinfo-id-dt-bindings-v1-2-eeee0ffa25da@oss.qualcomm.com>
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ilia Lin <ilia.lin@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4142;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QDNX9rIc3+V78t7V9zIwvrM/AH6wvejJsDVcaxeNNFc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAypw6/Q6ki0V+mKyE5/fGBby9Q4tgr2uLfbdT
 CiU67uizO+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawMqcAAKCRDBN2bmhouD
 1+1YD/9RDgOcFay831vJw10yLdmlnm5V4ceIY+fBLSJMbLH1Xs+IM6USjRSbWDUFIQS22Sx01wy
 lZdgJEdFJFqd6u6/yaDT0+/k4u97vQ8L5RuZE9BGZxUm613bhWw7Fmv5VkA3NMziF3FDVlggeSl
 amTOnBTl7dpowGp97y6Z7NOBPVC43J9z5co0oyGqwYyTI5tIb21Qg5dx6gzDU8RORkCdaAhvYTF
 ECx+iM1XyqGwt629N42fRjWdZHXtXmN9IjP3J2qS3J5bFOOHSc70hs7zLEoRg0tLXVw2l+PUyGf
 ghQQwy21gRKDS2GFRm8FHdOfkukPptNIshZLyzUodI5e/xB0jv+4LQ3awFflhVWcHFhACgI9/bT
 DFmAK3mSPz5tbNP+XkNhLUZLX/5H3XtvlPKPm6OaYoVD8UXhGu6dPGtY8OOH87HjPxltWfSQJC4
 qG/R4VhN2GH70vpCW5qn7EjwQKEGHynon4eu1NFJp/MO2VEr4o2oYDmxPxnB1ktAivRbtBo0uxr
 q7VeunKto177WXb5AKed+3imLjRZYGKBbFAf+tY8lilR9wVgkxrSbTX7DROfX10Ent1yzxD89YP
 KVnzHhmVNcQ4loIIZkWDxDPw+P7bq80t0P/5/KTTu4jKg+5AR9gP/wVLxvUE1uW0Iiy/f8MvPE8
 3JbbS/Ud13oyqiQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
currently used only in the socinfo.c driver.  There should no and there
is no in-tree DTS user of these, so none of these constants are really
proper Devicetree ABI.  IDs of older SoCs were being used in DTS, thus
that part matches the concept behind DT bindings.

Driver have local copy of these defines, thus these can be dropped.
This has no impact on in-tree ABI, but any outside users would be
affected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 93 +-------------------------------------
 1 file changed, 1 insertion(+), 92 deletions(-)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index d89d3b5dd00c..ede8fb7ee51d 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -229,98 +229,7 @@
 #define QCOM_ID_IPQ5028			448
 #define QCOM_ID_SC8280XP		449
 #define QCOM_ID_IPQ6005			453
-#define QCOM_ID_QRB5165			455
-#define QCOM_ID_SM8450			457
-#define QCOM_ID_SM7225			459
-#define QCOM_ID_SA8295P			460
-#define QCOM_ID_SA8540P			461
-#define QCOM_ID_QCM4290			469
-#define QCOM_ID_QCS4290			470
-#define QCOM_ID_SM7325			475
-#define QCOM_ID_SM8450_2		480
-#define QCOM_ID_SM8450_3		482
-#define QCOM_ID_SC7280			487
-#define QCOM_ID_SC7180P			495
-#define QCOM_ID_QCM6490			497
-#define QCOM_ID_QCS6490			498
-#define QCOM_ID_SM7325P			499
-#define QCOM_ID_IPQ5000			503
-#define QCOM_ID_IPQ0509			504
-#define QCOM_ID_IPQ0518			505
-#define QCOM_ID_SM7450			506
-#define QCOM_ID_SM6375			507
-#define QCOM_ID_IPQ9514			510
-#define QCOM_ID_IPQ9550			511
-#define QCOM_ID_IPQ9554			512
-#define QCOM_ID_IPQ9570			513
-#define QCOM_ID_IPQ9574			514
-#define QCOM_ID_SM8550			519
-#define QCOM_ID_IPQ5016			520
-#define QCOM_ID_IPQ9510			521
-#define QCOM_ID_QRB4210			523
-#define QCOM_ID_QRB2210			524
-#define QCOM_ID_SAR2130P		525
-#define QCOM_ID_SM8475			530
-#define QCOM_ID_SM8475P			531
-#define QCOM_ID_SA8255P			532
-#define QCOM_ID_SA8650P			533
-#define QCOM_ID_SA8775P			534
-#define QCOM_ID_QRU1000			539
-#define QCOM_ID_SM8475_2		540
-#define QCOM_ID_QDU1000			545
-#define QCOM_ID_SM7450P			547
-#define QCOM_ID_X1E80100		555
-#define QCOM_ID_SM8650			557
-#define QCOM_ID_SM4450			568
-#define QCOM_ID_SAR1130P		579
-#define QCOM_ID_QDU1010			587
-#define QCOM_ID_QRU1032			588
-#define QCOM_ID_QRU1052			589
-#define QCOM_ID_QRU1062			590
-#define QCOM_ID_IPQ5332			592
-#define QCOM_ID_IPQ5322			593
-#define QCOM_ID_IPQ5312			594
-#define QCOM_ID_IPQ5302			595
-#define QCOM_ID_QCS8550			603
-#define QCOM_ID_QCM8550			604
-#define QCOM_ID_SM8750			618
-#define QCOM_ID_IPQ5300			624
-#define QCOM_ID_SM7635			636
-#define QCOM_ID_SM6650			640
-#define QCOM_ID_SM6650P			641
-#define QCOM_ID_IPQ5321			650
-#define QCOM_ID_IPQ5424			651
-#define QCOM_ID_QCM6690			657
-#define QCOM_ID_QCS6690			658
-#define QCOM_ID_SM7750			659
-#define QCOM_ID_SM8850			660
-#define QCOM_ID_IPQ5404			671
-#define QCOM_ID_QCS9100			667
-#define QCOM_ID_QCS8300			674
-#define QCOM_ID_QCS8275			675
-#define QCOM_ID_QCS9075			676
-#define QCOM_ID_QCS615			680
-#define QCOM_ID_SA8797P			690
-#define QCOM_ID_SM8975			707
-#define QCOM_ID_CQ7790M			731
-#define QCOM_ID_CQ7790S			732
-#define QCOM_ID_SM8950			735
-#define QCOM_ID_CQ2390M			756
-#define QCOM_ID_CQ2390S			758
-#define QCOM_ID_IQ2390S			759
-#define QCOM_ID_IPQ5200			765
-#define QCOM_ID_IPQ5210			766
-#define QCOM_ID_QCF2200			767
-#define QCOM_ID_QCF3200			768
-#define QCOM_ID_QCF3210			769
-#define QCOM_ID_IPQ9620			770
-#define QCOM_ID_IPQ9650			771
-#define QCOM_ID_IPQ9610			778
-#define QCOM_ID_IPQ9630			779
-#define QCOM_ID_IPQ9640			780
-#define QCOM_ID_IPQ9670			781
-#define QCOM_ID_QCF3211			801
-#define QCOM_ID_IPQ5211			802
+/* Do not grow the list with entries which are not used as Devicetree ABI */
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and

-- 
2.53.0

