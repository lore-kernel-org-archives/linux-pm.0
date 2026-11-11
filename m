Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391262;
	b=GaILOvi65T1YUnOvPDhGlexfheDDaQ4r9BHTSNz5gf9jcByaQETDtPBRUqvuIo5HFHhh
	 hjsESRqGrug8ritJQKsnGaDowjgyUf+VsDWya5SVJkT31paRPR45vWkS7p3Rm4mwvErb5
	 +Z+55kOn8yyjYnDP1r81K8PvAPlAfYmBsTAK1Uw+kkXBnEVcXwIUAXsAzMkAjuZpXqMrg
	 9ft1S52yPPtvhzexfhp1FuLiI26mnG6FeH0EeZW6+qUrBBB3+zYSztDJxSQ1Sj0jled79
	 mxB7Kg2FiMpBBnYowzDA0SXiGLAMbS3kbFdPM4gDFE9dWMB64bUSfkvi8r6cYrdQgLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
	b=aGKVDMgkdKWWn3kCDBlWNYl0ZnHAs31yaE3+BybYP5jMMtiWsVHdBabmcY9M7JwQtGXZ
	 7sbhYrbm9q5iygbBsH06d5Sfc+zDeQYu9/ORTS+RQ82vKCS4Au/3vwtfsy3V+skIfkAh4
	 r3FGU4xY1ZHaiKln5IMazaDwUtFw7FQggCE4c2PZ1O9mF3pE6ZXPiqV5nESpBl+zlTYIq
	 cMKnx9s6qkG6/Uvb8FhdlVuBoTu39LHEF/c3zNk5BbL7jP8cpu756wb4lN8V/TKfhAwKF
	 aWqYW9wvUVLtLezYBipTdBc/s9Jzw9Crnn6j4nIuxdyskOy+FxGWj66/v85m8hljwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=knAJcfdH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cMxsjZrc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE960A2610
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADE960A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=knAJcfdH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cMxsjZrc
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNj83958971
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=; b=knAJcfdH12dl+DpV
	rQsIAzgLcpb6HZa/I9n5EhG2rVjiazUNeK6LzBKF9G4S1VzOjE59p0FcUjMiohL0
	fWl6QoF9d00zZbXeVbBt/l/zjaKzHow1PBl0KfJ494zY05/YsY5PM97hkMQqCaB/
	83eS/TaAcGPyFXHD6q6QCdw4Uo7/b9H0qAOsGQJu6cGjtsg058eiKewrUpmoi0yu
	qXAkeKh+xttKStpyCbH49yMJJjZlRhb/18QH6Lh4wZk5+S9BwBwUTlinp5KY9iLN
	sDGmr6QGUFr5O5yxmfjpPtHX6VXkWDzY3Z2Xzwv6nZLNnIjdw++uqEjTda5R71iX
	OC5NLg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b33112-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:01 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-55bf11583d9so3302675b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794391260; x=1794996060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
        b=cMxsjZrcXx9StQ6C6iBHxjT/1sOE3cleNZ9SvNiOVWI6GjtC2E1OFSLinbrRKshNiJ
         KNNtS48dLlRm9m+iaAOJ0rr2jWJeOal6uHvQKBKBRlpCmtEL4HPgbXINcxc7f4PW4FAw
         Vmf7cL98TZCZctKb1rljClzYyOR8ZKYhu7wEak9UxpydEw02RS13nO+wMmFU8fXLMOmP
         aa00ay+8gKTu7uoPWoxIas1XqkjZRUFTyNskJRSAPRTcZFbgkNgC4N5Bhwa59W+a6ZBc
         hri/nd4leFJc2ianTpIhrxxVHZBb84Q9Q2NKjCt9/RXHtJvsrTxAs0tYBck9GqXB9iRT
         dsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391260; x=1794996060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxy4cfAf042PiXXoQRywKNCGpgVupBVLw8AvprKIGyo=;
        b=rCC78Ao143PfGfpUe3snJpulTek0IWX0qQJ3XXn0ID8gVQBsLvQ6cZr7ooOED1x1TB
         589+tfEvEw6Hvw8Pb3uuhoROnqwZrHZlKgsMKSTFFOPTfEmDEQd5gQI4taggN3o+7M0I
         MRXu3vuIcis8ejQeyHpAHmGxuI9B7L7wD0nQgGxD7pgnIdPpbeQTlgBeu7wt+OjglFo4
         vnlUJDHCDD5CZuCqDzIVEDvQvxeTr5VdzmuIsbBKqyMNdm76tcUWM1/2vtRcBDQCJNQH
         FKQ+kpHhN5SK5uFOZePE8A4Z5TyeYztCr3M+aaQpWaGtr+yPvjakSYf8dpGn+9Jys+0a
         rkuA==
