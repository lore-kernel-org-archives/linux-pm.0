Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4236C9CA
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527895; cv=none; b=cCSW9LL4dAoNxAQOg9LMKupcXAATCzGm5hzUAsZggHPaOKPlb5c4srYZIObfFL4GA4vnMA9zvppwwkdk8C8mRdChaJONauBCD8mBF82z1R+KsT/u8ZYuvKi++WCfx5SosppbX5IFd5CN7f0k8QmBJk3faQF8OeJXWt2T5MeY5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527895; c=relaxed/simple;
	bh=4QtVTf/kcp6PI2WWiINIQNaB718D1pAnUlaOldDVU9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEV55t1/eDef+aZrGXM+2wPhwYiW7vkAFztY73j8Pf9ZSs70YG99efqb7UIGGJS15bItGqqTy33zEJF3PXOUmJu++hZG4hpw+4ygPresfxGfrY3yVSh6Wo1z8lhhOj9dvNEnYEK9ncUGqHH/27r9FpOjjhjkj3pzIHEHNi43Jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCt3N4yV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IIkSeOc3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCt3N4yV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IIkSeOc3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuPl93636710
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7TotAmjoMV5t/Ifey0XxwS
	1AKg+VW7hMH4YIH2Uj3Qc=; b=TCt3N4yV6CgZHjTXB68NGjXYV8qP4MHaNx7brP
	J3Y7uF6BWmug+0Vs8d9LT5mK98DcqeU/1s404p2Ppkp05sgPBMj7KX7bU8/+z3U4
	Xa2H37NQrkimN6Htf7JexHZeWCCX9stRddcXgi+xlNliKTct6H7vDpfIeexldIrk
	UCF3SmWXNBPiKb7T/+f6fM1hwx6hLhKweCGtnU5o4mJ+y6wyS6R5Rkzcm8rjKTln
	QY6Q2iYu/qe4EFTsDN4ihNQTIHiw9qc3KOGwqa79GR7WnVWAqHUcIX7QSV7xdusR
	KQeLeGfWaLxe27HCi0nAKcKwP0oGH/OzTtAzhzVb+EBD3RIA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q10mb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:44:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35e5791871fso1135761a91.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777527891; x=1778132691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TotAmjoMV5t/Ifey0XxwS1AKg+VW7hMH4YIH2Uj3Qc=;
        b=IIkSeOc3R+Hwna7QyyzNLiUCclhng88fSZioU3rHB2vNSQaA7M1wKP2ZCy0EXmExCd
         5jHPu6z5qFuwV3NHWTyCvRrfvUjAFyqNS9sgekV8h4Y8b+ieupoahY2WEfId6oOZnCAk
         8I1g8lnxYmRzZAJN8N7Dxqw4cL0/OBe7UZtYmHIK0aBUuPS7re6zSmGX2MrmykTmoiyq
         VCaLUGJuewXRWGx6KULVp2v/ttBtwsf6jRtfHp5jUWuF4/kuNkzrS7naWyfA5rxp9qCo
         fkaYC7Mf3yOqeX4A2/LY4PbKbYOpjIksnuvi+bTOl1qJhFxYlwj3ZVqyDhXd+AI74Idq
         fHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527891; x=1778132691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TotAmjoMV5t/Ifey0XxwS1AKg+VW7hMH4YIH2Uj3Qc=;
        b=oCbKuQJc2x/q6KDDw5HMMTNpVpf6632AYsZu/F/AsbGYUIhIp4tUhrGkJw6iq1JC8t
         W8Q7BQ8V5pyvH66XBYjAGVXBrG8oXAI1FaZkBbSEgIGUVG838LDjOX/fOaLHP4uQPO0q
         6MnjvYJ1cSS5hEe4WwTrmagH9SDMkcIFPfVO3X/Ukard9gCDYu7xlwd3X3ajfi+7KZd2
         s6gGNL5SqIAL+pUvEu0jRijbBP70iNgLsNkzzafF3+6dgaZrVkK6tYyXCwCU6WJ231iS
         uLsrnZaPm+AYiluV196SSeH7Y1Ts+AII5r3FrE/gp6HeplEKCkbzY9CYx1w35i5tSlto
         7lPA==
X-Gm-Message-State: AOJu0YwWx5Xuh6KKatLHlfsd7VLXOdsklDGofcwDfjfGwon4kHlWq7Ty
	0B1Q22DExh+xD227M2et3BZjC7K5J3LeQmPDx7yV3E1nPESb02GVSpMzXO7A9z4nkQgaCDXJ2qS
	WntYiLB9gLnCrouIknCwRjNVLn6mCMKlwkieKV9y52i80BtagdznPUXHSCdHE3g==
