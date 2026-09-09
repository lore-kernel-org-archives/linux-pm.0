Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7555C327
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957446; cv=none; b=kE0EgLdsE00HOQd97cJ3GJOkvei9U/srSyb8tfPSe/O+f8DwRG2O5jIsqXs/dvV56VvEFYKcIv6guujF2XchBkvQvkhjDyyjycI/g4w1yNRu5PR00h70ahpyE7VgNZ0NCc/OsQlTbNuQiVoHZVVuCadMIpVxia1n2p+E3Bq5Fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957446; c=relaxed/simple;
	bh=cnUC2byAamkt2Wsw7cDkQ/4/MO2pVReZkFP/SiHVTKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukC2Ch1T7Iw+Rrd/XtJ6cclOvDZT7d33bubDdSNNGgOPqDyxZXwAbfSy0ExF4EIM0GC0KnT9CjFzv0Bb0ZuGZ11dw/bemrRYmWV6uJojhM6J7HfXnb2keZsuWLaN3xOX8TZBg1hLlvjtFJjeiyA72tN0txtO4BsVjHFgKjQsP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W36jju9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/RS/Ypk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W36jju9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/RS/Ypk"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CCxTE3053134
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 12:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LtvTnbQs8y8XYlcms/R/6r
	Fu+GMi3ezg/AhGAbsadr0=; b=W36jju9l0IY7eFtpvl4zTpYVci4EaemrM3mkGu
	0lJcCjIX8lpJzjMUg+bXMNIO2Xwg/tZjsY53MVzelO7ijQncX+VnWC8UESArHfje
	6BgdrOSaDsTJIDvTxVL03bZmvefwOvWVxYQJOfXACZn0UU/SSvnZs9ErYWSovzkY
	r+mPCDE0sEPDSLCMhica2ET7gQ2cYzAnTXmM/TifeXc2Y93NgQjDacSBQWx1+wri
	MeyHxjqXfFITuCv7nw02yRw/MPWZ+OnbgohgxnBSDxDYm7eFtR6xiZqtNjzvlRhi
	Nr5pJ4P7lu5JgidZwCgMCx+bQEM1SyT7bmv7S+q7msS/P9kA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk79202vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:37:24 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-756261d422dso4134707137.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957443; x=1789562243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LtvTnbQs8y8XYlcms/R/6rFu+GMi3ezg/AhGAbsadr0=;
        b=P/RS/Ypkep6LSWE3cUotop7bJFfO5iVKRTlSryTkAiiID6Xeh/hYO4RMxPKhQhje/j
         U9aXjYdQvDTOufMpxJRfcUx7iXlv0Rtg8PZmhCgyZAMVkx0o5AqgVll8RaxM1rPbg1F4
         HixacOJkS42apty9tKlJ8YPoZNThikQEbB7s2csHQEQC/2MGhlMGFdBKp0FCvAF0u+xX
         bgqJIxLhEh1D/DCjeh4Ee524K4x8OnavbDrlx3pU5qBFrr1LLlnYDQpVB0kps6QM9v7f
         ESFdAUjD0AMfdpQskbCj/nxqk+M8crLziF21iUBlQ69dgwQ+0TA+Zi/wv1kAoiwISgIn
         xdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957443; x=1789562243;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LtvTnbQs8y8XYlcms/R/6rFu+GMi3ezg/AhGAbsadr0=;
        b=UIXz7W3MYlM5Sp5jn6HkCnRFR6eCzj8I916vyDCxnoTbk29btiWwALGxpLxnuhum2k
         RL/0pmx3/MHoLXdylf6GqX8M9aWzjhKukbdbWbccOUe9BuK/c+ISCHezOKjfEopMBv77
         XtybWMxAISbqQHFQqpMDs5kNpLJAHnmTcckFPGSMA5IL935qxqVWcJMdiXzxBt//axBO
         wAQ00Ov+i6su1lBYkaDub/gLG7PEX5kT3C5gBlvFuIHIgejgrV2aDGr88fiD/6TnuxOm
         D6emR63PrYL1Cb/hCKN1M1MJtVdvYjo84IKnp9MC3HNqqFV++SoaePPLqT84Eu6ZRGrn
         IxfA==
