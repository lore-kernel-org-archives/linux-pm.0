Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794644342;
	b=JUy81aq7enPfTFatnZR9yH5wWtjT2QibOEPPvS3aTKRhwEGOek5OsfPBe8+Ku9NXxmnf
	 h8wTYuFekIeui+0II2dSG3zwzwOzICbVFGo6ym2onorEnMema5kzy5mqmqpQ6P6aJ86Wz
	 CWYN0ncsOpV28x5k7/swzBQgreiEuxG+SusvASQFudgEvXAqq+v9pXGMF4remLe06iYGL
	 02uVwms7BgENT58i9GKXJr+8azOOLg6u/VjQxImze94Z/xaoghqXOHSmKMoAyB3wjvJWP
	 MWz9cI4FV6r5QkdfCB55HSMBdPZZCt6tHbty4lKRyx8rDKf2J1mal/n2LE867/j1gOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fKzcjFxqGvvYnRdzMZQCZdZZhZxsTy33VYOqVFlaCgI=;
	b=QpoRZI8HmNA60DZ6dytTlAoJFlcNdTuctNhy1Qxt+9cJyg44mzVYHE0ua+3fhUZ+xdg1
	 7sYxKE75+k747WvCRktct/9RAIRFLgycuY/uqXFkYNrh9Oa23Byu3FwfIF5mCcexC2vHk
	 uxNLkpgqZTcHsbavUhfQUMTp3ql/+LZ0aEu9VH2fwP1eO8s+Wa9z+R8j4Me5GB0J3FSOh
	 GSheda6tFzxVfBFXwxw7C2evGcyPs8cbZ3LDPxfQN9zibC7aKTzFOx4MycsXY5DfCPB0C
	 9PNl/HvO1PCs+b8ZgNZ6Y13U1WjSjmFpJTm+2EeAPxxETsl0TgZoQGvUChQF0qQvX0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g2lsw4oS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H+c3tBba;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9D606A329
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF9D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g2lsw4oS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H+c3tBba
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE60pCR3161636
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fKzcjFxqGvvYnRdzMZQCZdZZhZxsTy33VYOqVFlaCgI=; b=g2lsw4oS0C7kW4+U
	opEiTfMF0LUYiQau3gh3GvXBGEhya76EPmzdl7rzJp0gn488egNSxOuQFZ5glSqH
	iVDkJ4JP4V+sZKVC6Ip+y4dVBjFTPfl8iwMBn7XuQYnARE3Subi87vAo6RrFyHgp
	/hgH+KTJFe8gxoWNmdLnD2WacWtj3a6qSMangdB3apVGNEMNojdYzz7piRjXIi0J
	7txafB6pHCJrviHm8yq3DmB/V0EwZssYEvGd2WUR2m+XC5NihS8uSQY23N8U2GUv
	GwskLP9+1tcdg/P3krNLXgTa+62rB/YVQbEmGxDxjePtM/GLS5uKn7Gc7GIi9Laa
	C2PbYQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjragf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:19:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea71803effso15733345ad.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 00:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794644341; cv=none;
        d=google.com; s=arc-20260327;
        b=olhhNbcjKOVYN5ur8GDOMbRo/94ycavaY7unkKdFH1JWuZA1aFwMG+ygMhqAk7wC07
         rXzeNM27P5Js11ogTJSkESqYJU7XEfUb3xPjGFgO0/IvsSoaZPYIQlnmufoMd6/3ROq/
         8ftGr0o3hfw4IPI8JhmYfqmsyjGm0KZPcDcdMUOH16qonyX3gGTzWT5fnAPUVdIJYFN0
         3C+Vuo5Issfjf7dRg6DxWigobnN80F5vaD5YeMXqalSnVY8X9XEPniofB0BwzMpCPaZw
         ozANGxCy6IvZyLYe/BEinNTF9nTgiveZFwSaNCbVjehwfJNwX53qLQrAYpwaBCpr7ALG
         lRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKzcjFxqGvvYnRdzMZQCZdZZhZxsTy33VYOqVFlaCgI=;
        fh=rTEXhUT2pyTGgg72wHBYpi2xAj3VGcC86MAizxLKRKM=;
        b=E/ffVxNcqIYhrAtNtVV5V5K/yandrsPsskO6MOqhB0/7BenH9o0GJfXToXBWBtiyGF
         Vaw1L6QYG8Cc+Am1E/ZuxbBvLLfSLygWIN2MJ8uUZK5HR7LkrEMHfW5Yl92YrmGW4v5M
         xmjJCDDDMvFk/fHgylPtUMN/IWtJOWV6wLYZOqFi1D9Lh8dEEP/GMVmk54fa5Si1D4g3
         0MOaaZcmVRzMH9/jZdI9DLMua+K7DSaVrI5ZPz5Igih+R+q0T40MrEoWQqdtw+PLvSo4
         rUFQ2va0Rvzu8jZE11GD9x2Kq9DG7WW2hoJGRo29bMoak7Rb0YdpEbrk6Yas6CgP3Jbd
         7WeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794644341; x=1795249141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKzcjFxqGvvYnRdzMZQCZdZZhZxsTy33VYOqVFlaCgI=;
        b=H+c3tBbatl9M9cNeV66aScll2PRSkUHoDrjVvqBqfxVteSePrVA8Sqep338CEkKkZW
         4mUriisdv8jJ9vh9H03FVY1oGrt465yg8v8DEUeYqd3+O/zhcmuOXxRbG3kr5E283Ca7
         pYwzDnsQAgzY1G01OSE96aaPqls2EzZa4O3ibGQxFSmQoI6xHY7s0omAGN3tpHkc0fSL
         fqnDlxBxKezPL4bVV9pjxIOdGb+qrykQL/xzNcg7qR/cz1blNTnBgJKOSthBWJac/iGR
         1okFTlCWZPyHgrusF8Tz+tZ4s7xbyoy7U1xF3VWbDW2TQsfZk9JNkBO3vYr7k+Kaxj2o
         gg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644341; x=1795249141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKzcjFxqGvvYnRdzMZQCZdZZhZxsTy33VYOqVFlaCgI=;
        b=H6qvKuox9eqsxWGLgE4Ikn6GuJ02PeFLrn4nlnDuJIeBYsHrADkyvdASu+JA50sPTj
         39ecDedVEjXi7voJFWpJ1MxWpAf7TiwX2j2500TibCXhj+QdDO2lqo+9AKTEC8PpSwp/
         U6Z2reT0HmfTsxoJ9oI8g2raEsIszeesQPJxK+an72I+TbOzVhOTUPSvux/A4JzcuK8F
         slJ6XqRipgvGOCymbVmwBL99fnBWptS16ePx27kLZ+wkqJN45V/WM/+jvEptJ8kb9ZA4
         eI1wE+8qTpDe2G5Az08gcNtXVU6nc1Ed8z8kWglSnoQxa0k0l+qGGhL1vc2lSoHxOi3o
         WXhw==
