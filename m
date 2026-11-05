Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907977;
	b=n9JUxaFADk8rmWcKtpZp1dYSkUmwLMxhrpz9Kh+PZGG4PHbruPpEBSreCIFBIBb9NYPS
	 NLXnr8VBdZr/46P9Imq2sUO13ATgS0M6qEUfgdlfwg+OLO5p/MvXJc45JE1ml2TUbNVui
	 qiGlVcWwhkwlMjis7QUcgPPYey2yX5YhWGDfCEyCTwTVQuvqc+lE2KBbMBaEb042dLDvg
	 ZxNjQI4tgPVuvo354jlI2r+JPRg1D2rp80cfDSGyAalelep5crr8gIpB99dBgBDkur01k
	 pSrOU9HACszn/VaUZqtREqpj59H3KncgB9h7irmKUW62Te9gRzFiO12TitR68ZPgAog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3BFnUHcE/+pbpFcfNMGE+vFXRnYLIh629ZomjR+Ujwk=;
	b=pcpHBmzrAf/bhfKC5dubwxlCIFKsTRfbE1sja3/rURCtbZMud9bhxmft5Wq0YodWbcbI
	 GkhHv2vTOqPKMjs4R6KT2oFfjqkHjl/WvXvTuMHz9fB1Pnc4TtbEmZ45R/j1ypb8FiDiX
	 Efa+GUy3mWjcX6H5KRVVDUmK1IbSBpuhfUuZgnHB563qxEatOGGYOfr3ty05vIudn8bfK
	 8B4IRSuPuT/h5eQA3RBhzrJrLAQ5Tr10L1vSYbUUT3zGlQm/fICtxAcczaYU9Zt+ecW2U
	 9tqTUAw4FKYKyOVWB/tT1CvdHOMtD+ebUpYZR8X3BU1aUprQQh9dh2DxvMmwPlFvV8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AmeU8GTg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="QrZf/H5t";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26725607113F
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 19:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26725607113F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AmeU8GTg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QrZf/H5t
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5HePRM924199
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 19:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3BFnUHcE/+pbpFcfNMGE+vFXRnYLIh629Zo
	mjR+Ujwk=; b=AmeU8GTgDBwiWMN4/T6A+Dyxv8IvBJZNTHbYFRpjZ0iUxpLoTry
	iYDQJARx+xLyFlr1cMwf/1d6h/ecXd8dYo5LHQ2LUchNhlMV+uUx+6NMKK/DEGFt
	wnqY72zlKu2mJhwP1xT/LY0eJsiHvTjCCPDnaQSRmf+C0TwOLjPFI88d9RINzUA4
	NWMZRH59hbmmSddTDfX7mXK+gfs2TSbZfOONFAkVgHTGBFNRQ7exj3zsfJgDcIZj
	wJ5eimlQN3NpajwbHzly9WkySv5V5CsjDseBs2vUHow2JdkBIJta/viT/JHds02y
	tlSxSTkKZXHjGsPvhB4pVymO/j0CCCrKS8Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhktj8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 19:46:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f62934ef6so536425185a.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 11:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793907975; x=1794512775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BFnUHcE/+pbpFcfNMGE+vFXRnYLIh629ZomjR+Ujwk=;
        b=QrZf/H5tIzT3hY67++JUZAsJkoAiBRCSnRqvUizLKYRWaE7qvKlGBvYVCDwplreE9d
         vHmA7cLiTMIbwtWEQwjYrAJojoEKMRI6mR9sag9vN1oB3fLhUV0LHEaP/ghXXA3DCurc
         PbQPcwF6UX7ChB7eLcGyW5Ir84wZujJfV14b1LibKxNi2RAoXCN7T904K390sc6jLsxc
         HnAkuY7h2xIzkf8vLkfFEJVXzd0IQ3yeEX3gpA0p/MCnEXApO80yYqISvJj3/T4qniv2
         Uz4UuMNl1WB22zWxyTUX+pQ22ilCagFtKBzV4/2OEjh5ieSFEDnPHL6hq/YVpa4b6/IW
         IMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907975; x=1794512775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BFnUHcE/+pbpFcfNMGE+vFXRnYLIh629ZomjR+Ujwk=;
        b=SojWj17ZS5qnQm0BMZtzQ0BcFv6q/iKDpY/62gUwfmbExSmc9++zPr/bPhox1S1bqr
         3jWidrdq95L0e6n85fsDqT6+5kdvGV7dzw2ZG6R4SBnd3egzoRRdhTtKxtlo3Dex5ezy
         d8cCAAXEskqYbpj/n08rIUJKMe25zvn1L4oMTtxox5lAHCV5ZznOvz/ltKqPpEm5Kmzz
         Rg1zG2xvEvHisDnjgu+jju/BMOfoBmWS36kFhzkCK1kP0XPFA0QF8VxaZi0+5NKslY/O
         lBPsLeBjrHB7IZhuDeLu47eXdgR7zSF32v1SkZGb9hQ/UUMZpS9MSC5y3JI6Li04xyns
         x0XQ==
