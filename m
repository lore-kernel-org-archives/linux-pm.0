Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35C3B4E88
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030272; cv=none; b=q6Z4WpIWOGEcI0gOYBH0ts1TnX+qveZEPlYmDelzdfg6mZFjjgAh/WVVyy0k1sAD9drqHKVeTToPSqI/M89Y1wC1t9JiR3n/i6lXz5NtEaXKQ0/IS/pZmVRmm8aOhhds5y1mfBuSZpCBSOIBZ7ed5LkNlKafhXqbvaW40KnkrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030272; c=relaxed/simple;
	bh=zgBKqmvo/mlM6FAwfCG0BWWZ2cekk8/EaEDfQ0LGdU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYng8J0Sw2GbvV0pht3eAE2gWcFwbXciQPb+nHuIy6u3HAyKf4smRLTb6prBZftafMxlOzJYkDZSSXAYcBgN38jdIzauAhuXBXuPc5ZVtUM0B6Bkimg7b27OH3FlyQHg8A2lfRrCvdTaXsYUkQD5h4SEXmfh3FMEPBvyFsf4ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsRl/kW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hkEgsSyU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsRl/kW2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hkEgsSyU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GLubZ21677666
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRg5yfMiLjjVTzLnOmCYkQHh9tXjvKAmbvjX79fDqnw=; b=fsRl/kW21v3lLkoh
	9VrhsFaeAsrCc+JkCzRHQYBBjvwpjzmYDRVCrPCW6Et+3emLS0w/SVSpE6/SU0PO
	i7r9YSHND9rbY8pykQ6jx3IY6HYqq1F3y9gGoqxA8vYxstM4GYeqTbZGe2Hnmp0o
	VR33teDnIYGOgLDk/y8dL0eDnNy8/5XtRO7w4VuTxhJsTHRXahVnoSUoh1RfZ6fi
	1V5fHAloq7VEAMKPzR735D/XCtAp39r/9BCCB1I9PvsUjfHM/a3mS0vuPgvGBz+9
	sbFu5XukUPGGuW+RbGGJmL+ok2jxv323WvlUtga0cn7CafCjfMLMsthbpe1wnfgH
	pp1xdA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvqu1uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:04:28 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56fab6d9242so4252659e0c.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779030267; x=1779635067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRg5yfMiLjjVTzLnOmCYkQHh9tXjvKAmbvjX79fDqnw=;
        b=hkEgsSyUQE1kEBp0poqXP43ZufgqFq2WW6PYoXPAyS4qtQLlvuzqY8kP8yIsk2Q6zT
         xwIm/AsEfHyNbq01Hn7bRTok7LJZmvKjL0mb3ybixK3v65y8FTDOC6WRKflDYnXM5g5T
         0l4cbVOCflWUh3RGbzbp9+R0nG23FQ3Lp2Sw8YJkPNG8wy/Hv2jckyKb74gu+tl7nUSV
         WvEHJ6fuRSiBuJ+0OMMXILgxHAksmlvMG+enxmhB4eTaOmj0Hm9iFnTmcee1dd9nu4Yp
         FLuI6p42sF/wYVpqlF4j/jcrqpr/hvGMw96JvRk2l9CDFORAmTRWn7SWfg86h7vitL29
         NBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779030267; x=1779635067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRg5yfMiLjjVTzLnOmCYkQHh9tXjvKAmbvjX79fDqnw=;
        b=WlF+wzyxO2kxz4efkNVRyD5wFPQDwlbyTkhCAn5da+tmLXBl/GldFkb7dXKI14KgBg
         nlzBhZgSUdMepVYQUeL1midhcaa1r9lLULhCzzGZet/KRm6rswkOBTB9V4uqnyu1qTVg
         ukwT9+LGvfagQ57HLwfnd6DQUa7XVzrrxmNuPPx2QE2pfDMJHgKcPq9c0AAwONWfI8DJ
         BQVUkBJA1q1Xk0nhM6XGBolgVv0C59yJ2l+MzojUNYIP7KOvZCSJ8oLwV+lYURlD/qYB
         UdrP27h2iCkUMLsQI5W7vYxELdnj0NDkRUncC7i8aoj2nOKaRyHed6NLAQgaFcVI6/Gw
         H8FQ==