X-Forwarded-Encrypted: i=1; AL+hErF4qf6gQsto8TGDrHI14+6gW8DZVQrxsDOZNKQG+a1GRnhgbjNC3l4kHEcSnf5HuIunU0TDxz6qpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ljk5BpFpH0xWvzfH5qdn9GtxGljDWhPqWcdKXvgYQVOeNtlpT
	jRZTel3AmLT8O1trk+TRnW9XoG/KCZehcMP2TgQMm0yw3+LJtArfCaeczssZzd2B/fuZ7zd6hrb
	I3hjPZhGEtez6Z8HpN5U/cXbcS5kfgKwfLf/WqPjH3NLwMg4kF/kd6PV0bj+NazyQiw4daNHwue
	T46V5WgESvNKuaCjbBotM7J3ye+ETvwVHke6vV
X-Gm-Gg: AYBFou2XoOozAu6Qa07cE2riPrGbITLJsDFde7EK5FmlQ6A6uJ/qFIE8wZIfo/T4ENv
	Q9CLy4bQErBNgMhQkirdnBQabp2qSCBpAi0AsnmmX3Dy9lNcOJa5FyNCP75ELFiW4g8qzz+zpRu
	LmP4RRnwU3r/hybuudNNLoBLnX1nG9VjmNJxiobh/67kYninBWFAkq5VYSYA==
X-Received: by 2002:a17:902:e790:b0:2ed:379:1592 with SMTP id d9443c01a7336-2ee0dccfa1bmr52675135ad.26.1794644340580;
        Sat, 14 Nov 2026 00:19:00 -0800 (PST)
