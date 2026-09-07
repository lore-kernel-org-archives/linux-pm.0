Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC7453A36
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791693; cv=none; b=UQtnZ3pqwMPH+gw1N/VtbIyQJRK4W7AqTDsa60x+Y+CG2gr6m0E6j3+7N3ywHSd6Ouep1EvoQbsjrEwTfLVONYVHF6TXFRDmsZL5Hng+8JnryaG+/J+tkENHeBETlTpDm4FjlcVulal6rpakcBZ10wLSznoDUKipJh0X5J1O/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791693; c=relaxed/simple;
	bh=CeOaPRCggz46p3spwHEOgqlgtyutb4XizzRTAZHvMq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6OgMPziNXkg5ypyyfE/E64PFiYIvuGqc27Hlhn65sgwKMt6ofP8KwwSZy8M1JEotD02DXYRmNmLBXoWYAM3vjFEZSfxrSJq2dgKDft+Hwew5MP1tjpUBE865toT1xKBRFmHm7ys7dXTUBil7F20/xK4n+bGd+WN2zxXyVYuRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLIvoTe8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=euti4sDF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLIvoTe8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="euti4sDF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdOYI851737
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 14:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	osuZCFvrB7vpquUKrOkkWHbBAiTf97Zyon+VcJgxcbk=; b=jLIvoTe8JcIGrIEx
	FKkVKBJKeLXfhi/O0xFuGAw/17S8IUgUXu0/sgdBfU4+lYbRKIFmCGfXoCUikKhB
	ChU2AGcBhSu8Rg0Eg13XffrN3sNxhQNi0FxuAKlHYQMu+BgkWOptV3x8N6XPDBAF
	AIy9lPxWQmVgIoMyo0M9V8FjEvvLhwMIVvP1PZ6vsb4YiU/6pp1vAUrkcNdbT9P+
	Cn4dOLyvr7Q894jj8PZ/FItStJflxBOTAwi6t9/hqfNMjonH7oWxmJZ3n7eVB1DO
	r5or91N53fbMh0M1lm83b313H/+3o2xAAIBBXSAkcGFWOqZ+39YNWoetPQjAeGHG
	tcZaUQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8rg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 14:34:45 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97e9b747ad1so30655241.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788791684; x=1789396484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osuZCFvrB7vpquUKrOkkWHbBAiTf97Zyon+VcJgxcbk=;
        b=euti4sDFwTwG2cfXdfrCF9aJGMtA63UHppvMRy5LJ507FqZ5Vg2sGnnpSnJBzSV60k
         zYs1UcMymtyn2bpf7IB4xOzASaJdt1uWIGBerU6+rJCc9nW4BeAyJwaUseLUdUk9/MWx
         xCGPYUkdcY9aYlNmWWNqn+RUx0rmOWOH4r4QWqcInH7IPpXXaY5EWnOKaG6KnVLuv07G
         Mp3SF9L0bR7jP+lxAgLf8ZQ//ic/i9fw3nyqf/hUWeEP+u3BE2NhZfp9h/BxNt5e101u
         Z1Vv9nksMhekNOrVbRiI5PeZF+UyOOyFIig73q8RgscIT4zC4jxageaBUvjNDF37nBZ+
         0Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791684; x=1789396484;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osuZCFvrB7vpquUKrOkkWHbBAiTf97Zyon+VcJgxcbk=;
        b=Jmu2JeeDbYVc1gS5YWtIBoC/dWhpbe2JxLxEAh/jWjNEVGRSqgbhiCNLsa+hx/XUvq
         vB2DV9b4Vm5jFagX44zgqXnRUqQohbvdMhZUFCLKJQObsS+aGI+Hkk98Yoa7xhbmxEeT
         e0L9stbbJKeUO0QdJZJzDlJioEAIABmUgzsojhl4ULusOiB9ykmWnVEA/2jtadRv5Zc0
         CSDfsookPy4V4b7dLO3etebN5ICJViVM28Bs+kzn1cKVt3kMcPdmcCSbBWWuowqbyzDd
         Lv6ltSkqtmgBlkVfslZWqba767V8lQE3Y9XAQ6AMg7iNgp0CDt0OxICTN5la8MJYr+m1
         G8nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsYZ6qJDUP3Eltc1U6s2kPTa2FeZYw7KxvqKQi8odBnfrApH8bty+TrZ+H4PDvo/ppXJ9EkwM2rg==@vger.kernel.org
X-Gm-Message-State: AFuF++m4O1QNlfO25o2vUqVzmYw7VMv0lWwEPt7cQKvBcvX8uze904aG
	8XvBv+HN9VWHvh5qEjUx1H8CY1dYTACEV4gBmP0bm5FgF49JQQD3/i4MCXuDLg2IrbpomqFq3R0
	dHfUnqgyHj5CUA3x/kYYYZbD2et//1UsVppl1ZM0hCItTBXDIqaIa95iMdXIOWg==
