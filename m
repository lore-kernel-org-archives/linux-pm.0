Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8168374A15
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972552; cv=none; b=mh9eAN8oeZ7E8f25rVENWC8p+p8LEiQdMdATfi4Pcrd0qrszi5L9u7FZnIDnVpEqA+UqGGrJNVDMn0zXNsbFWk49T0aaGSRnU9l1EaGl2ttnDBRlKCOlR5jvR9db18rotgLHISksKrZLQZpxmVHS9PadyHXU4fZWahTa8Yij4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972552; c=relaxed/simple;
	bh=ABJeyst78FLFzl9Ct3p5szQOsed4/LKHB3A9jqiuHok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA8xrsZLVIP5PxVmEQZqw6HV3Jkwx6jUYOeKMKNOKijHU1WuYiFlNju0iApkqdvviuH8JNkJlmyFlzZSMNNGC0Dt3NU/E9m7EKqBIWe3ST3EuJLVKDQIi62vumLwKxA8sIG+L4YGqosPoUD22LMFjo+5/RsJ2opdLKG00iwsWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YF8umf35; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ill/3Gex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YF8umf35";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ill/3Gex"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624iLrP3591734
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 06:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=; b=YF8umf350ugwReW8
	WLyKw1fYhj7iweUtFyEQGJfItQJwpaBqBEi8dPBk7p6eoHvNVqjHsFhFBaFz4NUJ
	mSvlqDFgnhiJtEsgZusvHdtSeU4hUc4ZQWdQa4rUx5fhLhPBqTy7ow7NkQQGU4os
	AuOXUNvTAKBJ3hDPRVCEGqb/pMiYJaLFNwdOWiW75cgf0f8fd9YxfCSThh3omQ0F
	MP5lK6PLNDjyWT+tOeBapcu6hHByLW7+15T36451FsT9P+TJ+cgB+l7bMNma/BBo
	cfMbJL+tuHm1qkJ+Yvzq/pG4BPDSd69MXJMgPdIoZEml8xRGV/vCEhxoatiUk0Vv
	gS8lcg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n8872-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 06:09:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c9960cf96cso22447625ad.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972549; x=1783577349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=;
        b=Ill/3GexwTi/ebrAcAeaPTwczPP5VvnpyXEGZ5DJegVVH90oDb6KrRzzMVVCb7YLdi
         sLYdjhxlRK70oQybVre871exLJ0yuK1lfTmyh48QGTGu9M85EurgdE+fFj4G8mg+5BXr
         HfNt+GSTfHNaE+l+3vg7NnOdi68/eclFzCDTNl1ZNTcbNDTPuyXCvgAA3XJiceUj6ost
         VHwWgk6jOKuSQ8UWt2DcLxz8+6rBmpAfvUqnChCtY1+TZXNXhG736eoW/yHt5GZEW4Vn
         redPBePx894xMni1CpuE4928l6fFjRxNMDNPWmMgE0QYOOcbNgHlJbuIGAFxuJw1fO/Q
         aE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972549; x=1783577349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4c11rFRRdg9DIaHq3/L5hXGchxFnFdVy3MEIWfSpE0=;
        b=KIw2iqMUiwF2ML9wUvzugV3OuOP5CPq6imKUp5LOvonpdHLBzlcBv3R7BbB3SWnNYG
         hvokmmsVAlrQezYPZusyGQvFZmMJbJigD5p4s17MA5m1/c8rRlQz8BfjI6iJfGJLfXmw
         FEuqW87fsXSuwBdsibGqF0aiTb5mYvYIZAcbSyTosYMCZ/sfNnN216lXiZyk0Lap2zro
         P+U8QC0iLaLIz9Ml7wVpJwSCiEKPHLxEqp2lYg8QMHmui3Blb/AjJHioxLQ/p2uHnxHm
         oQz7cTlhqPOKWVVlQfzI7F4RpF8DS95Hbj9X9grgojwyowpdAMAkBP+IkTxUCsro6tMw
         mA9g==
X-Forwarded-Encrypted: i=1; AHgh+RoqZPCXxkbHyHeXa39phX2Ek8Cx7qI8RJMYMzl9H/8163XPye8CCHu5AHz4bmkfj/B3HOnjlYVccw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KmMDk0NHeG30mEShrjp8VBFy4lMe3o/wGzVxmzwTX4MP2fBR
	pi+PFrWBAFBQ8HOHofY+fpVthZnbFkHjqnszpH3evKL05e1n9hMDtkYvOsijxquoMlhcg3+AIs8
	Xf/pSQyc0jvUk3Yoa7s5uq5/LMdgtkMqDtMQJi2jhhaUbjCLEd4bmuxXi/yDZ2g==
