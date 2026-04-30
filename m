Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245B18E025
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564902; cv=none; b=EW09hqJSqm5XHjeIyjetHl+SK588W1IJLsNgrYUJYuhzZTFWgH6cuPo5pcwaEYFsxlHjhBoFAcvA6csQCuRxpPpDxhHlNbbaJs4thU5DxVlS7d04zWb+u6Ea+ZhH5d51EcX3uzQvc+2lytcL/xLdz7bsVWZyRCt/Wh2+dC1YfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564902; c=relaxed/simple;
	bh=g2BCyt6Cw4IH3IKr003s/zobpkp44bDYU4lkEV/rArs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gm46YRTEp31Xdm1T/OIW3kCsNlhuDalmD05R/gSxyJrFfD5eTgmidzoPw9GK8z8uts4FtOSOTZSpI1uJzjSDEl4KJjjhnFlmV/3/vD2q8CEiZ4mPDkz5MhRUhN546hSrmSrGCwUAPU0c7JisfYx6WBalHZhWcbwgZxKxWP4qtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JT42bx2i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UG3U6WUA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JT42bx2i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UG3U6WUA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UFDeVb2907480
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g2BCyt6Cw4IH3IKr003s/zobpkp44bDYU4lkEV/rArs=; b=JT42bx2iYKaCOBgN
	JIaCZGDOh/N8nE7NV92anmvf9vJvhBwpWZvptDFMdtuJp/8jHKyZp7XMjk2vBDQr
	IaPwNwvE81YKSBwTjGBhMuG0Nso6TgCkUnnG2lkMgeohACLN+kGpw2sB40yPr0fW
	ETvLVhKiB/mZJO7bn92V0ZRBD+fqlToaatE8ZkVIf9ynvUZjSlTXnBkYP93BK61U
	3h3rzQypKu6WTbq5H3wU5p613fyYf/3hjB4DNxs5d4KTsaOyYVWJ86h1MEJLOH15
	rfdFtXO+7TkSLJ4lT8BE5BAAHFPLWEJE1hKkmM3GjtyD5EPsxfiJi+XERqK4yMrM
	YEBxUg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv0pfb0ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:01:40 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dcce2935b9so354499a34.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777564900; x=1778169700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2BCyt6Cw4IH3IKr003s/zobpkp44bDYU4lkEV/rArs=;
        b=UG3U6WUAABq5u7u5tV+rUAwZZQf/+i0sk0AZQrGtFCvZQB04qtv2goElfrfmRXVwDE
         CqXmWJb5JBzmdJG4fzK+E/jKymOWG1ZKUyrJ3ZVLv3EctZdcuB51D7HotAMODzwU1FFn
         Qq7Dj4VMg5b6AbuOm2u+/+BM30GMPzX4uNBBiIgRlDD5FX0X5ym0SIfi2pvJkiD2hbjF
         CsE4Fq7duxxhJ1LKQgxHxR3JiXd5eD3s1uzrtILBoNiMj3nPGCUrsQ7gM1KF9TWsYOv4
         ifGUIlicmBs30UIVSKhLgbkHVnaNhs1rbO545TyfB4MyihgOChcrN5HLwHwafDYnaabf
         lzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564900; x=1778169700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2BCyt6Cw4IH3IKr003s/zobpkp44bDYU4lkEV/rArs=;
        b=MbsR0Xtc3/l2DXI/RwpCVTIIC7vfhYXmZatIcijfzBeAp1x7YaYdkvwDF9wl2Rrcse
         GnaMi7z+OZs7A7xYtQQOB/MQcjByqdyP88PrVJMld0NrxjMHHpAs823UQM5uyMGU67kf
         YICgN1OF2Q9GFTynToSxvOnm+JCpdSziRQRuwQenZ8WurFWSX8uEwrZGY8KOxrkwgyPF
         Ua1nTvwt4QGrUVg+/YyKbroHVoYybMEhpOYm8MFNu+RC5HpqmrkNgJ4EuQ/nibP7HlJP
         Na4gGVgrd3qeb6KHEt8K+aOh+EkzeHnts1N3VvB/3hQ4KZk3SJx1tF3HHbq5Nthr4KUJ
         F2KQ==