X-Forwarded-Encrypted: i=1; AL+hErGk8XgEyUun0ogR0AFCpuBxNY05mRr6oILu3Dnar4fDOSliNfoTDdT1ZZOkIWX5udG3qhFKMy/8DQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8SYPxR28V7i1d1VnZdYI3Xl34MeRlm7EkNCKTqtSYdozv1Cse5
	4Mx60PG19cDClu4FgD+cCIuDJAbX+2buKlPYMwiwPw5kk0H26YsIkpsngTnWrsulfmjrkU395Z5
	9EkUjMhLJv+it7rjOwSCj9QodqIg19IPUcg96jaA317wWKvFZNkYgjgrNz6KqCg==
X-Gm-Gg: AYBFou3ivziluXP+tDvxmyDRTTqpZWzZ4xOZCLFO8c/YYrbYMR91hTNUVPnF2cE0kA/
	pXqhZ0Q9aVhlWotqzHeSgJlcw4RgXcyqetWIs6WdfEIyGxrOp8vkvLNkxkUyzpQq3iTlmS0sAFI
	1mzqzSK5Yfz2HeA56Qxe/Auew/ECaWI3vtGO1vk3fSNgKOsei3Go1slLZXmOUGDVKuH0Oon4seQ
	uqMzozscHQLEJnkmwEypU5/AbwF7R3zQXbS5GTT3mlAjA5XGRZ5lZC4H1wfU9ogysfalskjQAlS
	6Un0AXot2xeog4kF+yED11pAPBvGUEXWyiB8QNF1O7PUmebe+LgqS7wSuJVsmm/i/4A9onnrMCy
	IMvE+wur+312OELaYI/pcKEuHhPdxpAmotJvAo9PitEpLshExAoXPiYPu5gbFIBmEybG5h1MVFg
	jCTw3m1gMMFQokUq3j
X-Received: by 2002:a05:6808:1b08:b0:4fb:b543:dc3c with SMTP id 5614622812f47-56872851d5bmr3253688b6e.5.1794391259886;
        Wed, 11 Nov 2026 02:00:59 -0800 (PST)
X-Received: by 2002:a05:6808:1b08:b0:4fb:b543:dc3c with SMTP id 5614622812f47-56872851d5bmr3253664b6e.5.1794391259413;
        Wed, 11 Nov 2026 02:00:59 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm4686111b6e.4.2026.11.11.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:00:59 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:00:55 -0800
