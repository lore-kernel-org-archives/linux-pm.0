Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62025B0BB
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434760; cv=none; b=i2blHYqpGwb8gg24oQNbV+oDyVSGbMAfc8X9B9mybBgLhHxj3Y9PhlTI494iX7OVc9AcY6RFDkZ54AlkTI5exFihBfFYot2eZ/qzSU69GMLseD9s7ZE466qVxqWny94gzz7VmZXI7e9tUF8bsGfd1NRpv0Kxw9qxSDHElwUoeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434760; c=relaxed/simple;
	bh=rDeXtDL/PJbNE80wWmAYiMIlUv/C2tp5BR6QLjbzJRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYoeyEPk7PKl6lALliRaX6v+5BLe+pl7HBBrzTwDHrEmwwp8dAYg9Pc38gI9nc+o21Oo2505LhYDagceFSUn3ZCTMbwK4W/rglz1Fg1097kla8+yZhjp9bwyIuUIe3QxqwsmLCmZ9oK8DxkCIt8g3U7Xrz+tBYVUjlMz5zHJOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gD2vEr+D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OD5PbOz0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gD2vEr+D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OD5PbOz0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652Hea6q1938135
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 21:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhSG96DeO4siCnlPLzkltobE8Bmk/gbxupxseeS1UBg=; b=gD2vEr+DoVPkixd4
	cS5j0E9R7LlPbyh5DJAyVIC+Vr9/uVwFOxWYlZxSnp2J0O3XKqaSpef9w4Y8LowJ
	RxbebOXoXSe5/TuC4wFmLDzTqCIqpyhLiMwLofoHxnuFQqoWQFUry04+vVV7dCps
	hkTJ40ct7QjixlXT66rUe1A78PQU4/qcUc5YC8gCnPFrRxDhwmDWKjkDkSWvdKvt
	WrCztXkU92kt2PGjAb/Q2GaQIgnhYUqNicBQiNq1rIOx42qhMYRibSyEl+iRI6+R
	kUkY4nB7BAJqgE+kaSKA/Ew3TG4YP3pWFt5FvHugJVaK3vms/UpEibeb9E7H07wA
	28VgXQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubm3bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 21:12:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso40251221cf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780434758; x=1781039558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhSG96DeO4siCnlPLzkltobE8Bmk/gbxupxseeS1UBg=;
        b=OD5PbOz04O+DdhFIY7qgukXc/tWkf576hLkuvjzwuZiTI0oyc8lCu27KI+NYIwbfyh
         guaMpA/C5mgzqdUMrqPYkhf1R9yKvn9lmv6SpQFL4DvENXl0z/ZWw8wWJEI+ckvKBjPa
         cUM+lNHXct3kvL4C+MGNgpm/pDKePowyLJnjrqqjZvARVH3CAixxu7/+zFhT6pHq8spI
         ho6TcXxvGNNP7EQRBGbURUvUWWC/6lFxleIezjniurcojJ91r1jY/DHfutA+F83rs4PZ
         K1htGsm+8jD2l9Ll21RXyJxMyP43Fh1tjsjK4qKzSTISVI325ue5aLU0ciI42l2yIbGn
         6+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434758; x=1781039558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhSG96DeO4siCnlPLzkltobE8Bmk/gbxupxseeS1UBg=;
        b=Gw6PQ0OHXlJdFR9vX/SpHbBoMJTkND7gI7RnfGdKDIr5gelXJTZP+1hd08p6RddfCX
         vHmOVR2s0d5Ux0MbQ3tiK7ZIG3pjJPq+fxinGZOPO162XZ1vL+H0Tw9kMCcBimfrXLMW
         sr41lP5uV1U3PykK32QJKDYtpfsMLQyqmWy5bIeLd0B/qKN3uHEO9IHIGeBjm2ontyGk
         pPmBA9AxomviD+b8jOpCY3YEmYAWJOTTfkD+JJArhIdUDoX7fJZXuxT50C88X9Jkmu2W
         tS7hiUkysD975QzBzozGj3Jep0sBQuGa6dC9MFUycUrlchPboP5ge+Rf3shHfavPIDbi
         ogWA==
X-Forwarded-Encrypted: i=1; AFNElJ/0TPJme5oANUNc4XoVKgA1Fd47mw17blMPE/16aAjMHZuNlktSiB54AmZpxQo2jpqSc7BSIj4eEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLe9ASt5Uwn2AU6HyKT/Gbbpg6F5N/ymNdzEQJNLKMtVieaUV
	Ar8ENbdKaIy/UglvpIL42Lk1L03DF8rqjSFSpxJtgzk5y2B/bUWuGJc5WxHY0jHt3TtEqkCXZz1
	kqtTYUeIB0oee5N1TmPeEtE8qQm+GSpBZliM7PkL9p3BNlMwgWqtufeOagHP0wA==
