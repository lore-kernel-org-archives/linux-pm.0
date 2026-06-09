Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389273A254D
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016408; cv=none; b=s1vnK+Qln9+Ex41dN4IJacA+ta2Q9PJjxxiRZ6wkziOuJq11fbzx7K4z2i5LBIHda4Ln9OgX8LPFpwswt7PBhnHJP/r+K5c+p/kPh0G5R5Zvjj3Gqn/H2WLGigD+3d6LJ/u+viJFXybbMZi/JZ6YbhCZs4FGKMvi4KPd2mJO3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016408; c=relaxed/simple;
	bh=bcIiQ3Hy3fZNoZPgiIB/RB3eMSSwI+emSFXrO98HBV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIsqT5H4+8G+TWyWMSIvFVV80Lv+NXJ7iQDIb6U0WjVPLE/BrmJqqMw0bFbWGbnf8ihk4RhFd1espA5dgh6O0Kb+Qhg+5ef+tCUvm33wejW15dtUu9fqIoHOiGjtRbjmrZt3bOynu9OpzyFoGUhQhlqs7bxJ4+vf9Glg18v0qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3kjTEny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BlPgZOPk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3kjTEny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BlPgZOPk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClXed2706215
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 14:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vIUS59A0O6RBuRS+Kkco6cG24EEkEFY7etH/qyFh/I=; b=V3kjTEnygGOL69Ij
	WkEhWs3ymG/H8rKa/JUxRg/o1MjD3cubOObhIRGFP74ADLXbKjvcapH/gEPdF6I+
	+ZgFjiDL8BjAdCflyjgsTN6LKG8HBD6SOW1G1qkqasaJ28uumGK8hfNpInA2g2kR
	cteYG9nx4U6y7ouzH2iBw+iJFXvkfzjtOzJkIjq0aQW2M3t1kM9GtHrNMryNB7wv
	T3Uy8TjlOcEji/xDtX/Ur4maovZQVhncAaQzuVMNZSlEq55jVUlnLGFYDJ1eYOa+
	ltqMiFIo12/iVnnTrGBcDhrW+mm07ocRoMAxzNW4aDAr5B2J2qwqHIOjk7HQC/lV
	1we47A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt1r3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 14:46:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cea06537c5so325153137.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781016403; x=1781621203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vIUS59A0O6RBuRS+Kkco6cG24EEkEFY7etH/qyFh/I=;
        b=BlPgZOPktizQC+gNcbXrzNE6R9GUOxE9+kpEwItQUGQIMeTo3QjCMQi9S/4zIV2qKr
         TUJ3L7Q2MA+JENTFsBz3gQUanpC6Aquur4uL0ZusG0UD+sVCJjSCBhEbwadfNhJliWKf
         IIDizNQClKHXSe7XZc+X6yLTe94X2wzKWLVMyY12ewVKXiKyVUFQ8Xr0kt8tlFpkdAV1
         mndIEudrKDHB6d5ZBNmCq9DYsfKPPywOcaPe8+kxmzduE9q8N5TuBp+nQbJojP8I23R4
         LgNxH53nwpP2IsHvttk2JOX7fXal0f5HCFyVuBNfmeTnjvtfuEN0+Yns+P7iro93nP59
         +2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016403; x=1781621203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vIUS59A0O6RBuRS+Kkco6cG24EEkEFY7etH/qyFh/I=;
        b=Teo5ZZeGZ14EOhisYUog6SUcF3Ci0PWplT9wHLa2lebTJ6egxpXro/GP1XJwDmK+3t
         NGf9hkwjTqFwXn8jXrFBKqmXaRQv8M6qHUgUv+yp/KOe8ekpSp0KaK8GXUGV72irvkXT
         gUyRevCOEE2/My+6WKFchzruBstuUsAkxUrf+xHoFhqs08Mk2jCswcXzaWQR/Mo+SWE8
         pygIShtkfnLTmY1fANTqrUHJEYqAR8uY8so0LNnfPUz+lS6Ec6UzKhXYXKmmGHqTNZb/
         HXSNnUe5GM4NatM6jflccbw3tYuMgW5D1Y0cJCxuvfacr8bGI4nzCjno+pBvDFpJl38U
         do5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8JzdsYz4KYzud9lbCkXgD7onmtCrnHHn8KwgbDI429OQqatAdtq7WKjHymV8Z0mUQLYmu8/RRF3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsL7IGqel64MF8P/Hf84dFQxNjG0SS1KshVmJHvG14LVx5fB5A
	Y38yLapftiUn6FJhZ5Hz/ln6TUbTXjviWyH4XfWYWjENnylkSbmyxNfqBuRgMQcuyFcWlm1/A6S
	TlxLzpFxJDQACqy52T3X19nO6OC1v1p4QgWZ3ojeozzxzYUN76FULkdZxnz8maQ==
