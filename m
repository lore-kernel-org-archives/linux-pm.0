Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329103CE4BA
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844071; cv=none; b=A1Hi/GoCmqUOJcn6m8Dhqmd6EHXvQFH7gJHlU+6647wn9Awq7HOS+Ebg+dcYADWLm+VTusCmY5UrKWNjfP8ort0H6E5sl5aI7SpNdLuy0193h4eHrD3oBN7ykWS/DZdEbJAgCYGKuRcijP7rrBQ5Oud1dgIzv8p8QSW6a+axKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844071; c=relaxed/simple;
	bh=30w/Dz4DHVJOJ0saZ53MomLXFyE2pfTJ5WwjLxeeNjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FO5mwlB2/V8GOO2t2Gt8lLNMvIWHMSWeIuVQRbK6a4xRui9nYih/EaZtg9bA/rHD/CdFhrpIRa8iPDrtCnK/4VY0B5b/bL3OcdFwiv4KhY7EqdWM5jpo5WnEJQV+WWGj3x86IXtKJ25VdweW3xStE4V++fxtPwGem0TuI6srLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+YqUy0n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OIIr4vIp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+YqUy0n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OIIr4vIp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBGKC03512832
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q/OU3VpcyP6ezliR1RElx+1+qYN427OKZn9xUmYZuEE=; b=N+YqUy0ncaIRt4Rb
	fH/wWGSlzx56jCniYQhlvFbmZRUxyhWnpdCBylmk29QZtJrkVZIUMEnnt9WsrI+Y
	/CKW5hjJsiPaQrvOgBFzDVKTz/pcaqO11WvnwPE1mkAxpXeDnmvHs5BfkcbsIByB
	Kv5pgUr5adgn49LwzEz1ZaiNNgDtb/KNIkFx7sSTW5BH34xHXQog4i+CF7PXzKAJ
	/vs9+CdZq4UuPSRlVg/EDZ6zlgfmkhXWiC7cPeIIuM6nWFEuSb2oPadlKWfWCKLT
	ghgkXKkUtV1grXBUYpeF9iLL5hT58I/71ls6SmtbUGnDpq5bmO5Wz9qsh79FcL4i
	86+kbg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vb117-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:21:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso12270314a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844068; x=1779448868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/OU3VpcyP6ezliR1RElx+1+qYN427OKZn9xUmYZuEE=;
        b=OIIr4vIpyg8/PkYcWwcdF1QS5pDe52wBqhoCvW6qPsqEX7ZPfPqLO2RGDFCznpmGkq
         lor3X6rigukNzo0/JU5kdU882Cc4gl3jXnWYHMQ/QijslmcD32uZtuMNq6BCefCQ0sb5
         JgtgbC+Ya8P6L5BtRtWIc4W4C8Fk8uHYC5zkRSqqN5O+iluZn/n/KuOJKBhIh7cp7su0
         OFaRdBr3KxMgsG4FqPKekmnjlr5CIApHKoyU5GmVwD0uS572A0JONsGixY5txop3zsT/
         z7vgTyXjxC9bpGMArASk3bDLPqVpgszYSUMfyjdTTgHh7sELCYtYe/E5ZXaWgYIZdsKx
         Uhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844068; x=1779448868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/OU3VpcyP6ezliR1RElx+1+qYN427OKZn9xUmYZuEE=;
        b=MEV2PThMflCvWj3qa2IbmYx/81sf1Gma4YNCGDHN1FMkm2dchib07eODozzYU2VpP+
         tSWo2Z0gJwCT0Bf/xWPckr0GAb5VQz9Trw1CBN4zJ0JlrTqdteLVckXpLYFQGcZUU+x/
         9eSWO5e07T58KUHi6FjpLAGONR3NUPeODdM7yCLQ1DasyXzPnzpzluswwUGeCKGA4BjF
         +Q5Ztes7RFvrsymgrNLwkNanHjWMMxt2TW4Vc81xq+874ntMNv4KNwj6mzlOKlvMDA/f
         +NY8QYwXD1f3HQF1hkRet0FoPfESUq48b+ypUijngsw8yHSPGS26Urs3Bdz/sugrqKld
         xQWg==
X-Forwarded-Encrypted: i=1; AFNElJ9Mf7V5RzUZWd858/qry8Hqzm9jhosR7MNrNi6gVQYP40AotQ7tkCWMNgwCpg16yWEalMxul5jXpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zWz2CQu6NpA7rLns+Jz76MeRutpWphFvWj1o9gEWWnDQZqdb
	3mgAYu7y7w1q234s15KXY+2tlT9xNL0Sv+F4FrMPn9gxSDI/x5EdKJmwxDP4hkWtvL/3rUb9FAx
	/ntx+skaZ+DxZHcySW+b1dRCCaYKoLXPh7U7JUTn6FOKWRZhR7nwiIH3aeLDF0Q==