Subject: [PATCH v2 1/3] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5210 SoC
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
Message-Id: <20261111-qcom_ipq5210_nsscc-v2-1-7e2c1dda3ed2@oss.qualcomm.com>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391255; l=12138;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=OHhmxjAaFrk/KrSfVg+GuvTHorpv3eRxfNre0pIomoQ=;
 b=XAGYZPYjot2gCAxSBvqEHJD9eviRUpTXUPw+1TIGHeXiWfilIACC5yFBFF0rOLzd4gJYwK0WW
 Am3yCen6HcICT5rTzkyk1nZba9b1G/odV1r/jB+RcBrlJyzOFfCaXl5
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af43cdd cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=U5FYPQ0ST96qNyfkX9wA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfXxoCkMmderddk
 wdaBTNbBXEKAnagGC3bNhZKltVQLvG073Fdg0nD1rPC8BsKuni/VGPvi+UYuF8Xn0GCIa1tUBe0
 PQtN3UCfjKvc/k3wBAsI+PoL90d3pgrz1PV/bK6dNxyhc/NqSwzulJ++bWLbssJr0vXyWoh/cOF
 FY2vDWv7gP0L2lVTvwu7I+JRgFPjtbIz5pGPNX2uUMVo5yMu7bcTJs5ibbwUSjIgDIp5bIxyASR
 GkQ+WG9gIahB7x84bVnLDusbAsx7lj8AWYNETEfPwNSJ/sKDtBr3Ze5EvyMIPYRu72ryYO/hVyg
 zCzX5atOR85I1J9sTtyUVpZaLbiUX2Poto6l7Pj44Jrx0voA1CEEARDyuJOqZT3NilO4s/hVKAt
 hgcFdlRDVsrovmd/FGpgccAtYuMCJuVQ9lByYzXLKw28HSY4Qci+ZjHuw7gcDdR9OXvwHxTIebC
 fbDgcNr/G75KFRDQvog==
X-Proofpoint-GUID: D6BshpLyBKMFvsCAzTc7q7A5cs7SNKIz
X-Proofpoint-ORIG-GUID: D6BshpLyBKMFvsCAzTc7q7A5cs7SNKIz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX8dcyLE7qNO3k
 OwJMbFvUE8iUwgILa6MF7naQhQs1GCS/yDeNo72YSO28WWeT2uxUdg2ddUKq2UR6eJt/u+YpF5U
 OcGduIqO7hPZnnsEoKCirwrU1l1uRig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

NSS clock controller provides the clocks and resets to the networking
blocks such as PPE (Packet Process Engine), UNIPHY (PCS) and EPHY on
IPQ5210 devices.

Add support for the compatible string "qcom,ipq5210-nsscc" based on the
existing IPQ9574/IPQ5424 NSS clock controller Device Tree binding. IPQ5210
additionally exposes a pair of EPHY-RAW Rx/Tx clock sources used to derive
the clocks for its integrated 2.5G Ethernet PHY, so extend the clocks and
clock-names lists with "ephy_rx" and "ephy_tx".

Also add master/slave ids for IPQ5210 networking interfaces, which are used
by the nsscc-ipq5210 driver for providing interconnect services using the
icc-clk framework.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
 include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++
 include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |  60 ++++++++++++
 4 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index a35bbc7b1924..dc7d90a99dc7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -4,24 +4,28 @@
 $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ SoCs
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Luo Jie <jie.luo@oss.qualcomm.com>
 
 description: |
   Qualcomm networking sub system clock control module provides the clocks,
-  resets on IPQ9574 and IPQ5424
+  resets on IPQ9574, IPQ5424 and IPQ5210
 
   See also:
+    include/dt-bindings/clock/qcom,ipq5210-nsscc.h
     include/dt-bindings/clock/qcom,ipq5424-nsscc.h
     include/dt-bindings/clock/qcom,ipq9574-nsscc.h
+    include/dt-bindings/reset/qcom,ipq5210-nsscc.h
     include/dt-bindings/reset/qcom,ipq5424-nsscc.h
     include/dt-bindings/reset/qcom,ipq9574-nsscc.h
 
 properties:
   compatible:
     enum:
+      - qcom,ipq5210-nsscc
       - qcom,ipq5424-nsscc
       - qcom,ipq9574-nsscc
 
@@ -42,6 +46,9 @@ properties:
       - description: Uniphy2 NSS Rx clock source
       - description: Uniphy2 NSS Tx clock source
       - description: GCC NSSCC clock source
