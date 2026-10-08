Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE230F927
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462126; cv=pass; b=R0JOqn5hz7y9qJ/N43hn5bvge3diSIKU8hRCueO1Ml60jPiYSHvS4abRYVJOHyQeKJ/6SbCfvSKvtGTn3kK2TWjMc2iV4JQ+y19lQdnQTy8E8tEzHuIRqYImc5SzVI4A5Xz/Sw+6D/1p8o/K2TZwy78109iiTK27zX3K+tylXUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462126; c=relaxed/simple;
	bh=+4j9FfZKR8IGCg47cVnrN1yTG8l/L0oUKeTDJQOU6mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO1FVlW1EtcBFRsvbpcPT19QfMpsGdY2o3ujUq1uqo8VMN2LrKBnWbWKmhLv297FLQaXIxgRNWemXBBDRl9Urb5scV4vl/7VVqTKDl0AkoRZOIa3IE+/lRdNi326RPspsX/XEtup5xOBZqHu1bu8RVw7cwKmmC6ZqHArwSM24Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PSlQoHnb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUnCAw7v; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSlQoHnb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUnCAw7v"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BK8MY3099351
	for <linux-pm@vger.kernel.org>; Thu, 8 Oct 2026 12:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+4j9FfZKR8IGCg47cVnrN1yTG8l/L0oUKeTDJQOU6mc=; b=PSlQoHnbsoQqCE1q
	KWv2ipXNFwyawIB51ym7mtbKSWaIJ5GKoB+2wyBvbFOvEJCzuQMHCpzQZ6BQ+Tv5
	foRGsm7S/gM3eabLuAkAm+s77Cnb+Jrv/IEIRhFf+ee7PdA0fzSuzgkMLdVrII4o
	EX2pu9BeJWjEz46dxcMRmBKCgVOIsKt4DRxGHKAz7pO3WgHaXJyuU3eWHVT6xLKM
	NRHUE4bp+FXrDEaYr9LN0TNdA34spBo/xomgdbz4ZkYNu3nstT+5ir6qaY06sCFN
	pjz5MIKEBGfEycmCJMWq2xd1cW0knOJigkR2i/QD7dx4rvVdwUKP8vyQ0QmRwmN0
	pu0VLw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe82sd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 12:22:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e827b3a6b4so3090355ad.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 05:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791462123; cv=none;
        d=google.com; s=arc-20260327;
        b=NOY8jqil/Cr9JtTwkfoOK+BUZaQ90/QeTYLXRXHbCTJxEjGzALXvbXgrg1o3jzFBZP
         1aIBcTQxB04zaJe6lOFLj7CzjQ+hYdzfQZV3xNdGaW7KD2IpJB/hy7TdU0r5aB9w4yw+
         FbN6hA2QVbx5mAxjsk7JQw0G7o4UyZY1ISXm4fVixDyBrsbVPL7H7xRHQE9D6yiZMzan
         wFA2htP1DZleWHA4+ur11f1GE7mZbuDvbiADxec5gZ+EJ0K8m2UGdKlhPsLscGpRfaok
         gqDZkmeRtf4J1oEC8h2rubBOAeueL9MtzZvJnVNUUR6NGPO9T4jQxWoy+gVAJgAHJ2t4
         QEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4j9FfZKR8IGCg47cVnrN1yTG8l/L0oUKeTDJQOU6mc=;
        fh=FebCplHUL5c4Rwmk3VYpKAMiV9YAxKMuyGXYS4B4Nbg=;
        b=mHZznzTLyBze6zOR4s7+TxPDe/FwvXEinlxYh4+rDcYNa3j0ke2vcAljrVKXF7ZCo4
         Pim6eM5af47hvHVAVBhbS8fWSFwWYFmTplgzQ/5xK7pfxkx9K+iY7ove/vjrz9dy29AT
         0a5l+GxxaGMRC3lHUKy3/c5jOEmH9wu2El57Lefr844D5tW9Vnil63NZuNDMQRWI63WZ
         e6owkU5AudiD6bdUu8nv7u9zxylm6Ni7LG27g4KcmSxw1MdHE2X/YIN6LbfXRXKI4VUr
         5LnEUhJ3PtXxiscpQvyeZD4Tr5VCt3yjypE6NOHQB1BpNHvYbHEWyu5+N8rq9zaoFYCV
         fGDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791462123; x=1792066923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4j9FfZKR8IGCg47cVnrN1yTG8l/L0oUKeTDJQOU6mc=;
        b=fUnCAw7v+6Y+SMXFHRJkZoWQ1iacf+BgAjuo1pB2HzuS6qDBXYjUdRapTmNVAYtsvX
         sOwkYwVYM1wAD4endgtxjUazgbsqOvhIwcdnpROUgOqSGmjv5SXmhl890tcfGWj8S+bs
         YGnoU6R1cp47fpG2TWCp/UCxJL0xweVQT6FX/Z2s6op9g15mLld4KxReRYF+p+xz4ttz
         YukBNQnyaV2p3Ppi3DyXBjcYOFcStwwbv7fRC5gfoCFF9LQRufUjhKVKFr4yc9lOlFOB
         7li63nc59LRTyF9j8sc87Zcf1/qnQ0oiPGjafe9sF5ohSs5kBXYKhCe3CpQ/3VDkcy8R
         24LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791462123; x=1792066923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4j9FfZKR8IGCg47cVnrN1yTG8l/L0oUKeTDJQOU6mc=;
        b=beIV1K3RU+szdU+jertbwV4rX6z5pjhNwyvbMjmKAlFPB2rskqLAC2WsF3k3VLxLCt
         X/jUBYJM75coqq39IdCsEB+l4Mqyg1MUJqiFZeBBwWuqJUPZ4P7BDLmVYL25WowWt6mK
         mlodkZmGM+c267LVjyDUlPvoFBMLFNPldaqiuvwpSIfzdE4XJhtUtuYE0oIQvclyQMrA
         /cdkKIze/+9dj7DoNsJ1R3r04OBQL4jAH64G6S/wZ4+/hcKEt4QpfOPt2q3yF08GVroj
         7pUpvRUgndFk5hYoXV1gqazvmUWGkRww/TLm2yj1LpeZ3jHRx3xsByKWTczcKXTDFwqt
         QMzg==
