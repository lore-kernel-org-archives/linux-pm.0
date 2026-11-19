Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081655;
	b=aAGFZc6Zuc4TY1WLEzW3/AcwrlIVNCDZUBVVSJ2cQ/G7zbe3E5HgsW4Nrx0mjA1692vg
	 UUBOjT1JUtlGjvM74KaFuQB66Cmmhh+fVaPgt3nPtuEt05KaxtXZHljj6v71FXxNLjHwa
	 L4eH84x1FOeSFq0i2ZyZyFnuVOS//q+FkBftNXzUYgctnGnfEaI5y1T0XEq6GBj2kjT4k
	 kjwA9yb/WNRc47XuP1xQXa2aU62K3QEi9gyWlZS/Pkf/f8j5xyGCe99o6V6Oi/KjfRBtl
	 EuGDmGfxI0SvBkx38Re4YHEIkFbSpgSQhf+Zgp1PBNx4LaqwEbhyisxKWIkv70keQrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=32NvXl/QRVRMCIJ4+8E0Da9OwR6rhfJaxWi+40EzuJ4=;
	b=Fl4A8Q1371iRegZz/tn1b3KVnqkLZRw5/HMz93OZnJeq2maG071ogbZmmN4M0z2QsCY7
	 z9zcC+vHlk2Kvqjs9WG8zxcS3GLieqOVwR2mOiG5XAFaxeuGTo7fMSpKd8ieO2ldEfqcK
	 gJrDlVEQxnnte4aP8QvoDylbzNYO/etxyG1LKg9/ajQZu/LbG41rrd1BwGmkcCrIXeq2T
	 703434B75Z2YEf4IPXZISeEzgNEHMSgfL8EIZ/T46JDy/cT2+doJyrBxM04ULF939b9XF
	 5IDuLWVCeij3alBHOJDp+Y2tsASLFwMGJweSvw7nhbzmTtNFPrg6m1s68OX2jD9OgnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RieuFA6v;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YRsj7ago;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB4606A32A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58FB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RieuFA6v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YRsj7ago
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9jhKR1949757
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=32NvXl/QRVRMCIJ4+8E0Da9OwR6rhfJaxWi
	+40EzuJ4=; b=RieuFA6v+MuWfG2paLd+EJ+PdpckDEK+fFmxJQQWFTlkrJG66Jx
	dBhyNHDPZ2n115lcNAiPv1+RHnsSXjaaOsukBO84tcC/aFFO41VIC7GU6pANQJo1
	6MUiAZ/GLh9BzZi7UuXr6saM8y6L/nudZBYxib5B8ApWNJ21hRuL0/ZPm/cAnYgQ
	zWjiWwuzzJLbOToJnVhT0PpbZGv0lT6qS7fOR6ncEpS4Wz7MT6gIgC9DtPc1e6hJ
	RHUmw/53xOgFxMvQZBUT2XztIE8aq9Y827MfPpHo4t08cX66lvWNpSgN9dnTjf2t
	RExcJIGPNxNxrZHqOvft7hoCdDWn6/s7dXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1uux8vnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so435203685a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081653; x=1795686453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=32NvXl/QRVRMCIJ4+8E0Da9OwR6rhfJaxWi+40EzuJ4=;
        b=YRsj7agogQvooPe3jF/Oq394dB6p7w2Pz+59frg6wVWZZb55d0XwVurBfjSVJ6bwDp
         Z06reNgjLcB6D951zBkFqayhMWuyuvi/FGRLRZqvVTVA33hWBAWRg1zSumtNflz5Zzdr
         KegCjmHeq+8b0AxzIygdSvcSlO/u+TzCsae/q4SpEHGYO694Tt7dg37P7CBHa9s0PYeH
         cAoocpPOG2Ad2mYprfBMSeQ+852o4FogTavf/emugefXqKEWr8S6ogy4ACVpD2BTzrv8
         CE0hcrCuurc1slvnEPTcVwxIkYjIXkr+PJidlNAH8sLHNfpoA9gQnBQIyluDwMDl+Qdu
         BtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081653; x=1795686453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32NvXl/QRVRMCIJ4+8E0Da9OwR6rhfJaxWi+40EzuJ4=;
        b=JxZR0CZ1qrb6at/PuXNk6z26EGRvws2VsB6Q/cOO12JC7nmIHtxVNPQ/kAM/rEO6Vd
         KazhemcSVKfBg0ng+f6eMrxs2M2ltt4y7pAdgoBArYHZXsguAtt0qLW3aofwCH66KYhF
         1T/NUJWgaVG+qZgZdEOEJpUTv/k9JGPi7DAgpMpRQ5qgIJKfGHcD220s25mYEcFK+/iR
         SNDSl3lMhYbn9v4480r50YShXdzVlYAthPvibibX0L1GB046U1vKYT83o7xsi5QSHN1l
         uu9c8Kr7pa8JMlqJ9yzG5DeIpSm2HsZBmnbrZPscVPZoMhy1v43tQ5o+EPxHJXBS+Okj
         ULTA==
