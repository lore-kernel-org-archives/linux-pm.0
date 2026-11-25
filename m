Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599935;
	b=5BT2bPkU9bT2CAZtsq0J9GmJOVp6GlFK1IS0h/QapEmVMk0SlBL8Ld/DXSjKxv2pF9qP
	 8Ei2r0SrKVIvHn50nCRF74E2fbWIVicI6TdETsd2W0OjvPbgR0Gn+wCUEgvkcsJhbmX6n
	 DTVuAchori8jb2/I+skaFgFzcnF7q3/fQ1M9XYQNUfF5uI13A0/fXAXBw43HeYcvk/rWZ
	 64WyEGzuQVGlfGP2S2w3jSuT6Yhd9Puu18zCs6/g1YhZtvIwjJlvaS0BegXY12VOt5rHa
	 uFHVOc8MzW/GeHsx65HxOZZED0rMZDzb98LbNcABoS1FIhZdFAJ7vHnx09aGsq34tsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599935;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NvXtOvEwzZL3rVHSTXfwhOmj0sD1jdrLdqsI9n9mBj8=;
	b=M2o7nYETml6KUrmLIDdfg5EkBlBzKRA6knedKuSuyJ/BwZGOq0Zy6nwloZhzvpdhCR1O
	 lXLIsVcCqtdMOcGz5rh5JYi8wVDBIfETakttj/2iIjRB72DhY26wxDi67qiz1sH26ap+F
	 ftqHrEAxwt17AT2YhhFxSGgfboLIZJ7SaHleSm6kpB/qI/FbCS8Cwr4BYAWzRYDZNJCOD
	 et6HjrK/NLs+MaDVqzx2Nm3mgVCp9x8Hlhq3HUjoQYLp29YHGCJ3wLaqhhmODy7OhgCpP
	 MMU9RmKU4SApv2VmDzyw9Gx/om79ilbvAGlEhru3DmUxM7xWgXhBMwxRqzHd8NVj93g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfpIUnCm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dmi9y64F;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F2606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfpIUnCm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dmi9y64F
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68bnG1860485
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvXtOvEwzZL3rVHSTXfwhOmj0sD1jdrLdqsI9n9mBj8=; b=JfpIUnCmPGmfQ+JV
	EcOfg0YsGAxyNWnGmc6mIIkLWE3hR0i9O7/T+i5tFcd/vko5sKjQLQlTowOZA+YK
	WMTcuLpXQNqORghCPfUkJQsZ/gmc6Tmr4As493xLl1DV5ziuCxqfa4roDsLSxMLp
	PzLUxxzARgRCMbZlLA2D8RJ0EnKPiuFCRN9SqYsvwO6QHTurL/qWdOfohadEzjAe
	S43XYu8Q7ljfjWdPx1mSjD5J0NuyZYV/Hat7nl7ukoMr6fmzJVdweN9z7ztNckCo
	u0TsIxg3OoU96oTLvDSvJ+/u9EN7ZZ0Mm542NCQWiQO2UGNAu/uenMsg7S0O+4N0
	3jqXug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu69vgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:45:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9460411fce4so31912585a.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795599934; x=1796204734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NvXtOvEwzZL3rVHSTXfwhOmj0sD1jdrLdqsI9n9mBj8=;
        b=Dmi9y64FyShY00JG8GyzK9zpbZb0WxzmhPwXm7or1c4AbM/oa2L6HnNTiNinP9oTvb
         2TZ5dlW5d0xSVBjh86zf9ksMZz+Bj+kgNq4maFkvJ8L+g9xYvMP64KjwG7rpZOab/0Bl
         bOUzKVlrx4wPVPv6A9EEaH+VgkuZ3w6Tkj49lDERKFDQHDg5rHOJH9oTYGgnQJeHeLSH
         ZHpCDk43++cQylGofvoJTNgfXiYsw8rdrzBEcmd7Xh3IsogSdsRcF4kzUhPTzAkvnv0d
         h3zT14akNPwSxFo5lL7t25mHM5RtxHhUqkO0vBG0wPvR2sf9R8DiqoKdK5mjrMuiUuEd
         yNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599934; x=1796204734;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvXtOvEwzZL3rVHSTXfwhOmj0sD1jdrLdqsI9n9mBj8=;
        b=m/KYux1v/GXtG8SBY+IMsSlB11hHBPEDOnKWLajVWuZot+5K9LsrqQXzfZkIz9nvrD
         LW/ExmaZpHpqTPmRjUGWQCE4ux5lPHMRbfJs7g/6iQokwvG6otgne58eYh/6pVAX3f3V
         WlmM4nZ0kMpH4XBnJPGZRth+W8M2NJIPpdrA6DW3LVuTgJgzRJSKa7CzzVHAq/4iKdb6
         Yf8jGd0hxYLnfxfH4BmetuKofb6OvuQ/CwyHF3dAYLc31AInpLGoeF1sC9FtxL8ocCpt
         giK2neTMupi9WPaMioaZg4ATVYlTTbqKSVua4prwLraATWxST14IJuuWVuyUmJj/WzUc
         J0sg==