+      - description: CMN_PLL EPHY-RAW Rx clock source
+      - description: CMN_PLL EPHY-RAW Tx clock source
+    minItems: 11
 
   '#interconnect-cells':
     const: 1
@@ -63,6 +70,9 @@ properties:
       - const: uniphy2_rx
       - const: uniphy2_tx
       - const: bus
+      - const: ephy_rx
+      - const: ephy_tx
+    minItems: 11
 
 required:
   - compatible
@@ -77,6 +87,8 @@ allOf:
           const: qcom,ipq9574-nsscc
     then:
       properties:
+        clocks:
+          maxItems: 11
         clock-names:
           items:
             - const: xo
@@ -90,8 +102,35 @@ allOf:
             - const: uniphy2_rx
             - const: uniphy2_tx
             - const: bus
-    else:
+  - if:
+      properties:
+        compatible:
+          const: qcom,ipq5424-nsscc
+    then:
+      properties:
+        clocks:
+          maxItems: 11
+        clock-names:
+          items:
+            - const: xo
+            - const: nss
+            - const: ppe
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
+  - if:
+      properties:
+        compatible:
+          const: qcom,ipq5210-nsscc
+    then:
       properties:
+        clocks:
+          minItems: 13
         clock-names:
           items:
             - const: xo
@@ -105,6 +144,8 @@ allOf:
             - const: uniphy2_rx
             - const: uniphy2_tx
             - const: bus
+            - const: ephy_rx
+            - const: ephy_tx
 
 unevaluatedProperties: false
 
