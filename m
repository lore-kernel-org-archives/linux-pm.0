Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740132;
	b=CTzn4ieQEvHgc3S//eBLeP+6VWImpvsVSG1eYwMDsmx8Z+XKr7EtOZvvo0kCC2nHP2fG
	 Zf2PknpESBlGFLKp3IGToiH2qIxt17Su86rUdds+ilQECHVIOXDYWU9o1qwHW76OcEeTy
	 Z6Cmwhe7bA037Omp5jpRE+8GjnuUintWAXYQRCSko+WzP9LreiXnG29cZPXs4aWcmxgFS
	 OukM5G7Yr8wknMTyVfvHrOYpWmhpZyAr6C2MugTH9z8J9Y7ESjwTXTOaUG8ZAJjYBGgXT
	 9uIt93J0wwBfCk/kgLY2QobxpGkXX+EdTJcigZKpKXEZduY9ruP0XlBxUzTU97SljOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740132;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
	b=vZmqiqnDhY+sr43fGR0JSB748UYG/EPANfyEkGcQMmgPUgM0tUJWOh/mqv+2iCLNxto9
	 SAma/5V7TEB5tA6EZMtOERHE0+XeubI/RzHk7svBj8h+lJa5p4n7dSuLdF7mRBlF5yLF/
	 UQAaiDP6KV45ih5lZpcZTSyBf6oF+Xht+CD6Bq7wfa0Vk9apfkgaZ4/qFSrwfvwnkvuyt
	 2wwVgWHj7Yxw2kqwMrHvMFEkrk8i4He5tHL4GIzr454rsB8gP99pS4s1hthP+IcsC8OvJ
	 2yMNyUd83TdBjaj9s2AM2+lhFjx7W/0HjLgxK9iCvun9zmB5z9cQYXifCPVnxXdtojw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d19wo7gv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U4ZQuWL8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C4606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 21:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D5C4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d19wo7gv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U4ZQuWL8
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IYqkD445210
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 21:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=; b=d19wo7gvSskyJQtj
	zn04v+tx++jgkYt9Qj3cAJXvlgXV3Cw5+iqSdFqauPrwz43fXfVRpO/fPUEdYHfR
	lMZXWimqC7YCDZyC2i5j1lckR15gAHs+TZpOj0+lBBualPVy+7PPATGPhJOAlcZ9
	DAPOoMLFRRZUBrP6kgsKzuw4IZgl4jDopwcfMXLs95lcvlaSc/d7Vqds+CCiaafo
	N8m1ziwS/8lzMMCkvJrvqYOEeMEJHG2Is6G3UCCsTu0cWD3BO/zzfskc7cFopaTW
	avAtwGUCSzzcElg30NazHEu5oC0TDKWpUx/zI/NPtiKrnEuEISsT3cGolU4LS3TD
	i6lqLA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pguam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 21:08:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9501034c4so87495ad.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 13:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793740125; cv=none;
        d=google.com; s=arc-20260327;
        b=hFFHLHe9zLpK3v37HEZv++nno+H3uBEUlzL+xIphtwiEgxczKGIVw7bFqhiOxEHUCR
         jeSRWNQ8c7Km2UiuM+1d/MwY0N3ZIxswL/ot2XzmIZio9hqAQyaE5NW7boyd0YQi/TjF
         2rz49M3AUnutA7G3VlvhwBsdb/m40oHj8OBjBxw/IHlpOajhtZF6BtCrnPRSpwn+ZgFM
         cQ8qA2q+5Eokzde5C/PD30DHWxi93zklRptARbL2QRNVACWD93ECLvIh9z3RxvVN5Wbk
         ZsNOkQbdWuRKNLPzDNTtw4Y+QJ6wbr48ruG5CgxA7rVSOMCDeGZhxk7SRH54Wswc5XZt
         FmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
        fh=W3/XK1gCRl+7EIjz88JJT+K3PcVrLGdepSg2EHxj0dU=;
        b=THvoxd8RaNY/bVZGufJk4cjwxmVVSkRPNG97poouYY5cBlJWBli6b6QEE3RE1UmGFr
         0bGMyHFs+a6U2bAExlMDKFDrFS/4eIs1TIV/lPJtdlnHMcAdXFXTMub9e+Xf9ODdxEOE
         v+wdp74PG4YAFLqPxlDs2NsNXA+XSCHBwdwP3h8u1o2qQiz266JX1KLiiGJ+915KbDl3
         FASnz2hy4iDnSDYMvNLpKldWeOXee9vQIXVpfhqdiIcORyuyGo4OhcahVWoT2Tu2Nocy
         HxtzOkmuIZpRUP8N4ppE2c6bmdKg2zXZSJHVZPAvRsUDa6MzUgOL9JduliAaKEfLgBvu
         4hdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793740125; x=1794344925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
        b=U4ZQuWL8VkMrSEoloKaedfdbfRwUjR8An8rhZ0Xwewv970HcmQTtrnssSiAFu1FSOI
         8lFNExDAkHfqNCmv6GvS/ZTs9kXg6cK7ayRDMM7/go4WgwrRmGcmkkFfs1T2OxrPjmX4
         4uBv1KQjKv3i3U+CFTMRCd2vAAzyAMwF2fklqqurGuPE37e3IVVjmeessTXXtWtXGnQl
         +qaBztSrIhg9/Zy/hTMlUBNZbYySVPL0fdlb5GoGRlm1J69M2L6ZXhW9FbcvRmuhl1Lu
         yKMA6i8vDMS51zf+6r3lRIe23CY6WElaMggqNXjBBejIy7j6UOv6kIhWG/YXNeJkosrq
         nTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740125; x=1794344925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nqa2HWb+gMyhH1q5C2IS9vP6rX1bzS8fEOjh0AxXP0c=;
        b=mJTgG5QoXPsmNnV4U6jeJhz5cc757Yj8wEenwYXaEeLqOs3YV7zH98Syqusu9Nwtj/
         hY36eAh/XLUm+uw4eBvpRzrIXA0W+rVRNbW+u6q1yzSfglJladEUBmOEyr7CcUaigqP6
         rsd45EUM8b8TyOU9xwBxd25cLx3nzFtlTy6OxUkhYPJM+oxKjFIT3o4fVdMUbKY42W1s
         YtmAJaPIAh4d05ybI6u0fU1xYUsUmrTUBzRrRIczBRwXR/eLMYBZbJTsLcauq6HSGqfl
         uT5X7bRkwScJlIoPKO3nurjHnKs1l0ZdLawqyx+ZeyO8nkNZIc8g5h5CYi4/AKo8u4Hh
         Ezng==
