Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539151A74D
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683073; cv=none; b=Ctc/tSsfx3ykeGjgoL8ZZjvPR0xWERRp+/RLEtyJByXsbxavJqxPW/4/kCnXl9QCs0n6Q7VgrSzK7Bl+PIl9Q7EOXJ6FnDPNKamwJJEGw3X81+NB37C73DFzK/qRxf0nY8AXIIo01AeFauQjCJy913ThvPc0oxPOsWocclRKlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683073; c=relaxed/simple;
	bh=MrVJPBb1sUYMnP+KdD5Y+ht9eqbfNm/5DTILPlsF/gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPS/YLOwkqzBkb6xjpsz/TIemfpiuczRqMYWW3YJt2Zpzh/SOC9jfN/15D6gzsiIMsnbr2a9XpaKIRfh8jz8jX5JLXp676kVxW/nnUFacUCeHefbcwZyToThgtxSBtd3ZyLqiJJ5oBCl9juoNfQMdgj1uslWgk1IjNuOfv/IcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Znbg7g3n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TrK2z9JO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Znbg7g3n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TrK2z9JO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAjKQs3870508
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkEatPLSlTdDIMBrwhI5bGneYqgoKQbP4DiVJOzUsCs=; b=Znbg7g3ntcCSA0Fo
	2CddJWLLBn0d9mUHVduyhfisTlHLzaobq+3Em2Y5ldLVMDbaBvJwbYfx05UP3iWF
	PmHIsfrC+6yFuhsi6xdvQryYu6CFC3hqctBjOk78296UA9bINfL8luqt6oAsguO1
	RIZaqhIOAh2nj8A71L37mLuWIHOUWRNoCibW8qVGj51Cj7LEXkyhUnfV06d3qLEe
	v5Es3afZWjmeiVMy3W4eGRAYIhUHesDe003nRevbEhlAMFOeJO9Zt93A7uShphSb
	BN6rRo1skD+RUahmdkqP6nKMC5jiGMf9jp11ACWCRHTV4m99Pc9gO60Aw2W3NDum
	1UEh2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnbusw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:57:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93c6a0d2122so515659985a.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790683069; x=1791287869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkEatPLSlTdDIMBrwhI5bGneYqgoKQbP4DiVJOzUsCs=;
        b=TrK2z9JObfwTGusP5gFWb1MlioDiPjdGsngt2LQrnjdxB419gOHENSIjwVAgdtHESv
         XTUe523mFuS+p4ntBD20C0YGLvy/39sLvTjw4sQpFMowljp0u4fVIV7W7oRJqD2WNDKM
         g48GJn1LfRdwTZeAG4pBdhyZvTaVWUZXJrYuky7m17CwuIdNV6ujXrvb0DW4Hh8+2Vpl
         1y0iKXb2Kc4fkjBC+mkbYoDk7ApMFMT90oqW3yg5MZKWx76qpBJw1iqwe+xWVx8izWpv
         0O5ICkZhtfmUB00xkGul4E0lgO1lr60gn66JP3ulzVFQ/DqoKtb/y7a5QN59+ehwDr0Q
         vy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683069; x=1791287869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkEatPLSlTdDIMBrwhI5bGneYqgoKQbP4DiVJOzUsCs=;
        b=EaBx+Qt3chfWxe6SUf1r1a6srMvtycguy/6vNBSkHxiZz69vyr+hMBdJURiMXfcdQy
         9p5NjbGJqS28f3deKKV5v3HRSkesrFJAoXHv6Th+ZHCTEYeOVleobd4T0n/GihReGU50
         YjhjsLze9A38Q0DflKqdJNM4TEnCCxL8uGvAu6gH9GLZUfIJPYKn42UC+qxncCjCQ1lX
         Fqxpc5J27x6RI40wS9gGovYh+AiBz1/RciGi8K0+Iho8xyzuZ9WR8CD2dVWUHdXp5LPY
         tN2tnJky2HKAcBHyOMLALJ1FQS6LWScvRvWItjdpKJVf77jMfqDUNf9Xw+EbISxL5dXB
         CnqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIXmEDxj4kaHkFGh/QNg44wZ8DccrkUeXTh2isqLj1jd6P/j9AtFnq34lPsOjaPMJF0SGuWTkmCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kuVym5l0FagHH4kvtKTHnzWl+xQ7MzPfOo5ETm2XyFI6UgTRF4
	Z8spujJcyIUFjME3AW8uV90l5qvxbsEW1LJHf+w9QFYvkQAkRPatLc/TxdaSQKd4c0IC9Nfde1a
	gBPSkami7RnL38mUK8nyTzYIFuZE28Tdew3yaniN10c3EQ9B0cQeO+rYfxpCbahOZF9tTew==
