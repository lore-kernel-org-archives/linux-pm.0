Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596723C512
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176580; cv=none; b=bXIz/qos2i1BZ5EDhxVzxM1k2jsv6j1C/1L1SwGzV3W7cn+LNU/N8TmtajZMoVsGoxxw5xz6T2+NyEqWMJU7u6nH4ShIhSPzyXGALWwHXLNQTNzIYO8USonx/V+hO2+pBS+OZ6LuDBRyoQ4MR/BoIPjIJoeb64oqQp+p2CDN1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176580; c=relaxed/simple;
	bh=RpiDGkJOR1Okpis1o/oRcRN55/N3YkysXuZaJy2F9x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SesqcBrl9HANGFQRyQUdnDMrMe5rArau6sqwI9ehfJu/Erq5LqSyc2BjKW9nrILBPId0WSwkie5wMxowXAWWAfPEy9RPzf8yM+FwnkAje6uAt01aHzGG0w9CP2MB0STR1L/iDrTFTu9N6p2vThu/1GnGu4ze+OYU+7QWnAGPJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/+rg6GG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aEcCECgJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/+rg6GG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aEcCECgJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4gPQ1525646
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 00:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4QnKBqRJ8Pxlp5wm0lmApGHFXTpwJPHSwOx0pf0DVY8=; b=l/+rg6GGMyR52NwQ
	VMVb2/fctF4G91zT908S+dhIIZC/12ez/pi8/bmthsjhwKjk1hldmOesKWDOZbMT
	tF012LbTRptjCoebRLa2APTwqy+a27grdvTZytLn70qdxo6nfwDY04tt9BJz1rJ9
	QSGjh9DA5VbHNsf6z0ZVWpv76T8ywBaM4J2+kTMDgGtz5zJDKBgVstspFXe8crjx
	Zluao3fwGvu2Qw6ZaUq9OXE4EhZw1gufCrcpC0qqYR1KkKipP2q+eL/qPvxnAgV4
	trbRoUovr+sxRvqLDQ6xRGiEQOlLGIAkv8S22QKKuy6uLcadKNJFXLQYY9xuaQa/
	WRdchQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcuc07f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 00:36:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12bf9974587so1100006c88.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775176577; x=1775781377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QnKBqRJ8Pxlp5wm0lmApGHFXTpwJPHSwOx0pf0DVY8=;
        b=aEcCECgJ90UVf9rtqpOXucfpfmCWJcGRlc8uJqX8DpIqMBUp0uajQqSYFjZcCQm7B/
         84fQY6tyVF35dLtrjUTcKsrvQyYj89akMV/3mZ5c3LW02o8msonsRCLv5m21o5GIcUBh
         nHUkRCOj9IgWD0SlBNsBLK9RWSsbIhUEWPW9g8InNWC9RINmOe2Hh30IBvmI5IKmzhrl
         iGox3am8REoFSMQ0v5+J7RN5vvGI/EwxUajV3UTs1Ye+6j+64gpiX07FlHKX8Vnn5Z3n
         TJua9cKUj2Yn966CVaa4XMVibUlcC4urWhvMjf9Y0DcZGehdvQ+3ZSlly7M6Rr1iWwy3
         lmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176577; x=1775781377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QnKBqRJ8Pxlp5wm0lmApGHFXTpwJPHSwOx0pf0DVY8=;
        b=B0MVFIdA5WQnerMR9ancqFq8NWpzFAzJVj9v18300oNO4g+L5zowe6Mpxw8Kh6iSRq
         4Xd7J++XvB5R802AH65YTVtpos21Y/229WIPTjnSqepioC9VOUqGc/fgVr8085U3H5Sz
         UmdUQeiXoa+acW46rew5v91+RI6XicELbOzOeJc0+Vott54z7Xwtpb0X28NBawcejRzv
         ncrtdeqzePsdj28A0hNESlfm+K1moqaK7dAfRvMbCQYUgJaYzxqQ+iGwxaNrEIVw/4D4
         ZDD40R0AbgB684QC311lCmUCR3eqoNo2HuP1x8U78jbmzMZ5ekweKiFHfQpg6UmCM8h7
         8TdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOsHZQGayZ0FveDHIixUMS3z8cCfrLa2djgpiVXVSoIhECBJ0/cWqc7SO7rtFoqMjh+D0zK/ruOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NrsdGnIqtVuDjEx94NrZLyI1CsS0YDHx2zfd0M72TgEyFr9z
	gG5Gg0FGMsqs/UBYNlVlerK5GLzmoDDvKzQsTU7P6/d2s+YUkH+UbU2zqd/wr8KZM6Xgqk1blLf
	s9MQW2Ov+VauzfCsfJZI1SmJj2VEY2RjLWvH1I1FqcS4D6z9jRi7CSnjpAmcZBg==
X-Gm-Gg: ATEYQzzGcYIMeEw5eLPGTDgPt5rn5ZGOvjkn35OCv4mA+OPm++EHcFdCPgKXmB8YT82
	GixY65S61QnRrXllI+xbt/suJqNLfpsjKKrJevTyauBn7pK4mmTufxjgWwd31VmN7JADWVYyTfF
	FtEM4zcBhA3wZ4Q6PFtHsMBZr9IM3ls3mNHQCko2d3Hy4cPwjBNrvobQqL7BeQUCLQHd30hdh3Z
	gdA4K96dy469WCiD0jTNCYCnv0/rJRRnGeDnTpW0IzBW98ycQnt7rqlHCfwYbG7Biy17WAO1yOA
	DGzN81RKNodEmy/w/xbl2R+bRU7UdIo+nFQeEkN6zf0hyjyH6Dd71SgDv5/JVUVgEhum14Fy3Hf
	X3vl6C2WH8XPVXdRo7b+zXtmxQ3nK/X03oMtzkBriITui6yINMCPQLFOsGJnZoQOtIbqUAH8wwg
	==