X-Gm-Gg: AeBDievnPfk0OtEv9yVh8QZo0ebqF2rRqxcweWykfw0Abq2ykEoD8EU7hm2Ds9jvRam
	Dxsx27Wvj/ev7dgkWS38E5/1H3QIt20rGTq7Bjw0XaLhG1HoPrp/8s750CBgGlD/V4U8DXy5Syy
	/K03gxitBm09XI06KL11F3rRR3tQE2fbwru2xi2QdwVoUakgJS50TNYhQf66CG5NZHzJTfiUvBM
	DUpI3ofhpNTz4pA/OicL5v0fi5GFMKPiW1afEK6Hk76VK0wfgyTya2zuZ4gxHAGhnvLwKZRYdUa
	PeAHbYFmbs9UmMdnrWMbcGYsEGisp+/j2d+VXGNlJtFlLdJGn5zyHyyFANzKScTQbmAsf8y4fDK
	et97BWXiW/JRSUPhtJEu4PPDjRnZe4tC3kzErXrLwrrGsO+2i+WUXltMUzbKxMzFkng==
X-Received: by 2002:a05:6a21:339a:b0:394:5513:ce5 with SMTP id adf61e73a8af0-3a3cf8f3911mr1942718637.51.1777527891361;
        Wed, 29 Apr 2026 22:44:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:339a:b0:394:5513:ce5 with SMTP id adf61e73a8af0-3a3cf8f3911mr1942690637.51.1777527890938;
        Wed, 29 Apr 2026 22:44:50 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f21cbsm3955231a12.19.2026.04.29.22.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:44:50 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH 0/2] thermal: qcom: tsens: fix temperature handling
Date: Thu, 30 Apr 2026 11:14:19 +0530
Message-ID: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Cpg8rHC5oM7II3yI-L6pBA65R4XTaRw
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2ec54 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EQKb40vYdxLEhVMbLbQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1MyBTYWx0ZWRfX8MgqleP3VdDC
 sd4bIyp1YeiLWp3p1dh7VXKlFcIQF07v1Zw/DC7A0BjCwtjfuCHB4JZBzz61WOrNmgeWXBHY5hf
 Z1IiqFUCYWhAhQJ11nzRBC/etPdNOcjKbXTRqKSsZVZGypBss/SU8XnUudS4JbapK9CKVw/P6Al
 P5aaFzAzEPiC70HUqXyR4JFvYG/gT7kBr0m2DEd0seVvKIIeHy8kGR1nVEh8rgpJ/z/I96wcTXG
 6TWdSPmsKfO5oK0VBsDaWDBhqX063M9hPMO/7aKlDV8VQXhMi1mXzLszzzlY8Ku1u5xHDQ8uDDZ
 S+raWTElfbFguLFQFLjrr1bCJAh6Z5ZwmfJgAM1APXaYPRaDv3TnpnBwbE2K3i3sZkS/V4u0opE
 7xdJAndKRsr7wPnmqoW1QeG7lctdYO90UQ2K18jjGmyZ8W4mezKa6nbLYagO/MeKgKWsixbSWWK
 KygWhETPJJUk7Jga79A==
X-Proofpoint-ORIG-GUID: 0Cpg8rHC5oM7II3yI-L6pBA65R4XTaRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300053

This series fixes multiple issues in the Qualcomm TSENS thermal driver
related to temperature sampling and trip threshold handling.

Patch 1 updates the temperature read path to atomically sample the
temperature value along with its valid bit, in accordance with hardware
programming guidelines. It also implements the recommended retry and
fallback behavior to avoid incorrect readings during transient hardware
update windows.

Patch 2 widens the software trip temperature limits to match the full
hardware-supported range. This prevents repeated threshold
reprogramming and interrupt storms when devices operate beyond the
previously clamped limits on newer chipsets, while preserving behavior
for platforms operating within the original range.

Priyansh Jain (2):
  thermal: qcom: tsens: atomic temperature read with hardware-guided
    retries
  thermal: qcom: tsens: widen temperature limits to match hardware range

 drivers/thermal/qcom/tsens-v1.c |   6 +-
 drivers/thermal/qcom/tsens-v2.c |  10 +--
 drivers/thermal/qcom/tsens.c    | 118 +++++++++++++++++++++-----------
 drivers/thermal/qcom/tsens.h    |  22 ++----
 4 files changed, 93 insertions(+), 63 deletions(-)

-- 
2.43.0

