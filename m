Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619193;
	b=HRrFVz/5aWo2QJa6pE/+Tdh1A095cxJ0u07fQu3N49yfsb8EPlrGye1DYsx2D2RQyx17
	 qC4ObdxtddvFrhuDPzSKJKkpXyrroUB8MneS8m+PTPpAJDGxmQ6PhLni2zvl/7ncUpA6k
	 7GC44WUDg8x07oBi7MN3+zzJHS4QY2Xdu9sTME6HgTGzAyk3Pg+Cbro0h3OOuITF7jYH6
	 yN02T3E3TDkzaq2802RTCYmikURJjp2h+hYS2oA/VQNMiCL8fQ0UR+vAZbQcma2PVKa7M
	 dfwzxU96oOGP/p4JXjTduTcaFQe0UF/oRf5x+fxS5o3MFKo1jPDEjGQVZ5PZYCfqC5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619193;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
	b=fS2mrJNn4tvnPBdHSAjDz1V0HYoemPSvXe+LWiC22XrdW3cOWDIIg3MLDL8NCcceixbp
	 lAr+AENZKaTR0p0uLyA18bYEJQFbvdVuUXQtyqEkZYW/eGeQCm4E4Zd7QQFfJeBgRv51z
	 J7jp3SGkwMMjO1pLmYf0XKV5E7sOrUmxmgxDJyabvGyUKJDQUf1RtUIFqyk/jecf99+A8
	 XGcYZ5QGE5JRrjW4JhjzQQ3S6udgdst4qdWJsloaUt6TUE30NbDrFAyqJq20CH2q64rAw
	 ouGqOjEcKQZhIv6Vu4eR5po9NDBzuWktvx9nC1VZS4xfcGqBiQ/RuEKKtLYoJ3dOxag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzjcr1Jv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tm0T52eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F8606A32D
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 268F8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzjcr1Jv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tm0T52eB
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM3mk724468
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=; b=Nzjcr1JvAe8O3y2M
	nRk02gsmzckXBcRxfri+XHtkdUIEszeIzfFyQQgR/BocgtLFL+n+eCBxHRzQ6Yfq
	qFzg8RINXEMwOvBf0/oUkncHMiBTksHiHC9BqK7fPOJQt+fer1msKMHomuVFo02M
	HWlOZeJFWN/NORls8UyWol1U9y/9hHAW4fZgccoU7/Sbqi2bbTFG+4vjo+f4z3En
	x0PMMHwz77Py3aOkFJX8N0yFo4LC9oqXKJIiDzifeX/5Vv+KdoJ8lIpcubq7K9D4
	SMLEBhZdEr0PMudXVoqY9KyOzziQXsPFG/RnejlYfRIxAoE94rHnRlkzkztqvvLf
	0Vovvw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxrphb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:06:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd66551e02cso5465020a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619191; cv=none;
        d=google.com; s=arc-20260327;
        b=Y1/VIHF0McqnBSi23R6CwYnByJGt9TwwhET4CnFw9EGB8ERGNw1D88GzqEOopF1CEq
         EHQqHiJeK1HNDgdHo7441dDB9ADUJ0VMEzin97f6Dhy0WGBOQSz2OCtFGd0CwjAoyH0L
         gQj9uvtg8bBnsY5Gfr1r/3uU7czWz1c8Qwo5CD4P/x+U/Odyk9+5Ns7H/vwSjX+4nJFb
         zhv35FeiabQWgu0BjirZCWjrRcbxLuCNxti7VAEjNginmsk7DGNNxSDFJ8fiU9G6MWwB
         uTKSFm20VlemQQZgaNdAEjeoJr6ZgF34jN7pdyjdwTHly72cLINyYLdIYm0CDu8UQ1jU
         38jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        fh=UpoMc/KARL0NV0ajlCiaQhPZq2/Npw6fpYml42qfGQ4=;
        b=FmIoqpPnw8X5oIOuRwi6yw3iW1eO6RQAxsibYGmEHNnC6X1kUptepSIFcs0ygoOgeA
         Yit2D0Y+A+Hiek7PDcy6bf88hsDYzJBPp9J4dSYEfbfjRrooKH0iTEOv61671Oq30mu/
         YYpeoNvzrJB0Cuhx9XhKPziPdQgAC0BRf6tcQOt6n/8kr6490IgAiiG+w83LsNxg28i+
         n4GsWKCPauj9zUrWjRqMPf5Idm0qNXb6SOpVikzvz2gxPSXaCXxDsW4Hs6xGBvoYCGlX
         9v6w5ZUFpookdv7hh+9dd0xFybkKkyJIo9oqH3Kv45A63xDqEHce3ZLz8EnsEEXU+wJ6
         8AKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795619191; x=1796223991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        b=Tm0T52eB+3K2/VKo61GPHg/qO857dlNheqkKLINH6e1+xLC75HYZH0AmvGZXxaBRP8
         e9euYzi8mPQx/3zoPbYcQ5rQlCAF1e5F569tTkZUjCFTHMeKShdfb1nMAXujozYNkmCZ
         TUr7GXj87gMCfFdXtP3RZzhVjhejC1K2DGDnsRzj3ntofvdwvX6kwhxjp6b40ZMiuxIE
         Ewi8pYTKJodyUePyGjfwjzQXEQ45DSZxkTulAybb8aWicVIsj+tsIdJZ1GwuLIu6J+PP
         O17mqMvHvBNttkKuXIqIUzbgXs15LVO5iLst29Wiw29PSAUr+MBPNu1qhXQnHYa5lCJK
         fkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619191; x=1796223991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        b=BCSxyVnzP+CvHLlJVmsNLB6lSu6nwtp2/Hnvx7+LHs/1W6EGKo54xD81q07lY3a5Bc
         EzdKkcWjXeyIjK4f0+ZfYGCxqSUeVoOUDblowLJ7KQZDiNWy/SSC2OeRChNPx97eXETK
         N7erjDFe1istukAv8UMHZC8B5/2DT6G49kZ0g22bm7Zfc8K19jxeNBNPJZ257W50T6Aq
         6chJKvbWR6uxamtmMUzYIiZg3kbe5gRk2B+3d/lmQg8mJ+jm/jdJimvQBPK1lpby9Wbt
         MlIfGfBC7Br0ix8Z/2yMPNuC66tgVWcOf/iTETU2YQQuFO+NgAbcWIbeFqoTOPHYvjHY
         J3tA==