X-Forwarded-Encrypted: i=1; AKwUvByiclT9IpNRTQAq6H0FDIypT0Le6eW6FFTe0k+i8ep+37pEV6mceottChA5flXZdFCcT7e66bBCQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2NCD6gaJZ8QkyNa/JH2uGw3Bwemp3SGHj9J9vIrKK87KDNiSW
	QQy130PamQEQysaN48k8wi6vI5c4NRt0Me3H3ZFkTlSyfHxS1pp/llc5rhn+WfYMS3NfVjv2efO
	DUEj8pUQQUOgDkDZGiMT4/H93ehtgT6Kr7n6AMQTAT7yO+tUP35eCAREaURGZfaOtj7d93Q==
X-Gm-Gg: AYBFou3mqJ8MEjjvas6nK6Uu5SdPUpWmveucSb/fTtUrMWUtFgELjBnUNqKNbu0Jx1p
	1FjAcjyn3NBLHCwslFs5W2QD0iTya4sNFNkd3KQo+KwkAlzxk0XkthMDnO16DXqr+m8RXFz1vD5
	Oq4f+aJV4Y4PoQVbEKzwTsPuLlVqs6yFryv24HCashkLPv9e4yCo4VMBLOKZv3rhFchvdqOXRBA
	EoJvKLl4NcIE5DtQWs5nzYMeX+eGjXPYDOECvYGm/r/wzKfAb3r9zJER7e5QmjtNaDTiIylgy1+
	Gu6K1YfaTnpm3Kvozn2C8lFIY091EnpDerpTFzq53Nxgfqp1jx/Wz8YZXEjMaI+7G7BJVG8Y/LO
	SLP+KloetFZcBVHCHBcxkG/JnDHYG89YwklD2iHLobBUX3tad7LohWL9hkmtgOw==
X-Received: by 2002:a05:620a:2702:b0:944:2e2e:69cc with SMTP id af79cd13be357-945f34ce97fmr20081385a.49.1793907975273;
        Thu, 05 Nov 2026 11:46:15 -0800 (PST)
X-Received: by 2002:a05:620a:2702:b0:944:2e2e:69cc with SMTP id af79cd13be357-945f34ce97fmr20076685a.49.1793907974812;
        Thu, 05 Nov 2026 11:46:14 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcb8sm82495855e9.1.2026.11.05.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:46:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: Simplify bindings
Date: Thu,  5 Nov 2026 20:46:07 +0100
Message-ID: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=ei0/JnfNAAX2qJbDNn+6Uyh3n+06uKHSrrdp7G2A7ew=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq7Nz+q/+5a2h/Vy/JzzACmTB3XbMLDFW+T0Sk/
 hhFR3jvxXeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauzc/gAKCRDBN2bmhouD
 1wPgD/9N3au9Ru4qEGpuVNiEQ38tGsbqeiHc5J+W2pHu7VmvW66WRXXhxknNTTQeguVW1hZBea5
 ksi04j56hZ7dZXSA7q6+LP9ZvikzypImgq+GMVxm+t3nY4FlJEcOg7/95DLLbaAknbxtd6AhYld
 S7RujdhKRyul5vmnj2pxn7fKuXjl6ePoaKQWmGsyohZwMsKLEKuecfdcOTW79wN8hiFszw3OKtw
 RFR6ymuACaIK687aWKaBI+CvYLISj02Lyb6c7UZ4u/i0GJQ1YuN3aoM0b2nbpIBAZgHvCd1nYY8
 TjpZgXL0ioplBAw9xHWqT6DNwbdDvKOnpmpRWJqAF1x2r2kGtsvxtN+sb0saGZ/pyEtYg4F8OpG
 wJcu8Mhf5XGgc2BCPWPgJ+6iYVlQJPrVxiaTyrVJcD9vADPd6tInshRQYU5sHkq5jD9IalQKYWJ
 XNd1tjf/TM8cT2RKH9n8tHc87CehvG54Buf5sXF7FUX5N0YMof8MnMdeK0xy+OTiRY2An58ToC0
 me7gwJc2JQohRBHxirG4Gt6PpeiPsvVXFtX+hKQsa+4ovmNO0Vni7MgwehKbgDa4zdAvCg8khvL
 tnT4oh8HFFcQZTlYb4K/Qp/9FaBsJf5cjdsk0TTHCckcxhatEXLR9e+tL9Ymb+3JFoxDuW0yUP1 1860SmvyRqfz7Bg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfXy4mCIqXHKiVr
 lStVTuB1meIgyIdoNsU7fckbRSMghE4YPnPRZgWZPClq1e/ti3FBK0Q8Mfye6zR+KLYfAhNskQH
 eQQ9Pzt58Epn/K13Agd06ZiAQx3fuFIof+r/Uk5WdU4BiBkLpgo+WkdTyPXbdNX8kRCiueIv+Ja
 4LG9pEtbgc0LArhWgfPKfOHi1235M96zjGW+gA7lvX2Sc1IffKTeIYZUfgOpy7shIIgupg03dUN
 4F0auQjpmbQ9JXNoT9LvtATzy1zBDfj0dzyvsJUWAXF8OloVaMIwBrHFf5FmjLioZoQK+G6pqqA
 7x2N5bTzj6pccgbsQZPi5zB/l4mnkSbEeJmcsIMOF9sT9mHTFEBE7DTrWebbnQ+Wbeam/+WaMIM
 WH7OyG3V4yeYC4lG1xZZP1t5aSHByKWqAUKU1YT7InouRLBaxKeDyCX3Hrk7XRpKSA1BJkQLW2i
 gt1vsocphpXkjQEtVXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX/WUGSRX0ZuHw
 lCZCvcGZSchqVAeQr0rVHnTdsE+DHV4qVIxVENIHeqT/tjf8dmSUz5tX2u9/Qo75VzITcAi9UAR
 2Ig/xXrDdGqtrC8FGnJTAuaVMDXDuBU=
