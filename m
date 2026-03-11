Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C73CF679
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225379; cv=none; b=ZhTLCw7Vymxv1XSdXCrsIFXWBBawOjCNLuKYUpf4G2eR6d3QrTQxQZZGSrJgFYF+PG3SyIT0RUYCToB/AdWY7i6EwxqCnbeMwKiuTum3jF776rxOHkiaT5/RFE3Bq+7f4YQJB6U8qUKJczg51S99XtpV+lGmxLEoNuTNL4wyDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225379; c=relaxed/simple;
	bh=tGrNcd0y7CJU+ZVI9UlHtCqY+NuYNkZ+5bmlpSwapVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwBV+My9vbIuF2+61HTiBkt11gPPFRZMRzj9MSo8Qd3tDl3gAMn6zVytS12T4z15mR+Ju9Jg5amcqbzb0EGcPdrCxMyDQ91TUGbkCO8WtnPLOfTrr0/18Ab6dXeupJjBIhcaCvnHqTa7zB8AI/AYz5FZUrJqtTdIIetMFNN0dU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6Bc56+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BuaNScj2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6Bc56+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BuaNScj2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9Eq1O614148
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XnF+hwK6IN3
	lQvtKkrLMTEvYuvQLMpmBOoiGY5dThRg=; b=C6Bc56+J53g9Dc1aHU2aflWeLhl
	6wqlAl8gxRxOdHeHzWQMWIKl1CKci29UowrmXV92cc2xA9Uah2gDOUOtesSLXTyn
	MjwHw+fmi6Psjq4adVe4xW3dzUoLrF5R3TBE3jTudI65xbTGkL0Wp4FiuW91GlOm
	YtiouPlw/uGWbLwSPAbNGspGvlZTf5spXXuMavjn+zD7o3G72uVZufNpZ4Cqj4bU
	XPq7091+cHdaXaRPrcPdsZamPDUI4jyQ+3lSoSOz91dGW7v7z0IJdDb5RVJSBFMG
	naCQm+kmx7IiX63F95Y0oB4p95OsSRZ7qqd4VlfbnRGUo58mtdOcsgCA96Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf1geu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae57228f64so103563435ad.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773225377; x=1773830177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnF+hwK6IN3lQvtKkrLMTEvYuvQLMpmBOoiGY5dThRg=;
        b=BuaNScj2fEkyo7j6J43gMqmg/fhWJyAqet7cUIxdnAtqKSt8EgkNE5KbofCucRYlaq
         GgVJXYl8r17NzYamkuzhCzx3daLh/svERFaCUlC7iG/TqhseFJfnV2twy+ALgNd60Ln+
         gMJOf3UyvIr/MwcxhNPQBx+FGzEku8hh8/IIgnUexjDVlV7hgg5byNE+O3BWOH+X+rN7
         Nqvroyn3r2nCJ5XEXTecZsY//ChS5WZrxNopy+1zdRdEvq9zlAS+YvWJmTQ0er390g+x
         tfYgal9rDdMB/Cxypcf2PB3kscUS0G1HdVfsbv5M4XvoF3PskN4ibpDsLt38VpYc8chk
         f5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225377; x=1773830177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnF+hwK6IN3lQvtKkrLMTEvYuvQLMpmBOoiGY5dThRg=;
        b=UlGCdOhF3DLUvT85mkM2JGDsW1WSUzLkbY0pY4K/MQN1eJuNEZlbGzAzGSJthvG8ol
         14+cHzX2GESnJsGKBz279sRL7Gd59yvpNCVh7TL0QcS02pBPTqNF7BT65ecIpp8GpQ2v
         R7v7NXczE6YuBLL+egx+m8fqKQzOMgyWyVu+CdypYijBf7iRU7m54NKtmD53jAngzlw4
         EKEdPi+HnUPPVRWGFXaBLf6Sx2GP5ycs39Z83IMVZnTtj6N6OW4/pdd9+wfM84/EBX0c
         fF6DbD0vPDAZ61NRzUOYkwGUVX217fCa3/TLwPJ5tZWnGNk1VF7hC7xMzG7a+RWoLbjh
         TOzA==
X-Forwarded-Encrypted: i=1; AJvYcCVdapgUmZ2HPAm1rwSG8vbOF9HAuMMXqUhqlb9kD1lbrDesZ/3eVRiMYiJl3euTunHVHdfsIUFgww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsQkJFEZ3n965XiFOl42deY9KJo4pm79nQEw+xYcuYj9ZJROV
	HkQWkLW2h6d2tP8VC9GPG3Lpy+plzELuA3+9bOzJED+z3smT5bgk1s+DY7cEIJNeXYkQOTC+L/C
	afCVk7atK7iVru6xY8cRyWeHY0cMBJ1K5nT49TwufG4U8t0KqNbiWPnZwH3nQZw==