X-Forwarded-Encrypted: i=1; AL+hErGd+1ROPWs4nq9C3R3AvTEmC35PzFO9M633fx2w0awoey0soho6M1X5vTalGuL+F1sZTj+2XKFnVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z92a4QWTjvEnzzBNy2Qo5/rmArEZd9DGqMrURkxXN36gmIKNyMI
	vshaP+W9JYtJSR9Iixm7LbXPM7Khrw8DhIhWpdDTB7JH/JWlQCs8s6lnCRM+sx9hLiz/JGqJaSv
	uRk5yHo+CudBdgNTjCP8kL91txXNNVvPmGV2M/D+e7aJV+2jHG7kKp1q4PEVPHlUblLuIfrX/3C
	dyHT3rl1JvPoAZSeL8ut8/YTNWizW9y1urSKH2
X-Gm-Gg: AZFdTZevvjU1c94y7lCPi6E06kN5teZ3PTPsBJDjEq+h0Lqa7ymK9lcsVxpg439zCWZ
	CefMTi4NgZGRZi+RGP9+hF0w0XzwUF7/IoNlNIdCSYbeME//ERaUs+evlJw7oYh1GC9flLIsMcG
	cp8qeHMXihxrfLT4Eiiza/HoS+ylYSwUAAgWfNtUgSMYQ9b2qAX7nIaeo1rw==
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id adf61e73a8af0-4014d14d2d3mr16907586637.63.1795619191477;
        Wed, 25 Nov 2026 07:06:31 -0800 (PST)
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id
 adf61e73a8af0-4014d14d2d3mr16907537637.63.1795619190966; Wed, 25 Nov 2026
 07:06:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:06:19 +0100
X-Gm-Features: Aa3M54qxdRmYOsZoBrTl4IfLXTc7pY51UNG7OdOGBQV2sjgdmvbFz8dtj3UY-KM
Message-ID: <CAPx+jO8oqBcGCSUReJJVMjsnQg+xCv_X8LhFVaGk0NDuOqmEiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: fix stub pm_runtime_get_if_active()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Alex Elder <elder@kernel.org>, Guan-Yu Lin <guanyulin@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
        Maciej Falkowski <maciej.falkowski@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
        Frank Li <Frank.Li@nxp.com>, Alex Elder <elder@riscstar.com>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Matthew Brost <matthew.brost@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: cp82LMfat2FP2bVaVXa3patxXqdT0fOw
