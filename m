Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624D44BCB5
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387295; cv=none; b=ear+U/b7NwrrjLm7V5lMYBFmPtUDL8BevcAuRRAexb1R6WCWqj1p7F9buA5nvU536gOEF/P8nu2cKJIqiOFzWyx8BnVU2JTmyCKabsS9PVK8+x0FJyuFoNTPZM7w028mCb/nXZ+1IWgEVgvhLCMHQzIAjJVXItp7lOwgGHVwGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387295; c=relaxed/simple;
	bh=86eYR0i6ZVOAL+yOW9gV5s1lTtVfbPgehRLwOGUh8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry5HvqZ0RY693T1f6tRRZN/+jRx+ZEjD0zuOxjV4oDRg/3AEPMzM/z0E/2XxvnKF0hr/IT7izob95jC5Xd6Gq1P1jN2f79aO7rZFgMnlA66ncixaEOzLPPe2xBJd8VFY8sJx4q/kbsK59O/Nq5/TIBioXAHMC/5VQ26EKGbQB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnamtNDQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fnpxsse1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnamtNDQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fnpxsse1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAm8jR531006
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=; b=nnamtNDQQ9gHj/1u
	8u+wb1s8mTP6JWRKxKfdX3d8ABVXd5kMHmfW4wQ9nsSyRrjYa8WkAnjy0dXdtaEo
	h2enOSMboZOQCYy8H/CFLdd9f7u0SAjuYTs6HsjKsSMJyk6o6xUB+uwhBjPWBiyu
	sicjPLoGajNYaGVa0l8fMYcMn32TORMoX1I0eqFvp30N4DUbJntsg9O1Mb2f8SY4
	vyxc953Q5FSjtqXmzyZ3M9e1jVgMce4t+MrG76KRNx7HpcRB8WhzKnbYVSsGWoj7
	x1ZSWv1V0N9dsqSCWcPL2ykRO9F2MIYBz8r5t+u5rEJnunkGwCFUwiCOgKAy+DCQ
	w4ofBw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hstamu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 12:01:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97c4f47fa57so35073241.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789387280; x=1789992080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=fnpxsse1qRX5sZQfeXxfoDy1JeUSJGGnh7kIrYSDevPsbZf3X4xM7ub3P0Cz0X0OA2
         YGMD8OapHpEQOpEO2DwGXPfNeoqS2B9ivEVYD+KYFX0UlhR+09Nq5jvKk1ZhV9X7p1Xu
         6gl8Y4sPZcyvszLo2QZoTXjalhrbQwMW/1NajFtBSgb9PYiDHrayepU43xhvPgemwwL4
         KSIm+HZr0WskZ0xLivosNLlto0+o4FnOzZ5AG/vew5tuy796IEeB4PxIqwfCeNzpU25+
         bQb11xZTipONqNcZj6DIiGAKSCiy55baBdDX2ykYRy9bWHBBGmkXvCVwZqJD9MBZ/YhP
         xhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387280; x=1789992080;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=F5igc35VcH6uWRDIC1iOY4oa8oiwSChPARyxLY2b9Yr0TCWdaMJRyPp2dLOg3ilvOz
         qbCcJRMSypsGiK666jIsrj+WmXV1HcQTuOTOncRiQ2qQLFJumrn25ja7olowsKu+d2JY
         zjAVVdlJ0qrlllXA7X02T+CfIXECwHNWlJ91fH4VS60syOLL4RlTYttDLb3e/Y+7KzHa
         PTFo682hk+bGnERHWXtv/WMkELZ3MPPhHi6XdhT3UZ6t+BZMWNWJChTBTs/F2rvVVdHE
         OzS+vnWFBskgng+h4WbXr7QeO105/QN0LXFE4duXrS9Lymv6pJjuZ/Xu7cMiKaUvCkh1
         1YCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLeHM7jy6DVhGk8f9snSDsu4JXxN2E45tQNs7qaOR7+3vkn1sWnFb+qPvtFADdTbv+aEI5K45V9w==@vger.kernel.org