X-Forwarded-Encrypted: i=1; AL+hErFKYrAc3XACBYJfkKus3ttcnhG/v/+6EuHUuJTLPhVrkK8w3SoxYqOnaFG7s/ba3okEqivVe4Z1dw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+F3p9qWiJRzm4yBke/g+w+h2Lp6dmiUmhl4O5WKt8xLTOEWwKe
	FhL8hZC4EXihthtiV5zNd+pYcsgGG4zoqsVjFMzOWfq9ShNiSroV/MpUZuqi5/0IsP3vckfsHfO
	zsQ6KqZ4nHtFiBs9aSxTZGkfuUH0vsi00T6YxZHhbkRHSQ9gGNQC2IwYqF4TJkg==
X-Gm-Gg: AZFdTZd+u5BPo0Bxzk+eX/iaYNGEm/gUahFsvyoOLMBq7BRQmghIrGOaVbn0JQiDpy8
	BzG3kgbIqVT/Ye32Hw73av9ljs2dQHtmJa6+Oy/bET+EGMzLPYksLEeSGJPp7I3qFOeq+zj87iX
	Vjg3MkPGXFCtUuKBKAJeb2xE3eiATr7qaBKkuMEAC+K77NIy9k2xbWAO9bszecVvxJABw7NFs9s
	wgWHwPJN+VQOAEw/ke+ustc1bfFc7GlY+R2JUNSlHkAKfUPk8IgFWsOJ9BZuCPC0R41X7v8jM5E
	A4/oRX0yRmE9/qVK4sOapSv4cH+teaEybGLFVk6azMZsYqtTDS5Ubil11qo+GxN3aOA1i1eS4RJ
	10h836kj+HpYgQC7yM9H8S15Io62Hr6et/xShGz2NAEw4ONe0SlqydU+OOdu7M6Lcxa1RB5A=
X-Received: by 2002:a05:620a:5399:10b0:949:6fa5:1edf with SMTP id af79cd13be357-949ba7f2491mr2879604685a.1.1795599933658;
        Wed, 25 Nov 2026 01:45:33 -0800 (PST)
X-Received: by 2002:a05:620a:5399:10b0:949:6fa5:1edf with SMTP id af79cd13be357-949ba7f2491mr2879601285a.1.1795599933086;
        Wed, 25 Nov 2026 01:45:33 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm1320136a12.2.2026.11.25.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 01:45:31 -0800 (PST)
Message-ID: <68573981-f9a0-480c-806a-0980cfbb6242@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 10:45:29 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Don't read back BCMs without an RPMh
 address
To: venkat.yadlapati@yahoo.com, Georgi Djakov <djakov@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ysBNxoPnBRfMYqHSjfFwg763eFhVjs9a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX7TKRGjdxHIoP
 j94U79JY3goLj2v1NPda26DRjHdMPnfsljK7rGH/vXxEuOYGZaMBP+90edlrSBxJkaFExomh0Vi
 xygJ0bwoqcSmNitdtRo6xDuTMq9wWD4=
X-Proofpoint-GUID: ysBNxoPnBRfMYqHSjfFwg763eFhVjs9a
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06ae3e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=CjxXgO3LAAAA:8 a=CVOz8DntD0RYTBbE8LAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX3NFaR/4CdBeO
 PABhEYODtj6fh6gdt5/XeRfLu+aeByxk0Til52dcIaqi1CPEf4fsnKCl01QRVz3hAhfHNr9QCRR
 3vANDkv5xC0HHUS6d4j276IMBaRleRy9tKga/uwkZ/dcujgAwtc07QuZl+35e6CRcNcf1X/FHJ6
 vkxy1KVaHl0MS00U9h210eqzWdNCXbYM2/cTwhD1b4OUfL/0UTbY6x6Wx5J/wIMTkA7Kjslyzqp
 ztExHwjrDaWoWO1yZrGFRlokTsD85dIrP1uKy6haEPqzK3b9LH3g2FUtaTGOdGUj4zDyehJcJM4
 HeMEqkzJ5GbCDSuu931sUVji9JdVZdsDAYX1rzjUgY8oBQAs4q9SLAc/ZXzP+CgZIXoAgTBe5Rr
 TxNugk+e6eakxcuLY3uRFTi2ZWh5lO/gVCvWX+uF73i5GJCUI62wv/oo4Fy5Wb7d+RTzXtP4jNE
 cvgjDmvVM+q3W9XrgFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038

On 11/15/26 9:19 PM, Venkat Yadlapati via B4 Relay wrote:
> From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
> 
> qcom_icc_rpmh_probe() ignores the return value of qcom_icc_bcm_init()
> and reads the initial vote of every BCM back with rpmh_read(). When the
> command DB has no entry for a BCM, qcom_icc_bcm_init() fails before
> setting the address, so the read goes to RPMh address 0. On Molokai
> (SM8845), whose command DB lacks the QPC0 BCM of the Kaanapali gem_noc,
> that read never completes and every later RPMh request times out, so the
> regulators fail to probe and the boot stalls:
> 
>   qnoc-kaanapali 31100000.interconnect: QPC0 could not find RPMh address
>   qcom-rpmh-regulator 18900000.rsc:regulators-2: failed to read ENABLE status ret = -110
>   Error sending AMC RPMH requests (-110)

Fix the driver instead, please.

Konrad
