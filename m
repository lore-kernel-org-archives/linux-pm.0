Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595D32B100
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187819; cv=none; b=uEoZDJMEghHPQ2CplnWgBTAoZm+ACqozKsbIimBrqzdUGqSLZmJMJOPiT0qamtUMJHHkvF/5iLR1Hh7I2I5E378KeT/7RPhORoOmFfo8r63u9uLt2Ew+EGkQz1TCvsnnuI9cvDH0oR7td58rF/Ui/Meudh058EdrmZHEml33Znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187819; c=relaxed/simple;
	bh=ykVX2JfEgwuvzc2/xbvDBqQmXvj/xqAycnxzoxu1sD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FBuU9iWWNR+VqbJnA53dASS62/q7zkO76VySxlnNPyPMYs1q2wO4r6b095EjyvSfdgAQeagMYwyCENoqZAF6ea8ToAwwHFbcSlxqHtH3pnB0l7yuAD7PvujTgaePHB9H9Qoxe7KTWhbc5asmZ1raNOXkVkn3rknNoht2QWNVOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AQLB9pGa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ego2/9Hq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AQLB9pGa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ego2/9Hq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JAlw5o867066
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yhVzbuKGUnJsoKjJBAWaOM
	jpe2Ss3XlvwQTt6r5Oxto=; b=AQLB9pGa4RkicqpyrqQZjSdzQkCGupC8DId2Ja
	sTIqxzLUJw0F52rtrWvcNpdq6hawA2hBl8OYDJjNVTuuGp+HzulJb1PhNzVB1nC1
	IFLAu14eBbBK1+w10YNQxfCqQjJcvjaeVdO5dHXZuCuo2RnnJZFP+QfvmqP7x16F
	a9YGhG5YJR5efU8TLxsYPsejYYjs2QmQB+VziqSMKeZ3lYy+lKYgvRyxRmUoCv1o
	4tSdT0x+jKJDRlac3B9gjpH12S2SUVi4KrSptCeJwVO0Qwm/25d1nPwC4dJo2YX1
	byz0oRaPNG1Dz+vJuazdqsNJekfJieztNptFTH4Q7MBDDxfA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8hv1hb6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:50:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8354503d9acso4663380b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779187816; x=1779792616; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhVzbuKGUnJsoKjJBAWaOMjpe2Ss3XlvwQTt6r5Oxto=;
        b=Ego2/9HqLcEjyPsuK9C4MTxAWZUaBWLoK2wnroEiI/KalO7REVhUmJRsP1bV7sUxHC
         Nx7CjY/NVhdsA7+/JCdzNeaog5ZfiOwlCZ0wmMJXdfG4BsXhPeYxW1PHe9yb+XrcnR9f
         jVdKEB3b+1dtEIlyORRQtnpfKbbCz1qHYUeDXofebC2IWh27lRraJhpCe4MP2mSPdgXX
         l6Efsm+npejeISb8tVHGA6t5Zv9/b+31EiE72EYIJhGMZi2PrUyQGCS5k//jsXNz3yzt
         9T9/d8/Oys2eC7hFu/qciiYHW+gdnIB4iz1LGPJkdDjxxV/65UDP38LEsxojTN/aSm8k
         m5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187816; x=1779792616;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhVzbuKGUnJsoKjJBAWaOMjpe2Ss3XlvwQTt6r5Oxto=;
        b=TC1tsvqtCjTIWNddhirBtm7KebLVzm10cs6/kIboj290FplgT8RqulToLg75y6tcnq
         2Z4HvuE5qXNFBbXCASb1RMWcik1Q7hIPoB5oLnu4rq+F2gua21s+C0niEtrOtSjzSZqU
         k1ngsHTeQk7F3rB3/wFnqnVJI5bgpbkCuXamzwDJkfh1oCIcUxrK5RQ51MAdgCE6JfqO
         SES+j/9MxCFlVMaHc7z9sSRxoI07a7NWm970WfEKfwN6cwTf171NeztEJJAxWIIr2PmH
         Z4Iz9ZF+8U6k48MU3NhVgvzynf6PEJcCIDLOoe3cibLlXpW4LBUXTfo/17/AoHnXhO6p
         R77Q==
X-Forwarded-Encrypted: i=1; AFNElJ+XyF32+NTh3TipG8+aVFAFUdZ0ZYkpd0N0pkCbwgYiKFIRwIQ7s7WUjvxkHX5f0O4UlnZETSwviw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFw5e7IdRrnMcJYIrrtiuCEDIVAv8YMdOOkBRteSlf85uJFwrx
	i5IkL8Zr9hClx/w8DPfFBGgA7aP+mSNcE9Y8zSXS5i/P8y9i88SqRqG4SLSOKMo9wkOAW03XXbm
	wdGVVIf90M4tBzI7StBY+Tf7pn5q6/v6gaX9amUluby6ENMZhz2KxGHf13ZDjaA==