X-Gm-Message-State: AFuF++lvHnNiIHl/xjAPdhp9kFKTIIZOksV3YlKfXrvAUMpAMOAosU8x
	1s2CejEqSwXcxEa979O/DgL+S6loacLPWo2BoxPYx0r+EzSM2TSAxsgz65vOrREVe1/tOiyDRq0
	9OE83dHCoPqBl4LQKICiHE3PIB8QnU514BBZ5+mOsqt9OU0wdemumubePaHYAPQ==
X-Gm-Gg: AYBFou1R1lySwJE+wNjDJqlAS0CWJ8bbEhUNmtpnc49KXg2pEUu3VDz9j9q7P0FWINZ
	0L1mJ6eATVbcJwJIWzjMLMCSOc7zhjpbUhKEtAg91okomLeCpSgT23Vv9KA4ZFK11a7c9EDZvxx
	VO0fMLahh5G5CFtsc1gR5ITYvjcRZ7v49qbhukowqWNsL9dZvoE+gay9w1uLx9d0o3rLORqLvu1
	z16CDrGLGerYOUXa1snhTbZoRX6ZWcJoVmPoV9fcIlGmX3y9LHihgFr8XF3gF+XRin5BXOkT+wa
	TzK0ntRsBloOO7VNQkIGhGdByw4d8hThQlYKGXSkLujggn6Ce6CV4U8rJQJTEsFkuHrwzY/FkpY
	RpjGwzgVwylI3/qdHvGAZUO9whUD9
X-Received: by 2002:a05:6102:578e:b0:778:4fe0:8297 with SMTP id ada2fe7eead31-78a4aa70e09mr17976249137.11.1788957443462;
        Wed, 09 Sep 2026 05:37:23 -0700 (PDT)
X-Received: by 2002:a05:6102:578e:b0:778:4fe0:8297 with SMTP id ada2fe7eead31-78a4aa70e09mr17976226137.11.1788957442952;
        Wed, 09 Sep 2026 05:37:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm36317328f8f.20.2026.09.09.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/4] power: sequencing: add kunit test cases
Date: Wed, 09 Sep 2026 14:37:06 +0200
Message-Id: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJSoWoC/1XMQQ6CMBCF4auQWVtSBlKtK+9hWEApMlEodAA1p
 He34srNJP8k79uArSfLcE428HYlJjfEwEMCpquGmxXUxAaUqKRCLcanZzuJ+zLQLHJ1lKhbXRe
 FgjgZvW3ptXPXMnZHPDv/3vU1+35/kJb5P7RmQoqsPem8QVPVBi+OOZ2W6mFc36fxQBlC+AD8S
 oH+rwAAAA==
