Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF639427FA3
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893334; cv=none; b=fCH6JpFOUF9Pmq/qQq97qgkZZXOEr82JM4ztKsb2n0l+slaafNaYqRkngLRe2elO02jJfC9sWAvf/db6bZwK1ou0JvL2mrrSNZDYPCb+iT0ZVfYEtmKEqqObPRZr4dChemGRxMLI4ciTkk+mz+JNW6HF3L+jYvybjn4bnrGHaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893334; c=relaxed/simple;
	bh=4Bm69Yg8RIZJ8BDdbzvHwZy0AX23wGKsLFtXKPqJCuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XxjUQcYJA8HPInDHtHcJnmuZTMt4cSzFm4XjSQiTAhcXzxh4Xee/BByHxlYKjqf2JZJ1mn4MoPWT16myCIBukSLdA223s9ihU4dVEkARe+4ji4q9Bd3beU/ZudkansqglnSOYQuKcgUoeLD7EQhig/mgX+bJOPUczNLmY3hADNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+zdG7ft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WkdR4D27; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+zdG7ft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WkdR4D27"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OAE5GI2256714
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jrfbSY7vue+YfRuGSpzdj0
	Ofx5ovB5eAwsN1MtZt+C0=; b=T+zdG7ftozOFrv9ftGJaSD6JmHB5HMeAxxTv6z
	PZeuZhs2Ueo/oX5mBiGpZBVEI4Ux/ouF4bhtCPgd1YIfuLDGJ7snexTnnCDVkuy6
	zux4Z04VGFlhDTImepSNFVZ4wY9+n8c3lx047LLD10zs4QsaksesMhpWuOzuxN2w
	qaBN68BUNGipzvNYOlqBqsFjfMF3y4B46lFPzvQ55ho9OhJGkz8AS2Naw7gljbbn
	UzUB2U1JMijKeARSc7LfPEhHMWHbzYkkV8giCy4FOYjS854/w7WXANcrcJlSLjjX
	YHPInGqk5Knzp1q+fqbNANHRWHdmKSzrNvhrkfh0HF+/d/JA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrtb3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:00:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc8bde6318so5972365ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784890832; x=1785495632; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jrfbSY7vue+YfRuGSpzdj0Ofx5ovB5eAwsN1MtZt+C0=;
        b=WkdR4D27Ne0r5QiHvkn530WufY5fv/CSucFLQdiBy5RbJyq+Cgn4SD19WdMHLIhkAB
         4jCrRzqr5Qi7h8BTFFi2h0WnXiYnDR+/Duv21YnZz4i8XtSoLcWTWxLxll5sxBTCKfNA
         IIEDwot/X46vhpN2y1C6oJ14AaxTWL8/Vy+3sI0oWjgKiEi8VEtydUEzLxxLGRaY9+22
         sfN2HVS7fUh9Tw5PfLIqrJFucWGBCODRbfo2p0n9FGIMGaceb11WHY39NLUVGfibz2MG
         HrS1fdFyHFlRZl9aBdWTxPvxN7lNIND5iCgPLcMUSoYN9cPtW7gK1LbMDWskgNvUGKPa
         BqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890832; x=1785495632;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jrfbSY7vue+YfRuGSpzdj0Ofx5ovB5eAwsN1MtZt+C0=;
        b=ZnAWSUyrcYxx+JUOeNB0Z9UAG7xB5G1O10BECqb8QdntB2bMQO/XX2KZhsier/xEUh
         2keo6pMqtf8rseEE1I4NSS/WCqK1yqd8RmoCwCfUZUnlb6pKlIUcy95RdGsBAYzkDJvh
         SxNS9zfqItToPImjkYacOF/+j0Q5wROnr44hUqLZhchoPdJmgKaveKwiNn3xTnh18MaS
         j4mBceBRarBVQPdw4y3k9GIV8xTXIAQrGU1JO8V6Mx/Ufrk2VeBUAeAVqi18wTm4ZWh7
         GLaIYFvNSt9tArIWNuMnRp4VGR7vXHPZUwh+aO3w7sNCFIvRuwHbnW9E+JfFvxxcieAk
         bHKQ==
X-Gm-Message-State: AOJu0YwKU2ITJPIdPRsrcPRIXNySKtoTwYuwtHpBiRMoEYrUZm1XE3MQ
	5YDuc3f5RWK+aueSPUyGQ0buMfeMA+OoMKCveUG2NDdY4UmMLiWOakL0976ZEVEJa944EoiHhMk
	JzPqJyVldPth5Mq0lOpBJIxJsrzUQKRc3BXY/4PXoX3H6pYM6pkkH4wQ/PPfV
