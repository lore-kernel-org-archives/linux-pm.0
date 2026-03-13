Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143062F691F
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398084; cv=none; b=FaoVWINTK4+nsADBtZYTokIaBfcQ2yQKY//tOD1/tTMhK0VCunGOs6Y+khmcwSIkoHZ6pxnpHS41/6Iu8H5MkCip7H49lUeRk5Wr0XSE81hIdnEXtRsvtOw04GK7Mwv4WZjuNJc6qdedq/Hcsvq4/QLIkI5oYaOF4+HGl3w1ULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398084; c=relaxed/simple;
	bh=b0m5mclYoW9En5q2IdigRQ0qzO/S5dlubz70W7BgIpc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=up85I66yxUv1I3BHYT/d2O9cPRVAJDtii0YhuUejhM6obLRXKqt+xxvl0CAqyZdfEcpgtNnReRU/tvCXGTQnCzPHRQEO7nQe4yREEpjRA7TpRo8WsYVun8ThMhJpv0tnSgBrr1WtURze/N+3B9yOAThjXyid8VDsPWHONglItkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kseG5+UP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFVutWV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kseG5+UP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BFVutWV9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8vBC1481522
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=npOVpXI/eG50MvSU1dDdoX
	FqT+LB80/JNvS5DiEZhFY=; b=kseG5+UPj8jZmBG/cqzoTZsXmHrKjPzYpD5NCY
	4Gj9FTcpufzRUdwR3HLuo7+8JqQ3B0UoF5wl9XfGkqMbd7a57FPtmeeH6g3tKedd
	cJH4ppw2C5dtSfEkhE/7wR4w/EUUlFd060pUz6A87kIeLEgH33COsQnV5vF8u9b3
	uL4RBM97HzNtgmDwmRX53a5xK2cr9HJCKTin/Kp3lKpI+2wWqIT5SDVJLzKcKtMn
	DgbnMeuJf5fwP+sFyAjLeZ+ZEV1couhC1dB3WhP2nhWR1+RXsV4/VmjW3MRfVzbm
	ljiMRnTWA5JNSFDrId9VjQSRuhdTHtFcFqQ1rZfQ6trREnGQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7rbmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso2394369a91.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398081; x=1774002881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=npOVpXI/eG50MvSU1dDdoXFqT+LB80/JNvS5DiEZhFY=;
        b=BFVutWV9TiUCNYC3RRN2z63Z4cW7GU5N1MjZ3fZ7TY/zRwmpq2Zrv292d/WD6KuZwS
         6f45rpjXeAfoJpmtoTUf3s0dQFYs5+Fr6C/mrUaZrC0leeFdiG0rXdkV0oTf/Up98FHS
         Ym7yoKGlWQnurfHQXc01caWD/t1QCchOK7vDkI038GeePsE6pW6MYpfWHbt0A0Gd2FE1
         BHJY2OKlvmWTfM1WCqSXPwHuzBbemw9RcK13ejdsUlszrrYfNgRY5WiXKIV8t1O9WvGn
         vRhfW7dzSw5GgtqkI4XRoIVKYIrBbPsbn1on5VbXOh4qVJGfPSWcqAhA3RSgifQ2QRFX
         sKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398081; x=1774002881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npOVpXI/eG50MvSU1dDdoXFqT+LB80/JNvS5DiEZhFY=;
        b=maJEWIviWANGmFvHjS2rIsy0j7n8ZI/X8GvAG9s1WAraAxJkOnp7YNw9MIFL2Gxtqo
         bmAHT75CSGsA2kRjEZG4XHUhe76HxpbX+smnSqdWw3Rq6tUHQdOJCTK+s5IUEpaarDFh
         baasgpdgPQnwOoiZRe3WiUUdkPFc51AAyj/pqSCQBKfvGvtCoynVcZmXw2jfnmgA3VJw
         YV1rkvGtQj7nuE+ssVih+SKmVN2vRGsRCYFIemFXSP6jG7vthbuCTSNpNcnakfS2Xmt7
         sUVaehUH/OFhJwySvOf5vgDgP53+ZN0J9RijV2j1pUswx/ckhTKv8/hFeFCc84u5zEnU
         Gw9g==
X-Gm-Message-State: AOJu0YwfzGrpRKb4WyI9bj2DUZIgpma/MbaHh4eyZwz4lMqDwzwQWm8J
	0m2vHNV1s8bEcOQ6uAdk+Lf4GW4TdUgtlLLJVh0W6slAyFkAguLZ1e569qzq9M9qVg2huVioXlM
	8OmAt7KcgQJ4JEbKD6/XcdEOS+dtsx+4sz3drCaC/BnOMjBQsjvq7JqUEivAlMg==
