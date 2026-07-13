Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA43F482A
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943911; cv=none; b=K40LpLdbORpZqKu6SIxV/HPU1lUcv6iw/04WcErECoRomleqjY04AdQCkFx+MWokUr7cQTwAYirxpz8sVcfJIC/kzD0JrQ0CVsT8D64GpjkVnaCQF8Jn0CRZzDSYaylPOcqJCGRPdEj1LElK0i5TR21p1u8ZfIVYm5PKi7J84uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943911; c=relaxed/simple;
	bh=sT38bhRjWOjfdjgeqQAmE55i7pDR1ODIXujcQKTrYXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m29Q6pdPL7tRI5hTs7Tqzm/DC2lErk5kMdJQziM+/HW+n56ZGsTtX8V8F9Ul6qc7MDyMmmgLpl7I9zioNjSsImjvyEtHwjzpXCHVeMZiUH5ZSRGi3G6c7pXgQTajgAPysqnv4C4GJgyr7EipsWvRByFvLn3HlP3aApsOG8OxCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ATI9jp4Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hribDZEO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATI9jp4Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hribDZEO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D77OlG810510
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yaXmFhfBKuGEAAuHt4MFeEPEkTShnS0CQLRSXab8O8g=; b=ATI9jp4Z6w+G4JQh
	WVY7KWuyroHXna46KmfiNMp9o6C2fWryNubMAoEaylH10pGipJs1aKelZWs3WhQH
	HhUjeHVkXYWk6QJot/nZ/W5wj7EUCqHlh9nJRLg9Vd1QMSuGXI4fbZE2KFiH16Jl
	8MNkpBddaxrvcxppsUEFAgGDxivgGiN3O5ZwlnvBilft8b62ecOlrEui1s+KEAwt
	sFTsFWC5zdDg3xdqYK+qTZL7Ej5QQmj66r1DGqCJNw7EpOYPPykkBWAi3UeF4wlZ
	yF8sZgnTAoWMpSaXObWfoYgWTK60p/Uuc5ELCOD19UDAxhx+rkMp2EHT4Oa/Hbd3
	Zpx0QA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubss25v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:58:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso2767558a91.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783943907; x=1784548707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yaXmFhfBKuGEAAuHt4MFeEPEkTShnS0CQLRSXab8O8g=;
        b=hribDZEOSwHhzNZhYHk4EXAmEVV2YenfS3pO/QIHcTwiczTgfUvAgBzL00I1E9i5A5
         p03jAYqH7ifSIdRfjHlyGB7PC9X7VcvyxVqeqTbufEBt9irpC+W3D48ISBPpxdAUzVpA
         wRJbUuPeNn7NneLawfuO6x3Vptr12iE1x18T0Jpx1zPYnxTXXT17A/ZuoFZRsOgqEOHw
         tJ8JNVSJYVNAzfGv6xnUbr7va1ovkYCPkpxgQr3qhpg0fJpzhlPKBmnNU2PbPFlln/bw
         tefcVIQpZ1+w90DtfpVYnolYLpgAs/vQVxhtjBRhlcMU1PxcySEL3zbDGE7Hz7pQL714
         AZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943907; x=1784548707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yaXmFhfBKuGEAAuHt4MFeEPEkTShnS0CQLRSXab8O8g=;
        b=sczn/jRLknqGUW9K0wDU0mq0OzVUKy6nwDvnCI5JeOVf19LM2S/8MxAdFv1mCOCc/V
         X8djwHeTWEn82iFNX4n0qzbLUp//eaRODhuNSN+iKs1/KXZ8Dnl/oz+cB3Oh4Ue3CyAg
         psm7bI2D8+JKmjTPYtRcp1iKR8VgnLUMwFmpk2E78xK4DyI/7BmfzRieYW4A7KCORIGW
         0N0Z6kRCavDfYAzxl7dz9hzDZilMHCuPpGrAXxuR3+parQKtNgQyufDjIUmjdh87Oze7
         WHloTpVRo2/DoTGr9KC8f0b/THs01SD0ZneZVx1cGrAQZaSaBh9IOkHuhBJSsJR/LLRu
         xRFw==
X-Gm-Message-State: AOJu0YxrhVQUMawP8zWhHpoQrCrJy7tQg3bbM2xi1KvWPuF/dKxGQXmg
	YOVba22MWfKDLdzHbQDXgpBkVGIn5Lp+xyD7OpWQjbS7onhXlaPriWZGTzYjEHqUVZ1OzrjRrRH
	Yap7Dyw5Q1s1Nk0CSsolAvMfM4akFBgocdX+l29pEIB55s+wY8IqHh5/B9bE1
X-Gm-Gg: AfdE7clfAhvpSZzyF1NCTAdT3jBgUrceVfUqccX49MdIoWI7J/V3AYi87MOHCrE81zW
	BZnIhpksolv4a28HU2on+JwpYzlkuwtq1lfYA2v8gaSWgriwgUPQjwpQf4O1LuYVeKXSv9PCQRh
	PZDWPKhHLr3L3ZB+OFfX4L3FYT+kOHwv9topJfcG9E6Vj8ve7w8WCE/3twZWZ84t9D+/AjM8WtV
	kLMt9l1oNViIprkm8PRcRa3Er8WTAowjSqPf+1MhCpsvipat41sUdB4c6Qrii0XsTSCoiuCCqSF
	4pj//VYSbLmfxAdbD6j64MtaQiKTW/k/rNZ5GHWXXLRHIlilVyPIsrDL85c2PCfmOJH+j2IaUHy
	wMOjiPxZjIHwWyrNEVq/pHhHXvwNTvxwnRAGqBGue