X-Gm-Gg: Acq92OHamEtOpkQ0M8V4KY7pGkaLV0+VUn2JtONVk8p2tAIQWdE2DBLmb2LAsHWo8Aq
	/CUN/IkadxfmhtfO8+RMqhS8W6sJnRDZD6TIOSV9rxM66VJdBf3JlkCgrImlg7J/6dsP408JPBy
	1gxXfrCr5edab0focgUAzR2I0awdbmezUzXsWdQiotMChwzgeriyhrdZsIEwJjbL4l7SNpoAqoN
	urxBP2WgjYtHCF+vfUYSDFCz4UaLs+fsbw8epvFws8/imTpAYJhBS3LA0HEjwyokw4ddEK85WLC
	x+Azk74ypqZ9H94AVpnWicTznILrP2khDgS93MOVBIFu7Wy9pBupSeVoIoaersFrIe/GYRvHrun
	V6HmnnxEejzNHYWDVVJL86PRk7e5Vmx26FWmNrcWXC3MKkLmbHCZdllZg
X-Received: by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd with SMTP id d2e1a72fcca58-83f33c9bc80mr19699135b3a.38.1779187815820;
        Tue, 19 May 2026 03:50:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd with SMTP id d2e1a72fcca58-83f33c9bc80mr19699096b3a.38.1779187815243;
        Tue, 19 May 2026 03:50:15 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19fa869esm20877879b3a.61.2026.05.19.03.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:50:14 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: [PATCH 0/3] Add Qualcomm SPEL powercap driver
Date: Tue, 19 May 2026 16:19:48 +0530
Message-Id: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1ADGoC/x3MSwqEMBBF0a1IjQ0YQVG3IhIkebYFfmJVtwji3
 g09PIN7b1IIQ6nLbhKcrLxvCTbPyM/j9oHhkExlUdZFZVtz+H11GrG4IHxC3C/qVzCuxlpMofF
 NhRqU+iiY+Pq/++F5XlQC4SZrAAAA
X-Change-ID: 20260519-qcom_spel_driver_upstream-11efd8c85e6e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779187810; l=1732;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=ykVX2JfEgwuvzc2/xbvDBqQmXvj/xqAycnxzoxu1sD0=;
 b=BRsaVnei+AYKkPcFrJSq3/l6PPY/i5cQAO1Kr12LP/4gwE3wRutqRqZz6lXC+lae5qmcc7ywm
 wPGj+cxAqfIDi7cdUkSAP15kZDisMCwhZdvqUW4rzNYgeuNMXUuKyyu
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX9BIti9JfIbr1
 GpGEuo+VNn87HvEcwd815dQIxG6Jp/zdTALJ9AiTE3Ghj+687YdkSZ4w9B3tL4JXUbSsGXPHE4w
 IeYGGgQc2dJQOyY1tbhE/uHEE3ep3D7sxuyklUOP3eAu1JL8tPkd7C5DU06TQcaibkyDyHBp8l8
 0Y8r8xhFIfUIGly1SML2lumWnOulQmryhvRpG5hGEymJXRLZ+zxoz7aMlUdMsa4S+iZyVMn4/F6
 F3I5IK9e9lRLI2tzTP9pPOZGm3uGYGOXBgOnDzL9JVfZAoGU4cvvNhDsmnlhGwb7h4lPX/bh+3B
 /MyzKNdA3L9bV4PJr53hoNEP0cf0NG0U71kMts3WSUJ4DWZsMHrXoKWqQQYpcLENKmguuOsv5p3
 4rssqXWIZ8fRtJo3Kfzqeq24CPo7fSzxikKsJh3PmCEFyk6X0Rv7of1ayI/GvU/9Lbc8DKKKBr5
 8L35tT6EEL4I2a3Fr7g==
X-Proofpoint-GUID: SSZ-IGROwMOlqi19OiVGNCKWPEbZNO7r
X-Proofpoint-ORIG-GUID: SSZ-IGROwMOlqi19OiVGNCKWPEbZNO7r
X-Authority-Analysis: v=2.4 cv=WZM8rUhX c=1 sm=1 tr=0 ts=6a0c4068 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zL8LttSLqXSf2cHOEy0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190106

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
Manaf Meethalavalappu Pallikunhi (3):
      dt-bindings: power: limits: Describe Qualcomm SPEL hardware
      powercap: qcom: Add SPEL powercap driver
      arm64: dts: qcom: glymur: Enable SPEL powercap driver

 .../bindings/power/limits/qcom,spel.yaml           |  47 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  10 +
 drivers/powercap/Kconfig                           |  13 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/qcom_spel.c                       | 787 +++++++++++++++++++++
 6 files changed, 865 insertions(+)
---
base-commit: 80dd246accce631c328ea43294e53b2b2dd2aa32
change-id: 20260519-qcom_spel_driver_upstream-11efd8c85e6e

Best regards,
-- 
Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