X-Gm-Gg: Acq92OHFCSLdQXaePQW443hxtH28SVroaQGJHUXXW/QaWt6E1HAOHFkMLqMT+nRKShc
	u4/qW9pyj99uACFAFghcy8QzxQ3NgLbaukq3bnqvs0ycGQ0YPhk6RJ3Az3bXa8SNaWc+uuFst0H
	zcn3CvNmHxHcpVAXXotl6EMmpXZxkrvh0qwIrTP38OY0Jbrq5j1701r2VfiZZj0BM0dSWoKdLGC
	OvBOS4FYQZkdxqZlEL2SBW5TseaoXvv5zokW/ZMwNnr+vtjnuJOTuyJXqqbySc5x4ubYO4MU8xZ
	1ePJSeyQzDoNQmj07RFIonvsOR/TbrbTw+vPomLpaF9aTYVa0SUtXzr8VvnBJGxedzC/bu941ME
	BA7qjnK6K/bvXa0HlGLfXRDptLFE1ctPQykyH8VBKffJHtvC8M+cDhKdK
X-Received: by 2002:a05:6102:161f:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-6feee4fa818mr3239499137.1.1781016403184;
        Tue, 09 Jun 2026 07:46:43 -0700 (PDT)
X-Received: by 2002:a05:6102:161f:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-6feee4fa818mr3239481137.1.1781016402812;
        Tue, 09 Jun 2026 07:46:42 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6585185csm8879687a12.16.2026.06.09.07.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:46:41 -0700 (PDT)
Message-ID: <468b82e4-dbe5-4fb8-984a-7f91089d3ee6@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Enable Shikra interconnect driver by
 default for ARCH_QCOM
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526-shikra_icc_kconfig-v1-1-c589db2d023c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260526-shikra_icc_kconfig-v1-1-c589db2d023c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JPmlFlF64Y5V4sgC6CaL7WtItxBE5CSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX6/jNpT5W1yvl
 vGmC7+kiBDpgtunNRDcOWE4ip/fpier/UpJEGTVeiLSCsnAALTrlXzCMZdXJ1cjJY0NDZjL+NJB
 BhkBv854PB47cGLYRnWOMrA41hWIlQzdVWdvYdzd11ueeNSHn2G6Tv7OeBQR8X1dkWSf58F7iFs
 sfJ7CENkMMtZz9DOiIk7xrSYmFgHP6yo6rS0Fp/omxiJV7EEbGTqOPoDs+XMPj5DQUA3zVGW2Zl
 mXPUoqbRBPtECki/OTalRklohCfhdZ9EDn1nubIOpxQ+IeqyvTjgCAoWgFqbNuarvf9vwtpNMqj
 fc2O96DFO0yQPNJucQsfpov/+YkEQCnRcTarG1+oEF0v06R2bKAVpG6u7htJPcLTA0ApzA2RTl3
 EhbbcvtxbEU9cVIXEjmbJD/A5QNN60PtZnYpvT+7F2r09B84/mevappiC0M6zIyCzL9i99Z5KzP
 wPlSnPbhIK87oS48PCw==
X-Proofpoint-GUID: JPmlFlF64Y5V4sgC6CaL7WtItxBE5CSH
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a282754 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=O3lOxlod8mDF5Zn6aN0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090140

On 5/26/26 7:21 PM, Raviteja Laggyshetty wrote:
> Interconnect drivers provide fundamental NoC bandwidth management
> required for correct system behavior. Although systems can boot without
> them, power and performance are impacted.
> These drivers need to enabled irresepective of the board variant, design
> or configuration.
> 
> Enable the Shikra interconnect driver by default on ARCH_QCOM by setting
>  "default ARCH_QCOM".
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