X-Gm-Gg: ATEYQzyJZnWztFwrRuDpMfGxs2u3Yu6SKEYwfSRWURnwWhs9OiI2Mf6Rbn18CbEoJCs
	O5Ono4+IGcQZviX/+2R1VCnkswv5+nrzWNUJZ2ATZQSpgy+ue6Kq6F4lAyQPD6W7KKbGlMISj44
	Wfgxs48LQRh+uuoSafUru31jdyFWipjOSYfOdVtqEqGlVHxNDNBM8jNeOu3OswQue7ZYc9sNlet
	0ueuf5DI2tY7hEkip7tMHZMCsUTuNulSyWexbI5c8rEUBY/Lm8cqJ2GYCkVkDWm/S9+PTxJ0B+h
	6gr78k0WFwE5wmeSXQi+nIaNUCtmgBXSzZqiFSCyOCMWFFYz7GVsAccOimrlPd+lc+4sWBygXBZ
	CYxZBLCcX/m4SWJtOeCruYRzpOdw/qZXsBXajWoB4khe8WjzZdfXKHgQ=
X-Received: by 2002:a17:903:1249:b0:2ae:4fc8:3f5d with SMTP id d9443c01a7336-2aeae90b614mr21054465ad.48.1773225376881;
        Wed, 11 Mar 2026 03:36:16 -0700 (PDT)
X-Received: by 2002:a17:903:1249:b0:2ae:4fc8:3f5d with SMTP id d9443c01a7336-2aeae90b614mr21054065ad.48.1773225376299;
        Wed, 11 Mar 2026 03:36:16 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378a28sm21042925ad.88.2026.03.11.03.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:36:16 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to enable QoS
Date: Wed, 11 Mar 2026 16:05:46 +0530
Message-ID: <20260311103548.1823044-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ai9TUxazKBFRKlVO2RjXKTWv--RssXG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfX6A6T245k572R
 c26b8VLN7uWye7RLVDECuxBd3WemiZUmt3c04qjYPKcTJAR0oBegr+FXF5i0J5E7JEhhVfYQzQP
 D/3uHuE66yo8hr941JcfkNvJcBpl8BmvEF9ASKtIHi+FBh09tYzZ9Sl5bFw6W83xgaKRnyI3EPD
 VEfZzgzYHB8DSpJEUXK78hsod0Fm2l2q9AXbfq5+N4Cr8SK4nZeSHAjwgdU9b/SWaXCrvT4mT2a
 ml2Itq8CxMlIGO5SSVP6M1nGM/DTOyIitRg3HsKPfYw1qdjNGEkItkmfh+kq5tkue3eJHIWS2fC
 RWiU0jdkxgu4nWlrH2Hqqmfe50KJWYlVaFjdJcZWgatiNFtGblLXYeuJB7y5ddVlFMVQUuM5Cll
 lHAIhiDu8EIFHgUb5+P9gWygn66psHWn43bbFjZB2jvgJjAFufheLZaNacxLlnzVJpHgm85X6Ap
 f3X6A54pqyI4QtVF4lg==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b145a1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ulcEZqAivlg-R9bOFCgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Ai9TUxazKBFRKlVO2RjXKTWv--RssXG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088

Aggre1-noc interconnect node on QCS615 has QoS registers located
inside a block whose interface is clock-gated. Accessing these
registers requires the corresponding clock(s) to be enabled.
Update the bindings to include the 'clocks' property.

Ensure that only aggre1-noc interconnect node uses this property
by explicitly forbidding it for all other interconnect nodes.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,qcs615-rpmh.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
index e06404828824..ada0bf15845d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
@@ -34,6 +34,13 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: aggre UFS PHY AXI clock
+      - description: aggre USB2 SEC AXI clock
+      - description: aggre USB3 PRIM AXI clock
+      - description: RPMH CC IPA clock
+
 required:
   - compatible
 
@@ -53,6 +60,22 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs615-camnoc-virt
+              - qcom,qcs615-config-noc
+              - qcom,qcs615-dc-noc
+              - qcom,qcs615-gem-noc
+              - qcom,qcs615-mc-virt
+              - qcom,qcs615-mmss-noc
+              - qcom,qcs615-system-noc
+    then:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
@@ -69,3 +92,14 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    aggre1_noc: interconnect@1700000 {
+        compatible = "qcom,qcs615-aggre1-noc";
+        reg = <0x1700000 0x3f200>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc_aggre_ufs_phy_axi_clk>,
+                 <&gcc_aggre_usb2_sec_axi_clk>,
+                 <&gcc_aggre_usb3_prim_axi_clk>,
+                 <&rpmhcc_rpmh_ipa_clk>;
+    };
-- 
2.43.0