X-Proofpoint-ORIG-GUID: cp82LMfat2FP2bVaVXa3patxXqdT0fOw
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b06f978 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8AirrxEcAAAA:8 a=ee_2aqc6AAAA:8 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=1XWaLZrsAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=f3U7k-wd2kzf4Rf19YkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=ST-jHhOKWsTCqRlWije3:22
 a=VOpmJXOdbJOWo2YY3GeN:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=nlm17XC03S6CtCLSeiRr:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX0171K5I7eRF9
 HboUJkZUV1gDUlJh+WBbmIymesTdy7DDRCZNrJALnI16ZEj9wR1eL5s0k80xi3zZv6f4i7RFRN+
 OJYZ5tGf+r+a88NeOuZ8fi1J2GVhLwZCIUnRhO6GykLDWMDv5++11l4SSmk6j1bx9I18G8X0GKN
 5EOw7LWdOa7m/Uodo+dNrmtphiZ7RUy53mBH52MPlHgt9g+/bOlihRleLEeqGN2rBVVNY63XAaN
 o9Nl+ZTM3c2Jmr6LOV1VKUOTsGv4989dPp8A0RfID0o5ap49q8gI+M8K2NnZlgfgH+pifosKkny
 42UX7ATdVrxbZpKiU2ts2LZKCFdJhwf/6r696nttoymAkV/Mj4LmvgxTOhMq4YGGmYx6zM+eIUL
 Eb/iF94jr3l9aaI2GH3JNaKyQN+QEMEyGQCFIM0FYhJ0Q6n0xSx78ElzWBnBRu5Z/7ZW8xvlw5b
 K2XjQiCrsJUKvhUixXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX/tLBFnm/6qh0
 j4YjMCdlq1ICtqgRWJ4BuAOoxCDMjnwMJxgNAD7zIGTX0lU0wsWtFKsUjHt4QgW7u1jOWTwjLDL
 N7kUfahu8qliO9/ajfww5lJ3nlHz16g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250060

On Tue, Nov 17, 2026 at 6:37=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> When CONFIG_PM is not enabled, should be treated as if runtime PM were
> enabled for the device and the runtime status is active.
>
> It's a subtle distinction but the previous behavior returned -EINVAL, whi=
ch
> means "runtime PM is disabled for the device"
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get()=
.
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
>
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
>
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>            drivers/gpu/drm/msm/msm_perfcntr.c,
>            drivers/gpu/drm/v3d/v3d_mmu.c,
>            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>            sound/hda/core/device.c
>
> Pattern B: if (!ret) after get -- no impact
>   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>     in kernels without CONFIG_PM), drivers/pci/pci.c
>
> Pattern C: ret > 0 / ret <=3D 0 / ret !=3D 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!=3D 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<=3D 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<=3D 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on =3D (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<=3D 0) early
>     return now skipped, correctly proceeds.
>
> Pattern D: explicit -EINVAL check
>   drivers/hwmon/prom21-xhci.c: checks (> 0) then (=3D=3D -EINVAL).
>     Old: took -EINVAL fallback. New: takes (> 0) fast path.
>     Both succeed when CONFIG_PM is disabled; functionally equivalent.
>   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>     stub is never reached. No impact.
>
> Fixes: c0ef3df8dbaef ("PM: runtime: Simplify pm_runtime_get_if_active() u=
sage")
> Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload stat=
e")
> Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context=
 abort work")
> Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
> Fixes: 46edb0a3eb16c ("drm/xe: Fix xe_pm_runtime_get_if_active return")
> Fixes: a71aeff3dd0a7 ("net: ipa: kill IPA clock reference count")
> Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the =
device is on")
> Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device=
 is suspended")
> Acked-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org

Kind regards
Uffe

> ---
> Change in v3
> - fix drm/xe fixes tag hash (sashiko)
> - drop i915 fix tag because guard by CONFIG_PM (sashiko)
> - fix net ipa fixes tag hash (sashiko)
> - Add c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usa=
ge" (sashiko)
>
> Change in v2
> - add fixes tag for patten C.
> - add Alex Elder ack tags
> - change subject to fix stub pm_runtime_get_if_active()
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel" <joro@8bytes.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Guan-Yu Lin <guanyulin@google.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74f..de9e7518ecef2 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct dev=
ice *dev)
>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {
> -       return -EINVAL;
> +       return 1;
>  }
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return=
 0; }
> --
> 2.43.0