X-Gm-Message-State: AOJu0YywitcfGB3W774iVo2dSARAWoXFXsAQ6KeULLycvW8wORhOmdHO
	cIqws9anU09iE5kOg6rs8BmFeAt142i4Q8sFDBYKf0DduGGQpiko2Jymd1EhjvAz6oxHnHnQxEo
	iG4ywmx5Qk7B9mBNFvsv1Ho8eFy+ertpn5CO3uQcfBNVMWpthVotQnIwp30XGbw==
X-Gm-Gg: Acq92OGeP5aTkryGpd3jl0sUMJ5W1fYcIg+gj4yZ5eYkmvKNujOr9lQBgCQy7ESJNuU
	eaqvxIxgdv+I66kZJWYQe8+mmMv1ctopgkLFxtUZfP3ENMAw6USrGbpKB6rsTHGzORezXVxSDyL
	NfxM2pUJcecBHU+zld3GcavfaAnhvsn4/1cbxjsOuVfYf4p8vBCI8+676d7jrVPnGRNywzS4f8r
	NcquB8i0ozr2rZN5hQ5VwayZ13uaqgt9KDnkfK1s4Rs2pgfcbmtSAYukkPvPHiKWF03SpESjMKA
	/P81r49K6/2eBojdHCFlaOHz4ENCAPOyc2y9bucERIgKzlB0YHKFqg6MkNfNqcijMw9BzHuZjxe
	KbT/xpVd5sAJQ8c+SIdyLmTR+gIbHsJ7avWMZyxZI3KxsRsdAkui9r6R/Yuva5p4I2+5gjQcib3
	mmLBF4jj1+XjKjmKChAGM=
X-Received: by 2002:a05:6122:8482:b0:577:48e1:8aff with SMTP id 71dfb90a1353d-57748e1c34dmr1488669e0c.11.1779030267682;
        Sun, 17 May 2026 08:04:27 -0700 (PDT)
X-Received: by 2002:a05:6122:8482:b0:577:48e1:8aff with SMTP id 71dfb90a1353d-57748e1c34dmr1488648e0c.11.1779030267339;
        Sun, 17 May 2026 08:04:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3e20:6c07:e6b8:6153? ([2a05:6e02:1041:c10:3e20:6c07:e6b8:6153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm207620125e9.6.2026.05.17.08.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 08:04:26 -0700 (PDT)
Message-ID: <3aaa5d3a-4aca-4c16-81a1-5afa17fd49d1@oss.qualcomm.com>
Date: Sun, 17 May 2026 17:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document the Hawi
 Temperature Sensor
To: dipa.mantre@oss.qualcomm.com, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com, gaurav.kohli@oss.qualcomm.com
References: <20260512-dtbinding-hawi-v1-1-96149d06cccf@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260512-dtbinding-hawi-v1-1-96149d06cccf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PZKMOt6OA2XAUmzdqZQ_x2HqkVsMqOfa
X-Proofpoint-ORIG-GUID: PZKMOt6OA2XAUmzdqZQ_x2HqkVsMqOfa
X-Authority-Analysis: v=2.4 cv=LKJWhpW9 c=1 sm=1 tr=0 ts=6a09d8fc cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=0pnJn9-L8U1tA-XNDBQA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE2MiBTYWx0ZWRfXzsHBZCN/4LIF
 t/Tym4riO/G/jh/FMYs9kJ+DKu7rW7OBkWpzie/r+M09SCj11AackwQntavUERtCd15bWZ/h65K
 Rn/TaoAC4dC0xbykOGjGdXHhd60MKai91fUDHpVp+acugcPEZwmAb4CGMJKOpnoU7mVBQUgbhEv
 5x1vBtSUEFPi1zG/0KDSHretFNH0TQU4jlhev9s08qX2GSTRU6AHc5YiVSpsR9lWg214P8UWF84
 C9tRW1P+SNx2TVvdHFW74DRh9Y+1hAXXVzob5a38o01UUfvnuKlprz7FXVkFRNImIc2lZVk5uTF
 dku14ObiHwN0c8anGSAS6E1vqFx1Bveulb7+TXeGUkSUqarSjrmMk2R1ALzrFr2ChubxAGk29KQ
 rDPMOJ3gGdulj9KAq2IBb2DcaO6j+JTcNsYM2vmjwITTs0Qku0EtCOyRg/d27ZmW6exqCjM/m7e
 V4ZKs/QDuyNPOYICeaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170162

On 5/12/26 13:13, Dipa Ramesh Mantre via B4 Relay wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Document the Temperature Sensor (TSENS) on the Qualcomm Hawi SoC.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> ---

Applied, thanks
