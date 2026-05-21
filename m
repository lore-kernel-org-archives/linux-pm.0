Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8483D88E9
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372384; cv=none; b=PnhkhoMuR/fSSj9FqbwsMKmzIF2+2N8wvJhkHOGBGYzM+6IPp6NrjMrSW3W9R0/AKnv4t/3aOOztK+2cNgwton7geQTcYxZqbkl/D740nJ0ldi8wsXTCiBkLv3eprCLtLsZCyHDSvkyDQqTvUzzxSCHwRv+8gqTQrYnAdm5q8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372384; c=relaxed/simple;
	bh=9y3ZdYxQ1rInJVGpUROVKIIH9d4ExlJ3gXRl1keGvNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lvjW9ZCbEkwpNEi/KPz7qCEkb/RjKpqoZempBkqu7tDwG0y5wQtkHte59CJn+DgcZVMY05S71/zTWF5lFflGcR+Ty0Fq+P/8fieMkh6gWmt4/GKLrrUf6hSP7XV/8Utc0+W+kZ+rrp5pUQqDrZxE0YUi9PKW7chT2T3yU2UbRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRt+5L86; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FS1KY3WN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRt+5L86";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FS1KY3WN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99o703118970
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QM3P8PzgJm+dl7DUTcWreE
	3kVwtqS0QLfbrS91c30uY=; b=YRt+5L86dVcqDuOlemlCQZTjt8uF1PGrbU1UT4
	KHyANEgd3ltfnz1JcFr5nXX3SmI/3MXWSk8rtRaAiqtaRCe7fAEADKujarJUDCXi
	SrgxcC+wKGQy2Xmjg+vv6x/3LK6nXwSPkQ/yEiSoxesfqL3JCeIo7ccuCYUpa6OB
	Tvz63v9YOcOilVpn66UjcobmvQUFoS/XW8Yk1tSaLyiBXFFVbvemOOfKvnMtIlg/
	48wmAHFHdsGbTPko6ib0YZ2wCzlOs4pnqs0vPSWYsPIbtphOqjxl97qMSzNuY/So
	K+J+tjXhKCwJ85Cge/oTNvAzmi4Ev6TBPxlNsM/dE6Rm584w==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962t5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:21 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd726a9569so117597477b3.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372380; x=1779977180; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QM3P8PzgJm+dl7DUTcWreE3kVwtqS0QLfbrS91c30uY=;
        b=FS1KY3WN2YxfSIxnSRBaYhEmbTZaWOLWuODsQObRTDw0lLar9nOPn9Q0OD0GBoHhKQ
         OcPHUzglDzeoz13cN0oxbAfdZPCcWFvyEC3BlBU/mOLxm+BOodlwHZg0STy7cG11sgng
         dYBdbnAHngrgUgAK0zrJTmyyenesPfXGNvt2hRV+fZKC/vsxsNKmPtA/HBb/K/bEKMTO
         icWM8NZ7cYMgEeX0lRhqE8y+GBA0KJ0J2Yrm0HSr6GC2fYFr2jXyNpwLDsxpm7Z+qhMo
         3dcInny5WS90jkK0NzATsJTcGjAq2p7SERvcPJkpjnQjA6vDOZ8pNiIaypSjId42X70O
         4pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372380; x=1779977180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM3P8PzgJm+dl7DUTcWreE3kVwtqS0QLfbrS91c30uY=;
        b=R7oAVfW8veSDOnVUBtTbaHA0aMnojhSsUoMFTtTvwuzeTnnVuQ2/IJDZWVI2O4wfFi
         u3Ws64v73Z6nuStto3iVWklFTPwhLrP37rnEZeIhpIoXkmD11sM3dyxajJjPLiesqVvb
         U8KL3oCrhHPaHDKemGjiRmQaZxXu/nhttynIJH8tL3Ou1VYefu4CEHEjPxtIu84GIh1p
         vzjcthKdc/9kba+YwE1E74Si4laj7OFDxSTUKNrTRij/5uoUHd2Ti0bjpoxespEvAb37
         D5XQUSfpMLzaWB/WGMdhxteGPYxlpY53Lpb5+0YKOFhY0pA+XuZJDschIUeVWWbmnqif
         LrNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Gb3wDoJWJz0nuxfXuazSpn5f/+p0sIDQzIkUWd7+MmalX+MXcvES3aKyZdMZcluDwiTwvD2m/ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqWh73KoVbfQQCBvFVS6/thlHGTodWA2ygFFah1z312Ztu0db
	/cu+X6f/cfYEaCqCBuzyj5x0Bu3fJ48g8KWllbbRdyU/26qB1tv84LJ/BIHGzd/SzPrm2pchD11
	hSIEKWc4S2FT9Cl0F/0aW/BE7dFrMj85cvL9IeQR7E4z5Y8jUfVIxqUi2pqPC5w==
