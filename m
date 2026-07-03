Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6241228F
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091152; cv=none; b=gUCmo9qsgL3plE7d/6DponhfeNdOsbmrkqnSdq/2/oJPsiLS51ftkdlsJdk4B9oEVIdKPF5CME01Cm96d0ummYLF32fcrSkQtxfg0LsT6EmJiluKWiPZtCgvm3zgxDx2tTgLWfKNV6vJOejr7P9TODxPSdiAKbemwnNUMQw5NhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091152; c=relaxed/simple;
	bh=+1AFISiUFHQ4vbjZNkqW9aWZMrSy4vCzMTnu4c7NCh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPZijQZUoTpwtlz5bGAYbs8sUnSNFHqw+7+BY8KjffC922Q9HPNxauGheDe2qX6VNLFrpv1sJKQriEbu8NPB7dNzFYDMWddC4ETu4NsfuOikoUrc/WdHW0Q81oqvMc2InX2EOMCQUtWg2NGR/VclHptgfw1X435IyeTLVgfm4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pSjNwadW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DpWP0a5Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pSjNwadW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DpWP0a5Q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BW1BO3136108
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 15:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6WeUVekFxFkuveS+M2x0ccM56quUUYg6HrGNJ97KLF8=; b=pSjNwadWc5o8+Bx6
	hts1chv7RdRcidjgnMa0AL3V8enFnXFkutJhZFIcwXOLJN75Xivfyluyk3PxYnZt
	SnuI5gcRqHzjhsMDDkRb1LywXMzjaM5fOWIVLOohfcL2BuBSwLDigj3XD2yoDfSP
	DzIyp+ZISPoNNVF5ZZlDtJ8kSqRLmbqYgtzA8WG4S5Fjl2jKqKhla9UCqZT4fIwa
	J/0PrkDNMsOV0Lpw4s/inRnW5e6gU2FUSv956Eu8RX9A/emQ3ROjLQRoCGIiCzLl
	mn1ymqSvkVKe9hQLp8AaP21zbsyeF+yAf1b+KujIxdLjq1rzmsDPun8JjtoXbgwp
	6xEgjQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5aunt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 15:05:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9960cf96cso11946485ad.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091144; x=1783695944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WeUVekFxFkuveS+M2x0ccM56quUUYg6HrGNJ97KLF8=;
        b=DpWP0a5QcsiQURy+sZmDvmM8zWNmKSLj2gAV5rxPcrCD8Gmg+kPer0eGGKMsxazCEf
         2rcWypfHObDDhfIwXd31eqFCeejesFuGdexO2gMaXJDx04C3c8/GnC/OWhkls3vf2Iey
         17j30teUPvSNxb5BvU20r8d+DYT6jcRvr1h6wz5gzCA1WlIEFR99JVzn4VdfU9UZ0ie3
         NDGDSaIzYmXxPNCpXjNQiLN2hktKhBnD9njrod1pRN6b+5ea6jTNAhBJu1qEE079vGwg
         mUuXY2aCEwyFdTP1nXLP+Y9+Vpo33it74T/RB8xw9o86fG//lGxTmpvuW+xw5RUCDA9D
         6/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091144; x=1783695944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6WeUVekFxFkuveS+M2x0ccM56quUUYg6HrGNJ97KLF8=;
        b=k6lBWy85Y6sczfBVdaJWUblYt5huV1yJ4DKwsbkyYvo5FB+g2CpvNOhJzRy4m4GkEk
         floYylx9s0wWRmd0NAlRz2/ZyyAt/9Gvs+j37GWQ/G4et4BQoFtU3jvDJYAy4YfFoYG7
         9DiTwBOFmGq6Jrt+B5x5P0mC8myQpHcgnl1rpOWQxzrTmbX9EhVtXTEnHQVgA4Ae75d3
         xZEvKQcM/rkaXi5yBjwqVJtPylODiY2XC/ZB6XFQm2swjcGPK9c4Cy97DXXn4vQYwyJo
         yvPUP0NjxElENwNYNYwUmWk9yJ7MSnd/OWlX636oLi3VEIpFbCmRCKVdtXIADM0nNOME
         iysw==
X-Forwarded-Encrypted: i=1; AHgh+RqL3LKsehHFs3lWTuAaa8mS1tgW4l/t93j9JHtN6zMu05xUFoGLuPGpoALeRB83k2ja9bC2eB34qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzURXvAR7N9BUSGjB0d6dF1Gdxb4wy1zV+DvSfrzUlomlNu8h6P
	G30tpr1xiudiuJFGkZJwemIPuCWmV2THT2icTTNctVKO1oZsh9d01WAJPPm4mW/o1lHwXJGXU0g
	BHzhbsTMATyxwJ5zKxYRcJMXcStHJzwPEbaBIKcRW6fmwWNFKi0kaTo55KUaenA==
