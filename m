Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604633C3C03
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234839; cv=none; b=luShs8m8xd7Ar5mSgFIDYTUHmLiVsQX828h6lgkFK5xNMnGP4JrBTnv+rmp3nqw/ej/5ZRE1Qx9dGcAZuVFS6INDuZ78/eWdM7yI8zBoFS3jDbf7h0QBqgE5Kzm8GAsQzJWaADjLD2hmj6g7QCsVeyVYkhPDKy2ZGxAMWckA7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234839; c=relaxed/simple;
	bh=y/GfofqIHQANQ5CHSFxmSZ4K6zI+EcLOlo/P5fAMq2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fT/1myRmVX24+paGQmQPT86ht8dG11N6kVxYgoZlFV1GX1YdFdt3QZHhanPamINQgd8xjrOyArSshqwEowH/3czHQeGmVmEh+7AUbWrf+z8mhDwUgSdqoLe3lu0ZQR1DnmTxmM1Vnzn/dnyH86E/sF/0IE/QgnqAvVxaVRpTkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CN3Upoy3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dgOmnlFe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CN3Upoy3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgOmnlFe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6485orUQ2778224
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 10:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xsznKWdZhGfdpuJiM4vIT0
	VCeBhgZXrDmZgPnKnhX6g=; b=CN3Upoy3B5dpTIDfkvKDpPNR2pCrXSzBUxh3pf
	931ZnX6lOylU6mm9dpr76YA7sVX7MaSuJ97McOybCXcfH+I5sxPAWhSm8H3GFxmw
	vs7xRUFvc136KsttmL6buUoQOgrWBFYWVfF84p3ekvwlmn2gHbwQtpDtWowEB3+T
	U0SeGOfLI5P3fUUmaWgga4hbu6I9pvCCZuLEDNzLcLXsin2dEF6lKsFeeRhqRYmH
	53bYbATBel7wH7vkFJNco4SVAPHJndqEvSxipzAEXt68Q22l9uzTjt0rXc8egjah
	F6RyNC8BRp7BCWAG71DOpn8a9NRx9diAgB0qV1NpAgEiNohw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1285jhnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 10:07:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso2834590a12.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778234828; x=1778839628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsznKWdZhGfdpuJiM4vIT0VCeBhgZXrDmZgPnKnhX6g=;
        b=dgOmnlFeBzdwHYxxvq3HScGG5AmvdWR7BEhoB8n93JNQjITBp0GloaNHGQtWfMT1fP
         ETKviYFh2wKbw2JemGcV8SSHE1HHwV7bwK5cz2Imt+uLXtw+7P4cmyMuXh7L58bTFdGj
         aOjpFctrRDUCMZlPxWLrFDQCdDmEAvXspIamGAFIfp66KwZDt2S6k7x8PZVeGKJy45X7
         89ZaBAFSmnuzoA0DoCv8oGV0976//S3mPC15MH8Njo/0HlAszDEMan6TTXu1XSkUrCqm
         vTqgI/cXfI8cyQxy5O3alU6oIoNAE2+zP+rEObW0nhT9Bov7GVKuhAR/BtwohUS5APr2
         hSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234828; x=1778839628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsznKWdZhGfdpuJiM4vIT0VCeBhgZXrDmZgPnKnhX6g=;
        b=AjIvlKT76x1u5W2dKQrKjVe2jh8X4mFb7sfH5vG++6wc5H7j5o93wONGmroj4Wa2Fd
         inCI3FVQfgXZUHts2T8iNs89aDqZL3+uWcdAZOJ9MioN8erlNYWNMuccQuDptgpezPsL
         gpDQkc7WzzFsAbLvnQCtrGw7aM9yAZJ2THsmBQ/GNAz6TMl6Mk6LRieFhGwIE21IgVuu
         TQDfTJDtmBXh6x3OP/1xYqADug/6PsE55gG/KhBKTFSn5+EUq/qlfncWyQGPwHYRKpY0
         1RU5VHClCz9qzxAf3ga4V2BidLAFRZzyTZxcwlFhq5BETADlgSwayRoql7OB5QNgCbVa
         KfQA==
X-Gm-Message-State: AOJu0YyOdRDTQCg8ZfZ7dv5PbfRlspWtCkWmWiFcnm8l0c2+O0biF8ea
	FxC+yKrUuvjAN/kpGeiv4AYG3bF/JYY3TnDketFOyQnQEw3CoyB5o0Zt288xNZjhX6xg4bcIRN/
	e6DCyGdBig4laPKevINYH5VCPka1yOkOJFHK0hCCf9s5h108L3j4PqphHEdkmIg==