X-Gm-Message-State: AFuF++k+iI8RrI3PtZiKIBKR8nVkBjZsP+Z6KZB3Rx3Jxb0Hf+KTxTwo
	1dOrGHEQO8GEyXVx0xOtH5N6NsvPfKSbEnNO5i5vxmfv2V3bQ7JmGhY1s9IHMo8RJiZHWtdOugk
	KHaTgJIzMn9RjRY5BBQyKjIDjNH8k6lugTX321/Uf4ylRR2ta0eIxGVFb4MyhLLnzhk6VYg==
X-Gm-Gg: AYBFou3zEf0r91lBxAikLM7ohsVJKH5sVT5xBQrpoPWuTwNEgrSsdvGZzGb7YKPags8
	DeuO6qvX9Cr7ZjlK+vgzcZGt5zOTmdvInoHwy3Y4VatpCZiP6W2qs6Yoy8x5WM/w+n6spv0FPzS
	5qh+5m3PEvvsn8aEUyUuJwcyXY0W6QiS+fUhApwHtWuxQjW1JGy4bJ7NUcasvFQvNX2XeN0TRR0
	6hFRd1+iAlvYry0ccxO9WFlNjpDvRH43iO2274mh0mS4+OYhuC5byEm+i1o/KGyeMUeTlxeSkyw
	OFlGzvfL+GQe5VVJAG+gyHCZMx1XkogCqpQzr3lha9KTqNILpwzdr/qnrPU62X3Eo+BgYuIHgWY
	Mtn03FKgO8TdPLtt1vhpouA==
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321806137.2.1789387278918;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321754137.2.1789387278364;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4dfc7sm417817966b.4.2026.09.14.05.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:01:17 -0700 (PDT)
Message-ID: <7f3aed88-fd53-4cd4-a316-630208e7c08a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
 <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
 <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX/vSDRSlXZZRj
 F8d3uCFVRAqKC7QOMHqfHsawlDrwb2nmeevGtCvCOGJnokdRE0uEB6mNNkbscE1RIA5qFjRtlAi
 wuldZeePvRLLEHp1CLECeL+kqJvTMHp2s9M5u1S5qGN1Gi0O0nS3uuTQv0FDNOGVHPzvQjIhr3a
 fJpP+jBWxw2qZZF+mXAyY8u/EJ/Yu9+1EvFI9NbeXsLx/We3MW+pfeeEBEcjXCo2vxFPfGaR7/m
 DlHvtg28Ei1ykfPG4Qj9qTQ7BE57KyfQWhw6YoNB/xsRd2lMjJ5y8pY/AIOOuFkLtSCZdMoFiH8
 0UNV3dad8d8qClerpzLossb15wp823xViYze/yKGVMhftzpJjzG9C0lbRORJ3JJWaeM//OW0pQa
 bEWw23bH/9O095HBLXBW2CYuos4KmJhbUCh4/l4/kRfXIaSd8H1tMjJUpJcevp71p63Bi5Cn/Yd
 1+QGKhPGPeMlIes3PQA==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa7e210 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=OuZLqq7tAAAA:8 a=NPzieGulNsBdfkreKLwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: uPfORNIEDz2tszV6PtqmXiX6MNLmJcE5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX15I28oK/x2Uq
 B2vT8P7MyAb6MsesJ60RZRl4LWiXhiVMc+b0vXSWf9EU+dN+GnMFSVY++rHr3yAdHQldoN3P70Y
 Anve9q/iI7nWn5xC1F5pqEpM+6RnVyE=
X-Proofpoint-ORIG-GUID: uPfORNIEDz2tszV6PtqmXiX6MNLmJcE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171

On 9/14/26 1:58 PM, Muzaffer Kadir wrote:
> Hi Konrad,
> 
> On Mon, 14 Sep 2026 13:22:52 +0200, Konrad Dybcio wrote:
>> On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
>>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>>
>>> Add General Mobile Shamrock (GM 5 Plus).
>>> Shamrock is designed similar to L9300.
>>> Downstream reference is [1].
>>
>> Please feel free to
>> wrap your messages at 72
>> characters, otherwise they are
>> a bit hard to read! :D
> 
> I am sorry to hear that. vim shows
> it less than 72 and I can't see which
> line is bigger than 72.
> Only one I can see is url itself.
> Should I move url to Link trailer?

What I'm saying is that you wrap your messages at something
closer to 40-50 characters, resulting in excessive newlines. My
previous reply was an exaggeration, pointing to that

Konrad