X-Gm-Gg: AfdE7ck0ljHXmQIjehfSCdb3kuIlz1pPc4ZAHWbaJcTLooXJ0GtaiQzlN51wuBR8b+K
	QXceL/oWNR+T3WBXf6tq+ZMsvxPKX50nvs7QjGHazcOgmNm7juqw6znU2EGr9kvqstQJ8eDOA+g
	8IRKbTtivWfAxLy4EX5uJ9UPxTg9mypI6YRF3TBZJPgnGe1mH4EGeDftwSRSz+BIN7SKDfA1KJ3
	jBfADGXTH+fKt6tMBmNk+B21FrYgFVbZzJiU2MKxYBBphZLrBH/emupPjoK0fimrl6l1NxFLfFc
	ASGTGyDWJitwRjmJkX6c8sDo24zDC08HfIRlFv4wFDiD3xuwxAK1NhbO/5JVhseavG5DdkfwKY2
	rl4V83mGsJlwQVhuKk2LEJ0PDG+F7LBQXMQWupJEjsdeR
X-Received: by 2002:a17:903:2f81:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cad1513c0bmr45356575ad.14.1783091143874;
        Fri, 03 Jul 2026 08:05:43 -0700 (PDT)
X-Received: by 2002:a17:903:2f81:b0:2ca:d151:382d with SMTP id d9443c01a7336-2cad1513c0bmr45356165ad.14.1783091143295;
        Fri, 03 Jul 2026 08:05:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm32904517c88.10.2026.07.03.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:05:42 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:35:20 +0530
Subject: [PATCH v2 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-1-578b78a0cf46@oss.qualcomm.com>
References: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
In-Reply-To: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091129; l=2052;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=+1AFISiUFHQ4vbjZNkqW9aWZMrSy4vCzMTnu4c7NCh0=;
 b=WhkaOSwYX/KACsdDCwK6cOceV9G9k6O41aw/xNJptN3pHVbX6NRj3bPwGg3tCIGB355tgCOhi
 iXsJ4/uG66RDjut+TD+/pBhvFZr9wz2auoG+gT9Oy5f08xH8B+2oKG2
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfXxh8pgARgmspf
 ab6vFzAyKddYOVWhAXRaBTeLgREx5h8al3swja3L3uQdxCFXsZuxDi0hzu5qLcsgxFlcopM6sBk
 Iq3hTBvt8HocyccXguLgQq2fwVxImEw=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47cfc8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4WVRsyPI6hImBWJIeNoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 8RSHru8VfVdi695mM45LflePfoNoH9Bz
X-Proofpoint-GUID: 8RSHru8VfVdi695mM45LflePfoNoH9Bz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX3SYsHTHMyRKC
 xzVfMCFVwTVvHBKQ+ignoIK3koFeac3Gn9L7zgw8VQpE8qUnjejO1zwHUD34vrv8QsS4lH1kma/
 kWVnHpBf8S6QogFBPsR5Ck720clpYDk7FtkZimCffzyFLme8B4QXgi8sJyB6mInws2f5pVc6dmL
 3gY12z+kFTN+IPRYIky2JwetIhvqEoFbIjZaYxIYWfc/J3j08ih2ZSaQCg3WwtzTEbZBbQgYjGC
 Xonomfhc/7xTIwgWXwV0DVj7K4QWNo7QlTVcE5U9RGiF+DxXalbObU+aFo3TUOXXoYrdmhAfSVw
 TMNi62nHZiyueSWpv44wV7zrt69TkDjDm3HhfZNqGqfIOOvTEmrFgZ8XlLKJVzdZyD2caAixllr
 j6bRB8hALReznQ8MgxdPFjd4Y0JoQRYN0daKMvkxHLhyb3biBDT7XNZ9/+zysAIjmsdBN/uIPRM
 YK58BJQImwAdxrS/47Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030149

When a runtime resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  This causes all subsequent calls to
rpm_resume() to return -EINVAL immediately at the top of the function
without invoking the callback again, making the failure permanent until
runtime PM is explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  If a
device's resume callback fails transiently, there is no reason to
permanently block future resume attempts on that device and all of its
consumers.

Fix this by conditioning the power.runtime_error assignment in
rpm_callback() on the device being in the RPM_SUSPENDING state.  At the
point rpm_callback() runs, __update_runtime_status() has already set the
device status to either RPM_SUSPENDING or RPM_RESUMING, so the two paths
are reliably distinguishable.  Suspend callback failures continue to set
power.runtime_error as before.  Resume callback failures return the error
to the caller but leave power.runtime_error clear, allowing the next
resume attempt to invoke the callback normally.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/base/power/runtime.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..70d933bcd295 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -469,7 +469,13 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 	if (retval == -EACCES)
 		retval = -EAGAIN;
 
-	if (retval != -EAGAIN && retval != -EBUSY)
+	/*
+	 * Only stick the error on suspend failures.  Resume failures are not
+	 * treated as permanent so that the next resume attempt will run the
+	 * callback again rather than short-circuiting on runtime_error.
+	 */
+	if (retval != -EAGAIN && retval != -EBUSY &&
+	    dev->power.runtime_status == RPM_SUSPENDING)
 		dev->power.runtime_error = retval;
 
 	return retval;

-- 
2.34.1