X-Forwarded-Encrypted: i=1; AKwUvBy96Fj9Ps254ZvaX5k2uB1ovhdu4CafI0PHZ5CP+dUQ3nUnKTQwdWRUYEGb2H4/tgYcLxtzltX6XA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fjExb1pO2KQzdkMPHBehSJQzwe6U4t7zrXUto/RVEXRrOHeb7
	ttIegRXt5g7wBrw2uKgOdw76MgePnXnl4V8aok23oVCbyLw4Gy4FpKjSY+ryGEi2A1aovizeWZV
	jx1BRQqUN9yI5F9LvxtltQ0e+iYjnoyyQonvH5Ftjdt5H2q70+OndiqAqKBUlTCAqOyuPuUWj5d
	lkHm6n83VvMd/L+b/g/3ZVauuM/YgMrnH8P8Xf
X-Gm-Gg: AYBFou2IqWGLA2qJaoe22reNzJcdzU3M0Ea+Zv9q+Fr6d2xly1uuuEhzpUlBSBalv0L
	eIgLVz3PY7M0QnfyWQWrux0usEEbT4eKhUkM7NlTbtHrL2VVB5j/wKyJclL68vB7I5U6dNyVK21
	sgEDt/T7R6TCLG9C1MDv88Di9CcDfpRYbgyjyUxGMUkUBugHUqZ4HdNmajt7M=
X-Received: by 2002:a17:902:f542:b0:2e9:9263:a5f with SMTP id d9443c01a7336-2eb36493707mr131781325ad.17.1793740124578;
        Tue, 03 Nov 2026 13:08:44 -0800 (PST)
X-Received: by 2002:a17:902:f542:b0:2e9:9263:a5f with SMTP id
 d9443c01a7336-2eb36493707mr131781035ad.17.1793740124147; Tue, 03 Nov 2026
 13:08:44 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
 <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com> <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