X-Gm-Gg: AfdE7ckIn0xlKrztrNM1LomO6HBFwA9f3G+dZvZ/sr/7q9UAnyMRPlgR4hXQgKYXNum
	jbLNu6jMMFSjCMcSDic7XjezpCewzqWgbx0BEmKmu2N+I5IkfW4nEqdR0UjXbvcjQ35/vLoMZiN
	vcnvNeRQ3lzAZCuS0SHbTNFnpzRoU9O1V5x36Z9c4fa40J8nEwmTfrJ5OKxlqRD23V5/bLw6UCd
	63VnxqxTCBqCnkEcCCtTKWB2alPr8mgWvNXMf1StyK4pw0l6JUuPopUdkHeS7QoaXceWcIJf7Zm
	oPBVwiPA/MlIcfUkpXUKVtZ0i8l0Ub4IHplz6Io51GM+DKoPSvUfLTGKD0FL2Cl4HzEOKAJanyX
	rIRGG0mvmi5TA/+FrsoiLirXXzM0olbX3BodEpZldb8r4
X-Received: by 2002:a17:903:944:b0:2ca:68b1:b64c with SMTP id d9443c01a7336-2ca7e75d694mr46456255ad.20.1782972549332;
        Wed, 01 Jul 2026 23:09:09 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2ca:68b1:b64c with SMTP id d9443c01a7336-2ca7e75d694mr46455805ad.20.1782972548669;
        Wed, 01 Jul 2026 23:09:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:09:08 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:38:23 +0530
Subject: [PATCH 4/4] spi: qcom-geni: fix sticky -EINVAL after PM runtime
 resume failure
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-4-6ddc317011c0@oss.qualcomm.com>
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=1226;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ABJeyst78FLFzl9Ct3p5szQOsed4/LKHB3A9jqiuHok=;
 b=pTmMgvbP8fxitvKl8gNaFpnEQsYhWQcIaXWMOE1lpf+pt3wEj/I/dPGuaDCXim6fhgCF2LWpC
 gUViEoKW7tJDmktroj3cQarFJG9LkP5v+iztS0gK1GCq18Nn0VBrgrG
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX7IHLQtLwmjSN
 /D6mC1urz5jetrTkIFK88mgZWmpikV1RGJaub2PGnHJiD5eg2uD2NUBMLB5yVIjvTnxjUnRqg9h
 IkkzpFQopcWJk1EAzhOG/sDsFXYs6p3KJKYX7fO1+Vvv5wGe38zJBltd3cL84/C4Z+o0a+GMtAh
 BLZwiv1LT5qh4jTQpnDnBlbAA5zNymPY2sD2Flvbbng7iC6K1EXF7WGl2oAKlY6EaJUUyHY7tvo
 MqP5JYviKT9gcQs8Uf1rb1ABoIk3uOXZZwXuE4d0Ba4dLEyiLWef4Yj7AP+dE3eaHkaynRdgFFZ
 dB2uxSKJAJXQJEYAlR3P2G/B+rSny68XGVEQRMtRiNUr1/G3eSo0SxEH4hryNLzf4hgvXkL1v34
 VzFYgopISYGuI3pChDqYd+Uox0D6DWhMaK21bNA1pxNmyMDI4y+ZgXvmht6lACQQyvt6KhMDMqe
 UBfmaL83zQyfUMR8SKw==
X-Proofpoint-ORIG-GUID: 1uWRxM7DewROZ581Gmo-0zSmKJG39vLN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX25Fm9/QJFaXd
 m/0KMmaiSWpQUs3vM/kdcTeBVsfInk9i2v/XsWK1vJswJKZZAeJPBqRXG3v8m26oZQENmT0QceC
 NV0mZMzRQlb/cU5HhQZXlLXGaa5tYJM=
X-Proofpoint-GUID: 1uWRxM7DewROZ581Gmo-0zSmKJG39vLN
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a460086 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=r-mwoWhorYt2bIR64zIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

PM_RUNTIME_ACQUIRE_IF_ENABLED() in spi_geni_init() calls
pm_runtime_resume_and_get() internally. When the resume callback
fails (e.g. -ETIMEDOUT), the RPM core sets power.runtime_error on
the device. Every subsequent PM_RUNTIME_ACQUIRE call then returns
-EINVAL immediately without attempting the resume, permanently
blocking the driver even though the underlying error may be transient.

Add pm_runtime_set_suspended() on the failure path to clear
power.runtime_error, allowing the next attempt to re-enter the
resume callback rather than failing immediately with -EINVAL.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a55a3afc0ebd..5f65e6d0d08b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -616,6 +616,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret < 0) {
+		pm_runtime_set_suspended(mas->dev);
 		dev_err(mas->dev, "Failed to resume and get %d\n", ret);
 		return ret;
 	}

-- 
2.34.1