X-Gm-Gg: AYBFou1uK6xQaLwRDEALGNWaACKPyf9cvDXS9HhoG8FPBvFaUyOvytVSCbTHzVpGZmd
	gfDKGfa5EkcMNVc/7I2O7KAP/0idYbcR9/foCmSNQpumDK1gUD1JuGGkfl3lqiLZCGGsnSqb54+
	hMn7NU/yPl3R33ZSg9I4RufAe1UZoMM+p3d9NH+cIq8e/C+OITBD0V4hOKGadUl7sn6IawSsRin
	FCLpQJfOKMLfyB3ZmfbhybWoF900ZhKDdHFgmB0ySII3YkFLysuWQfsu27lGIoS5rJMgf5oO//K
	Jn8MVJ5Xjqssnh61INeiOm2STUFoXuac4qXGZcnPBd6NSqKwQG56Q5TKRZxdjPS17QXZApdL027
	gSvyh9KRdyVh7OaOjMBATZA==
X-Received: by 2002:a05:6102:508e:b0:786:d38d:f7c2 with SMTP id ada2fe7eead31-78a60ee3f0bmr1885968137.1.1788791679162;
        Mon, 07 Sep 2026 07:34:39 -0700 (PDT)
X-Received: by 2002:a05:6102:508e:b0:786:d38d:f7c2 with SMTP id ada2fe7eead31-78a60ee3f0bmr1885953137.1.1788791678627;
        Mon, 07 Sep 2026 07:34:38 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5921e2sm485710866b.46.2026.09.07.07.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 07:34:37 -0700 (PDT)
Message-ID: <0916741e-442e-431a-9831-9457e3af1cf0@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 16:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
To: Marc Zyngier <maz@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mostafa Saleh <smostafa@google.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak
 <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
 <20260527-x1e80100_qos-v2-2-305c6539e6d2@oss.qualcomm.com>
 <apgeBNSiP01YfNcs@google.com> <86ld9d4h4n.wl-maz@kernel.org>
 <f58bd978-ca45-48b9-a928-45a2878fb54a@oss.qualcomm.com>
 <86jyox4fas.wl-maz@kernel.org>
 <ca962589-3b6c-4e5d-a11e-b49cf20dc262@oss.qualcomm.com>
 <86bja94234.wl-maz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <86bja94234.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfX+6CJRLI3SMlS
 rnXXo+s9mDbAcyiJxjciEI3TKccAWy7OiSKyJtKq6i49qOxqjbYrQT0Mzql0llKfwzAF/dWjb64
 tm4op+zBY7oLr5WtGjZk+N4SblbRND8=
X-Proofpoint-GUID: IMxyPmCjVXDukgZpmlfH7Nqav6GdS3pI
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ecb85 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=YAGKaBiEDj2kTEL75LoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: IMxyPmCjVXDukgZpmlfH7Nqav6GdS3pI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfX4Ibgj4TSkYcF
 rGVNWXmcN+vI5sLypZB8Z3WRlRAzL8jkXGwkJr2FIIWhJjX7qjHoFRlv+RpdFXkWBJhE40wXk4o
 S1dV2/YjGRk6R9dW9opHmMCLC+p7dkKBDm0svurDbLtcpjkHLrsnYU039y75d/sZwzMpEtVYv9V
 FR7HhBqfSLT2O8L/FYjmGfw0edHjdotl6QRz129tsko5iljHwwU3P3/qa1YBoV4ePtFu4grlqmg
 ipPOTR7qvzlgfb/0MlNiKvxSp35bblBuboim3n8FD5gj1QyzzhftyuP/7v/93wSP5eYF0qz8Ppc
 n+o13NUMTuYto6r1PYttproYLakmlZ2j1yMphxic0NXtoNnA4tYPok3eJcuM3eHQYR9vDOFrM3H
 P5L+BQfABJ+WURHsTCjDsQdiI5ah4PTmRIvlm+yhdqxKH7Fvhil4HQwK0WKHxrSPGmkYpws+wxn
 QnxtOXTRcmrb+8dFWww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070160

On 9/7/26 3:34 PM, Marc Zyngier wrote:
> On Mon, 07 Sep 2026 14:20:26 +0100,
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/7/26 10:49 AM, Marc Zyngier wrote:
>>> On Mon, 07 Sep 2026 09:18:38 +0100,
>>> Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com> wrote:

[...]

>>>> The current patch enable QoS for Hamoa SoC, which get programmed only during
>>>> driver probe. This shouldn't impact or cause any spurious resets once the 
>>>> device is booted up and probe is successful.
>>>
>>> And yet it absolutely does break things.
>>>
>>> With this patch applied, the box resets within 5GB of heavy network
>>> traffic, probably because some transaction get delayed, and a watchdog
>>> fires. With the patch reverted, the box keeps receiving packets, and
>>> everything is hunky dory (100GB+ so far).
>>>
>>> Which makes me think that the set of hardcoded parameters in this
>>> patch is not universal at all.
>>
>> They are, provided the configuration is for the right SoC..
> 
> Is x1e001de different from x1e80100? AFAIK, it is only a binned
> version of the same SoC. How do you explain the above regression?

I somehow skimmed over the fact you said it's on the devkit and not
on the mini-x mentioned before.

I pulled the Hamoa settings I could find, there are some updates but
none seem particularly related (maybe the PCIe one? I don't know how
the network card is connected), please give the attached patch a try.

If nothing else, please "bisect" the QoS additions until it stops
crashing. Although perhaps applying only some of the settings may
have its own set of dragons..

Compile-tested only
https://github.com/quic-kdybcio/linux/commits/topic/hamoa_purwa_qos

The Purwa icc patch is a bit of a mess because some nodes seem to have
moved around buses..

Konrad