In-Reply-To: <CAD++jLkC7XehyM3Qh4mDu1zB+_MKhmFn6ae1sA4XCxeS1btT9g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 22:08:33 +0100
X-Gm-Features: AclHuK986C4IgEa_un_uJ2N3V7r60Yd74MfgWjVPHQJYngYAYIhlhA3cS1R7Hj0
Message-ID: <CAPx+jO-=OXpTY7no36tLoKh52EyscohYqtwD64xsgAc4Sh-g8w@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA SRAM
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        Frank Li <Frank.li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfX0VpWycoXY7Uv
 Tfv14O1DZjTEuKXbOwWx70kiIUznU89x0Ed0FvulhN9/bJVzkm1iJdgw1AXfN//8qL5SvakeKNB
 uxt2IwYlP/iZhscPVft+/rukO0oNqMfH82SFQsNHIz/NHKJ6EkUBJXkd7MqES55pvu/vzwZHifZ
 iDohWrSLD2IRZKq/46XLPlQpwnFlj/GokVSGI7b+6H3hYIEmX/5NRgxiD0yt6SYeNYhV2as2/6H
 eIsbne8UXf+OBEXIthUJi3WMyyN8zvhGYDE7SixyskuohkNfBQ7sp3sYdO/TMGGYBbUX/7um4yM
 qUjVLi1TmhlOeAyWc2xb4AktDqj2AdhOLtBuI5MAYbbJ/eVWyTRsNGVYgD8wq9oOD1NiErKMVty
 Wo2KmF1mn8lyS5wszKe5cBijs8hUi9eqZN2mFAcf69Ag88dTITVX1QDM1Ipb3RCHlRhs2Yayu8C
 G5SmVTef4hyf0UoQ21A==
X-Proofpoint-GUID: CAQ47uEkBXapkJL6kNrOoC1sllfdMbwJ
X-Proofpoint-ORIG-GUID: CAQ47uEkBXapkJL6kNrOoC1sllfdMbwJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfXwQNgDc2xfmRD
 hZ6g0LndMTFoVMtEhhLn1kD+HJGcHiPUPMkD6ID/MKc981bs8hzZo+EDUUTr259PM+6g+yvIcbe
 W9IRu6E8rjBlE1FTTZoiZb8AFw2ycfE=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea4d5d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=neScOegWvRHQb6aK0P8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030084

On Mon, Nov 2, 2026 at 11:12=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Thu, Sep 24, 2026 at 3:27=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
>
> > > Hold that domain while DMA transfers are active. The DMA controller i=
s
> > > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM referenc=
es
> > > from the descriptor preparation path instead of relying on a runtime =
PM
> > > device link from the atomic transfer path.
> >
> > A bit of an orthogonal problem, but related to the above. The irqsafe
> > thing have been discussed in the past for DMA controller drivers.
> >
> > Would it possible to get rid of the irqsafe configuration for the dma
> > controller device, altogether?
> >
> > I don't recall exactly, but not the entire consumer DMA API is allowed
> > to be called in atomic context, but perhaps that is not sufficient to
> > allow us to drop the irqsafe configuration for the DMA controller
> > device?
> >
> > If not, I wonder if the consumer of the DMA (like an mmc controller)
> > should be assigned as a consumer device (using device links and
> > DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> > consumer (mmc) would be able to control the supplier (DMA) through the
> > device link directly using runtime PM. This could potentially avoid
> > the requirement of having to use irqsafe for the DMA controller
> > device. Maybe someone already tried this?
> >
> > If the irqsafe configuration can be dropped, in some way or the other,
> > this patch could become less intrusive, as all that would be needed is
> > to create a device link to sram device using DL_FLAG_PM_RUNTIME.
>
> I looked at it a bit, talked to the AI prompt a bit, thought about it fro=
m
> my (limited) understanding and while it seems possible it will need a
> substantial amount of work, so I think it's best to get this powerdomain
> migration in place first.
>
> Steps to actually go there would include getting proper consumer links
> in place and verified, remove all atomic resume runpaths in the
> DMAengine, handle requests without a device such as memcpy (I guess
> by simply using the DMA device itself as device link?) and some minor
> refactorings of lifetime for channel setup/teardown.

Okay, so it seems like it may be better to revisit this later on then.
No objections from my side!

>
> But indeed we could use the pretty well documented and supported
> U8500 platform as a canary, I think you have access to this platform
> too, the upside is that it is "simple" compared to some recent SoC
> monsters so it could be an example of how to do stuff.

Yeah, that could be a good candidate for doing this. Let's see if
someone get to that then. :-)

>
> I don't see much generalizable stuff apart from things like the
> pd-patch to the SRAM driver being pretty generic.
>
> Yours,
> Linus Walleij

Kind regards
Uffe