X-Forwarded-Encrypted: i=1; AL+hErEtACM3qXL8RndE4rSFC3MeglNh0agQv7GEZ8PNKgPwwqsdtupOLYFtRnjuZ6RWuLTDSR0ztZyYkA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NqsgO0Wj0GolpLeNnMn7x1HAV/UIiE1/amWwNHeSqTzIjq+m7
	wGM+IjbQPcMVxrHnZX3Yj/aaKghLe//QzaZYPgnXv3I4LNmBE80iBCIwqU4XeGyIitqNf4LlaSC
	UJazgwacb29tmLDG29L3+bC6iAc5zcEd8pj67szdh4Nf0wjxZJvtwposul6kqdQ==
X-Gm-Gg: AYBFou1bqmjo3PPeo5YXTPItiC2b7gEPO/oZmDz3/uUzRs/FAw9x14MVMdPAPQAUJag
	zGTvNuhFH0j9jvkGwjfytoIL/4dw6Jc2pY/ksB4c5UIXxYbYg7VHNrLPU9+2EPfhhPaT8v4SNgz
	Opbgvgz2zS3U2ShpEJQ6Q0vDYk+/6Egrunh2sjXiLLZcV00t+xNvi0u2+5WW/R7LE+zxZPPeyry
	jTKKil/pf6KDFhhM0JK0xvZsNR5gKt7CotZ7c5+Q/toT/NEV5gJAGhrCWK87efl2r6ysE1jY2bE
	itY1v8uNRyElOvRTogC9hp8N30oioNmoMC0BM0refukZBJufNrOonjHo8k3WP0Ynh5HPfmMv5m5
	ghD3gY3nEySQ9O0Ss2KZFeG+Sh7nBjtsTDMe5fzIXZfS4ICHqKao8/a51LGhFGmp0C1pd4C4+p8
	D5
X-Received: by 2002:a05:620a:6011:b0:947:8354:c694 with SMTP id af79cd13be357-949995d88d3mr873156685a.49.1795081653189;
        Thu, 19 Nov 2026 01:47:33 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:947:8354:c694 with SMTP id af79cd13be357-949995d88d3mr873154585a.49.1795081652663;
        Thu, 19 Nov 2026 01:47:32 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:31 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 00/12] thermal: Add multi-source thermal zone aggregation
Date: Thu, 19 Nov 2026 10:46:42 +0100
Message-ID: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Kp2UCDdQ9ugoptnd_GeHgtw5cotqQqjN
X-Proofpoint-GUID: Kp2UCDdQ9ugoptnd_GeHgtw5cotqQqjN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX+ko4w7jTBY1q
 nq/ohqZdajOxWs88ZyZQp9kR7LXbGp421njnZfvduEogxo4jthv1C6oa91F/eNtXo3XPxs7RNai
 AS6Kys0stlQWHlJhYfwiHZ8U+akdRcg=
X-Authority-Analysis: v=2.4 cv=Q89HcI2a c=1 sm=1 tr=0 ts=6afec5b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=dTe2qqOzE6QIQVNfbKUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX58WcFGX6r8eC
 jyqBQk/oYxRNBCWSYWIaD+tANzdZx9xaQcNp7SsHqhDJdzWFT4U1fBAufXfJcqFLsvyHBvhav1t
 iOljj4XR8WF76AXKDIQqa0XXqCwO7ELEySTQfcB5Eslgxc95tvS6aq8sF/k88xvfp+CJlqDS2UH
 8SLYKQoSyzIlun72PRELZyuqLy09GfrOepBV/K8rtSlsErvSjQ/5NIQtQn3xPfFoFcmBfIm25Ki
 XBw4PDV770Gal4JgzHAee4a/PYR0yNLp9IiUoiVL82/GyDsGU85dZuhzuczIQHjYwzTROelxArs
 SUAvpLrRWDrIKRjoCg6UZpo1k518Rd3GWLhXKn9jIjCqk8icfBFwx5OUdNqkUIZaHk4lp6jxvk/
 c/ty8a5qxj3ixE5Va/YqzYbFBwi/n+/0J9hvC/XbHSrCoCTRYpaocZCm09BLVQUwLCgpfaktvtr
 F0KmhC4Pe2M5OezDKww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Thermal management may need to estimate a temperature that no sensor
