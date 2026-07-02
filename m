Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A15360EE5
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012995; cv=none; b=q3+CsZealA1WTy/fF4u2w5ZWRyp21a7KAhIqNBsveSSrleoCZCZGao2WkGdZPqSc5J2mK57UaYotRtUKbbQQ5RHhY847BJ60pNoE8lnWGgat6Ij3UYdcdOte+5sibfNP+eG050o5lqlGeSeQ4VjZZgGT//FEcvjpnmLFx7tq/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012995; c=relaxed/simple;
	bh=SQVELIkS6Yw3HpdkUdHKEkrxPxte6hDRaNWPxNHtyYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V78ccbeBcVjoc87jAqORwpfLS3OQ6kQB6TbwYZGdRgV4U1rd1dqyltAhXGJtgd1YQ7knlX5PATq4iArPmFfbszvY/nGeob90kYzXWEIOnLYw4KtO4DxfCCsMCKDFkjI/RZXE7aNL7Bnks29GGicOuGkwMFcrJPFonNIhUmxOc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZweog86; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LpXqr4S9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZweog86";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpXqr4S9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3Tsh549154
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 17:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QYGE1+3lnFBhSDxCjuj8Jz
	Eg+wB7iM4pgaTuFcIUXHo=; b=mZweog86Hk5bnj+K6WHhKGjju5PousPJQZreQu
	1WOaaKiR27HFpXBA/qA27o5OBdg34shk/dxsvWYf+8dU6GrStEJKyrcf/VSlRjaI
	yBi9kxI0b67dWKL5sM+3xPp2g6JZHXjmQaf3xWEmXzNmv4v1t6wfRI/+v74oBWIE
	jfLJPdeYoqCp0NAhw0FH+w7JeXxcuxj80wMQFplIuxfoX0uE5bTLNPkf1WrJWzVm
	9kvKLbFadycssuGi5BaXJVEJgqDx5s2HuO5mC8zpK84UUMtg6oXmja/zlga17PWM
	glqw4U9aZ2XRIbpWmdHyfcXeky4UTSlCLtvwL3Q97Xw+3Ncw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98jyga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 17:23:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso2752690a12.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783012989; x=1783617789; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYGE1+3lnFBhSDxCjuj8JzEg+wB7iM4pgaTuFcIUXHo=;
        b=LpXqr4S9OWWfM+IiXS1m5wVRll0oDiTTtrV/u5msN5na8JC56fpvXmnt4qEjgna2sg
         y1ocud4YAGqk/ZUNy0eaiMIcgAm/dFh5Vpd7Y+eY2yOidVmWt4E23PgavIgzi8apDveD
         9LbkD9eMqW+zpvm0qSYLy+DndtNmIAKLzEGpSYx3nASQiqgrXq+ty5IJNUQ6qRGCBh/b
         vuqDuF/oEFgGu2lHzcKZ2/E1BUSehHwNUYo7CUKDDgL4QuTp3SAL2ZF9XdSUTXww536r
         IRXsk5Q5LhJRYRCV+QBxKSXJYWbQSXbuYZpQ3qwHK7bIgqHmvStw60xakKrlsOyamic2
         nsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012989; x=1783617789;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYGE1+3lnFBhSDxCjuj8JzEg+wB7iM4pgaTuFcIUXHo=;
        b=XRVFjOOuIW2phDh6mLFwBCMpZdFngujcZwZvqXDgpskCoOB7zYd6iWWSbrtJB2PEj7
         0itikNZIu0D/scyjnxxsU6Bdv9PSm+nfJC286XFitHmZkqSnUhx3nOhfvAGRtBZaktMw
         wCb/aRNPPk6hpOSAuyuFhBjK2FN5zNDhlLbwqHlQF/Uf6zSJ5sFBYxIPJLkm3PV2YX67
         03ByHZFLctEwY7Cxt4f6aCOvHe8tJIROz0UFVj+snkpqg8i/Z8Zt7ltyvYdt4lM6aKg1
         Wbp8g/WIKeOcRZS011oRc4AuVgGs5M3fWOID221GZIPVzi9JWv+3btj0J9NmN8aPOujb
         P5aA==
X-Forwarded-Encrypted: i=1; AFNElJ9bXOmazkC5bt+kUTp1gJfmL58E+dl+mnOF7n2iwKiH9YBB8VpK2Reom097U4O7YIcuU2RnnrU3vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5M/dlFjZSwH/6SNUoyH2KOEsYmG5H8b7xrAwqa98ZKFl+oqdg
	Z0lcvWn9VF+KCDHTEfso1k9CMQKfHWLQDznbnvWDWeGZjUVx/kmzNVJG54BDBDh2eYenMMT60dl
	gr6EcBDQxxowFsJGWflQqelhHVwofdRWR4G4ZNb8yF6zvLGF8gBqcixEq5haTTw==