X-Gm-Gg: ATEYQzxwAU5W7xDeBQyK/V2/A4FRIOnjXuXvW0SvmmfvZ5tupSTQrEJkGeIA/VMmtVD
	PpCehzAkR0ivb7X4iWecLw40Cc3kh85f7mkNvCotmNniACaSDxwo8a2Kt7gqZ7BVWAoiKG0jWTe
	1pgvbBxSOYeYP8JxjFkPIPcgs2iMh5wbUG8or6JWK40ZmjvCE0SYmvs2/CxhbiDXx/d1RUmjlZU
	EYcvOwdhTRITVcWEoNy4Wac1hjJpt/l0ZVAWoe8V+9RSXxknMq/z6ZSld0FX887dkCtTsOYzZuL
	uySAF8qPDusaQzStjRkZ6Nuj0ZVJiSVZwAPnGeZMv7PijUXToofqxjLHuU2OcS3MBjJbRcPAaVp
	kBZ+e/L0ArjrtKA90MqCieFaATXBMmVF67lHef7mkDy1Gy6o3tZE=
X-Received: by 2002:a17:90b:4a46:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-35a21e38ea7mr2317490a91.5.1773398081108;
        Fri, 13 Mar 2026 03:34:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4a46:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-35a21e38ea7mr2317449a91.5.1773398080668;
        Fri, 13 Mar 2026 03:34:40 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc8465sm8055383a91.9.2026.03.13.03.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:34:40 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable TSENS and thermal zone for SM8750 SoC
Date: Fri, 13 Mar 2026 16:04:16 +0530
Message-Id: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjos2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNL3eJcC3NTg/iS4tS8Yl1TyzTLVGMz4yRLSzMloJaCotS0zAqwcdG
 xtbUARyPpzV4AAAA=
X-Change-ID: 20260309-sm8750_tsens-59f9e363b996
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aastha.pandey@oss.qualcomm.com, dipa.mantre@oss.qualcomm.com,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773398074; l=715;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=b0m5mclYoW9En5q2IdigRQ0qzO/S5dlubz70W7BgIpc=;
 b=UgeqgAmsrx3Rbl1cGEkWil2GG+yW0w0d5oEcO/z7nKW2ruuD2tm/pgec2j7HY0cxwmyooSKQC
 n+Usd1Q4MwEBs97askkgET4g9Rf9HJ90wS7lf9ZXYkIS/ULjEAIg3rE
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: qnTQOl8Jj8H83AK1cfHflxPIhFduOU_9
X-Proofpoint-GUID: qnTQOl8Jj8H83AK1cfHflxPIhFduOU_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MiBTYWx0ZWRfX1T64JipkV6Vw
 KQ3CacOeWcL8cHoLUS61p0c0ikeVdTHd8+gH+dKnuDeVt61msDRlcBkGyOqe6rdWIQ7WJ1CM2ni
 Lz3a5rmvMz2ebAc6lvZtqUmV6yNjLvLgyjEanlNZw0CkCXKLPsX5ZkvBC5zI3QVf6W7GbrqhP6R
 ClcelQ9hDWHsyWpEp5Va7UbWvUyBW0Z1j8BZhyJVYEkHpicqEEk1LrdPSJGfIiTJ+lM/Gs3s+rE
 8LIpGIjJer7fS5MANkMldgQg645Fnc5TQPxKvXw7PyCDWd68PW5nX6qS+182AAv0NEH6gbYo2S3
 rokRXn8R3/uNvAdnxykBysVwy//ID/PjIoCU8Tcf1vNNyyoda2C3WkieBaFtGTzs5acwLbykVV3
 /hN7WhfXaQwFz2X0xklXItAdlOLFQrtpVcD2YrLKjIlqLPXN+Lwr+f6Pep9bjdqWHWZltUaOA3h
 7bk2+/cTNt/jh4tb8AA==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b3e842 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iVRbNCi4RErFctStz8oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130082

Adding compatible string in TSENS dt-bindings, device node
for TSENS controller and Thermal zone support.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
Manaf Meethalavalappu Pallikunhi (2):
      dt-bindings: thermal: qcom-tsens: Document the SM8750 Temperature Sensor
      arm64: dts: qcom: sm8750: Enable TSENS and thermal zones

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 897 +++++++++++++++++++++
 2 files changed, 898 insertions(+)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260309-sm8750_tsens-59f9e363b996

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