X-Received: by 2002:a17:902:e790:b0:2ed:379:1592 with SMTP id
 d9443c01a7336-2ee0dccfa1bmr52675005ad.26.1794644339943; Sat, 14 Nov 2026
 00:18:59 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027140751.2465743-1-b-padhi@ti.com>
In-Reply-To: <20261027140751.2465743-1-b-padhi@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 09:18:49 +0100
X-Gm-Features: AclHuK8IXFCYeB3AWBk0BgMTxu3LSqf5mRE3cR_dlEjTborPRMXNscrVzwDLsE8
Message-ID: <CAPx+jO_GHZopd+D_v5X1j3GO4ANxsR8eMsV9h8HGC9qdJO6b6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow platform drivers to skip PM domain power-on
 at probe
To: Beleswar Padhi <b-padhi@ti.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, pavel@kernel.org, lenb@kernel.org, ulfh@kernel.org,
        sid9.karanam@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
        u-kumar1@ti.com, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzMiBTYWx0ZWRfX2BiGQQMJ7T5P
 oquEjsXp1HH9djsGTIkgqsmVf5RMDnK1E7WFstPJ+kg+WPoLB13caKWkmno43JZxEknZfkH9wMD
 sVKd8kHAK3dBNI8VwXxyqykN8urdHeIJeErP2BZJBDuaVgg3IT/A5K+ofJGXRY/3A6GPvEvxYCU
 edreUjieSWxsvzTvvSOrP4HbFYk3EAilWHl/ANbFGZ7R8FVc8Vv1Z7MjGX4/OTQkLnF28rUoq3i
 50iarbBIP3UuiPbxsu+fd2PkOL93KQM4k4QFdbq5yTG0fOEYyRvVtq3Z6KNaVMIvgbL80OWNLk4
 h1o1Wob+hgqWFXgncKJxvqmvpKzIR6RrN9k+6OUUJaYZf5pPC+ddyFMAsF8QUF+EG8MCYOV9NPL
 VKXPZPfpaVRbohmPY8aV74vrPMfosKJB89Z+jFryyxzIqA0JowlAmOhWUsNByKZeF/terfXx5Vq
 MFp3fAb/GW4eYM9xF6g==
X-Proofpoint-ORIG-GUID: uJstr_nY0VdEo_gYU-l9kW149IQylzF-
X-Proofpoint-GUID: uJstr_nY0VdEo_gYU-l9kW149IQylzF-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzMiBTYWx0ZWRfX0uCcwj8fJB8A
 wrOEyDNd1z/Ke77UuVHN11B2wRfiWkCEnCqxwrlVHk5chco2b8ViQ1Cf5hJMs2DexRP/GZrsy7Z
 huz0N0uIkAav3zSRZ/FIogCr3ODcFdQ=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af81975 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Ht0MZJmIM3MH2Up-epYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140032

On Tue, Oct 27, 2026 at 3:08=E2=80=AFPM Beleswar Padhi <b-padhi@ti.com> wro=
te:
>
> Some devices must be configured before their PM domain is powered on,
> but on DT based platforms platform_probe() always powers it on first.
> This series lets a platform driver opt out.
>
> The user will be the TI K3 DSP/M4 remoteproc drivers which need to put
> those remote cores in reset before powering on the pmdomain. A patch has
> been posted to add "power-domains" DT property to these devices[0] which
> is the motivation of this series as well.
>
> [0]: https://lore.kernel.org/all/8cb23b44-027d-4d81-b342-7eaca0248f63@ti.=
com/
>
> Please provide your comments.
>
> Thanks,
> Beleswar
>
> Beleswar Padhi (2):
>   PM: domains: Honour PD_FLAG_ATTACH_POWER_ON for genpd
>   driver core: platform: Allow drivers to skip PM domain power-on at
>     probe
>
>  drivers/base/platform.c         | 7 +++++--
>  drivers/base/power/common.c     | 5 +++--
>  drivers/pmdomain/core.c         | 5 +++--
>  include/linux/platform_device.h | 8 ++++++++
>  include/linux/pm_domain.h       | 4 ++--
>  5 files changed, 21 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>

This series looks good to me and solves the problem in a nice way.

Please drop the RFC and make resubmission so I can pick it up.

Kind regards
Uffe