X-Gm-Gg: AfdE7ckGfI+g8HsnKJm3+m9w1MP1lkLsWc3+rR7hPo0X698O/GKbPSv43mSu4gOks4u
	kamyzR4wEdJV/vHMkHNSOQRh7Qq08/jpYOytLmHb8Fx7DMb1WENfmBlutyhggsGckY3fDz06mZj
	f6FSfvY+goP6NeIg84QpWspHyZYXwY6PorIGRX1WZNN04Q9LqzOnyTXh8DN1G2tRypgdz1eXoP6
	SrobqnBkTQnvNUa0VoeKv3bE6cyjgFKScscY4Wxt2kJrv4J4CALIn4zkdrzDBLVBx+mvRPeA1DO
	0IioDuOfUPk4LzVOc3ql0NlORgnT17TqUTNqb5wuh/Vo9BalvYFtkKGpeAWo2OzmAM7T2d3QWK4
	WX9YbiqDiFf8HkQuWdKwnfrCDswgcBYOseftHqMMx1EnBFg==
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr9157694637.19.1783012989472;
        Thu, 02 Jul 2026 10:23:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr9157650637.19.1783012988774;
        Thu, 02 Jul 2026 10:23:08 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm10564289c88.8.2026.07.02.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:23:08 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: [PATCH v3 0/4] Add Qualcomm SPEL powercap driver
Date: Thu, 02 Jul 2026 22:52:53 +0530
Message-Id: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2eRmoC/33OTQqDMBAF4KtI1o3kp2rsqvcoRawZa0CNJhpax
 Lt3tItuipuBN/C+mYV4cAY8uUQLcRCMN7bHIE8RqZqyfwI1GjMRTKQsY4KOle0KP0BbaGcCuGI
 e/OSg7GjOci2zSmkFimB/cFCb127f7pgb4yfr3vupwLftV014fqAGThnNEpmkmj+yOj9frffxO
 JctVroYB9nwIH5gKtgRKBAsJUCq8Fuu6j/guq4ffvyX8RoBAAA=
X-Change-ID: 20260702-qcom_spel_driver_upstream-909d37c8d8e8
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783012984; l=3809;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=SQVELIkS6Yw3HpdkUdHKEkrxPxte6hDRaNWPxNHtyYs=;
 b=PIjNMLYQ7O2dYZ56VLmjm9CtsrsqOXdg82ZMGQVPKWDEgjirbY9X/L69V1Px2Ssao2hxENwhx
 acrfzqMv9gqAS17eoyUjTF+RHPsUFummveZBRGc7Mos9hv4sqmYWGbo
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-ORIG-GUID: pVoS2q8TvpiKAHb55JakS81m-4QXiT1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX/8jlYbH13jtl
 pZET6vcrW2bi9mQivyTwE/qolAT+2y+zbNTQUfFi3H2I8+CnoJ3DfYveDOKBJjqBVe8/vPLW5nF
 wfbvw8/wOcFsrFXLp2R9ftew3q8LcGmptAjwbvfLTGUZndCLvtuQY73ettsOyTNVlFj+4MFxN6Q
 vGwTsqmw/uD2FJ9/HKqPt0RWMeOkX3TGRVOyJPCAlFnFQA+xJNP+z++XVe3b9cxONUesI/EmSYm
 oP3kTnYb0Ar63KUmj37DFiDxCTNXPhGP9VP7W9ODUZAV2D1Ogu4IiZLGKHkgrg+riAcVyRAWNJ9
 O7P0aeeicj1RFFzELijTYTZdJ1pvWnKeowHE5fFZg6RJTOZ5mldi7iYT1SntDpqsFQ0AIyK5Lb1
 7BcJwwd6jFVxK+rWLmWg584RUEjCCh4MN3jCa1bide3NIOyrSnA39omj4lpaxgEoWM3FoCUsd69
 3P4Nn9BZ+P85g654szQ==
X-Proofpoint-GUID: pVoS2q8TvpiKAHb55JakS81m-4QXiT1g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX8xbgaN/jzb/b
 0QirCAb3a0hd/TlhOGzOt/1j/CApYIhlGxaQQWZrIwNxLtDIJ20CR7g1ZJ/8OthA12TQ4wfuRCu
 ck9hmQ6WSva65B19EXO4nkxvB6vTS2Y=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a469e7e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1rr6DjYnXoqnmp2ReCQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020183

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

This series introduces a new power/limits directory for power limit
controller bindings. The power-limit-controller.yaml schema is added to
MAINTAINERS under "QUALCOMM SPEL POWERCAP DRIVER" in patch 2/X alongside
the SPEL device specific binding, as this is its primary use case.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
Changes in v3:
- Created common power-limit-controller schema under power/limits and described
  power-limit-controller device common capabilities.(Krzysztof)
- Created SoC-specific qcom,glymur-spel.yaml file instead of generic one and updated
  description and commit.(Krzysztof)
- Used FIELD_MODIFY() macro at different places.(Konrad)
- Updated glymur specific domain info table.(Konrad)
- Updated all for-loops iterator declaration to C99 style.(Konrad)
- Fixed use-after-free bugs.(Sashiko)
- Corrected time_unit documention to reflect the logic.(Sashiko)
- Link to v2: https://lore.kernel.org/r/20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com

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
Manaf Meethalavalappu Pallikunhi (4):
      dt-bindings: power: Add common power limit controller schema
      dt-bindings: power: limits: Describe Qualcomm SPEL hardware
      powercap: qcom: Add SPEL powercap driver
      arm64: dts: qcom: glymur: Enable SPEL powercap driver

 .../power/limits/power-limit-controller.yaml       |  34 +
 .../bindings/power/limits/qcom,glymur-spel.yaml    |  61 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  10 +
 drivers/powercap/Kconfig                           |  13 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/qcom_spel.c                       | 803 +++++++++++++++++++++
 7 files changed, 930 insertions(+)
---
base-commit: 4f441960e691d37c880d2cc004de06bb5b6bd5e4
change-id: 20260702-qcom_spel_driver_upstream-909d37c8d8e8

Best regards,
-- 
Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