X-Gm-Gg: Acq92OF1bjGHx/5D4yTkDWa/CtRvyJFHJUYYXnrpGBRVaSMS3IFzcR4LP9ZlaKtaxi1
	GDusGI6aYmcxK3aTfiajyxTErz7z4lN2RSw3V4Hv8m7du2UAzI/NXhjjJxPIMDO3QIlNaPYT8cb
	URsXn+uc3Dp3z5f1uAUcuWFloSZSPcT3ToIamwjZywFgDBwEhrZo6ejyyFEoVg6PyZv7FEBL3oY
	RVZWQB/ASTZuSWK7d4vFaWQEefjoXf2taS7OmjMRiyX5ypKtBEvXuE2RIVn4FCtPqIOLLTcVYZO
	rXyvgJeDkLoXVtSGFz5wUN3kJLomvFhywncpifANXLOwzxgclUs6ldC2L1XhX/oQut99K3LBqkI
	0/qWKx8JJ/QYARTANWyUT0bLKhkrwjVuSvNbr7Q9EzOMimqpD8XakWB4T4Rx+OAqZgMr0hlbW+T
	1U
X-Received: by 2002:a05:622a:190a:b0:516:d955:ea4 with SMTP id d75a77b69052e-517785d8ec1mr14317851cf.17.1780434758013;
        Tue, 02 Jun 2026 14:12:38 -0700 (PDT)
X-Received: by 2002:a05:622a:190a:b0:516:d955:ea4 with SMTP id d75a77b69052e-517785d8ec1mr14317431cf.17.1780434757610;
        Tue, 02 Jun 2026 14:12:37 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm2086132f8f.37.2026.06.02.14.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:12:36 -0700 (PDT)
Message-ID: <993ef9ed-65d8-4bcd-b0f9-fa6f167395d2@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 23:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: qcom: tsens: refine wake IRQ handling for
 suspend
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y2c4SfG5QIV0Vh1L7QbRzNiHVq_kpub4
X-Proofpoint-GUID: Y2c4SfG5QIV0Vh1L7QbRzNiHVq_kpub4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIwNiBTYWx0ZWRfX0T2mJd1JoGBX
 jOsYYo7oWWs/kMqt6QNn95Fd7d/zooxUDaJh8fnIkK/LC+XCVZzDdxn1PXBMkTlStDrRL5BkwNC
 YSz5vSIZi4BzJFqS/P0GORT3P8KDRzhWid/wg7Ka63eGsdXdFqrk0hFEeAmKnFHrMKTzRvfDQYQ
 lEKyin4VkYphuhQP9feHWaZCuk1EInX2L8YMx8wf3mzmc2A04CJ/m6mB6XzSZJuDzVNMS+1yeJR
 3wrRoOPnpT7qLMarCnMRe77yhwoqSG9fBL6aey2s+oi6+9QlHGmkVWuPtRYzw/PakY0WtAdTPqk
 5HERUKJQuKLB5Oh3hY4xlrf8BBPi3tQx9BPyEkm0/o8t11qMDOwPhUnklwafCCWw11YXYvzOhHO
 1qReSIhKh5LeJ5vXz+T5eSt7rPIDHJpoDQelbvBCgazIJ58rgaOIGY7EO3V2Y5bXs3IL6GfJKCN
 d70WFQbKBzDid6Hd9XQ==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1f4746 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BZznKAv9R9A1RLtjlQAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020206

On 6/1/26 08:37, Priyansh Jain wrote:
> This series refines how TSENS threshold IRQs are used as wake sources
> across suspend/resume.
> 
> Patch 1 moves IRQ wake control from registration time into PM callbacks,
> so wakeup configuration follows the actual suspend state instead of being
> left enabled during normal runtime.
> 
> Patch 2 adds a platform-data opt-out for wake IRQ setup and uses it for
> automotive TSENS compatibles (SA8775P/SA8255P), where parking suspend
> should not be exited repeatedly due to TSENS threshold wake events.
> 
> Series highlights:
> - store and manage TSENS IRQ wake state in suspend/resume paths
> - keep existing runtime monitoring behavior unchanged
> - disable TSENS wake IRQ setup for selected automotive targets
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

Applied, thanks