X-Received: by 2002:a05:7022:41a3:b0:12a:72af:83d4 with SMTP id a92af1059eb24-12bfb6ebbd0mr555500c88.8.1775176576735;
        Thu, 02 Apr 2026 17:36:16 -0700 (PDT)
X-Received: by 2002:a05:7022:41a3:b0:12a:72af:83d4 with SMTP id a92af1059eb24-12bfb6ebbd0mr555485c88.8.1775176576142;
        Thu, 02 Apr 2026 17:36:16 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm6290550c88.0.2026.04.02.17.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:36:15 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 17:35:21 -0700
Subject: [PATCH v2 1/2] dt-bindings: power: qcom,rpmhpd: Add RPMh power
 domain for Hawi SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-haw-rpmhpd-v2-1-2bce0767f2ca@oss.qualcomm.com>
References: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
In-Reply-To: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775176574; l=3267;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=RpiDGkJOR1Okpis1o/oRcRN55/N3YkysXuZaJy2F9x0=;
 b=w5vWo17PutDYOzx+dGXZzF9z8xU0BVO9E5tXb9ITVIpTEQz+ZzR3Lqnn2ml0Nl9FTrhKG/30X
 Q4OPX6eB9tcD4/taBHXjWirbQYaqCLrulk9V228Ks+tY+Tlc1dm+ki/
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMyBTYWx0ZWRfXwHO6jbatipWT
 N7PdWCf/AH0+L15zARzW9x+l3wt0Zt5ITOvVpFGyM1MPfy7wz9oDJ1uQkjhAsKDnJRWj44OERoG
 I3+lxFAaWc9r4eSXiCDnYxO4EcPGEsKVqgY+iTlsGVtH/bbGaJcxPqGoiHgPgAG+Rn3ZDmYkfL+
 r20/i79JXkySygITWYsLidgl0Hx3p0qBFByLa8GdPUxTQ1uXjM1vAYn5NtNL7K0GuOrW7FXLU+o
 STHEf5kKzXdl+qQGYg5zAvcM/RgavjKYREvcOyDX0nJuwW3xu1EXwsjQgSJ+umEw7kdnI0Ly+It
 VpcVX/u/bGaoEE/3wu92+WYXsAEsL+RLTHmUqVpojEKzZRpm8EtPoOOFFKvpbytHB2+YbJyV37d
 FFC7/PvUYMMPTBJrz7QEpQBNKSAPBRD1vC7RZ2fhe1Bt8Bfbm7wJSOjPAWHvMHa+h5MvMIGlbsH
 RvyrmvH49ksl2L6a41Q==
X-Proofpoint-GUID: wKCChBj_DZ4weuCtigpamkZwf9LOg9-v
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69cf0b81 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=j-8-n3vk8KpYigB0PxMA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: wKCChBj_DZ4weuCtigpamkZwf9LOg9-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030003

Document the RPMh power domain for Hawi SoC, and add definitions for
the new power domains which present in Hawi SoC:
 - RPMHPD_DCX (Display Core X): supplies VDD_DISP for the display
   subsystem
 - RPMHPD_GBX (Graphics Box): supplies VDD_GFX_BX for the GPU/graphics
   subsystem

Also, add constants for new power domain levels that supported in Hawi
SoC, including: LOW_SVS_D3_0, LOW_SVS_D1_0, LOW_SVS_D0_0, SVS_L2_0,
TURBO_L1_0/1/2, TURBO_L1_0/1/2.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 include/dt-bindings/power/qcom,rpmhpd.h                 | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 27af5b8aa134..35a0e01c2015 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-rpmhpd
+          - qcom,hawi-rpmhpd
           - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 06851363ae0e..67e2634fdc99 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -28,15 +28,20 @@
 #define RPMHPD_XO               18
 #define RPMHPD_NSP2             19
 #define RPMHPD_GMXC		20
+#define RPMHPD_DCX		21
+#define RPMHPD_GBX		22
 
 /* RPMh Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3_0	49
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2_1	51
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1_1	54
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1_0	55
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0_0	59
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
 #define RPMH_REGULATOR_LEVEL_LOW_SVS		64
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
@@ -47,6 +52,7 @@
 #define RPMH_REGULATOR_LEVEL_SVS_L0		144
 #define RPMH_REGULATOR_LEVEL_SVS_L1		192
 #define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_SVS_L2_0		225
 #define RPMH_REGULATOR_LEVEL_NOM		256
 #define RPMH_REGULATOR_LEVEL_NOM_L0		288
 #define RPMH_REGULATOR_LEVEL_NOM_L1		320
@@ -54,8 +60,14 @@
 #define RPMH_REGULATOR_LEVEL_TURBO		384
 #define RPMH_REGULATOR_LEVEL_TURBO_L0		400
 #define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_0		417
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_1		418
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_2		419
 #define RPMH_REGULATOR_LEVEL_TURBO_L2		432
 #define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_0		449
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_1		450
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_2		451
 #define RPMH_REGULATOR_LEVEL_TURBO_L4		452
 #define RPMH_REGULATOR_LEVEL_TURBO_L5		456
 #define RPMH_REGULATOR_LEVEL_SUPER_TURBO	464

-- 
2.43.0

