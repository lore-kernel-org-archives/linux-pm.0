Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD643C0604
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276803; cv=pass; b=n3IaSF7zTNH4NMMLnzTbzqkODL1Rx81/r9LjNAh5dkCPrGtZMubMmbtmVa2WlYAdAzqp5yr7yv9U5TOIWSdObrg0JWCq+rQnwNp0MCxLC0n4Ki34w4OZyNO/tbpJ4JTUA9xfR3HzKKw8ifxLXrLnGsJDbhAuc6XYpVKSnqN6N0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276803; c=relaxed/simple;
	bh=VLcjVIGQA/r1W3ldFK6WW8apuDX6mf7txYWwobfyjFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ1jxQtgmHKy2PiTj6AJsiV6QKzAX7r7i3xVL8CFqaNRvKwMobH6Sk0msHe2f5uCTwbCpx8cKSSVyVMWtM0KfYnyoPq4Z69pGiAJIkijY+v/Y1fJZ05ajOyT/pveiKePVeJ4PykTiP9Wod5rQQZGRTAgOO5P3XVMkMUQvL/OqEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N11QSB1z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qkr4eG01; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N11QSB1z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qkr4eG01"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966gsCT1046211
	for <linux-pm@vger.kernel.org>; Tue, 6 Oct 2026 08:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QQGtjGd8ssqWuv/V61Y20ONf
	ksGn+OprzCvB7AXUQWs=; b=N11QSB1zHyJJcjTIZFpax126Tk7PweRduHBLIQfr
	9WI/6tPVU6/1Sq7jSIhD7iJncx2dewrhweyDOeUxV7rS7YUMXPT4CrkLbzD5QgzM
	2q+RyDEN71+5KHHvSjS5clpUzoAVcBcq//y305l50RsWDd6KAR//l+rjuKWZCW2+
	wipkInHf7SGEizuN4h6jeybHNmEW2SJIBirz46aStIzpgr6hKBd8oLIihZDzjNR7
	sb8BuFtQnbettKsV3vvYdZC4V6ZTrDJylyo07DXmfIVN3D37HZ2g3ECCIl7F5JQn
	rUollOwbyfQoRHPqdxD6SfvQavDSjhPpLiyRB6m2GiM92g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4uy4geq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 08:53:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e4ade8670dso36274705ad.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 01:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791276800; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHn/ODir6OuGcERLsZv0lP36GHR/GuRcTxx2DpdfwE6NffTbkyoqkwqXvz3Q7twOVe
         Be2/gg9XNiR7dm4KSBYcQK567j+3ItX51E0GhWgiTrmkuZTtCnGVkFpgH/L33ougLxCx
         IuJeVD2pHjwbCBnunf9Spu53FpIFkGCBM6zzWiDc2ShCIVwgyxmiUsn+1lweqCSq+K4q
         Yd0k6Vtr7GAEpOFtt6PULh7+Kg/o6xlGH3VzUqv8FkE1vP5CLxij/h1RaHEPXYS4pZH0
         gJTTqwGu2h0lKug6FPk2wCyWltaq6y7smttodv0JjgmOwzUAyEcre6quluDv8hj9UUDb
         UvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        fh=P+YUbvkPZ3jdS5X+Sbul+oUZrXUJBco/DAgclBdGL4k=;
        b=l+2aGkLti6irvikKUrBScfgm6eUq2VL2yd6M656ngA6eKAcceT5NfgRujxadiJWWDE
         Gog8Z072Ttv42QQ3mrcOiNhK+N6gsQuskE8Ift/TUgU4j7GSlN/QVBSVDxnkXcyR4aH0
         dBjKPOCsqESEF/TjIyX8yE8U7CiUsw9CNEBn2cGH2I7KQ1nqYntpqLybYbJbd96LgAjV
         JG+iyPrW5W22aXhd2F6kOfr0XipgFJYG6C1IxAmLeX/IWAOV28rGKoeHZ9k+jYkuOC1Z
         mCUm9jtWNVVh4aR05PXtc0h21l6B5yiTdgiImmFQMzDuDz6ylnWKg8uNHh91pW5hkmyy
         xcOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791276800; x=1791881600; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=Qkr4eG01L0SgWYMfOLboetbicjTMNFGSU7JPC2tjjTaCTQMktFXJluk6fDheGWWXkF
         6d7cPrJtLG8mTpQnuLYzCxPGblvN/bkY9KTDYnZzUvxRxa6rkoT2L+M2QRgorfM1Fn9m
         VhvqpAfx6GhmBQQCXL0Mwo7WTzdU9CILnTAPSY3yJ3/Uuuzn0yNInynG8huoeQWGxFP2
         SZIZMZh675alBPyodQFoDSKuEbBKqkKMgyjvG8EwgP2dCzYd2bHvnMW+I6D5poG2v4v1
         IuShUpDIMjX/35RcLteyA8vlZYqS331kQ5XLwO+5kQwtjhAX0wyr5KrEAupSG+HMskif
         X2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791276800; x=1791881600;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=jab1bdxtxllhArQCTPj/Vpcu1HbWz3A0pQ2tztYM8geUl1AcZuw82nffuVC4loGQvF
         vVs8bi9bm1tLpWJOBeaNm7JD/BxMa5QMcEESEhhwacfoK+o4O0WtzX9u0ynZERVa0Q4j
         8ZEY2SlTaOl/qAu6YDyHhiYZXTk49yYjdeJmeGgHpWC1As2fUesc0I9ceT9wlr0J3bH5
         XUlMwtIdWxX/P00Pveu95ja5QS9E1hqdG1afPpBIzR8k/9Asb/KXj/GL/ViSxHcdWH/B
         lBG2i+YISy6VswCrJMvMXTI0luyc5dvuPUZroWwklwCPorYWxmhUMHW5fUzP45bBHeIv
         u92A==
