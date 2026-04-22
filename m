Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC83BED76
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881619; cv=none; b=lFejfpbhfSZoYc4BLasauACexwkzYtSK8KfRMtzEZEIJIckbTE6p7NyY7WRfSPDdCTMIB9p+/oAYzblE2oR32bwRw/DBkRhP+tf3cCb+7lWgU1rIWOGXI8XuD+8vsLsS1/p8cHqz1qoK6mM4AZeawmSFzio8vV+nLtReqkslcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881619; c=relaxed/simple;
	bh=PaPDqh80ozVU75aW4BNtrfEuNWCk/0rdTrdselOu24o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga8mSEnFcdL8MGbiupXxCsG4bMDnZxEW0IjhuBDGfvUlqMEG4WNn46wLK4Rpl1r6CFQl1WH7itog3A4Gst5bp1rXXncQWchIBjyQP2PHNDfoumjRtBQISuSbuLaDTeZPfuLez8YLmTlJ4SmMOH7pGm7MFSWkd7gG0R4ptt4O0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZpt0Fsm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1zR2Uvw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZpt0Fsm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1zR2Uvw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG9pdH3172967
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KQsGjDbp+bler2r1zdP37zyP
	pQtnIV+3S3atXelU70s=; b=IZpt0FsmfwZEwHOdBBZJjgGLsliu0wofhmSE8vIS
	zEHKzIV7HxWDtIrUEsSS1nKD0qv4FkG/Rn5AGGI++12LwmMYzclPT//Pe279IpuJ
	cAqCX6WnBGWFdMIXQ/nLupA2jo+MyrKmsS3Q/obmeOC13ea5bA8pWqFdvynS/b48
	HwyQHqVzTUXP3Qyn/7N8294Zy8Xhf+1snguWyXYVJQbsHB3FKa6hf6nAOUIAIWia
	iLur7JldRhFqLFxumA+KibNZCR3wvl8WETPRv9h1u884hcaUsHnw8gzOqtOkM/HI
	Y9PO+vdNmW0u0YftRc3NWfjIKSvFCFCO4L9t+mQDkHlYoQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1m30dxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:13:37 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-953b15c76fdso2369770241.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881616; x=1777486416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQsGjDbp+bler2r1zdP37zyPpQtnIV+3S3atXelU70s=;
        b=L1zR2UvwjdOp04IstzGkNa/zDJSAePcxb8LldcizvqlmIeJDcBZ1VSG4MaDv5LuwER
         fE5+OTJnGQ8gOosy3crT5z/5koHyeh8DS//rq1sDyh+PMFrHRsDffVVoPWd1l6UdPBJD
         lPhPhT9pilsqiSGXSYteb1DqwI4+xMhH8ja1RtEp+QcFphnCFJiHHE8qbse+6FkdxpB+
         9tM6LYR+YJ4lO9+xDP63Qu20kXUXQo8n4NXiy3sLifKYoufHAqylFcq31PWKtCKdh11g
         MA2N5uQzkNi1Qck28uaTMVU/nRtrU6BDdr8CvqJFRhcmpKQEnyIxSOZJAuxua370znkI
         GpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881616; x=1777486416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQsGjDbp+bler2r1zdP37zyPpQtnIV+3S3atXelU70s=;
        b=DsyI0sOHhyX7kjBGCdZ+JRalOsIOeKdWsSH0nrNfiQvO4/Df8CPA9TvIZYu2vTYGOH
         A1BblIVbDOp6qeiy3e6k2twCHrJxrD1saqrw+ezXtVC+dEFjfuTdl0+FK2veMPBfzRVt
         fRncDMZy73KtyT4SQGz5OgU3322wzQayyuRoqbVQlbYtB8VwiLEWw7mokF/WN9GjyjCz
         YAfQj1USj4TBvNK2Dj7GCWLhPziao/akw3mVN7kw3uV+ilL8ov9GAQVG6bKJLiahLsCY
         Mcbj7QdJVnTm30567U0xu4NInv8z4+eN+K5tsat6djMTGh23noyX1p8XpRQCepsfKClw
         bG1g==
X-Forwarded-Encrypted: i=1; AFNElJ8HaQl0LgsYZ2ptivnCxvJ/BW9XsDtCpGjs+HZA6ZAEgsArUhsOy0SGD1ODB+sZ4IOqazAr59RUuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxStannQ72EVeaQ/U+8SODmVwzbwfh4IgrvTKEiN7MO2XNqKYvr
	E7JPjcm9qNpao+SomCZBqi1Bt0j7nRilV3MayiYRL+wWkKCeUY19yx5fKdldUK0apZDB13AwxvJ
	qlamc6uUBGm2/iC78KdCWw1dQMeka4GJkJqe2hcYJtJBDx3B/t/yPoDLrVcyCgw==
X-Gm-Gg: AeBDietZZ2ARJv3jbg5lhw3A+XQrlPi0kElwrV7cpWbi4YIyMsMOMCd316Ygej8srki
	aQvp/PiTzfA3f+jpb6qGymY/fXQoYXc1lLMDnCy9SIYxmvwVVF1juQhbd5Wx1nlnxekUWIG3Dkm
	x+pI+j4W05OP5dtY6on6PtNPSzl/jhiafvVWzh6SYhJVutg3sHmK/y215akkUO3q9pYzWI6V5Z4
	686f3HuFgBkq2WEZ2I8m77hHyPg19LDv2KnLTmj5HB2ReBRLSuRjpzgKdmXMJebFjXaqCcA8HJE
	rN2ZYNyXq5Tda0y7BUQUuv9uBpzL80zJcsct7lHFhYGV6L1P2lmfW0Sx3mQTlUbrggkLvXWD2hZ
	Qa/xBH0gVyHu1tLV5J8rP5neh9De8BthnTdaqEDU6PihG2mHkxxTGtShqxRB/d413tHpHwlLlcU
	d/OtoLO/MbCrTSSrq15WXRQDNfGPBAC5IDeS/31nZD4KsKwg==
