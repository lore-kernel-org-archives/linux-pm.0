Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F0404BC1
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678385; cv=none; b=XgR6p2kHpSFmdirVidDl1+6rYsnE30Ad1gtI6DpvysVAT8Z/1/JfNaPP9pCaYermfXXpiwYsqnaUhhOCcgS6GBM3My48H/NkSmlpfmUm1yPWl/oSZCQJDYwRtykCw3v8oOElyR+wU9oD5ykfLfqKvh4hZUxeTWyiQGr+HodHipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678385; c=relaxed/simple;
	bh=507xJERYnG5py92oNzE25+rSf6TS9DCmeVwskQmg59w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VoXFb+NKLZY2w609mnekI2CiUCJ9MXmj5nMHm4pUeiJy7nsYqR4By3RewcuuQz1lIgK6CRU/oX00LoizLMprPo6la+4bB7tKZYnqt88DN78NZ5pYj6t5fuh2LJIN6oalfsdXRbfIC3orkJWsALXmOkXeSyJMzY5Rrhyfe1/VoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wu5cIhAo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RrhX9oMJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wu5cIhAo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RrhX9oMJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dfTm000391
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bb0rb6OYxOnjgheRhVhbX8
	rxvB0hOJvli2NDVK8wsJ8=; b=Wu5cIhAol99zZRRSArzw/EetOJXjeUYsNecyrv
	YKDyQr54gKdfucpDY/5pybi6i8suO9uqG+fkYXM6j5CYCbeg1xHmO57IslklIPZw
	6EpdbDwJWCptCNdjDQlnKUNcqWLs9loxGJhEszFM/X6uUW+MSXtZ12ToLLKWyvA2
	yZXB60rFKo0r5iQUmaneiGJKuf6oRu6RfE7J+kQUjkugTBuLn52iVyLebVhz6jCM
	XSttY0IEG3A9back5ZzjNoIo2nVWgU2hOvEIpqpJZyRnb+GT4jd8x4ygg+U7JHmc
	WkAbuUtA/wnvvJtEcytaWngRJzbMaPwBfWeoQh/ZwbeL5TVg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24us72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487a20472aso362210b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783678381; x=1784283181; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bb0rb6OYxOnjgheRhVhbX8rxvB0hOJvli2NDVK8wsJ8=;
        b=RrhX9oMJv0fDILxUVmK4j4Oslkj7TDg43IpF6yMRdFuxYi+iOV8LYti8BISmefi82S
         SSDieDmH+A+E7FLkR4L7r1RWAqmwjyQyjEf0jqIf/8yFNX2MyKRX4cGgoeu3uVDkkSpI
         ppHOv3S+hYV/htowQjlv0tjD+XcRnwtuKCyTWsuP9QfvLDFpPkvRUTLXWSRNlFTpYKmi
         iiQB/1qAD/P3rhAaXJ+0BNXlzAeSnfDWYQU9WQB1XoMyNgPeRgWPY+mwlHMTc8lyx/aw
         Q6s4V84Q7q9uI4AiJyukstpfeD0pOw6OyELtQ2//rzKI7OV4J8w+Y1IG6SleS4pedell
         86CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678381; x=1784283181;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bb0rb6OYxOnjgheRhVhbX8rxvB0hOJvli2NDVK8wsJ8=;
        b=XkSluTRcbmwIJLgDiHqyfGMR6PPcCilcWVlJZM5mxKXRvTthh4FYkoYLWVnIXHXVXo
         xRSuUvmB0cYQfoj5ZOAIE5f8pGtRagpEHjKJbQn45j5dYwz9wrnmUmwbZpCSLVbn+CF4
         TZmcUU0loIyGHX/f5GzDwmHJfTjDe0lEgHvoMt42mWbxDEKv+oSlucMR2BB0xlIS3P8N
         STnJUMqpXSk8mVWG5Su0oBa/QNqG9tpta4jgAHO2t0ZFf+OiWwNjAHug3m52xQNGekxK
         qZ6BXnwZamiTBuDwfpjoCMS5EtBRjJRJCk8InlaN/CzYssvzhmzLqD8O1Dsbd31ykssn
         eOrw==
X-Forwarded-Encrypted: i=1; AHgh+RrXmm/zCNPcvXb0fNiV6l2cs52ZgBVgMcBsdSEQ5Gsf9MSezkjWwbCzpx7kzfGs1uFguOCWL8hvDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztAZWljDmDdfprfpeQSm68Wvdt+C75ka/2ZipqSoPTKHXxeoLc
	yaKry7DUwzG0CMfECgRpeNsfyq90YV+fpPl2rMMh4OCzu+WNfC+pu/ElNW1ZPgvL80+86BZi/vd
	2682d7ryF/xDVNok2NFzV6FFOUOYDxIx23mAq4zk3F8qILy1xEs4mlAIOBUl8HA==
X-Gm-Gg: AfdE7clL77/e/0GIwLWW1aGFMRBtp3IaOTjBS1cfsrNOuw7VQf5SW25wWDyrMZEZAv4
	eiXkVu8EkCP1Wdf9c8xwBYf3To5Lt4nLfaaRzolK7orwNbJJRjJkO6vPHhJwmW1Kosaps0ul64b
	Ev43ZpV7+5H5ImA7+Y1JKyNOAE7UNl3zdCfjc+/6/th++vbLEgpIBq3Shf4eHyZwBgRFBk4Jj85
	3Z8NgwNNsPx07Qpt+q7tPNyJeo+wC7+RiEUTE2YOD4/cZrPt4vNxlsKRUMBxvgQaSv/lHnn4X3N
	oeIeU2Ylv1ZmUAwy4GpgGCIG2DVaiMI3YVZr6n/WjgEHRjY+BZkd1JK8gH1rlByy9YXNBj1OJ2W
	HoBV0cs+lgT4kMfJz2zg/JKkoBA+57GqEms+GaGf0kac0