X-Gm-Message-State: AOJu0Yx8otbs7qcoojhWkXAJLoT/gxfcu187qUOM5PtXUFv//xrkGIxT
	P+edvOelL3Xa5n5lLsyrfoJ+i9ZUOWy9T10/UMXm5NNqRoZsRfUqom1QkzBAn0wxDL6h/gAuOk5
	twNsfhWNcF+awBeDSaKWLzcIEr4Lk50xipttqvxdVOlaLJbH3z8t+/qi/uvoOOw==
X-Gm-Gg: AeBDiet7cXv6c8Z8Oft91h0PiyISTzqKZ5pfdt1zF2NYpPqsU5bGSHrrOHCIqR2KTOW
	hn3RMHvZ3GaOKc7tJSaKpzq6a06p6B6ZNQ2vpDySbduRM4owlJJbVzYiuhcu7/LQpbR1Cp5QyIf
	uHeRpsQ9A92FxA5AwDMY93ES1/Iib+HKhu2eHbLlClC3dBLlBJ8En9NVRpZZIeH6ghEYWl81VJa
	g7B+ThQ3aCQxbBx9czYvGNBNREKQucbekY1fGCtnyF5QU8JqF2iPS12AxdwpRJx8Ft59Rk4efom
	o8nW6cFKC1l7XvjK7Er3zhp/fnVOF21TkZeldU1x8riMW3kq+m440iV6v4RDrNT5jo53ygooPht
	IDnTSUNR0Oevub04zyMFEiCImQmNxGzkUvh7RsiIgW8l/1fai0Sk/2/18CzyRBL1y1gvUolJKoJ
	LCi+lXPLCjSzc3+Q==
X-Received: by 2002:a05:6830:2546:b0:7db:dc9e:f17e with SMTP id 46e09a7af769-7deba3533demr1465599a34.5.1777564899760;
        Thu, 30 Apr 2026 09:01:39 -0700 (PDT)
X-Received: by 2002:a05:6830:2546:b0:7db:dc9e:f17e with SMTP id 46e09a7af769-7deba3533demr1465447a34.5.1777564897702;
        Thu, 30 Apr 2026 09:01:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe675cc435sm15483566b.0.2026.04.30.09.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:01:36 -0700 (PDT)
Message-ID: <3443efce-7887-4acb-b154-b1f812ce44ac@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 18:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: qcom: tsens: widen temperature limits to
 match hardware range
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-3-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260430054422.2461150-3-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2NiBTYWx0ZWRfX4B977F+EFJDc
 dMRz5w5kFeUuE3zvx78CTkMzufw9fHJJhIZ9Reungh1uutB+K17GuvzG/BW7LyoTGFXwuGJZL1Z
 W02u5Gfijc0ROiRz1tl4MDc1avKz0jUVVccO+w1ouJkZrW1FV6f6lTHndvKZCqrInreSeG2eaxG
 IY0G0oZ8d10/Hc7qCJZ+OcZ+z3nZpnYU8Z1ewrOVudZVqspCoCdYq5VVroVM2UTh6ybMlEkPqjl
 pftlqrf38adaqDEE2pNuLjOhPfmI28IhcaGymkQr7mLA7jvPcKGz9Few6zpo2Z3Ey+qUsj4RGE+
 Y6XxOVhe2rGj3Ul7+IQcz1akpbxABrysY2tnZXAOvtEJauZWSjfgL8vzT31FiLvKK/K9OfpHgbt
 lt/AQexCAT7VXcOIUEPSvCqXdrATOSMHlV+uefAa72sxZgcfaEQaMkGq3JKiNx+gAliignpfRER
 xkGSVgdKh9mdE5S0BMw==
X-Authority-Analysis: v=2.4 cv=Zrnd7d7G c=1 sm=1 tr=0 ts=69f37ce4 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=G6nGOk2YJiK-_vFp-roA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: sjiV-uPA8-DZQUwAqPZa05-_39Stz2VC
X-Proofpoint-GUID: sjiV-uPA8-DZQUwAqPZa05-_39Stz2VC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300166

On 4/30/26 7:44 AM, Priyansh Jain wrote:
> The TSENS v2 software driver currently clamps trip_min_temp and
> trip_max_temp to -40°C and 120°C respectively. However, the
> TSENS v2 hardware temperature threshold registers support a wider
> programmable range from -204°C to +204°C.

Does this hold true for all tsens_v2 implementations, starting with
the ancient msm8996 and msm8953?

Konrad