X-Forwarded-Encrypted: i=1; AKwUvBwTHtxzedRHzu8c1UETAWACQcHGHt5M7vS6hKzpzWhZ+3NNVQa28rNwkfej1pfvmnay4mVyzLmZCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLzcazI3e6bEWik7RFe/AXUeEKWYR8HKRTkH/P3CXi5arFgJ8P0
	IVSjl2k9ycPMlZ8HUakP7WquujiJvzNaB+41OMkLr/ubCMHd2PHDMGIj2Xe8gWc0KtSlYE3pWIf
	Df3zn/VQJEgF5ZzwMTCfjbQs9IPole+u1Ye02UqJf2wCrB+Ec5MOFmS4NbRN3FJALZxaGqqk7j4
	cuXLbGO+vaMqFsx8pf2Kke6qlKMQpXYNRSFGAX
X-Gm-Gg: AYBFou3Up4YuH9M1Jo3bHVXnZrCIsXkDY9HkaNYihPv3gvXAXpCfURHXfKYJPz7eP6h
	2gstP5YtRXz9XjkXt27DbP71/ayRUEIzUCvEt9z2xYrQA+sOECo0hNaRyTwCby9jqRLij85+lbS
	2jPIG7f4+MS2DuDeQ51otgAoKHlkoj0lOfFvabBx6kIkarNzilH5p4DJAAkZRzhi/Pf70skzI4a
	+P9Pv7keMMImU4=
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id d9443c01a7336-2e5dcde4da4mr6597355ad.55.1791276799662;
        Tue, 06 Oct 2026 01:53:19 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id
 d9443c01a7336-2e5dcde4da4mr6596685ad.55.1791276799127; Tue, 06 Oct 2026
 01:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <179098834078.3641559.798772743228949994.b4-ty@b4> <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
