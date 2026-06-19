Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0118027
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901569; cv=none; b=IV3YOIbvqIZwEqa92M3gyVyxkZl896CvQmoKbaukgpq8WfDUNatsjlebtWS3Pgj1Ry8kBRFiOz2+I3HgBYnH5qz9U2AkJqa/xZnqmr+ijdog8JxzMYTJ0RTZQm6BWCgVx4pynuS8iImFMuA0J1dbZyGc45JWNxHEb7cfZKbkzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901569; c=relaxed/simple;
	bh=mzAivGquTuxKJRNPNyBa88Cm3gzCu0h5ZhS95ueAnpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RFeO5jO3KD2nvWTj/kOJ3EiJLhOVqhuDCdWNml3aV/DcS7QPE/TCShXgUhq80HPNKbPkkO+cHvgVypcSg1m1QX+3+NzzBA2cQUZqola8CBFexG+hKV+k1+vZTI2X5PH9uGNXqf5XD4gquEFWiQVvR609dSGBjA+mrxOVfmfPWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXvc9/4G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFneWPWq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXvc9/4G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFneWPWq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHSbnp821449
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1LGsZZQGHjPFgChcl2b+wr
	rmhmSGdGUPrKtAPR68/hA=; b=SXvc9/4G06P1rvR5AKZ/HM6mwLZceIQFPMxbif
	093N7oZCdd3kRgdtNsddI/Uph0FFq6NayCvRiJQbU3T3jTgPD3YSqfraWghXQVN0
	mc4/6M6l846Cjoq3lZ94iWcfGw3dY919ts2D2aT3zdILzA5GL8wrSPh4Hxj/3mt2
	JR3V8EcDTtu+90WEyTYV1/xvU7biuNeXJRyoW1Q24d2euSx5y13BL7bzQYcXRH/x
	TzJbmB70imCHzAivuxBzvxR2Je6aQOBDGCIzKa/IXZ349xt5leos6raG7LVSLhhv
	9v22eK2o/eJYb1dLj1oYWdmet5WmaSzwtnS8Mm57IgBjsJJg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp674tdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84240683a82so1815901b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781901566; x=1782506366; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LGsZZQGHjPFgChcl2b+wrrmhmSGdGUPrKtAPR68/hA=;
        b=JFneWPWqIKwt76JaoySf4N3j2s3OjJC8ejBlvRF7HYQWUyfSiavnp6rnCbcDStzfxd
         SnJ2a94Uzq/suEEjF8c8wnv3ULLLC3BKYYGhyQGP0kk31wM6tQ76X7Cqht08cv5CU46t
         R8fPD67jyXw7RNZTiykQ3AY6JsCxS+UMiI1JxSuVfA5Sv9I5CI5FNXgVNLbILQ5zoFKD
         R3MybJDGJyGLtyjT1Q05ornLMu7prC/zeMaUKkdghVPNSgTh8ybbBIoMQxKKj6IvKZDZ
         VzhVZy7zG3VqxVyMLqDnRd9BR/rSrZubDmME3rQGkxV/9VMV7DnEIjLDxcRo0WzSXRXW
         KFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901566; x=1782506366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LGsZZQGHjPFgChcl2b+wrrmhmSGdGUPrKtAPR68/hA=;
        b=VwF6s+wsurjFMf+gv9trbR2WNfmZKtv5uCnwX2JnimKFrCFmOFPZF91UbeU5l5qwk7
         77+MqVMpCki09L/g5DiUb+EBDwMepqz5Mz9WXhQi9YNUZkdtmJ++0fSfoJVFgM6l/x16
         fWzUk1TwFJY0TkhFNcQVesNzjQ1CoCUDbC4ZSZO41nKPNO8qTYtqb/+B8JLVu/3yEw7E
         94JotRHRl12RYlX9JZ5vXn73unVuZBFhE505PmMhWNszGtVPmRJDDYk+uQG4gHBDlcEf
         VWaPS+yRN9zDuCraeRq2rRrCrkr3RfK69rIW8pjtaMyEFtQyCWmZqU6wWU5Nsi0gvOS1
         dN+w==