X-Gm-Gg: Acq92OHUY+dfi2NgETU9nySxj0zMw+Lc5SimB/4HqfwarEs0bHrrzXTKAmL0zCBQ7dr
	RvcH7GevYesswM9PTfr0AkKtWaD8Tpzp9dHh9f3d3onYC5cxUim3ssqYHR3BZv+0xxl2WQRJuHw
	krigLULUvvJvnHIlDtz2ybfPJlS3/F1j+/2lmFdUDe28DQ4v6bG2Ye+tDQXQ+OIaw8cUNWgDbQ6
	GOyZ/gGSUFWK77bVOsD/CcJuEW7TEOs+UM8mcBzokn91XyAvgUyhzOo1t+1y/cdZ1dfm+LFvVxe
	vVnARlYCWIAH4mTp7iZMWZGzGRuN62f7d69NLgCsxe4BwZvzV2V6mYImSowhFrc+puKh56Oa1EJ
	NhP6dMVuox/+aAg3nMHSNt9RPaQxORk1tM0/nz/6AmpOvCO0GclTchPwXrVaQAiJGc7vUGBnJnq
	QDbRXLCsPXtE5LBUpAJUq6jX0KgGUQuEvhg2HoeBeO
X-Received: by 2002:a17:90b:540d:b0:366:479c:59e7 with SMTP id 98e67ed59e1d1-369519cdb4emr3536220a91.4.1778844068110;
        Fri, 15 May 2026 04:21:08 -0700 (PDT)
X-Received: by 2002:a17:90b:540d:b0:366:479c:59e7 with SMTP id 98e67ed59e1d1-369519cdb4emr3536198a91.4.1778844067679;
        Fri, 15 May 2026 04:21:07 -0700 (PDT)
Received: from [10.190.200.212] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148b6efsm2717991a91.13.2026.05.15.04.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 04:21:06 -0700 (PDT)
Message-ID: <cdc0876f-622d-4790-95d5-4c35e3fc4d3f@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support tsens in ipq5210 & ipq9650
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX0LUOE7/E4K5/
 wrlQDhusQ5OTx6eOkGsJw+YuUyKPkOGH2h19op1nEQ9PzKn5BLOjgx8thb4+LnNn/0AAHIEW5Q4
 AQJ3wLFer9Y7WK9VORGx092tiKCnQtFpdldtph//EJGQkBpk1GEuKv6mL3niinTW5C83owVCSxE
 kyuRa6nL6nTr7GEFR9AJrgHMwCd94vG3+NXJOmvUVNY8NSc/7zuEMXSCC78ASPIbn6kWQvywmAd
 jXc+2dWrs05A/kiFpEqMvkQGQGLy4+He91IIebtcY8Q15E9JmPD95+/NvZ97xVUJuoPbFXlldyG
 5u92ckW604OOAdUfRFj3DeTh5NAY9nucBwJ6Kv37gT9H9QhQwMPxL/fbFsOLSxtA4TjfffHs6FZ
 ztrjnxAZeecAWzPXKUPxvIx+G8LULidj8TTXzkD5sd7G3z+QIg25BTnUgJtTmiOJmCG2ZOwmO66
 bTh9ot6LSqraV6u+oqQ==
X-Proofpoint-GUID: cdzQFfCDJQtcUrefUmk_Voy03C5mVEkX
X-Proofpoint-ORIG-GUID: cdzQFfCDJQtcUrefUmk_Voy03C5mVEkX
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a0701a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=SyN3j3mxg8ih-LVgmwgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

On 5/15/2026 3:47 PM, Varadarajan Narayanan wrote:
> ipq5210 and ipq9560 have the Qualcomm tsens-v2 IP. The tsens framework
> in these two SoCs are similar to the one found in ipq5332. This series
> adds the sensor data to the tsens-v2 driver.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> Varadarajan Narayanan (2):
>       thermal/drivers/qcom/tsens: Add support for ipq5210 tsens
>       thermal/drivers/qcom/tsens: Add support for ipq9650 tsens
> 
>  drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
>  drivers/thermal/qcom/tsens.c    | 6 ++++++
>  drivers/thermal/qcom/tsens.h    | 2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260515-tsens-driver-779b1f46da85
> prerequisite-change-id: 20260515-tsens-yaml-5f517c948b89:v1
> prerequisite-patch-id: 23a443cf15da9852d647ceb75a1b7ca98078a1e3
> 
> Best regards,

Can you club this with,
[PATCH] dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible?
Or send 2 separate series for each target, helps reduce maintainer work
Bindings should be in the same series which introduces the compatible