X-Forwarded-Encrypted: i=1; AKwUvBzOb38mbu2OkZp4L2z1MtWoNLrJhG5efkGmqky5ab7ZefRF5XNod4oWroVreIIJL0pxPJlq2SIiyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIuLMqMRxdYxsZrXmooFYDQVolcWFR1R0kTFaJ/ZGLc6DZ83Zs4
	ogtqJfWkQSe9Gf8CDHMH9FqcLmqL3yG3hC7ZCEUbkJTW3YU2DiMu2qrfyrHPjRxkvyY1dHdLuAW
	FNq+tvXMKp6J56fIarqgz1F/1OJLTG7Xfrb9U352FphkALAmxgcts+NNe2prHQ5jI8zaLQUjEPO
	ezEPjoeFn7CluvGYbnbXNmlXJHIcZVXquIVmgl
X-Gm-Gg: AYBFou3BPnnSHP0iu5elsT+rF2y1dOiEa5QkgTAaWOmVci1hsou9hlIlTLrHVLIZ7kH
	zUST9PdlJKq7HHaGu8eRlcqf/yZ7eksciPJGwg/CgbxWtoH8iBmWRfU4ePdlE+SDLzgFGKFTtQG
	03a1/DkjCxA0Pr18htowBhpqxhW2icfVvbxCu+QHQZXkZfDvsKJj2jEzrs14l0MN/uV1NYbgAgy
	NEvvoTKvgyRSvtJRw==
X-Received: by 2002:a17:902:b905:b0:2e4:a338:3658 with SMTP id d9443c01a7336-2e60051d4a0mr35952225ad.42.1791462122953;
        Thu, 08 Oct 2026 05:22:02 -0700 (PDT)
X-Received: by 2002:a17:902:b905:b0:2e4:a338:3658 with SMTP id
 d9443c01a7336-2e60051d4a0mr35952055ad.42.1791462122438; Thu, 08 Oct 2026
 05:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com> <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
In-Reply-To: <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:21:49 +0200
X-Gm-Features: AclHuK8ZT7r3xmegX1XclNDyrJeEDtHELpRcrHYyZXH39CoY5X64BysHsJ4sp3g
Message-ID: <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0OSBTYWx0ZWRfX29+6HZ3+Au6n
 pbYHVXgLyw1br6tpmfAW2h81mrt8twWpqyQr7rAVQZNCbn2mHOvoNoSBEy1EZ+XyjrAFlseRa2S
 Iry35zv+tCG+1UWGKW/oxkdXv95mG+RCYgK7H1l2B6rBGQm9suPouTdUWdaDrKMAsf1aAXo5/31
 CyI7sjMLN84tk/c99TD6OcoDtDC8yVUERjrRMQ56wQn15Z3YKe/vOmHyJeLDzLXb11ojLchVCAM
 oJAS07Pj1Td/cmse/ZnIOgLqz72eCkFfi77oM+sultwt+IrpBrbqY8Y0H3s/VwYTwEZnBCz/1dh
 HKZaZGeLV/g9jdu1ppSoEeI1GgvxCJeotTcbuaMz5cpj5ys1ZC4pudxnp1qAuzpRQ1JvrSlID2g
 kt93L6XrTWk6tT3CC4j+AnsSkRPQTed3cGVsO4qHFKfgPM0AavctyXDGh9/AnX6AGABJhqy6HNa
 IjBMU3n5oM3er3GxH1Q==
X-Proofpoint-GUID: YSrso7YRD23gRA9hPIkcHNc9eb3LWfS2
X-Proofpoint-ORIG-GUID: YSrso7YRD23gRA9hPIkcHNc9eb3LWfS2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0OSBTYWx0ZWRfX2d/WTEUPyQ4o
 c/14lOyF44OB9f+5SYriy/hZYyIPC5g+YzevUGu+50fCzImfGocGOv1gk3J40fPdCceuIfPP0OQ
 dh3O1p3F32SZduwpJFGzOyLwkZUh+Zs=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac78aeb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=3wAzXcUKBgoAJ-C3A44A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080049

On Tue, Oct 6, 2026 at 11:15=E2=80=AFAM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> > Some domain idle states require system-wide coordination and should not=
 be
> > selected during regular CPU idle. However those states remain valid for
> > system-wide suspend like s2idle.
> >
> > Add a per-state system_state boolean and populate it from the system-st=
ate
> > property. Make the genpd governor skip these states during CPU idle. Le=
ave
> > the system wide suspend path unchanged so s2idle can select them.
> >
>
> Instead of this I am thinking if we can QoS cpu latency setting and block
> system level states normally. Since s2idle is user driven, it should be
> controllable via user-space and we don't have to define bindings again
> if systems that use platform-coordinated needs this too. They may not
> use domain-idle-states.

Even if we likely could make that work, it's seems not correct to rely
on userspace to make the kernel to pick the correct idle state, while
the decision should be based on the characteristics of the HW.

In regards to PSCI PC mode, I believe we should consider adding the
similar DT property for the arm,idle-state binding and make a
corresponding change for the regular CPUIdle path/governors. Although,
it doesn't necessarily need to be part of the $subject series. I would
 be fine if that is handled later on too.

Kind regards
Uffe