X-Gm-Gg: AYBFou3HjlGD7RSPR7aVSJ3Ia06v6FORfHvNAtXOPW09KamEKP9PKa3CCvppifssSyV
	B49nFnzxr/r7QbqxALefEDCEvVrra23D8GyMWTrGh+IFyuY6U9m7BI1DrSAb4upTsx6l1GMI5uu
	z98xWhdPqdr55gQrN3Y+AaQKmK5Qq39+nOK+mh7wTdz3UAkSrHY+TFAXfBhjXs3ZydVhKaw3lcC
	K1KnRoMEh4P2yz1tbSklpsoTp8pNBWBfsliFBxwNN7q+S1mR8MCbPes5FmPMDeuZmjJOkCtvi3F
	DbrGz50QBiA9JLXugwo5vTYqa2adjZOe62KyEvxi997nkUB9811QATcROsABL1aeAnObFCRBzmv
	VcGLd93Yp6V9OMCC2Ug==
X-Received: by 2002:a05:620a:439a:b0:93c:35b6:5663 with SMTP id af79cd13be357-93c43ca3f93mr2495214985a.35.1790683068719;
        Tue, 29 Sep 2026 04:57:48 -0700 (PDT)
X-Received: by 2002:a05:620a:439a:b0:93c:35b6:5663 with SMTP id af79cd13be357-93c43ca3f93mr2495211885a.35.1790683068225;
        Tue, 29 Sep 2026 04:57:48 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.55.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf8fa5bsm84529785e9.6.2026.09.29.04.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:57:47 -0700 (PDT)
Message-ID: <ef9d2842-1e98-4f40-8aa1-307f63f62b5b@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 13:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal: rzg3e: Propagate reset assertion failure
 from suspend
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        John Madieu <john.madieu.xa@bp.renesas.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tWqcVMmhjDYEiNuepZmxwMLoFzIl0Bud
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abba7bd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=k310VGPmG+7YCqWoYgMryA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=5Eor16UomH0ERcGZyNQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NyBTYWx0ZWRfX5K3baKdnJHds
 HtR70CDIw8vQqAzN0jKNaLMLO3C1DwO72NDwl7B/S9PTTWIpCij8WnKZRYkwHVokR82YyJr43Ca
 N9lS63mZwCNxeZU3xInnpwUznEhjmCsTi6UttuUbkuBpgv183OCWvc2N3bOrQEpzOvyt1SsNCuk
 he0pQWqSWNDuIKEBXCOfEWXSV4Kys6vUwZNscRejkmYVEVmGEYgIagyRmzH1pbyaF3h8OMMNE1n
 jD8Onlp/GSM+4y3HAijeMXAP4aIs+0qbZKNNvPzwwIcTfWr4M/5Y86S8/4vJEAtwcjob2jSWGDU
 bc8adm5RiFMSqcswr4r2KRusIEe3s4724M1xeSJbSAtk/29nWmK9UvXsF+jSCyKhWm7/eOn6sm6
 +nVYWUa8kOwa1mA4a/DapxsP2r8gHyR+lpOZbA1NpHa5w3+0GOoNwgRHAfACNVjTmvapOAEgB1B
 Ahr7o5wWdyovoksRXjQ==
X-Proofpoint-GUID: tWqcVMmhjDYEiNuepZmxwMLoFzIl0Bud
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NyBTYWx0ZWRfX5bYKYXPdMTHJ
 2KnnfLAn07/KDMrjS9yq4UVEC+kAeLlRgsQBLcp004+x0VDTyZHWanOpxcgDgzmoM9HVaLZ/G8a
 W8Ly3bTmCUv7HBYOscsGsERp11exxlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290047

On 8/28/26 11:21, Pengpeng Hou wrote:
> rzg3e_thermal_suspend() powers off an active sensor and then ignores
> failure to assert its reset.  System sleep can therefore continue
> without the clean reset state expected by resume.
> 
> Return the reset error and, when the sensor had been active, try to
> restore power before failing suspend.  This remains an RFC because a
> reset assertion failure can represent partial hardware state and the
> preferred recovery policy needs platform confirmation.
> 
> The issue was identified via static analysis and manually reviewed.
> 
> Assisted-by: LLM
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Please resend without the RFC prefix and with Claudiu tag
Thanks