X-Received: by 2002:a05:6102:8022:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-616f68d76e4mr10996210137.19.1776881616283;
        Wed, 22 Apr 2026 11:13:36 -0700 (PDT)
X-Received: by 2002:a05:6102:8022:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-616f68d76e4mr10996186137.19.1776881615768;
        Wed, 22 Apr 2026 11:13:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a41974167fsm4585950e87.60.2026.04.22.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:13:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:13:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable+noautosel@kernel.org
Subject: Re: [PATCH 12/12] Bluetooth: hci_qca: Fix the broken BT_EN GPIO
 detection for Qcom WCN devices
Message-ID: <klxyhlqwzl6dzk76lrhugxqdsv4hushphlfchuorcmvx5yja7q@pdmp3abepldg>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-12-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-12-720d02545a64@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cLvlncxzE6aydZX13cbdLcQc9jBEoDgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NiBTYWx0ZWRfX6Eq4TKhVuwFK
 9T3MffotkF7KbPXKXgiqcNbBv3rtVfQoox9dK0mvQgFKmOS3DiV/sPHviI5R3rExxhL3+UoJ1bT
 MM5GbMWOxfuYjS3+YH3YmuFAuPLj3YemNhuTXhOdxjIirIH08xeRkyDyMwSkuNiAWVw4Ak4adXO
 QYaL2LE4SKl0hckyu/6B/33Lsqc4ZjDLB/+Ktg8Qhg6Hbibqk52mFLuDFOUZGYOI6l6yLeMw8yM
 +Cv2D9WbhsNhOKPBc8umo9ln/ieDDMx0AKlZTBCCZOoOMECeeCeHNM8zEQXH4NfmqMSplbICsZa
 ni62tV7w/OIn2W7dS0pWeZSu17jknQtb3DdTEIUd6O/SlyGZeAA4+LUYyVHGvm6Eml7JvXagPud
 8BN8fVTUpDvZOs44Dy5PuXAXQ/8StzAiJG6lfvfKetxl2vKkKHoBxBpBNbgEHvqU5UuvuhXOGZO
 SJn/aFNI/xr+SL6OEKQ==
X-Authority-Analysis: v=2.4 cv=PsOjqQM3 c=1 sm=1 tr=0 ts=69e90fd1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pih5qmTRXcfhijoFvH8A:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: cLvlncxzE6aydZX13cbdLcQc9jBEoDgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220176

On Wed, Apr 22, 2026 at 04:54:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Commit 'db0ff7e15923 ("driver: bluetooth: hci_qca:fix unable to load the BT
> driver")' tried to check the presence of the BT_EN GPIO in Qcom WCN devices
> to indicate the HCI layer whether this BT device can be power controlled or
> not.
> 
> But it was broken for two reasons:
> 
> 1. Assumes that when devm_pwrseq_get() API returns an error, BT_EN is not
> controllable. This is no way true as the API can fail for various reasons
> and also the pwrseq-qcom-wcn driver treats the BT_EN GPIO as optional. So
> even if the GPIO is not present, it will not fail the probe and this API
> will not fail.
> 
> 2. By skipping the error return, probe deferral is completely broken as the
> API may return -EPROBE_DEFER to indicate the caller that the pwrseq driver
> is not yet probed. Skipping the return value means, this driver is not
> going to depend on pwrseq driver probing again and it just assumes that
> the pwrseq is not available.
> 
> So to fix these issues, fail the probe if devm_pwrseq_get() returns an
> error and if it succeeds, use the newly introduced pwrseq_is_fixed() API to
> check whether the power sequencer is fixed or not (i.e., whether the
> Bluetooth interface on the Qcom WCN device is controllable using BT_EN GPIO
> or not) and set the 'bt_en_available' flag accordingly.
> 
> Cc: <stable+noautosel@kernel.org> # Depends on pwrseq change
> Fixes: db0ff7e15923 ("driver: bluetooth: hci_qca:fix unable to load the BT driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 27e52b08ec47..dd1d93cbb3d8 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2470,16 +2470,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
>  								   "bluetooth");
>  
> -			/*
> -			 * Some modules have BT_EN enabled via a hardware pull-up,
> -			 * meaning it is not defined in the DTS and is not controlled
> -			 * through the power sequence. In such cases, fall through
> -			 * to follow the legacy flow.
> -			 */
>  			if (IS_ERR(qcadev->bt_power->pwrseq))
> -				qcadev->bt_power->pwrseq = NULL;
> -			else
> -				break;
> +				return PTR_ERR(qcadev->bt_power->pwrseq);

This will break the case of WCN399x devices without the PMU in device
tree. There is no enable-gpios since BT is not controllable, but if
there is no PMU, then devm_pwrseq_get() will always return
-EPROBE_DEFER.

> +
> +			if (pwrseq_is_fixed(qcadev->bt_power->pwrseq))
> +				bt_en_available = false;
> +
> +			break;
>  		}
>  
>  		qcadev->bt_power->dev = &serdev->dev;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry
