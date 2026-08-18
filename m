Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9944A3E3
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049532; cv=pass; b=QGYHKUmZREig265k+6J11cgnBq6wDjdNpK0PREDVP7iEYZMretSxX9mJZ4ypaXyGoRrJ5DaR1Uqoi3lW85Cb67yXdhOz+k7GqodPxCned67JKFsIVHEtAt+eG80TQlib7v3mMQgg5jI68Vd4bAnprE43/yje4nJbANGCLU87rOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049532; c=relaxed/simple;
	bh=1CVz3hAYow20HSm0tSRp1klLWOhMCBPnoNEKix6XrK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKaU8J3nEBf9eGsMfEOnFEpPaxOf5WJ5Qzg4d3QldqZ6tlW7/pJdTzP3H7sxUBFMR04PkEyeOLHdM/pMRDpowNBpO4eb5SCVoDtUN4bglO31emMa+yqZxipp0jm64x7OfXzbWIhJfRyQ+PY/FTYiVRAN2LntF4Buh/MpLpLPVq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQlYb4yM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPFLGCjg; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQlYb4yM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPFLGCjg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABMmI515012
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CVz3hAYow20HSm0tSRp1klLWOhMCBPnoNEKix6XrK4=; b=pQlYb4yMZzn2IJG0
	FJ2vUPGPjViQyPuidqkHk5M/yY0eyoZONKi89SME7C3wk69pxAsD6amheW8asxnK
	dIi8wJMGclibgRqDQCj/bLy8c/paBhLs43g6VCNOA7+1JqViI3kD9ojCPW7iV/NV
	tO0odnrWCyyYVSmWfIKvUnGo5PivxNw7kPJHT2dQZ4kFWiwCte6xBx3UR3HLPQvi
	ZA82tjIGtsjNgch+uj6TI963RYg07O3ZGVqlQOygkMwDsAi+Cim0KjFDELjrpAVb
	600Mv2gNim7xoKz+KmfX70hsRlAD0juVyFq5MbG8bNE9kod3SjScLB8cL0TBE/ej
	fnVD2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2j1mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:38:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa55c9430so46270075ad.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 03:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787049530; cv=none;
        d=google.com; s=arc-20260327;
        b=j71CFBwLNeZlucPwELJn/K7h80r10LHbvzOq+liM6e8oAQZKFb+8ny4K0mbDfUj0Lg
         yyq7mHechAaKv7/gBCPY+gCZqsR2uVNcmu3zx+9+RXVNOF/mD8Sk2lm68gYcDRQvzqkR
         J+Jdsr9PQ/rCNZirOa9XMUNlhvECbp0q9y2XDhjmwawHC8MVkSW0TXAetU1uhNgbxevj
         WdQAZnsaw837zIUE9L1ArZzO1rtViwP1ZC1Mm6ZAn3J/1vNuL69u7Nem2nUG/hZDKO08
         b5z5asNqu4oLhOUzLUR32hfJD0XXKxdndFUajuT3bXwFotUwRtZSDc4H1qM3pQmJUVl4
         EhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1CVz3hAYow20HSm0tSRp1klLWOhMCBPnoNEKix6XrK4=;
        fh=3nB9TCNDMDa36eh5/85ELJxL59+6739znbOfy9aR8R0=;
        b=k6oTn6y58y6AApPHEYiR8DGMQ/bYgM24Pfd+mXZfu3L8qS6DsqwtFEcyA/mOlYhwVS
         ZeJgO18U+t+orbAnVzt0Tvy7woFJuWYVtIxI4ky2bd8W14ySS++yIJ96DrS/VaW5RS/X
         g6aAhwck8Q5vB5k5B+dxzm6CWRlX5pnYMRH8nGXa5x7908goOqM0DUy9patKAWJGJ7XB
         11hfzrKItXfOZnD/rI1Qf+c0upllSJlOpvUCIhQhTXYW6QSYHs7Y8UUZxty2N1brddkF
         epqnqq6SpqDg9wwhIUy4d/S7kqA8C/DUH+/4gSSoCL00wUdjzilltLXcD74MgREm8kio
         wtnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787049530; x=1787654330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CVz3hAYow20HSm0tSRp1klLWOhMCBPnoNEKix6XrK4=;
        b=TPFLGCjgVpFHfqStK7oB/CgPb6MRHjgg8p02/3ZpufAQ1rvQoJQrhxcL6LNBuYSWvY
         wygnIKYTpZ5NwsQXXqVvbT5SuQMIvInpPnnzthQIO2t9Fd5SyhoICpFVKGkmEWpt5X9n
         0ZAlsEqyNTzb4nSDXyD/t0u33J7c6G5ck8CdIh3QAybpAtOkzK/jfUiO36PbE/rKQroW
         vXB4ABApY6Mo4xg8Zou6vTorkIj5uSkDqimeRR+MHTxWjB9t194F98Qbat1kmsXoiz5y
         PrGYcTEaz3OsxVowbtCMFxqg4mjq3WN+7o9OHq7QFJd+/8Hv0cfaJWouvdQjanh/QiCA
         y77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049530; x=1787654330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CVz3hAYow20HSm0tSRp1klLWOhMCBPnoNEKix6XrK4=;
        b=OnxQ95Ck0Xyuwq9OLY3zdyUnxuTa77bXyFGFmjtKmwspYCYiUpHUCcMjaiFsdhwSHF
         dfybJokFAVLkC+riDGVT48nJFWvwzt/eq6pc59gyv1IEDzhY/2RupS5IxeY13/mW4ctS
         m+1OulIsxFAJ57eFruaAbPQr5N8q27skZsohxMA1q19/ybJdvAXEGK7+jaT2CqTL4bAk
         GWdFUmc0cTPxM8KU+jxfD+An26mvz7upC2lWXVMp+saUEumdCSfjkt90AwZ0CtVDqJat
         A4gcz+yGQbVpb1pciTPgS5S3ZweR3kgDLtJsQcAKZTrtRGXYUUzIcXoYKVCLONLFg15C
         LGyw==
X-Forwarded-Encrypted: i=1; AHgh+RrpbAyQSXf02J+/V0gX2rgZ07iLddQ7lg/doTFdSRz/UOjriX3LEStYR/Wlg599qXmOphuiybiPag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CqUZTzXrBRRcoAaw6wmsZ6M442pbtMEflB66L31Sgd3GOd3n
	N69gzVzuy5BHwp4XOnXE0OClYU/sj1L+YVeJ1cP5JlEwe3PJqBqEAx7ldwXBsLex0OYsFhri8ct
	Z2/XYOnEHIYLZWjYQ4EsyA2oO9FYymAUgdv+y7+oNEO+jKlKjaY0jbW8QGbKfukfYn1+matkdYq
	upFXBAFoaOs5vjK4zDsZMwU1/nkfihO8qw8i4y
X-Gm-Gg: AR+sD10DaF+IthEC0NceDNNoI+bw3oZYWcum7QQho6BgasoqkMvw+vb4Zi5NWW4Irqn
	Odc+CtGxFW/12nXkOUTiC1Aj3NtI0nKjagWK50KgdYxcQIw1psmYcRzNolY42LqwEO6fbLxO5Bw
	3aOTh/t+TIBYUVxLsUFK9sz7XyHXBAdceXeo0VGRe1Q1VclADIfWIP+kyLIA==
X-Received: by 2002:a05:6a20:d48e:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3cc7196e77amr37620437637.1.1787049530198;
        Tue, 18 Aug 2026 03:38:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:d48e:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3cc7196e77amr37620360637.1.1787049529688; Tue, 18 Aug 2026
 03:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
 <CAPx+jO80r_QF-hqGuRV4BnHyKoub3+j3EPbnZ81ejz+wKBBQ+Q@mail.gmail.com> <pzfjctbfuqghiluu6w6wteihsx55xudursi2ifsqylqgc2jgux@b2rgwlctk2l5>
In-Reply-To: <pzfjctbfuqghiluu6w6wteihsx55xudursi2ifsqylqgc2jgux@b2rgwlctk2l5>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:38:38 +0200
X-Gm-Features: AcwNN1UXPll6Az6-ppDKFHeuBDQLmewrlzUPgiEzvE3myePAINc1EBBa49-RPa4
Message-ID: <CAPx+jO_1bierRx=+qErQD-J03jRbYeHsPD3NXkzMtqRj_zvKYQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
 domains for Eliza
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfXxu3lPK9sUqsC
 NoKBmruBGQ4kk1fndcix4vVq3Piolselj6Lw557Be1f+ADFwihaxMEdphQdUT/A+HZ0djDmb7ZF
 jDUQL8M5vUdXfQktTKWA72l2b8pv2skHvum1N5eF8m09diNY2wE/jOQQUz2AR2veU+OjyBMNebw
 OdikeGUBVTS3Xgv+6ZhjvRfOvFh/yvkRYHHSQqQm3sAlUUa3OrdUWRGCr3EQN2Tf/wilwfs3i1Q
 baTbMfgYRK3zXCcsqo99gMmnS5thm1bM+itU+1f/fjweY0l+qrq3j6WKfoLqMfYQkZPqmW0vfWS
 Sg5FoMPslMVncfuAG3lYFDHfAP+dDqX8M26adHMCa0BN5UmL3dMKMLp337K6+rVvZY0Xrum+0EH
 gwTfm/LPi2NKaVl3ialezYYdpu8og2CXVR3Rigk8UJB9z2P5vshJRYz1wfEd0pInnD8WlcwRKDk
 RIXLImaErMn2Dwg2TYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX3+t6kDsN1Jt8
 R1coWNyqh+Ekog0DnCDgSI/rWJiHq/bn/Gr2Lplu34c4bIlPenw2hp9TtN5EqtWlQzQPtSNelWx
 tyFkRRk2LQadmcmDzjDASwJmPnWwxg4=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a84363a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=ibMsrSw108UUvJ17cHEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: lS2jgp-pTfJ8laXLplkMoS0aJZq82wXb
X-Proofpoint-GUID: lS2jgp-pTfJ8laXLplkMoS0aJZq82wXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180078

On Tue, Aug 18, 2026 at 12:00=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.=
com> wrote:
>
> On 26-08-11 12:30:42, Ulf Hansson wrote:
> > On Mon, Aug 10, 2026 at 1:10=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualco=
mm.com> wrote:
> > >
> > > MXC and MMCX were initially omitted as they were believed to have no
> > > consumers, and they were not present downstream either.
> > >
> > > The Iris video codec requires these power domains, so add MXC and MMC=
X
> > > along with the MXC_AO and MMCX_AO.
> > >
> > > Fixes: f387ecdd492f ("pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Do=
mains")
> > > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> >
> > Applied for fixes and by adding a stable tag, thanks!
>
> So I think this one needs to be reverted after all.
>
> The MXC and MMCX are indeed available in the cmd-db, which has been the
> main source of information for this until recently. Also, Iris video
> codec bring-up engineer thought they were necessary. Meanwhile, after
> discussing off-list, it has been concluded that these are indeed not
> wired up in HW, therefore, even if they show up in cmd-db, they are not
> actually there. So I'll send a revert for this soon.
>
> Sorry about the whole mess.

No worries, please send a fix that we can queue as a fix and for
stable then, thanks!

Kind regards
Uffe