In-Reply-To: <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:53:07 +0200
X-Gm-Features: AclHuK-hxeLXCCkrwwvQbFIYUVeIjRX4eEFvyGsggP4ez254hGL6BWI-C4KAx08
Message-ID: <CAO9ioeVAf2GgS+wu9GiQ3kM-_1KnrdMfhcpVotxhiFegEiZP2A@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
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
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX1qCx4sZVwyxf
 9pJY3d0xeaJnXTWkf0uv+WT7bELeIwxIRrO4uJih/fOHWGyTU9m1wQSf+prWhSzCSB7x8FRZF4E
 iV2MZrqeMAGq+ENp+E7B+omjtRs0gJgnJyw4zKMXNMNDRysX+qbNXIoVWdu8ylBnk3dLVp8Cqc0
 CXAoFKgm30IAhVDfVtaCfZFeHv0SXj7LmiLBFWps2viRi4CrC2auEFFWDASeRUw+r9ChF1WMAYY
 gJDmAk32B7qgJE3frYM8Gnt8yL/9coD0qQiRsMKkh/z56bsCxCJ6FaRrayUyo7R0Kk+22pejpcW
 A5KasYKZOZ/QOB5mpO1VcZMyA7JH45qiyeQ6at6ZKCfTjjKddgnmVfDrIHTfFNeo1p4L5DP4oyR
 wMLcBW842kd/ya+mevYEf7F22j00Uo/jtlj6vESgvSoW1s6kw16gHlnd0HH+jTmf8l1rYBQCWcU
 35M01j+JDxtUCTvu3/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfXx2de+2OTPcts
 HOw8WAyBacujUwxQkxPne+xdaHAnBSX2TT6sbsOLg34TVI8MV+azsYI7HOnWq8NzN5QiYjMmIYw
 JJrC77x+2XdCkH2KSRVS22Cu4bWA9ZA=
X-Authority-Analysis: v=2.4 cv=F97C5ahN c=1 sm=1 tr=0 ts=6ac4b700 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=OuZLqq7tAAAA:8
 a=wG-LvS21qxlCLh7KYX8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: nvQMHdIvjcZs7Jd0WaMA0xZN4KT8cANn
X-Proofpoint-GUID: nvQMHdIvjcZs7Jd0WaMA0xZN4KT8cANn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060035

On Mon, 5 Oct 2026 at 16:00, Muzaffer Kadir
<muzafferkadir@mainlining.org> wrote:
>
> On Sat,  3 Oct 2026 03:46:52 +0300, Dmitry Baryshkov wrote:
> > On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
> >> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> >>
> >> Ported without uart connection. ramoops and usb
> >> mainly used to debug.
> >> USB is not enabled in this series because it
> >> depends on the not yet upstreamed (and not developed by me)
> >> pmi8950_smbcharger.
> >>
> >> [...]
> >
> > Applied to ttt, thanks!
> >
> > [01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
> >         (no commit info)
> > [02/19] clk: qcom: Add global clock controller driver for MSM8952
> >         (no commit info)
> > [03/19] dt-bindings: nvmem: Add compatible for MSM8952
> >         (no commit info)
> > [04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
> >         (no commit info)
> > [05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
> >         (no commit info)
> > [06/19] dt-bindings: vendor-prefixes: Add General Mobile
> >         (no commit info)
> > [07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
> >         (no commit info)
> > [08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
> >         (no commit info)
> > [09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
> >         (no commit info)
> > [10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
> > [11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
> >         (no commit info)
> > [12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
> >         (no commit info)
> > [13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
> > [14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
> >         (no commit info)
> > [15/19] dt-bindings: thermal: tsens: Add MSM8952
> >         (no commit info)
> > [16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
> >         (no commit info)
> > [17/19] arm64: dts: qcom: Add initial support for MSM8952
> >         (no commit info)
> > [18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
> >         (no commit info)
> > [19/19] arm64: dts: qcom: generalmobile-shamrock: new device
> >         (no commit info)
>
> Hi Dmitry,
>
> Thanks for accepting MDP5 patches.
>
> The message lists all 19 patches, but only 10 and 13 have commit
> links, the rest say "(no commit info)". Does this mean the whole
> series was applied, or only the MDP5 ones?

Only MDP5 ones.

>
> Best regards,
> Muzaffer Kadir
>


-- 
With best wishes
Dmitry