X-Received: by 2002:a17:90b:3d92:b0:38e:bfe:81e3 with SMTP id 98e67ed59e1d1-38e0bfe913bmr1051360a91.8.1783943907409;
        Mon, 13 Jul 2026 04:58:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3d92:b0:38e:bfe:81e3 with SMTP id 98e67ed59e1d1-38e0bfe913bmr1051342a91.8.1783943906917;
        Mon, 13 Jul 2026 04:58:26 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74546638eec.31.2026.07.13.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:58:26 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 17:28:14 +0530
Subject: [PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-add_pwrkey_and_resin-v5-1-3bea476e1453@oss.qualcomm.com>
References: <20260713-b4-add_pwrkey_and_resin-v5-0-3bea476e1453@oss.qualcomm.com>
In-Reply-To: <20260713-b4-add_pwrkey_and_resin-v5-0-3bea476e1453@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783943896; l=2486;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=sT38bhRjWOjfdjgeqQAmE55i7pDR1ODIXujcQKTrYXk=;
 b=xhZaSCR40tr3xKCV0IHWfew6V97K+9crC/HzyBEmirpN0Lv55CNSQcWJj9WJ30mCJI6dwSBlz
 loIX53kRIlRAF8jHR2aShiRuQFgA2ZRReUqqMDtYc5J7XznbV2iMJZu
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54d2e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=s_ZZa6GQdcgv8AlZDVsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: kXUA33AIc8X4lKSltBqnJgK_B_A64_T_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX5T3Z3WWXMD2d
 YaaXVxqf61t8VABdaK7qDcCdDcx2fHv5/WaOrlXvrsLFBkhzUuyzk0eimSVCZs9coRDPJHzwVe1
 k0LuN8TPc9fETVhQekpTzCGlgnGNmT0=
X-Proofpoint-GUID: kXUA33AIc8X4lKSltBqnJgK_B_A64_T_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX7CuuCA1QhRHg
 nicB4iWOzMdg5jQJx06KuUOqGrOqZQya4EJbx0yYAwTKUVkhtcg07PpTn4psTs5mo3F/bXwg1ds
 DIG6xU5hMaDoOe97xGkcwGhFSmJgBn1o9fAgsZOm/j04qqPPFa+s3CrHLi+3zlFUbc7rBN72CiK
 WKo6rDueTBWJeJZXXRLFdNm/myrzZBxGRLJ298htMS0etjUNQ8aS5MI64rwo6Bl0R6Qtw+R808k
 2XnJQfUZK6p8cDjYr2lfnXWDp0ISjnRzBGlMHU64y5uErz837XEfFF7vEtoXZgDF0NQRd0FMiv7
 4sKTEwwU2c7Xcud9CyoNirNgRxx1ndzBUYFnYQNqBd/YKQpQFBp4niRF+Q99RmvRSmFLY1l/GVj
 CG3L1zx5qr/QT75oX+pzm0+pHpWIBdiIiqBIeRVnl/oBl7H5opOZmxGmxHTP9OUDVlRDRQRB1fQ
 mndxgQY0bPhp9o31AyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

PMM8654AU is a distinct PMIC variant from PMM8650AU despite sharing the
same PMIC subtype. PMM8654AU implements additional registers added to
the "hlos" register address spaces, so add qcom,pmm8654au-pon as a
fallback to qcom,pmk8350-pon to distinguish it from the baseline
PMK8350 PON implementation.

The GEN3 PON peripheral requires two register address spaces: "hlos"
for the primary PON block and "pbs" for the address needs to be
specified to facilitate software debouncing. Set minItems: 2 for reg
in the qcom,pmk8350-pon if/then constraint to enforce that both
address spaces are always present.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v5:
 - Set minItems: 2 for reg in the PMK8350 if/then block to enforce that
   both hlos and pbs address spaces are required for GEN3 PON peripherals.

Changes in v4:
 - Remove the contain for PMK8350 and new if:then for PMM8654AU as
   suggested by Krzysztof Kozlowski

Changes in v3:
 - Update the commit message.

Changes in v2:
 - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml     | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..09eea48c709e5e42c45c1949ee1d06298dea1f91 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -17,12 +17,16 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8916-pon
-      - qcom,pm8941-pon
-      - qcom,pms405-pon
-      - qcom,pm8998-pon
-      - qcom,pmk8350-pon
+    oneOf:
+      - enum:
+          - qcom,pm8916-pon
+          - qcom,pm8941-pon
+          - qcom,pms405-pon
+          - qcom,pm8998-pon
+          - qcom,pmk8350-pon
+      - items:
+          - const: qcom,pmm8654au-pon
+          - const: qcom,pmk8350-pon
 
   reg:
     description: |
@@ -105,10 +109,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 1
+          minItems: 2
           maxItems: 2
         reg-names:
-          minItems: 1
           items:
             - const: hlos
             - const: pbs

-- 
2.34.1