X-Gm-Gg: AR+sD11jkCR/rZJTI2TcgVe72IsjKrqnFz9RAVwVaMIjRQXbfEOL6Qd+24pXBHlgnXr
	BsaWl++TzDheS6J3jlaKT8zW3jJnShbZSOUnvdjG7xZpoHJdJyiZ4YLX+094D40VYzEEhwTRvHa
	vraEmHJtP2vH/cvcohHmRuALZNcvqKGH1TVDyVjCUpLptbE9F8/pGg02vztFFktdaZL9GHo86QS
	e56DBrRQFtIdaLZZYjwIcYMej7G9vlm2sPRsdokDoAn+zeyuBYFdhL9wxdRF+8thvU8baZNt98U
	SGj6lQNJSpHGaC4bVucfUppfagbgtvUDu9HUFcPEcvDXRY9dVR4Jj/lvpyaaBdERVyrB5EjDSUc
	BQmmYNPdfikg8riL3ymyPqQF0MSpKaA==
X-Received: by 2002:a17:902:e80e:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2cfa6b7d0e4mr80647515ad.9.1784890832269;
        Fri, 24 Jul 2026 04:00:32 -0700 (PDT)
X-Received: by 2002:a17:902:e80e:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2cfa6b7d0e4mr80647035ad.9.1784890831864;
        Fri, 24 Jul 2026 04:00:31 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde245sm48984225ad.29.2026.07.24.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:00:31 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 16:30:24 +0530
Subject: [PATCH] thermal: qcom-spmi-adc-tm5: drop IIO_VAL_INT check in
 adc_tm5_get_temp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-adc-tm5-drop-iio-val-int-check-v1-1-0b85a0895dd7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMdFY2oC/yXNTQ6CMBBA4auQWTtJqUiJVzEu6nSA8aclbSUkh
 LtTZflt3lshcRROcK1WiDxLkuAL6lMFNFo/MIorBq10q4xu0DrC/Lmgi2FCkYCzfaP4jDQyvfD
 csTbUqLojAyUyRe5l+Q9u98Pp+3gy5V8Vtm0H98QZp4IAAAA=
X-Change-ID: 20260724-adc-tm5-drop-iio-val-int-check-38e27c4018c7
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784890827; l=1273;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=4Bm69Yg8RIZJ8BDdbzvHwZy0AX23wGKsLFtXKPqJCuo=;
 b=jVLuG428fMEwp38ZG+icy3qWjwZ5S6ZGcDXxwyMGbSkmoQrBPoniWqRM5QfEaVz0cy1MniEzs
 Dfu5lW5rLhQDYhms02UR0C6KDDQsNueFqgyhVlvpZp3mbxJ1/Z1XEq+
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5OSBTYWx0ZWRfX03olHH1VnNUj
 BI+IHyA8OSzKALt6rIGeC8FRE7sSQCl/aV9p6+BbSUSjDtfzzhJQxT+lwMjcSL+5ESfnQ3TnF3Q
 0nIJ4EUvP35Pgz234ChzV99R+L339sY=
X-Proofpoint-ORIG-GUID: KVaYrkYzUMv5u1Wv3SYgbXQkGtBu4Vzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5OSBTYWx0ZWRfX8Fts0m0UHTmE
 9S+FR6HCawH/gq0t8q9au4DiHZwy6GXmJeF6VMWICk4TZB9cUWcAcHaApnSuorJloZZUkxu16jl
 44Ud6y3ne/H62WGutRO8sPSVyw8yYaqEWdjhFC/vAZ6W3jhCH55EcRdvu3NYiaN4/2Kx9DW9c/x
 pjemYcNZ1MZ3pYN6Z4pMDFmVrsOys4tJaX7nwMGS8twa94vLgrbSnRIqd6MJVpvGNg21Q4HnbxX
 wu92U15ASZ3VuAF3L6dGEAgrqGYOxYcwdeVMv+hBL2uCF9en6xJFw43XbrcvQysMK0u7POw8fnH
 X5ltK9kBhmuibFP5VKXN/lVvmg0mhsJenvA+2UgFlLs3SAXsgZckaTT20P2VDKZB8/ZEo2B2aSe
 HxYrQCoNIP2LbOdeGbEomrkT4BaNyQ==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a6345d0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Yggj7pwo_nInIw6FIyYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: KVaYrkYzUMv5u1Wv3SYgbXQkGtBu4Vzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240099

Commit bb21ee31f575 ("iio: Fix iio_multiply_value use in
iio_read_channel_processed_scale") fixed the
iio_read_channel_processed_scale to return 0 on success instead
of IIO_VAL_INT (1). The existing check in adc_tm5_get_temp()
treated a successful return as an error because it expected
IIO_VAL_INT. Drop the redundant `ret != IIO_VAL_INT` condition
and rely solely on the negative error check.

Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index bb6222c8cc5f..af72db6299cd 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (ret < 0)
 		return ret;
 
-	if (ret != IIO_VAL_INT)
-		return -EINVAL;
-
 	return 0;
 }
 

---
base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
change-id: 20260724-adc-tm5-drop-iio-val-int-check-38e27c4018c7

Best regards,
--  
Rakesh Kota <rakesh.kota@oss.qualcomm.com>

