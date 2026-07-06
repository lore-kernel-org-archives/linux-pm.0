Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097A4DC55D
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328023; cv=none; b=K1d9KdDRMfBTuU0OKn84Y5aEjZegvR8HYMc3Fip3zoIhCgVI9j8VhI3QGevjLqQ5SsSk5N3J7gXochiergHJGhjWt4T067fMDsNYhgQHqH0MvR68UtdRnNM5aS2bx0Z5UAkwYZMS7JSO4zGxiz2dqdTQqXIyOMTljzBkuXPzS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328023; c=relaxed/simple;
	bh=kv9UvjF4OBgXx5N1hdvWktzSDOGEwPg+1mlUNMbBiJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iT0T5IgAg6YPF+RXmXy1brn6d/VUFpOXBLnKbRV9duWREDYtQoC99loZHE1fGhflPEExWu+NzU3uiNCbeGthK0CBawldEvYklfFKhZsSd0oU+psjJQCb1YNzrUlF8Ln+BD5EHtpWJsNnNUNMEnLYO01V0hYAX2YSDkLYum8UUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3RYKBiw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hw/Jt7Kr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3RYKBiw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hw/Jt7Kr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6668hUEm3615448
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xQyaC8kg27l0TtZIDeouQj
	A00fl5IzZHks8WCZaGeYw=; b=e3RYKBiwj+xC81Ik/Ry7deKZXGPkps9t3ajky5
	mUHlTjWh4meh4OtAmnRBud6iL9Bg9N9I16/PlHzDUNxA1MPuoQaG0ioboHbY8M2x
	UUk+ZoUkPLZuiU03Tl2OnDw5RhoTPDVKTOigAcVpVhH83a1T3vNWNiEHAarh2Yfe
	0PXGPsGDU/8e9KoEawpih236cWzezXKALka8+w9t/1+UJzs5NDLJ6+45Gq3Hv9lu
	iT+iDd2QQ/N20gSrl8pLKDS6nl0lJsgXuZTTVQlXtMnaNk35ad5G7V5bVPP3De+h
	hVoPa7cCZ6X5SfhuV9U9+9LFLzydqowvxuMbc031Dfovpqpw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3dcap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:53:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84622d6102dso3752249b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328007; x=1783932807; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xQyaC8kg27l0TtZIDeouQjA00fl5IzZHks8WCZaGeYw=;
        b=hw/Jt7Kr5nqJfZB18BxpWXRKXs40yAxtoAAj64/jjoFp5FXv325vQG4x9I+aeJN6Gu
         2rpkxxZnJO7s9RRgs/NB3ZGFEAF5/6pK/lR6GmZM0M6iX0ldAINirQXhYTloUi2vBjkS
         uajiL1iqz7Is32QURLVVXFuGNjkWVMbZ+G8kaKJIsRHt67vnn2iIgNnUFW6CSApvgAvJ
         gjLrVH+8EC/mpF/S2mYeIaVRbHQvQLTDuHYIzWymP1uJRtw0QrMidOOnFpDd5WEvFzyq
         /HEgBEO65/6aKaEMxX4rTVsIBIOhwtd4uE54IguyyLX1FwTPHpZ49996rYtVlpFnTC9X
         1J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328007; x=1783932807;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xQyaC8kg27l0TtZIDeouQjA00fl5IzZHks8WCZaGeYw=;
        b=lvYQ/hNXoaLUuB/A6LdQDo6g0eFdbxKEzHE29fL4L4dfi36Qe2sdObh1iatSz5Y9k4
         ZbBZ7BeS029smsOYOjwzDEe3rdqw+8RzedutCrAk3D/wkpaWcwyXwSwNnnhPdI+X5z6S
         OpWXbnktir384EyMW1grR8A0YAiiBLEj0nNIGpHnbxwI6ne8Bn5vT7z+Ct820dstbe4T
         XLwidtavaYGsEDspyZzdbJ5a3d5e/66Xl8ubroJA+R+xL2xhd2o26unQFxWQVxISV171
         ZUiEMPhG5A9FxuyPLHKeRWwY3szSBvEisc2pAtFeWAFnlLU8LWsYmih6BuOfgUeZqzC6
         roqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1d89/3YJtsoByEm4vosq9ZuTFVGDzwbxntGK8xbO230+Gi9K/rkBEflSjsj17wKX5ydift1keVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAveWj9BuBSaxja0DyN/TK21YcvmL6NQhpmtQgBFER4UJgG5Xq
	wyKvNssz9yI/G2kOoyaed+H+1geYReyR2GLD6XM6D4peGQVUpPHRslcNvV7ire3rrMI5hOaFfx8
	S+bm+GXUQX/saoYUMabaxt61kMKIkfXA7KJ0/CqjRiJET6JA4CWicYiglsABgbA==
