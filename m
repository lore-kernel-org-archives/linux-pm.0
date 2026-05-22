Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324291A6831
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438125; cv=none; b=g4juUh8XwcqK3ejA4KPHBFv00iaz1dJc+qA18CagjMUyNBNgtPVfz/lmW/2tmmYQD3WNKCANxVPmSPYxupURQSPzitn76I5ePa46fO3kRqpEI9x3ZbHHSmG5ZHTBnPzKSCPiRGkvXEb7y6GdDnfOqccdAocafrrXzhIVoL5JHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438125; c=relaxed/simple;
	bh=azs06BhmYqKoQMjBwv/SMVh5kJKS2q/NUFKYoAlJrk8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZAzt+NZh75E97V4gtozHIBmOWK2Dbn1+SmMWomA4W74c1lmLfUPFNpFRThFZn4LCYS+0aZfTTcKAabeYavlyy9hx1fv8XFjbaf8itp/n8uUqQ9ZxcFpKu80B6IvQ8EjokDlmxlwluHwyflOmukpZxGN2OcV3V1v6AP6rlG+yrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BFKQwolK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XcQ08um4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFKQwolK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XcQ08um4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M30bQg399205
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a99CGclp/7pz+A1+MObzra
	ZAm8oXKx94yotIaZEBchM=; b=BFKQwolK4HqicGAFInPVwRQd0CaNZAmUwS2EM8
	w3vS5qCLkrO6yl06rSCZPIvqC4OLzMOdS+CKMHCLgo+elokrNM/0C0rEaoNMhb7g
	yYKQVm+bhhBZCrSPkrUR6UzLn3IEpIYrLJWLSnn+Ydkb9T+IYfs6lM5jsXXJlv+z
	htfoL0jv6kgvbrYNkWGIYS23k42KXa+CkECKJBpNwSa519OiWuXdU0HkbWBuTiPN
	XozeM1ytK3rzoL7gcexxJcwgX0WwG9N7u41bZbVvvFZPyOzZSsLGxs5TAqDOUesH
	ruhve+t2CMSobzZo+UFpLRwv2SB+KG4FRJxpHxy1Kxpl/PbA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9u9nn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f85179263so9198759b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779438123; x=1780042923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a99CGclp/7pz+A1+MObzraZAm8oXKx94yotIaZEBchM=;
        b=XcQ08um4OxEKES6zwhbwA7+MUI0+CDDpyumKCM60bzVwy1spZEYzmZaJHeCmv8ICJK
         mtape8l0+U6oi1RySdYuerEgQN2y2fgLXxP/QYBmA0qEuu2g70ZJKlow/S8xi3cbM6X+
         0IdQexg7NtY+hQthEH3XY7kwlwtyY1egJSDvd9mYqCelv3ZYw3amlxwmvRrnuNx2MYr8
         UBafT2ZzVvrev4B9TiSGb9wOpPdYF6ognTc/UVbfhKsrpJy6U08O57OrpxuXZrJ/ePGu
         pyqYjz8KHeSmoe4YLHj6TfFyrlhfTzSNKPZzBob3Ou0Ak5+4mHxDwYRzDTfOWbds/Vr4
         BbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438123; x=1780042923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a99CGclp/7pz+A1+MObzraZAm8oXKx94yotIaZEBchM=;
        b=kHvxaeARk2g2jgX4iq7empg46uLy5H08F3j24szelJV9jTFGq1jc5bI4Yr9iRP80Yr
         WquE5XgxP3Qe0k1HWwgMHktT7PhSnhGZdq7YtjYMkDopRYmw9rb9aHiX6fTbI533AV1+
         syM+2Qv0rCuo4csHpvLMwDO5WtZ/gHQ495Ux9gA2Dvlj3zZm6x6+LZKH2Y2/mE84Y147
         XZgXqc6o7oV7P+MkCxjTiAlsc5kBUIcRwZQ35NNEUg1q7xWF5YQ75HIKmnbf+gGlU9W1
         4+tPvhOpo4ECEAVQsY3RBThOiMEnNwL4DYOvo79CZM3U4a8OKuqOqimpmKRAqWkGYWwM
         pLZw==
X-Forwarded-Encrypted: i=1; AFNElJ+iSobaZ7vTDanbqf+2KHSm9DtP2bK5zAqFA7N/ikii9JJ/36hqTGnxmmmxH7OtEoPU0qry+u14SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvoFhmaxeFGtivtwRjcn0tvLsuF4/KFsfkBHdsRwjILbpRyUP
	lYj5jlsPBLveJpQzacrCWdb572F/Vda8mYJWD8beriyX1JzC0RjoMP0k8r2UCYeqIO+6ry/pJXn
	5cOI5IdJSj43k57pwwjt8Y+UbHHYzkGBWSiggZpU8QYZZT0SY6uBEW4K6yrVX