X-Gm-Gg: Acq92OF5F75nzAtfwgE6kkQO+Uy+q0llSLYZhU4mu0/BLEw6E0etreuv0WZO9IwEX7C
	tL1+cssz21ZnTzrvVhf0FSRXvKJhlFGzmwpsb7LnA8s6y0o7RN6DLqOvrd5JhGSpH4rqN/OJKDf
	fxw6lHk6jvMtjrXnRI+NpM3amTohKBFsMMnu4eN/+Ve9wLaw7L1ilfGHutcVXBMl2IM7ObejZmD
	Q/Guu79BYRM+TH5UKwy9xptIOfVamHKZprH56cxyBFeI6+CIS+i+FSmZ6LmmE5Lh0reXKdZTFNn
	qSH6KLOvYKRN+Mxo4qTjUoTXzdTqYm8hol4IZxKBA/+bbz+OdzKhJL3bvjhV5gTvaD2oXdXKMW5
	JvDDfFjRMG4TW+EDF4LZuqwjMKyw0FvON+aLlYAkGCPCE2x/W8+QKhXVpfVD5Q1I=
X-Received: by 2002:a05:690c:6c0a:b0:7cf:af41:50b0 with SMTP id 00721157ae682-7d20c74cafbmr27935487b3.36.1779372380514;
        Thu, 21 May 2026 07:06:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6c0a:b0:7cf:af41:50b0 with SMTP id 00721157ae682-7d20c74cafbmr27934697b3.36.1779372380000;
        Thu, 21 May 2026 07:06:20 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2cab7a5f9sm2920677b3.39.2026.05.21.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:06:19 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add cpufreq scaling support for Qualcomm Shikra SoC
Date: Thu, 21 May 2026 19:36:03 +0530
Message-Id: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsRD2oC/3XNwQ6CMAyA4VcxOzvSbYLMk+9hPIyxQSMw2IRoC
 O/uwIsHuTT5m/TrTILxaAK5HGbizYQBXRdDHA9E16qrDMUyNuHAMzgJoKHGh1dU96P1ZqBBqwa
 7iiprMwlMAGSCxOPeG4uvDb7dY9cYns6/tz8TW7dfMgW2R06MAtXnvJCpTUUh2dWFkAyjarRr2
 yQOssoT/9GY3NV41HgB0oJhWpb5H21Zlg/l+MvHEQEAAA==
X-Change-ID: 20260430-shikra-cpufreq-scaling-aff690130063
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: dcpVDmEKOOygOHXSNV4yGbqsQIT7sXXN
X-Proofpoint-GUID: dcpVDmEKOOygOHXSNV4yGbqsQIT7sXXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfX7VOLrrcX7BUE
 UwpjR3sOvW/PP2sL5rj1ghrG7Ci/9CJD5x4lTAdSij8SuRRg9WqWu55SoF5k5zyeGOvIX7BJ/hh
 eLUaTa88MsEdNustjUqoSeRYzY7vrnCC1RmHjjNHpGzO1+GT8vSQ6kbS3OYAfJNh/WRgSwiU1it
 AFV2fZWznH6fD8wBU20NRr4sbqnuIBIApUffBoEPAMn9xDfzoPZXccOQOdYil2tU2FlOhf7oPbh
 QCJ3jJ3Togh2PLIfcuWJk4+HtN3/QI5ThrQE/cXRf7alutL3B4RKbTr9gzpQ3TtSvHEJhy1DtFu
 FYKz6bqJH5jeEhQmaA06VCZJKUAbvML8k54xVe9329x3s3um9cTcg5nMq4SFeX/uoB+rZQ/jOR5
 xHK+hBnY1TRHiA82C5Y6NvAeP11brVPTXAA1aM0QIgbKcX0jD6bg6dFgt76v0teCvj9KyiA6Ulg
 47CJd/himkY3TecPRng==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f115d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=65fuDPeu_usOQaeP5yMA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142

This series adds cpufreq scaling support on Qualcomm Shikra SoC.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v3:
- Updated bindings as per the review comments [Krzysztof]
- Updated driver patch commit text [Dmitry]
- Updated compatible in driver patch as per the bindings
- Link to v2: https://lore.kernel.org/r/20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com

Changes in v2:
- Dropped the generic compatible approach, and introduced Shikra
  specific bindings [Krzysztof]
- Updated the driver patch as per the latest bindings changes
- Added R-By tag received in V1.
- Link to v1: https://lore.kernel.org/r/20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com

---
Imran Shaik (1):
      dt-bindings: cpufreq: qcom-hw: Document Shikra CPUFREQ Hardware

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

 .../bindings/cpufreq/qcom,shikra-epss.yaml         | 96 ++++++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 23 +++++-
 2 files changed, 116 insertions(+), 3 deletions(-)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-shikra-cpufreq-scaling-aff690130063

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