X-Gm-Gg: AfdE7cklITFOKM6JrDQraIZNLfZaW3vcb28FGfvgPkU7AgI4tRt0sh4ahoB6L9FWkbS
	npth64wKUnSpIFf39m9eFECQrjpPz3UjE1IUnuOv/CNubYctS5jfrf08V87vCaBsNYj2mDoYrEc
	wKgFNHdz5Jm+C/se0Vk+PVX7EJ6kIhhBut3tnYh3U7lMPkxp5hOsUA6WnXljHOAUJGROkN7byYu
	SwNXnqQdfXDWiQasjQ4QImX+7jsRe61lh/4CP6zPmBGAJERyTdVW7G5Xt/tLgbJHZzoyJgxiYE1
	7bheKkuqEE7OC/HazQkxC5ETpoMIWxO2ybWtQYvQiifFnZ809McSBPhMK4ppCMFtqwjhk0IZ0Gj
	ptVcG4lWFXdRYzXYeElxuryU6irY8YTAN2G35B+pMx0zg
X-Received: by 2002:aa7:8882:0:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-847f6ee37f2mr7547867b3a.35.1783328004976;
        Mon, 06 Jul 2026 01:53:24 -0700 (PDT)
X-Received: by 2002:aa7:8882:0:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-847f6ee37f2mr7547815b3a.35.1783328004019;
        Mon, 06 Jul 2026 01:53:24 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm3411834b3a.21.2026.07.06.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:53:23 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] PM: runtime: Fix sticky -EINVAL after resume
 callback failure
Date: Mon, 06 Jul 2026 14:23:08 +0530
Message-Id: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPRsS2oC/5XOTY4CIRAF4KsY1oMpaBucWc09jCEI1WNp/wk00
 Zi+u7RuXMzGTSUveXlf3VnEQBjZz+rOAmaKNPQlVF8r5o62/0NOvmQmQSpQsuYNXU1M5M43w5H
 6bFtjm4TBjJ0JU5+oQ2NHMo2ldgrIlf7WHmztNh5YWR0DlomnuNu/cpwOJ3RpYZbGkWIawu35U
 hZL76VrkB/rWXDgyntXCQ1COPgdYlxfJtu6oevW5bDliSzfmepzRham1tuD3lpwzUb9w8zz/AD
 BtxpibgEAAA==
X-Change-ID: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783327997; l=2169;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=kv9UvjF4OBgXx5N1hdvWktzSDOGEwPg+1mlUNMbBiJY=;
 b=mn+rVKDPni6XEuSuNPFes5p7k/c4PzNztMybdKlLJYgI6PIK5HSfOADRi3ogBmqhDFX9uVZQy
 NrjIgpAcN4eBPNCytloZRClJGZK4bIp80HuDvav7fELIF7FKAdvj7Ol
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX8yZXXjHaOeHb
 3b9nPt5AbH/cMkvfZhOVa570DUIqaphmIAYXoXRGiek6X60DWhesqNhufNbPjZdXJE8RkKJNQPN
 botxVi0NOnxIIXJMnLgDPZWh99F2Qa8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX/yCOgey3IzkI
 /Dka1ktBTXpMPlI6yd46M3oJQUbfuievB8i59seVxD/12+QKmBBYsBWJi7pmPtK40+Ad7kTMHOk
 kF4B4bEgLN/HSCbHgDSbY65jKmESTJpM/BRaNDsAaa87ss7SuGZZ25Z7x4TTUpr1ik8Np3EfXch
 Q9TcIzKiG/q8OKQd8+kwukZxQ0vgO0ERrmdfWaycnkwAukaCEXb7XtNgyk2+PjxxLa6E7zbPsdq
 gxEhE8ozqsOdl61NHV66KPDL5fb91KsNaCzuauc1fraMXM+3F4FqAabPngq67XQDwT4zb61bsA7
 X8FAm8xe9hTtUtVNenfNU1dSVhy0go3SgLQA3l8Y3v3nLSL7nQ4KJuVUFNE2x7QQt1zAuc1r67F
 0bDGoaCV5xSPcX2j0tCxIa/HYInob/RJxJz/azszt43w3Z++F1gc7ZiGGwd8I43IBso6rsV/iqR
 406TZTCl+CZpytnddvA==
X-Proofpoint-GUID: zsxAQI1hAr7NGogS_hD3e8-Lnq4ZakHj
X-Proofpoint-ORIG-GUID: zsxAQI1hAr7NGogS_hD3e8-Lnq4ZakHj
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4b6d08 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=rhjnKYj_BpsB81YBZ8oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060089

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

---
Praveen Talari (2):
      PM: runtime: Only set runtime_error on suspend callback failures
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

 drivers/base/power/runtime.c |  6 +++---
 drivers/spi/spi-geni-qcom.c  | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