X-Received: by 2002:a05:6a00:859f:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-8485935322amr6044418b3a.48.1783678380744;
        Fri, 10 Jul 2026 03:13:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:859f:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-8485935322amr6044384b3a.48.1783678380167;
        Fri, 10 Jul 2026 03:13:00 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm9977815b3a.46.2026.07.10.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:12:59 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v4 0/2] PM: runtime: Fix sticky -EINVAL after resume
 callback failure
Date: Fri, 10 Jul 2026 15:42:42 +0530
Message-Id: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJrFUGoC/5XOTY4CIRAF4KsY1oMpsBucWc09jCEI1WNp/wk00
 Zi+u7RuXMzGTSUveXlf3VnEQBjZz+rOAmaKNPQlVF8r5o62/0NOvmQmQSpQsuYNXU1M5M43w5H
 6bFtjm4TBjJ0JU5+oQ2NHMo2ldgrIlf7WHmztKg+srI4By8RT3O1fOU6HE7q0MEvjSDEN4fZ8K
 Yul99I1yI/1LDhw5b3bCA1COPgdYlxfJtu6oevW5bDliSzfmc3njCxMrbcHvbXgmkr9w8zz/AD
 MfO1YbgEAAA==
X-Change-ID: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783678373; l=3214;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=507xJERYnG5py92oNzE25+rSf6TS9DCmeVwskQmg59w=;
 b=9qtHC3wO+lvgguwyg/YH/XaI46a5cd/3BUHBLg8wAzd66qJAtThnToflVUGl3tpha+T6cUCl+
 M/QpLd8HbI1DExzKIyCBvkl0lKUDMRVDEwXXeqIg47Apli8uRJwZ1gN
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: L-7JJB9oqi8iPzDbYJNMvjsI9GjGKpuo
X-Proofpoint-ORIG-GUID: L-7JJB9oqi8iPzDbYJNMvjsI9GjGKpuo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfXy8PzdDf04LCd
 +T0hTnDJpe5vU59LqBwfDek1rbpnWMrsVPTgxuNFR/fSAieaIK5dnQLoP4uc7GKgIA3vI0dC17X
 04F2YCb2ZFj28UJcxCdOAwlfdrVpagU=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50c5ad cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=uz69HyL-ks-YmZ1FyLUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfX0R/svMAfkiUV
 boEanwbZawomaEY6mmidhzSl8oiFMwL072ALofm6Wxoy3kFTIGMl+ktjlubfSAPWZeoLYup5Ydb
 kTm//oHzVd5Q0rx0BGE1PxMzmxQDhMbui3Nohs5RWOmnqTG3oqJ5vxmyzknk4dgqTA3/s2cIr3e
 lre2RAxzYoWf7S2+8KX7RlH9eQhkn01brpsrS9Kki/AsvKGNAfahmcRXqRisDQACqpqe2bVNBty
 SufZxM5unRakP8DtXqz3Q1EmbxEp+O7LKC1PrAV7dXcsZ5dDFt9P3zdD2wJFsNwZujq1mo1vkt6
 HktE7WJG5+wCFLeqqSTzvCwZR9icUGhDtCA8Ls22U8nPDbm1RgR3FSaLUwITHlqZV88lrIVYQXs
 qRyUl5Ox6cMj9F31Y/N+2XPoal85ozx7QBFn2dsA2GqAUB0xyBKZ+tAM5F4k7H74gyyTdL7R9lg
 mQWa+BLNlOvV0JF7vPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100099

When a runtime PM resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  All subsequent rpm_resume() calls
then return -EINVAL immediately at the top of the function, permanently
blocking any future resume attempt — including those triggered by
consumers trying to power up their suppliers — until runtime PM is
explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  The first
patch fixes this in the core by only setting power.runtime_error when a
suspend callback fails, leaving resume failures transient by nature.

The second patch fixes a pre-existing issue in the spi-geni-qcom driver
that this scenario exposed: pm_runtime_get_sync() was called in
spi_geni_init() without checking the return value, so a resume failure
would silently proceed to access hardware registers on a device that was
not powered up.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v4:
- Added close brace to resolve build issue.
- Link to v3: https://patch.msgid.link/20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com

Changes in v3:
- Moved power.runtime_error assignment from rpm_callback() into
  rpm_suspend() at the fail label, per maintainer feedback.
- Link to v2: https://patch.msgid.link/20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com

Changes in v2:
- Reworked the fix per maintainer feedback: instead of calling
  pm_runtime_set_suspended() in rpm_get_suppliers(), fix the root cause
  in rpm_callback() by not setting power.runtime_error on resume
  callback failures.
- Link to v1: https://patch.msgid.link/20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com

To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Pavel Machek <pavel@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Mark Brown <broonie@kernel.org>
To: Alok Chauhan <alokc@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
To: Dilip Kota <dkota@codeaurora.org>
To: Girish Mahadevan <girishm@codeaurora.org>
To: bjorn.andersson@oss.qualcomm.com
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: aniket.randive@oss.qualcomm.com
Cc: chandana.chiluveru@oss.qualcomm.com

---
Praveen Talari (2):
      PM: runtime: Only set runtime_error on suspend callback failures
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

 drivers/base/power/runtime.c |  6 +++---
 drivers/spi/spi-geni-qcom.c  | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