X-Proofpoint-ORIG-GUID: QX7uKJRKwIkz8c26bgz7RGbFn7GW8ib7
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecdd08 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hpx_vC1UKZy5HMHMfZkA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: QX7uKJRKwIkz8c26bgz7RGbFn7GW8ib7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050078

This binding selects a few top-level compatible machines, but since
commit 389de9c5a677 ("dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
bindings optional") only qcom,qcs404 is present in  "if:then:" clause
which enforces specific OPP properties.

For all other machines, this is a no-op, because there is no schema here
enforcing a specific compatible for OPP nodes or any of OPP table
properties: one can switch to standard OPP table (operating-points-v2)
and this binding will not complain.

OTOH, this binding has complicated "if:then:" blocks so is not easy to
maintain and causes false positives when regular OPP table is
encountered in matched machines.

Drop all machines except QCS404 and move the subschema to top-level.

Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 78 ++++++-------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 547265b8b118..dfc7a27a7bdd 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -25,22 +25,30 @@ select:
     compatible:
       contains:
         enum:
-          - qcom,apq8064
-          - qcom,apq8096
-          - qcom,ipq5332
-          - qcom,ipq6018
-          - qcom,ipq8064
-          - qcom,ipq8074
-          - qcom,ipq9574
-          - qcom,msm8909
-          - qcom,msm8939
-          - qcom,msm8960
-          - qcom,msm8974
-          - qcom,msm8996
           - qcom,qcs404
   required:
     - compatible
 
+properties:
+  cpus:
+    type: object
+
+    patternProperties:
+      '^cpu@[0-9a-f]+$':
+        type: object
+
+        properties:
+          power-domains:
+            maxItems: 1
+
+          power-domain-names:
+            items:
+              - const: cpr
+
+        required:
+          - power-domains
+          - power-domain-names
+
 patternProperties:
   '^opp-table(-[a-z0-9]+)?$':
     allOf:
@@ -48,10 +56,13 @@ patternProperties:
           properties:
             compatible:
               enum:
-                - operating-points-v2-krait-cpu
                 - operating-points-v2-kryo-cpu
         then:
           $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
+          patternProperties:
+            '^opp-?[0-9]+$':
+              required:
+                - required-opps
 
       - if:
           properties:
@@ -62,47 +73,6 @@ patternProperties:
 
     unevaluatedProperties: false
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qcs404
-
-    then:
-      properties:
-        cpus:
-          type: object
-
-          patternProperties:
-            '^cpu@[0-9a-f]+$':
-              type: object
-
-              properties:
-                power-domains:
-                  maxItems: 1
-
-                power-domain-names:
-                  items:
-                    - const: cpr
-
-              required:
-                - power-domains
-                - power-domain-names
-
-      patternProperties:
-        '^opp-table(-[a-z0-9]+)?$':
-          if:
-            properties:
-              compatible:
-                const: operating-points-v2-kryo-cpu
-          then:
-            patternProperties:
-              '^opp-?[0-9]+$':
-                required:
-                  - required-opps
-
 additionalProperties: true
 
 examples:
-- 
2.53.0