X-Gm-Gg: Acq92OEy7BHtO64w0MfP7wWjkpE4ZmRNJQVe+dOtp6z/SoP9ml7tmlMOQCkZo0HCKah
	cVvn4YZEJFZKOCclm6YSJ6K+wm04Fdt2vJAViRgI8iqxe0gXIIzt+wX7B8HCCAanKcr7Jhv7IaS
	V7uRwRucYNwm880MraPdrD9KCvIpTkSKk/6hVmM2gzMK3WSiLOlokyEpaUInUP2OXZIjA6XvyWe
	RHET5StuKSYENafD3n8afVSyXo82j6JUuUKlbGmyRRHVpkm3fuEYFGdov3oaI8Tz7+a54dXNNpd
	AqOhyHIZB8duVLvwZYaUY5WwIyxeHnSgdo8gBnTryJoacLCjfGRMDHZcZuabRLp90DKkwj9qyOu
	tDguD9ecUY/GzsPxTKwKyLmWbhS1WGqZeaWafheEVW81VXxljjQc=
X-Received: by 2002:a05:6a00:b8c:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-8415f5dcc06mr2794991b3a.29.1779438122748;
        Fri, 22 May 2026 01:22:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:b8c:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-8415f5dcc06mr2794957b3a.29.1779438122233;
        Fri, 22 May 2026 01:22:02 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm1431407b3a.54.2026.05.22.01.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:22:01 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v3 0/2] pmdomain: qcom: rpmpd: Add support for Shikra
Date: Fri, 22 May 2026 13:51:53 +0530
Message-Id: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACISEGoC/33N0Q6CIBSA4VdxXIfDg4h21Xu05kAgWSkGxWrOd
 w+96cZ1c7b/bOc7MwraWx3QMZuR19EG68YU9JChrhfjVWOrUiMgUJESGiyUav00TKoNvb15gQ3
 jNacSjOAdSmeT18a+N/J8Sd3b8HT+s32Ixbr9g8UCE2yUFFCzqqQ1ObkQ8sdL3Ds3DHkaaDUj/
 BxWlDsOJAeIlIpy1oDcc5Zl+QKAh2d9/wAAAA==
X-Change-ID: 20260429-add_rpmpd_shikra-f57873b2fa7c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779438117; l=1050;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=azs06BhmYqKoQMjBwv/SMVh5kJKS2q/NUFKYoAlJrk8=;
 b=ADy/45Ch1O+1RpT/bf7DPzHkiMEhO9E8GoZMH5BtGtnA/g0MEJgWivvwrGLYsfDgn+V7BQEsi
 6Eo1HpM0u6ACdAp7XcvC4gDt6OnMxq5wit8dK03wAT/LGV5gyzl5F9O
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a10122b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fa4qZZSo5jqT8jJZuxwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: k7iPlCANMDoFAKATXd_crswG8UZkP5DO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MSBTYWx0ZWRfXwJf2XG36PWk8
 tsxrLF4zQlsRG+p9IdiYlqVPrhzgnayeHNwncl317UVTLe99ytLfWlpeZZGhbECKWsNImMHjYjU
 LlsEx5DB4oZ1b75vJdySzZqu4c9ft+JDT8w96GTlXrx6dhrQbU9SnVBFsEaJ9lWmUMCkJcPrS7u
 P1rmI3HS5rB2OO1YS9f2HydYZaEdA/cTtPwn+igIKz8V138PmqDTySSskxnUv1pXNEtR97WM2dq
 ASHI3g5dgqX8Uhzdm+zGeix4nOjh+nM1eKiNhbFgtusHMU3xCrgQ1KAR+wToR92lICs6RqwjM/Z
 W08k00p0v6lkf5b/iT86kbcRWImKzophv/N6bLYM06+xJ/hisI64gzFq1nfITAguOpmCoI8sfIQ
 dGP40vOSfiPbVjzA873ri1NLlvOak/0yn/l+mIzRwxBXsPD7CajpdxU5nmx7RvWxmkNr31+rO6X
 11b49DbdRa6J3+pk74Q==
X-Proofpoint-ORIG-GUID: k7iPlCANMDoFAKATXd_crswG8UZkP5DO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220081

Add rpmpd support for shikra Platform including RPM power domains.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
- Updated the subject for Cover-later and Patch2.
- No changes in Patch1.
- Link to v2: https://lore.kernel.org/r/20260514-add_rpmpd_shikra-v2-0-20bbd37592b0@oss.qualcomm.com

Changes in v2:
- Collected Reviewed-by tags.
- reused SM6125 power domains as suggested by Konrad Dybcio.
- Link to v1: https://lore.kernel.org/r/20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com

---
Rakesh Kota (2):
      dt-bindings: power: qcom,rpmpd: document the Shikra RPM Power Domains
      pmdomain: qcom: rpmpd: Add Shikra RPM Power Domains

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 drivers/pmdomain/qcom/rpmpd.c                           | 7 +++++++
 2 files changed, 8 insertions(+)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260429-add_rpmpd_shikra-f57873b2fa7c

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>