diff --git a/include/dt-bindings/clock/qcom,ipq5210-nsscc.h b/include/dt-bindings/clock/qcom,ipq5210-nsscc.h
new file mode 100644
index 000000000000..62ead8d9b076
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5210-nsscc.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCOM_IPQ5210_NSSCC_H
+#define _DT_BINDINGS_CLOCK_QCOM_IPQ5210_NSSCC_H
+
+#define NSS_CC_PPE_CLK_SRC			0
+#define NSS_CC_PPE_SWITCH_IPE_CLK		1
+#define NSS_CC_PPE_SWITCH_BTQ_CLK		2
+#define NSS_CC_PPE_SWITCH_CLK			3
+#define NSS_CC_PPE_SWITCH_CFG_CLK		4
+#define NSS_CC_PPE_EDMA_CLK			5
+#define NSS_CC_PPE_EDMA_CFG_CLK			6
+#define NSS_CC_PORT1_MAC_CLK			7
+#define NSS_CC_PORT1_RX_CLK			8
+#define NSS_CC_PORT1_RX_CLK_SRC			9
+#define NSS_CC_PORT1_RX_DIV_CLK_SRC		10
+#define NSS_CC_PORT1_TX_CLK			11
+#define NSS_CC_PORT1_TX_CLK_SRC			12
+#define NSS_CC_PORT1_TX_DIV_CLK_SRC		13
+#define NSS_CC_PORT2_MAC_CLK			14
+#define NSS_CC_PORT2_RX_CLK			15
+#define NSS_CC_PORT2_RX_CLK_SRC			16
+#define NSS_CC_PORT2_RX_DIV_CLK_SRC		17
+#define NSS_CC_PORT2_TX_CLK			18
+#define NSS_CC_PORT2_TX_CLK_SRC			19
+#define NSS_CC_PORT2_TX_DIV_CLK_SRC		20
+#define NSS_CC_PORT3_MAC_CLK			21
+#define NSS_CC_PORT3_RX_CLK			22
+#define NSS_CC_PORT3_RX_CLK_SRC			23
+#define NSS_CC_PORT3_RX_DIV_CLK_SRC		24
+#define NSS_CC_PORT3_TX_CLK			25
+#define NSS_CC_PORT3_TX_CLK_SRC			26
+#define NSS_CC_PORT3_TX_DIV_CLK_SRC		27
+#define NSS_CC_PORT4_MAC_CLK			28
+#define NSS_CC_PORT4_RX_CLK			29
+#define NSS_CC_PORT4_RX_CLK_SRC			30
+#define NSS_CC_PORT4_RX_DIV_CLK_SRC		31
+#define NSS_CC_PORT4_TX_CLK			32
+#define NSS_CC_PORT4_TX_CLK_SRC			33
+#define NSS_CC_PORT4_TX_DIV_CLK_SRC		34
+#define NSS_CC_PORT5_MAC_CLK			35
+#define NSS_CC_PORT5_RX_CLK			36
+#define NSS_CC_PORT5_RX_CLK_SRC			37
+#define NSS_CC_PORT5_RX_DIV_CLK_SRC		38
+#define NSS_CC_PORT5_TX_CLK			39
+#define NSS_CC_PORT5_TX_CLK_SRC			40
+#define NSS_CC_PORT5_TX_DIV_CLK_SRC		41
+#define NSS_CC_PORT6_MAC_CLK			42
+#define NSS_CC_PORT6_RX_CLK			43
+#define NSS_CC_PORT6_RX_CLK_SRC			44
+#define NSS_CC_PORT6_RX_DIV_CLK_SRC		45
+#define NSS_CC_PORT6_TX_CLK			46
+#define NSS_CC_PORT6_TX_CLK_SRC			47
+#define NSS_CC_PORT6_TX_DIV_CLK_SRC		48
+#define NSS_CC_NSSNOC_PPE_CLK			49
+#define NSS_CC_NSSNOC_PPE_CFG_CLK		50
+#define NSS_CC_UNIPHY_PORT1_RX_CLK		51
+#define NSS_CC_UNIPHY_PORT1_TX_CLK		52
+#define NSS_CC_UNIPHY_PORT2_RX_CLK		53
+#define NSS_CC_UNIPHY_PORT2_TX_CLK		54
+#define NSS_CC_UNIPHY_PORT3_RX_CLK		55
+#define NSS_CC_UNIPHY_PORT3_TX_CLK		56
+#define NSS_CC_UNIPHY_PORT4_RX_CLK		57
+#define NSS_CC_UNIPHY_PORT4_TX_CLK		58
+#define NSS_CC_UNIPHY_PORT5_RX_CLK		59
+#define NSS_CC_UNIPHY_PORT5_TX_CLK		60
+#define NSS_CC_UNIPHY_PORT6_RX_CLK		61
+#define NSS_CC_UNIPHY_PORT6_TX_CLK		62
+#define NSS_CC_XGMAC0_PTP_REF_CLK		63
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC	64
+#define NSS_CC_XGMAC1_PTP_REF_CLK		65
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC	66
+#define NSS_CC_XGMAC2_PTP_REF_CLK		67
+#define NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC	68
+#define NSS_CC_PON_CLK				69
+#define NSS_CC_EPHY_RX_CLK_SRC			70
+#define NSS_CC_EPHY_RX_CLK			71
+#define NSS_CC_EPHY_TX_CLK_SRC			72
+#define NSS_CC_EPHY_TX_CLK			73
+#define NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK_SRC	74
+#define NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK_SRC	75
+#define NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK_SRC	76
+#define NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK_SRC	77
+#define NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK_SRC	78
+#define NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK_SRC	79
+#define NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK_SRC	80
+#define NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK_SRC	81
+#define NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK		82
+#define NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK		83
+#define NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK		84
+#define NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK		85
+#define NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK		86
+#define NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK		87
+#define NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK		88
+#define NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK		89
+#define NSS_CC_EIP_BFDCD_CLK_SRC		90
+#define NSS_CC_EIP_CLK				91
+#define NSS_CC_NSSNOC_EIP_CLK			92
+#define NSS_CC_CFG_CLK_SRC			93
+#define NSS_CC_NSS_CSR_CLK			94
+#define NSS_CC_NSSNOC_NSS_CSR_CLK		95
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5210.h b/include/dt-bindings/interconnect/qcom,ipq5210.h
new file mode 100644
index 000000000000..44f8d35a372a
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq5210.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef INTERCONNECT_QCOM_IPQ5210_H
+#define INTERCONNECT_QCOM_IPQ5210_H
+
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_EIP		6
+#define SLAVE_NSSNOC_EIP		7
+
+#endif /* INTERCONNECT_QCOM_IPQ5210_H */
diff --git a/include/dt-bindings/reset/qcom,ipq5210-nsscc.h b/include/dt-bindings/reset/qcom,ipq5210-nsscc.h
new file mode 100644
index 000000000000..0616a3623897
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,ipq5210-nsscc.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_IPQ5210_NSSCC_H
+#define _DT_BINDINGS_RESET_QCOM_IPQ5210_NSSCC_H
+
+#define NSS_CC_PPE_BCR				0
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES		1
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES		2
+#define NSS_CC_PPE_SWITCH_CLK_ARES		3
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES		4
+#define NSS_CC_PPE_EDMA_CLK_ARES		5
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES		6
+#define NSS_CC_PORT1_MAC_CLK_ARES		7
+#define NSS_CC_PORT2_MAC_CLK_ARES		8
+#define NSS_CC_PORT3_MAC_CLK_ARES		9
+#define NSS_CC_PORT4_MAC_CLK_ARES		10
+#define NSS_CC_PORT5_MAC_CLK_ARES		11
+#define NSS_CC_PORT6_MAC_CLK_ARES		12
+#define NSS_CC_PON_CLK_ARES			13
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES		14
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES		15
+#define NSS_CC_XGMAC2_PTP_REF_CLK_ARES		16
+#define NSS_CC_NSSNOC_PPE_CLK_ARES		17
+#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES		18
+#define NSS_CC_PORT1_RX_CLK_ARES		19
+#define NSS_CC_PORT1_TX_CLK_ARES		20
+#define NSS_CC_PORT2_RX_CLK_ARES		21
+#define NSS_CC_PORT2_TX_CLK_ARES		22
+#define NSS_CC_PORT3_RX_CLK_ARES		23
+#define NSS_CC_PORT3_TX_CLK_ARES		24
+#define NSS_CC_PORT4_RX_CLK_ARES		25
+#define NSS_CC_PORT4_TX_CLK_ARES		26
+#define NSS_CC_PORT5_RX_CLK_ARES		27
+#define NSS_CC_PORT5_TX_CLK_ARES		28
+#define NSS_CC_PORT6_RX_CLK_ARES		29
+#define NSS_CC_PORT6_TX_CLK_ARES		30
+#define NSS_CC_EPHY_RX_CLK_ARES			31
+#define NSS_CC_EPHY_TX_CLK_ARES			32
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES		33
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES		34
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES		35
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES		36
+#define NSS_CC_UNIPHY_PORT3_RX_CLK_ARES		37
+#define NSS_CC_UNIPHY_PORT3_TX_CLK_ARES		38
+#define NSS_CC_UNIPHY_PORT4_RX_CLK_ARES		39
+#define NSS_CC_UNIPHY_PORT4_TX_CLK_ARES		40
+#define NSS_CC_UNIPHY_PORT5_RX_CLK_ARES		41
+#define NSS_CC_UNIPHY_PORT5_TX_CLK_ARES		42
+#define NSS_CC_UNIPHY_PORT6_RX_CLK_ARES		43
+#define NSS_CC_UNIPHY_PORT6_TX_CLK_ARES		44
+#define NSS_CC_EIP_CLK_ARES			45
+#define NSS_CC_NSSNOC_EIP_CLK_ARES		46
+#define NSS_CC_NSS_CSR_CLK_ARES			47
+#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES		48
+#define NSS_CC_DEBUG_CLK_ARES			49
+
+#endif

-- 
2.43.0