X-Change-ID: 20260629-pwrseq-kunit-367029f9b446
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=cnUC2byAamkt2Wsw7cDkQ/4/MO2pVReZkFP/SiHVTKU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoVL41oa/tbHiis/Lp4PCJg7tkwtIIGqBFV737
 W+3ufGYKuiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqFS+AAKCRAFnS7L/zaE
 wyWwD/wMeaJkISg5lPfDiQ7BH4ivPv+RrnYvaulCPoUi7ZrAFttpfbooJR+Trpk2deEcT6jn/WB
 cMe2pa1mYhRiH5kvb923XPR2rwTdzrsX/BQXt9DFKtjEO2B8C2o633NKfJGhpU3bXn2LlLaDt7g
 1Yy5MvNlh1/UH2GqElh0/zNCtpMV8BuM4dZlW6GHea/h3941+i9sMH/+JeFUo6WWqLP/yYaF3eU
 FZXsVnH61I8PkrqH3H3LqsX4v52b3f75WDS3eQzhwgzjAWG6baVVrvFclpJl5TtZdDO6Jlp8f1V
 MBrnQcPMlchV23r4u5P+GA/YUsHb9TtwNZwr3nAVjSxFjKnG3q4BLXpV8E0En1QZdMMGmr/rU4r
 O25BXrQznKWAuxhlxhgPdSeSASq0EyxTfiiQEpWr7JtoXR91e33UBUOgEioiJtHTIbGeFvmz3gn
 6X3Pa3cOZ7C6D1psXUP4CGGN4qf2rREoC48FvUQFf6xQQYPsyRvVbHsVOwqif/gvpcm/pe7OOJo
 viU3Zaimt6WL27fkXWjTfCHovAITQJoE9bCSLuJGosffVu2dYu+SFFPvUDjthOnGNoXz4Q+v3h+
 P3r+NA/KaPXMHeouxtiIES6kERbzrnDMkgl3Xzy16jpN0gDNvl5oi7lNQxL2k+kuQI1PHwZG0o/
 i3oLvdNKGWtPphA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bd1bluPB c=1 sm=1 tr=0 ts=6aa15304 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=WuEtKOOUVeBF-84atrsA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX3XZYtBNeO/ui
 KMwlwh7sadEESOKTeGTc1ltfZqNbf91AGGoaZxlytBKbrWDfVSMPQcUC7gOvO6gfCKayzArPpJ2
 6MmgF6Zxfz0YbkMPmI3A/5djPZgVD06fvZvI19TNchGEUP6q76prGFW+F8cwy8Qvlw7/ODVrw7n
 FfVWUKskFMHXHQknMfhZmTlR10+NQQ2kpKwUc/7a7T8MIvsTNCFK2kXygfpUEQ31lHpg9xc8wrA
 vAzSHEHPT4qGEITh+gBEYnjS1RiLZFdjaStCm4jgk6GbaGVXdSSIumB2RqcQ4DJb9NCkMdfKu0U
 XSQ+v46QyY5abZ0/hkbg5+zzu25YKfp1Znl4MN6QpZwHuiKXBd8UdcwFkzg1YXG5ZD3XewtELy8
 z9MHo6aotJybdFDMI9Zdh72I8yLhz8z0h6sgnBtcfm/JeNV1vYZGhdBNRrGCsWQwbplGDT01vRV
 ASVFvJUqWja0jQM2xRQ==
X-Proofpoint-ORIG-GUID: 3vB8XL-Fy-n0bTZ8f4oSJxhfx1R_TCNY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX0A+Z/sXgFaKH
 hjAm4m+zhs910bC7Iw7pnldyMrMa6EVCuh9KDGUfA71BTi9qa0Ez6TrMF8AEPxgCGENqyVaHc+Z
 fp+NfjvpoCKeZpscjqiDaZbfBFtcDBk=
X-Proofpoint-GUID: 3vB8XL-Fy-n0bTZ8f4oSJxhfx1R_TCNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

Add a set of kunit test cases for the power sequencing subsystem. Also
fix issues noticed when writing the tests.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Add more fixes to bugs pointed out by sashiko
- Link to v1: https://patch.msgid.link/20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com

---
Bartosz Golaszewski (4):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: fix NULL-pointer dereference in pwrseq_unit_new()
      power: sequencing: fix NULL-pointer dereference in pwrseq_device_register()
      power: sequencing: add kunit test cases

 drivers/power/sequencing/Kconfig        |   10 +
 drivers/power/sequencing/Makefile       |    1 +
 drivers/power/sequencing/core.c         |   11 +-
 drivers/power/sequencing/pwrseq-kunit.c | 1497 +++++++++++++++++++++++++++++++
 4 files changed, 1515 insertions(+), 4 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260629-pwrseq-kunit-367029f9b446

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