X-Gm-Gg: AeBDieslRFYsPTKqopp0TYyfXbbbVJL/NAjMvtRm95t/jY6Kl665iISultju7zEHqJN
	tVDk2Ao3kDMyF91rnKBM5gfNDO5RPp0wCv0an+vTy1vuX1sAtVfpppxEijiE4zrv1ONrTRIB7+x
	4fgOQmS80EdbHK12dbW+yhz23bD1Lnw76BqHTd6bkYZ8urJWZ84TvBjXpsG9wIMCWfXBdrh+miS
	mP5WfjT4DIMmiZfn0vI9nTpPZPFOZBr4Luc0NsurA2xoAq7XkjDvdu675PcWqk4d41OD1LRA/Mf
	kHlKjbo67refzU6QBjoDTSqOp6oa50Tm2junHfc5Q+7qMOmQvdtQ7wkypXHGEwt8uA1sbALMVdF
	EPzxNnHFgLLHFy27SKDRc6f2ID5lW3O2uOOWrEo5yDb1c2d7apP5o5to=
X-Received: by 2002:a05:6a00:440c:b0:835:45bf:9659 with SMTP id d2e1a72fcca58-83a5e45319fmr11575604b3a.41.1778234827983;
        Fri, 08 May 2026 03:07:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:440c:b0:835:45bf:9659 with SMTP id d2e1a72fcca58-83a5e45319fmr11575564b3a.41.1778234827418;
        Fri, 08 May 2026 03:07:07 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm15876379b3a.49.2026.05.08.03.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:07:06 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH v2 0/2] thermal: qcom: tsens: fix temperature handling
Date: Fri,  8 May 2026 15:36:58 +0530
Message-ID: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfXytsG/+L2DkBO
 hF6poNy1Hy/WSClhwAyy8Kre9YG0nDS27kvmpB/hIZV11170hv2LOLmoLXu1UmUiV8y0ybKObzj
 +3X7hdQYb5naI0PQjGuhCfB3pxzk7hGPg81XiEKXYCyAQQz2F0WqM1JfAxepSWk2mUvmjhzhaY6
 wVS8nPrlS1dNNAE+H64NZ8tf5xsrY+uRZJ4Fr+5Xt0TdHDTvoYJwc8DeEyF00nn7LKEKYYTHWI+
 e0xxbjVBiJ3ZNI0H419kjddq/HypSQE0WLaqBkCqzvOZCXEDEEonYRXrMDbOFvelBec6P7WzkJ8
 j+RlOadA6u9sW44AWXDUGe3KPfOztki/o/XYTi9PjrDr00ju4nsb72PYiOBzTthr8rzTohz2bwr
 D6JG5KIPh4beOkfftMz6iPwey+Keiq6UfbzaKrzEPR3ZGoiJRftUpInc+9WUwCp2Ce4zlR+UxDX
 NT6jXttaF1NIB8o+cqQ==
X-Proofpoint-GUID: clb57_mVg-MD3-QdX_I4P1b3HccGrY6r
X-Proofpoint-ORIG-GUID: clb57_mVg-MD3-QdX_I4P1b3HccGrY6r
X-Authority-Analysis: v=2.4 cv=NKblPU6g c=1 sm=1 tr=0 ts=69fdb5cc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=14Z0-YueNKWrp6JypdoA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080104

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


v2:

- Reverted merging of the valid-bit and LAST_TEMP register field logic
  to preserve the regmap differences between TSENS versions
- Defined valid-bit support and last temperature resolution for all
  TSENS v1 and v2 feature structures
- Defined last temperature resolution for Tsens v0 feature structure
- Dropped tsens version checks in favor of valid-bit capability
- Computed masks from resolution to keep a single source of truth
- Minor code cleanups based on review feedback



Priyansh Jain (2):
  thermal: qcom: tsens: atomic temperature read with hardware-guided
    retries
  thermal: qcom: tsens: widen temperature limits to match hardware range

 drivers/thermal/qcom/tsens-v0_1.c |   1 +
 drivers/thermal/qcom/tsens-v1.c   |   4 ++
 drivers/thermal/qcom/tsens-v2.c   |  10 ++-
 drivers/thermal/qcom/tsens.c      | 114 ++++++++++++++++++++----------
 drivers/thermal/qcom/tsens.h      |   7 ++
 5 files changed, 98 insertions(+), 38 deletions(-)

-- 
2.43.0

