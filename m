Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4B2BEC23
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245020; cv=none; b=oYAWKF57ysGpr/iUb+rRvnV5UkoL3EG0HirTWLKOkw5w5NhjIZmumkxcbnVSfSzft/caBqcuTHAnCYY4TerhCSnQgSjzkVvxeie9IIG++sDINJ3mSAD9Qne0L3DaEcD5rpcW2rBNmBeZ4JaJ8qMG6b09cTek7L6D0kgbvwK4Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245020; c=relaxed/simple;
	bh=lN6FGnIyO9hbyJ7xO4gq9+8O9xbjfOEMppV/97DZ0RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d60SvRKFN2YQPDIoLd2umUbzlD69p2qg4lAKqCgTF1xYH00KsJOuGRmZG5GcYqqZPkC3c215JTONLllNk2PdJEeALhwsvWadvovoiJbl/YJLoqLYyrGRFztfIy9kG0KwoBKk3vTXgdobjHzdYysJXH0KgqOLQjnwVVtBv71vqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imbAsPdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5BRU/Za; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imbAsPdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5BRU/Za"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6651jm6c391370
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 09:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=; b=imbAsPdI/78wXBPN
	D0jns2ekSIYAng0zSD8Qr0QGrA4nE6kfm84r2+FVj4Sz5fnKda6YbCZV61/yYjte
	bX88MARylaYfdjIldXpQqTc4d8bQMTM3P5KAvCWdS7izXTeB3Ci0j6UzGbPIT4UQ
	sGwrlLrEd2AZf6ZpzLsZpAMUXqzvjJZkXpLUOW84IdlyOnNJZnLwRN16J54QcPtR
	Ls5YoTtZxFs6AeHN9ZNF+ocuZKTTP3URp0eJuOXm+AVn2tN3DdEbT2CWypvnSUZv
	QO4uI7Ag56uHZrbzF4JdYbVY1UbYF83iHHPOD89XMNf6MgfHaIJd/pnzcieEIntE
	HUyRFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh2hvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:50:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384636ba25dso1118529a91.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783245017; x=1783849817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=;
        b=P5BRU/Za8vZTDqTHaPZwCQ7WDHvnn8UHQulI217PrNmw9wCon4pbXPOIHbEsoyn5PS
         gHStj3I4ahEgL9X0cVeEnOfbIOX/QLxT3dFtW8azG3hBCAKYMapkKk69Zv0YeRNrOYW5
         JdeVVfbQujU3Oc1uYGQ+ef02CyjIDHtlO5Tm0YaUUKn87bLfCzCimauKFxFIOFCpC56E
         Ln1Vj4KVyp7yecYJyFozpHtaDPIk4vrsrR3GgMzoS2iLAbvGE8TqvPtCeg4+6SEsoeE3
         5dyMi0XfOFKit0JHcYPSJJKpY/dPafXi5mc7qDzFfYp8jKvsJLXtwiQAPnxRgPhnNM4d
         ti1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783245017; x=1783849817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IO5umusy15uBlz6QwRBlAdgkQwTeBNR1A/rZbbmQ+Tk=;
        b=jHcmZ0EzsUZNLDz2GBjq1RpCMD5WqsEGeWkXs3WnDSnrfI2V7+qVYb3HLH47cXS9E7
         2JTFHW4hOqR7W95Ryp+UWbvbqga6DP6JQaQPATcA2iNn3qovm2XOj9Mc/5cgBdWbazuz
         FbmwcU9k4IPWDB4jo4l53ETZF/82U70y7gu/xDAPepRTcUPXtUvcJXfapSf6gC14hNZI
         cjDO5zR5OIRAXiljvYBpnmLwoznmgF0+aZfgSJprc2g+AKjgo3OCxt6pWxNqSuvSodAF
         uPM4EZtqh6+cyrvx9TS3tC0Slsq+cKufo5RjjgYpuEe1L1xyTLxrcSGV6pHotNC9FN00
         b8rg==
X-Forwarded-Encrypted: i=1; AHgh+RpmRYH+qZNmm/FzI/ozOtkLkwFVS8jwYuq3iOM6nsWxVn4sFj78EPtwcVlrbi7oKwSPXEqNmCzgQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HsHzrr9Bn0QcGTtFRUYNW+cVKFSqr/b8c7WPpFz9ApYAPYMW
	F9WDfgUtUYn4ZH0KjPvxF/AimZorOjJrG0Ep1wUjhuD81/VFmIFXUoD5I06zU3Cj0B6eO8yj3uV
	qOcD4TKZ1olbjmB1XROvQr4OHNngY1XWxKU0vIPK8ag2Kamnv1PJn+goDtRYSpA==