X-Forwarded-Encrypted: i=1; AFNElJ9UaMwpv7KI4DOnsqKmcpv0b1/T6TQksqqPI4EpxXZdL6STXeaKCVmksU9CX8LzJ3jAMMkHgWUUyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0bypBiVq8hXxpMFK7v3eOl3pi0NDD7XRUXU3ejHPxHBmWYTH
	JoR6OQ4AND5X57GE9uylYeT32ZLrvTVR9fTFFZiGmE6l6D1N71jF/D0c8Co4ylWl94tY52ar9+U
	VTi0XvQPvbex8Vbcm9/mZ2g6cYjmd7IDYZiL285WEVJt5WNOboKYQ+TGmQeOFvydEjaWR1g==
X-Gm-Gg: AfdE7cmN1SsOzVCZTtCSk6hgWEHGSYSmAeXMJpvAkntG4NgKm7ubTqmfYU/4HvQ1OTM
	Es8l41z+o0qcpFaaICG0RU3aceRoDGYAZJD2zRM8qlknsV12Y8QBH5wSuL8/5IV1HyGie/WmLhT
	Q5BI0CEBTzGZF/jGdt7C+SA17j3yPvjCAqgukkzrhhK/j3xEbf3nh6OIaOgDhMMJK/SxzKDUad/
	mn/Uehnovur5BANc+FDBvEkIYrp3RWmuzD9TW3xNvsRq3I3uQ4r04/YBQkknM+2GBhwGWA5EcVo
	rpBreyqCwNtnX0+srvjMIBiB48MNW9ctib4L9wtc+LOe3l6tmKrMXVWQeToFo5yuNeqqDr/tsgz
	1Lz2sImCCdPMgDHNIWiD2V0P1UmY8EkKFog5P7XQp7oUqZQ==
X-Received: by 2002:a05:6a00:9a7:b0:837:8342:abe5 with SMTP id d2e1a72fcca58-8455023798fmr4319442b3a.18.1781901565691;
        Fri, 19 Jun 2026 13:39:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a7:b0:837:8342:abe5 with SMTP id d2e1a72fcca58-8455023798fmr4319427b3a.18.1781901565110;
        Fri, 19 Jun 2026 13:39:25 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd779sm94190b3a.53.2026.06.19.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:39:24 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add Qualcomm SPEL powercap driver
Date: Sat, 20 Jun 2026 02:09:07 +0530
Message-Id: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuoNWoC/43NQQ6CMBAF0KuQri3pVFvAlfcwhkA7SBOh0EKjI
 dzdwsaNMW4m+T/5bxbi0Rn05JwsxGEw3tg+Bn5IiGqr/o7U6JgJZ1wyAQUdle1KP+Cj1M4EdOU
 8+Mlh1VEAbHSucoESSdwPDhvz3O3rLebW+Mm61/4qwNb+owagjGbiKKSGOmuK08V6n45z9YiTL
 o2HbHjgH1BC9gvkGyhloQEkU7X8Aq7r+gZlLNwBGgEAAA==
