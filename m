Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56337429CE6
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891399; cv=none; b=n1E00rYI8ianWyzL7fjUytpQcEBKX38qFOwJQ4Ti/0elkSdLqLJzdCL9eCRWQOsnORG5djDUIOdO/qdXNR5nNDW+PLk8cdnHbG4m90fnXrbWkABv+KhG9NRK6N59WTgPHJ549r+32wdchhCezhHxZ5PRXBwvPAl4D6xwGuWRCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891399; c=relaxed/simple;
	bh=SjaRgO11ZVAa77PForVsP04f24YEfRy+ox6Gs+mujQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpgEo2lMF6IPTd8nAfCgaFNQUghhFcLW39fHfD6lZlvN8drei96eBxVJ6y7ff6X9s/BufqGNS5FP68MHDyiFVmqHpJD6TOh1jNmFOHKYUQofyFU97LTI8zbwArnEz2bmHNZun/t+++8Fvbcl28ChdxiQrRgrcd1M5xEL4lOun7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eB8r8vo9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KREWTtQw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eB8r8vo9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KREWTtQw"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADbhv2875766
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ux5qS+vam7s/34MW3MovvdC6Je/WYT0RC4mrKVIhqVw=; b=eB8r8vo9xIJzqacz
	WEYbI7oxZo5zmIrFDlHvDtivC2+DNlAkgpf6tip+nzVX2H28i6IT5vKndueJTxVl
	3FEvMdJWFmEnyt+XM32lXDNC8LxwqUvE2aNOSZ4PyN1k4Wv/pB6EfRoDanpBkgmu
	mPRK+FkHQ/Bg1zgeDJxJTMukjbxGk9OYy7v19hS2v2lhCmbzZyEpJeyw8c+2UWha
	iNRRl19KlINckWJm03OZnSr/Z/9OxIUfS9otptHbX45MIbPjJ0KcCQz5xM7tWrnb
	ciov2cO/RaeXUbEbS40+pvQhjNj/R0mPjKc0ADHmG9Y9rJavvIOwEqNDxRnbQW4b
	5JbfSw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5byrdc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 11:09:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9310484c005so5705385a.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784891396; x=1785496196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ux5qS+vam7s/34MW3MovvdC6Je/WYT0RC4mrKVIhqVw=;
        b=KREWTtQwkwiziMFVPkX5PfIpif8CpkHgvDBqopCZHm+NKgHZYpgIwceh8r4Q2B8Nhx
         p6izjQfBFTrdiUWSAu8Vgc5kHiEouXaWQacx55XQ8+ZdvaqIanmBh6r+U0E2Ig0YAb5d
         pKSwlFnoes4fWQ87OaeV/BsBnC8LKq4LoeVPk0GT8UYPSVgxXGIBuVjTBc8711lWHRXn
         S5ez5qilAgLyba1dULvQ7RTll3+5y3aEogLloJyOjwEK9cS5TEYDEfTqaA53OYd6gQBp
         AhSYEseFKAFUM9nw3JfJyRSkDF7UU7xdHmNuzihwagVOmiFf9XGaNrMTUddkcY5h1CDw
         rTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784891396; x=1785496196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ux5qS+vam7s/34MW3MovvdC6Je/WYT0RC4mrKVIhqVw=;
        b=AgYm3jJwQjj4QUF7zNyhwRKDxvtSKU4RdxTCOzCAiNQ5fM1QIL+ScnHNlo1v48MS83
         DtE0z+faUzmHFwwpptfltcwqybLeZ/8seTL+H34gPyVcjNqLRbWW8oRniLw5uP8w/GGl
         Y+LotBQUqUmeSOZG8LHYo9XXupVuC7X21IhGX1cdnX4xVwqIj7T3Wn+1pniKUWS3yNJJ
         N/PNB30u4CgOOCl+tPwLB+4mnfs57lrjtWW6/n4Lq0JXtuIfOADm+0lxU9IGyGLdOO0i
         fmtPnOkzEQZGuJX0w0QbmKtr9voV/XiWk/NJQ3/bm/GN3qJfeO0olkDTiBWlsDt/je92
         fKBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp58tQuIwbUEWr9yWtf6mgkotp5o3eT8LWq+MmFz4X6nzn2Nmc+DbJ8qNC824qkOsyqDQFfzAougg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9lH3DlLxM/iRdEGz9kSeMhMM5UpV7KyUr1b+TJnWvaJv1EZp
	7x6XtasKXR5WZUqj4NWScKjnyNkFK1lJc4/HNnyUHCrQAGO4HPWBpW0unCAz2VIVPwLK4P9oKAy
	N3d0BwFFpnH0spN/gN6F2fcxvqJqBvKyYYW9g9dIO7BAXZL1BC+485t92a6cbWQ==