X-Gm-Gg: AfdE7cmPtThbPV1cOILom5dP0PbYM45XtHKGPkv42/GJiWj7AZsVISbw+8TxSqgWEcv
	DselFfml6fwyrRyM1Nx+xdYFmG565ymR8AiwvycOZuLLasdeQh5yTZ6ZJHYvVONE6mbYrOJ3Xa0
	YmAHrbTuzJm9jVJwAVk0EGqWSkzlqlObVmoVzid7SLSz/05QIiu1V5rB3mdmc0YkTX8U/adbyBY
	VUprfrbi59AhfQvAUULhl/m3uLqmYq8R6WyF4HmTbSQWzEebu9fFGnws033mWswija+grXcQnjl
	f1YsiG7NoafoA99L425gPuVND5icdXGK8i9WnYSRWwSXUhU6h+zPc1QhsV02w5nfmhlqCL6Sx15
	7cIoyec5HHnEcYpi5nREvUGLnQ4gpZ24cF4h2wnOh3A==
X-Received: by 2002:a17:90a:e7c4:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-3829eff9c3bmr5733629a91.19.1783245016624;
        Sun, 05 Jul 2026 02:50:16 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c4:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-3829eff9c3bmr5733595a91.19.1783245016127;
        Sun, 05 Jul 2026 02:50:16 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b4c5577sm45758032eec.0.2026.07.05.02.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 02:50:15 -0700 (PDT)
Message-ID: <afe16407-c0ea-4498-ac24-9fefe94b0474@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:20:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] soc: qcom: Add QMI TMD support for remote
 thermal mitigation
To: Julian Braha <julianbraha@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
 <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a28d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VSZR59-1Ue7iRqHKT1IA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfX8FAZBwimAI2I
 YqPsX71roMQf9tYqsp9A4XrIE+PViNE5yNOX3ex9ZJQgJaUPFzFebSAsm0uVk5y59+PpnkwB/md
 DxnyFt+t+JB3pcShaNzIKzrsoiIoSeo08P05uccJjm1mqA8cdPAq11RPaB5FhmplcCV7mt2WsoE
 0Iz3i4SeKaq2DWv6x861zCyvox12oJ9xwGVeyYAeoaw3r0zeHn89rqF+Qfn2UYN1UkTfmXz7Up0
 Jz7IZQ94+klDwVQKeB4Gg6U76g4TrtB9YUB1z+qUWVpPl3vP2LgG9PPZdnRis8shg3XPfKj1QTL
 ctZpF7G265QfrPJVqUhVTRYbo6PZ5R8JoDSWNvtLwxfndPaSz2RWHXA5dFqLBI1lrgXlb6x3jF6
 u3aQAh6c6XNP8P498z3jrhUEYNP1JoKs5LZI2KjnG4NbZY7H77+ocxAWbBZ/MZQlg4qPFpWntco
 9qkCjtvbdzQKj2yBrcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfX+1Efi6wR2jFT
 lAgDRdtfi0o5kg3++R2cvy8LNG/ECk8hi4ZSwpjrl1qvU0dtbdXUcgjBVoSFcaMBiDzcLSeEyUZ
 YsCcfd8Ee4t4rlgHZpQa00BylFOqSLc=
X-Proofpoint-ORIG-GUID: ruAV54IEgTgB_aRMcoKYnwIc0jKYkwI9
X-Proofpoint-GUID: ruAV54IEgTgB_aRMcoKYnwIc0jKYkwI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050101



On 7/3/2026 11:39 PM, Julian Braha wrote:
> Hi all,
> 
> On 7/3/26 06:03, Gaurav Kohli wrote:
>> +config QCOM_QMI_TMD
>> +	bool "Qualcomm remote subsystem TMD" if COMPILE_TEST
>> +	depends on ARCH_QCOM
>> +	select QCOM_QMI_HELPERS
>> +	help
>> +	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
>> +	  Device (TMD) support for Qualcomm remote subsystems. It manages
>> +	  TMD messaging and handles QMI communication with remote processors
>> +	  to exchange mitigation state and apply thermal mitigation requests.
>> +
> 
> QCOM_QMI_TMD can trigger an unmet dependency and build failure due to
> selecting QCOM_QMI_HELPERS, without ensuring NET is enabled:
> 
> WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
>    Depends on [n]: NET [=n]
>    Selected by [y]:
>    - QCOM_QMI_TMD [=y] && ARCH_QCOM [=y]

Thanks for review. Will add depends on NET to fix the unmet dependency.

> 
> - Julian Braha