X-Change-ID: 20260519-qcom_spel_driver_upstream-11efd8c85e6e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781901560; l=2710;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=mzAivGquTuxKJRNPNyBa88Cm3gzCu0h5ZhS95ueAnpQ=;
 b=wZNSWCLWJySoGaPwV0dKLloCPK6whcIsD4RLJBATv4QwY1VfvwTagxlXN/RrcMCjd0cUcZoJM
 v87SaWd/HGKAIc2b2VlebU+np/iNYBkJ6E6vIqnnS4RhcOVqeC58Ncu
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-ORIG-GUID: tnL4S1cj9T3FIomLLPgGCWHqH2ia4Niu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfXxe3GP/PKXnqz
 e8pHZe7BWbqdy+BmMGdXsRlZhY+A5bXgSjRlJmnlKeQ5rQ1WYLpLNjeeivHhiKgedyQqW77K0M0
 iZZK9XcaOXKOKxOx70g73OTk0xsAlnFfS4cf3Do/tK5LaZL+z9OWvSknqJ2hTpB+jsvmd9R4ad+
 0HyH4PxMSjSTvI4Raist59e0r9679ywu5H43zsreVDAQAFxCDacrcupWJ+o4S3f1/cB918Ftzb/
 odj8KGg+dUjKqnU5KrhaNKXoLt+wDIrvpFaBGIg4UjVa8X/JSLyta8rA8PbCGFgKAUVYZvEscas
 5dYHq/LAWyydDooQrJ8Riyu0XJhX9IM1bKL+Xy4c519J0nD82r75l0hzYqqL6rBCvEMi206Gj6p
 z4NZMGgjK/4V07WKoGEDmYbcy+OpH84aSINUGSzmNBME3IXY2JC5m+0uMj81P8wUxtFeN3NLTAp
 o6Rpb+e6/LLvguASLMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfX0Az5vIkCd9rm
 dBt8YoJvBSWiwqqfZSx7EjPu4KYilCe2y3Yd979/yQtfqdNBT6SuGpmkonZ+HQCeHwyS1Xkxxzm
 4dQ5Zk5tt4MqQx2DERQGrv+mofS8BKA=
X-Proofpoint-GUID: tnL4S1cj9T3FIomLLPgGCWHqH2ia4Niu
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35a8fe cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tfgfb8oKCnp2c5w_Q-EA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190198

This patch series introduces support for Qualcomm's SPEL (SoC Power
and Electrical Limits) hardware, which provides power monitoring and
limiting capabilities for various power domains in Qualcomm SoCs.

The SPEL hardware enables:
- Real-time energy consumption monitoring across multiple power domains
- Hardware-enforced power limits with configurable time windows
- Support for up to 4 power limits (PL1-PL4) per domain
- Hierarchical power domain organization (SYS -> SOC -> subsystems)

The driver integrates with the Linux powercap framework, exposing SPEL
capabilities through standard sysfs interfaces. This allows userspace
applications and thermal management daemons to monitor energy consumption
and configure power limits for optimal power/performance balance.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
Changes in v2:
- Fixed DT issues: corrected unit-address mismatch and made compatible
  platform-specific.(Konrad/Krzysztof)
- Cleaned up bitfield handling: switched to GENMASK, FIELD_* macros.(Konrad)
- Converted hex values to lowercase and simplified array definitions.(Konrad)
- used devm_platform_ioremap_resource_byname().(Konrad)
- Refactored data structures: merged domain data into spel_domain_info
  and removed hardcoded limits using ARRAY_SIZE().(Daniel)
- Added bounds checks (TIME_WINDOW_MAX) and fixed time window RMW
  handling (preserving reserved bits + firmware notify).(Sashiko)
- Resolved use-after-free, replaced allocation strategy, and
  added proper cleanup in .release().(Sashiko)
- Updated time window calculation logic.
- Removed cyclic dependency, improved validation logic, and aligned
  naming consistency.(Daniel)
- Link to v1: https://lore.kernel.org/r/20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com

---
Manaf Meethalavalappu Pallikunhi (3):
      dt-bindings: power: limits: Describe Qualcomm SPEL hardware
      powercap: qcom: Add SPEL powercap driver
      arm64: dts: qcom: glymur: Enable SPEL powercap driver

 .../bindings/power/limits/qcom,spel.yaml           |  47 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  10 +
 drivers/powercap/Kconfig                           |  13 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/qcom_spel.c                       | 776 +++++++++++++++++++++
 6 files changed, 854 insertions(+)
---
base-commit: 80dd246accce631c328ea43294e53b2b2dd2aa32
change-id: 20260519-qcom_spel_driver_upstream-11efd8c85e6e

Best regards,
-- 
Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