X-Gm-Gg: AR+sD10Uaz/Lyck6GsJLIZlndQImajOYsXsGDh319HNIZ+n2i0sNbplIa2RcIdaqeou
	QkRkBHXU1z+BXoIAxPnh1p4E/oPep4nqqOc8Lpkgw4VrEOEYABbC8Ag2B9eOHbBP/1r+0gL5imV
	wOhMlxRdw80rs9udRuELAdA/Nt8x9xhaveI6o5vi6KSewd/wJBpshKHwc+WIT8MEDY3Hx4R0bSD
	3IPu8IxBZ1ZoRCnil7VGIHDnFdJy7O8oy4oGKqHzAuDpx5BdtolK5St057hTal56nFqoQQy7YKS
	lkZVU9+WOkbBiCg0BkzHlnRgKmSNYZIsFMFNY3f6poGNvLG8VUChEUOvcrgJ1UZvKKByPgl6vCU
	LVirtIxYh8qUtF6TAvLUE/qtV
X-Received: by 2002:a05:620a:4804:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-9310365429amr571676585a.2.1784891396595;
        Fri, 24 Jul 2026 04:09:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-9310365429amr571673785a.2.1784891396117;
        Fri, 24 Jul 2026 04:09:56 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34b92a98sm3034189a12.10.2026.07.24.04.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 04:09:55 -0700 (PDT)
Message-ID: <36ec6823-8792-4015-8693-ff6937dca771@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 13:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
 <20260720-shikra-dt-m1-v7-10-7dc99100c6dd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260720-shikra-dt-m1-v7-10-7dc99100c6dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1bhB27N8AXr1POZ3WaFpfK5qlvk3Rtu0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwMSBTYWx0ZWRfX3S8RmhIpi4pV
 jIldtZcHVWXBfJ6x9uzme7VZANfoMlBvrFaMupMduWF+sGPlIkj5l0h6M76KIOqPtZeOj30aPzJ
 /mr3L2x/q+VboCQ/oVR+iSKnDUsdBlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwMSBTYWx0ZWRfX9JWqDztzHOsf
 rfnIEd0AG0YPA6f8h1myl2d2d6oPX0WH51GRrFjVwVOmTv9QrBq6i9467vaPLqgFQnTpFQX1KQ8
 maRIsuVSMN7EwJwGPU1b0v+g99alVCWAF7whBVkoOUfjT3I8/1E0fkZ4pkIdLnvimpLWeFCTYrH
 l8SRaO0kQYZ4nOYNPYotn4fOZduyMWJzJJyh8jw2ySXG4DvPigZDu+CNUOA3xmWBmYGFZodvSWW
 7G/znN8ZKzpq8cfh+dKA4j9fGPWR7tmg+LIgeUHGysY+PykpR+JSto8Y2NYeVwm9lccz3YoR6zG
 O7YfvIROryjRX9Ffld+D2wULhc2ZigcjwUzAExcE+tE9UY02hk0Aig3lc/YwN8VTg8nbvTb1yuO
 E6fg7YM6ZHfQbqR+CeU/a9KdWWs/G3bYNHniBaOutde8ygcnlOP0hEYEUb0IvbAhvVHgMBzLH9F
 ws02pLPeZfM12kC7Hwg==
X-Proofpoint-GUID: 1bhB27N8AXr1POZ3WaFpfK5qlvk3Rtu0
X-Authority-Analysis: v=2.4 cv=GMA41ONK c=1 sm=1 tr=0 ts=6a634805 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VaiqnSBy5ELP4sQjxKAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240101

On 7/20/26 12:49 PM, Komal Bajaj wrote:
> Add gpio-reserved-ranges property to the TLMM node for both Shikra
> SoM variants (CQM and IQS). These reserved GPIOs are inaccessible
> from the non-secure world and dedicated to fixed functions.
> 
> Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