measures directly. For example, skin temperature can be estimated from
readings near the processor, display and battery; an internal board
region's temperature from sensors around the processor, memory and
power-management circuitry; and the temperature surrounding the battery
from readings near the battery, charging circuitry and adjacent
components. Each sensor's contribution depends on its location relative
to the target region and the thermal paths connecting them. A linear
regression model provides a practical approximation of these
relationships: coefficients fitted from platform measurements weight each
sensor's contribution, while a constant offset accounts for the baseline
difference between the weighted readings and the target temperature.

This series provides common support for aggregated thermal zones, allowing
estimated temperatures to benefit from the thermal framework's existing
trip handling, governors and cooling policies. It has two parts: thermal
core support, which makes aggregation available independently of the
firmware interface, and OF support, which allows platforms to describe
aggregated zones in Device Tree.

This series introduces support in the thermal core for deriving a zone's
temperature from a weighted combination of existing thermal zone
temperatures and a constant offset, reusing the readings already provided
by sensor drivers. Each source zone retains its own trips and cooling
policy and can contribute to several aggregates, each representing a
different thermal constraint. The series adds reference-counting helpers
so aggregate owners can keep source zones alive until their dependencies
are torn down. It also introduces registration-time validation of the
aggregation parameters to reject unavailable sources, nested aggregation,
incomplete coefficient sets and incompatible operations before the new
zone is exposed.

The series also adds OF support for describing aggregated zones through
multiple thermal-sensors references and optional coefficients in Device
Tree. These references identify hardware sensors whose registered thermal
zones provide the source temperatures. Aggregate creation waits until all
sources are available, allowing sensor drivers to probe independently.
Dependent aggregates are removed before a source is unregistered and
recreated when it returns. This lets platforms describe their thermal
estimates without changes to sensor drivers, while preserving existing
single-source calibration.

The series includes KUnit tests for both the core and OF support, using
synthetic thermal sources without requiring platform hardware. The core
tests cover parameter validation, default coefficients, temperature
calculations, error handling and source lock contention. The OF tests
cover deferred creation, coefficient parsing, source removal and
recreation, and a temperature read concurrent with source teardown. All
23 cases pass on UML with lockdep enabled. Initial late-init discovery,
real module loading and platform hardware are not covered by these tests.

Testing:
  - git diff --check passes.
  - Per-patch checkpatch reports no errors. Remaining warnings concern
    commit-message line lengths and possible MAINTAINERS updates.

This cover letter was drafted with OpenCode using gpt-6.1-sol from the
commit series, human driven and a source-code study. The same tool ran
the KUnit and patch checks reported above.

Daniel Lezcano (12):
  thermal: core: Add thermal zone device reference helpers
  thermal: core: Introduce private thermal zone aggregation structures
  thermal: core: Validate thermal zone aggregation descriptions
  thermal: core: Initialize thermal zone aggregation coefficients
  thermal: core: Dispatch aggregate temperature reads
  thermal: core: Calculate aggregated thermal zone temperatures
  thermal: core: Initialize aggregation during zone registration
  thermal: of: Separate zone parsing from sensor lookup
  thermal: of: Track registered hardware temperature sources
  thermal: of: Instantiate aggregates after their source zones
  dt-bindings: thermal: Describe multi-source zone aggregation
  thermal: testing: Add KUnit coverage for zone aggregation

 .../bindings/thermal/thermal-zones.yaml       |  46 ++-
 drivers/thermal/Kconfig                       |  31 ++
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/testing/.kunitconfig          |  11 +
 drivers/thermal/testing/README.rst            |  34 ++
 .../thermal/testing/thermal_aggregation.dtso  |  53 +++
 .../testing/thermal_aggregation_test.c        | 351 +++++++++++++++++
 .../testing/thermal_of_aggregation_test.c     | 330 ++++++++++++++++
 drivers/thermal/thermal_aggregation.c         | 252 ++++++++++++
 drivers/thermal/thermal_core.c                |  49 ++-
 drivers/thermal/thermal_core.h                |  48 ++-
 drivers/thermal/thermal_helpers.c             |   9 +-
 drivers/thermal/thermal_of.c                  | 370 ++++++++++++++++--
 include/linux/thermal.h                       |   4 +
 14 files changed, 1532 insertions(+), 58 deletions(-)
 create mode 100644 drivers/thermal/testing/.kunitconfig
 create mode 100644 drivers/thermal/testing/README.rst
 create mode 100644 drivers/thermal/testing/thermal_aggregation.dtso
 create mode 100644 drivers/thermal/testing/thermal_aggregation_test.c
 create mode 100644 drivers/thermal/testing/thermal_of_aggregation_test.c
 create mode 100644 drivers/thermal/thermal_aggregation.c


base-commit: 0dd55073c872df387d28480d1197c013423d1705
-- 
2.43.0
