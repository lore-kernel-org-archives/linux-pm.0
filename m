Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F752BE32
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688870; cv=pass; b=ReHd3olUtDDNEgDQyqi3bm7BjpQ99KaEYnYc7PDdWhdlwJWvJVRiab288GCM+V7mZvzCfD83M81Ui8Dg7AXnS9ByvzLaotLBm4Dd0NABQcnTIdqLqGOG+mO6KlP+H6O2EAn7Z5Tgswz8ER2X4IigssPdNPuIqndkObm9NsEfTYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688870; c=relaxed/simple;
	bh=aatIQCpb5b6E18tOT607YiK+lREgF4JTQbKPFrO+iVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbOkNIt7FBGfRbNW8SkHfCyv3XqeBHa0+J+x2nURHupgY9qEWskuOYDcB9v4FbzH0vMpQ1m2SA+vf6FtFvtFiSN5/x+5+qnRjkiwafEL8RNxgu/V7M1UvvToYly9/npbYi47HwRNVzn+SdWknMTbUFdnuJU2U5l2/yt46OCDZAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hk6mvLlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MnW5UteW; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk6mvLlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnW5UteW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqdrG1576994
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=; b=hk6mvLlVWv66MepN
	iXjqUBQgGPOer5qnBJte12x4wjPvxOCEYL7J06CYjn0EHwKp/mQIZhzGf/7PTCrr
	JPVMRa5P31yNjd0syZbjgMb1SqSQl0EhM88wLqYun1EFTHMdFhjcUQaYctLQJvLB
	m8rrLNP8N82Uo9R+rz0dot2NO2Ag+BRrRZy3QHNaATzsOSBlDlmyQoF67xxVYAwr
	6AvhbgJpiztMCqAaEVjfmc1yrAp8Qnex8FnEzTZH2Oi00Q9D6r5JmaAxiFebRClG
	r3l0ApPic+NoNoV0+qGAVh5h3Rn6Nx3BILxnO83SaAFd/J++STdI9TWC1odBWbQy
	41skTw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4s89f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4907874a91.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688867; cv=none;
        d=google.com; s=arc-20260327;
        b=kBhS0b8xyNjbPpY19LYFE3eIOadoerx/QiD99+tLHKI4V4to1AiM05P0m0Zk72SI3u
         NkAy+KxutHNj+MlHU+Xc2/ibiTkneUyrI4OWyVCfLXEqa++j+yGfGXU7xePVX7/JOO/j
         fQE3Tu9r3WT7mLf1VE1H/ipYzwsNOtaWjHA3+lREePUJ5M3WKZfJNyenwkI4qlVZmT/g
         wHBgPHofszBb2ZzZzgwQ49Z+CYHSP2Z82js21WPFG+UVT69UaOEOgSbcEeia1oOsmH/N
         C4aNqvgAGCQdNpomnT/h/l1KQIHwFomkfRy8CiFpns3G7Fj4ZvDfzj+Vc2ins5spgBrh
         KOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        fh=zqq7hR+kWRfwZPhdKMcDswBNZTqAqHwmfSaLaK3Kbks=;
        b=Na7HSMhF2PLjFBbzcer1QY58OcEX9aSN+aC2EzoYTmz7ErIARceK2g1sczbmO3FP4v
         ZgS1WktllNrzcihOwTGeGBn1nPWHcxaiXbBgxGhyOwz3C9CmXPH3q6Bs3vK0H5pLkRnn
         VKbkQy3wEkqLvf2vfZI7m125qmK/F8RnMa5jmbDhs2CxSMgctaZNOYwilaaI6VpWIoCP
         a8pMMd1ppjE9zlv3ef4DsGLCPwNIvcOhTNffzTi2dU0LpJ913JjE17h5SCufmS3NWSNs
         svKP6yli5rEtXHQ8GDJ1/pfZysm6Yt+axgUuDkrgMEuDJb0jnyoFeZL2SgdRpAxnfal6
         IYUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688867; x=1791293667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=MnW5UteW5tCkE0domqFe0WMEddVoAo24BrHbfCGicKqHJ7zswfoA07vSpvD8NfqOnE
         fF8ELmym2xBwXyl8/OfGKwGsoqqQxQokZj3gd+Dq32ZPO3DRhsUh73z2LfN2tdHpGy/H
         EPBeds6ekZJPCl8GDtF9YdK/apasEgcCZd5m+U8eKxUnzX94w6I8HytVWl5AvvjGs3zR
         DpK+qksSdODDf/RHW+WZU/BkBWAdIHCAI/QR4tzPiMQzi530jEw/yRRLhlCn3CDzzxlv
         lqWsAjIxiU5+U2yWw0xsJgp1V2E0KCF+z32vgJSxHnU3S1tTCcTS6PAXS2gHKiJQLrhb
         2M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688867; x=1791293667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=cmJ/CJZw/qwWkEd6ydO8qHePjezVHbBioxoZE4+5TJRoJKj2+Ncj4xU7ee0NWB2tmN
         wsC3+B3B98LhyBL7Q2VjuOazS6YsMyqhDzwyVG1vLybY7vfRq3cWN9s4MOAt+f+sVu/m
         PgNDjo1NRasOMw//ubb5uonQ1Hbaj8kpMmfeOLrepzHLXYq2ocYWOFSyUw2jmRa0ZaX1
         MTwNECIca0o7u0D0kLb1cJUW4jJrUFyFX2dQPse2pSIKn8TOwwDUdEY3r9jrk9Vw/Hcw
         hYa5aT/GYiRWNQYzJHAHUnMNZPyDqA0l5mdmr7uSuZmmxE/rBwFIvFUOs61F25Zez1cV
         ITvw==
X-Forwarded-Encrypted: i=1; AKwUvBxo3tzj7mrkZZsOQJkFKhoSQwnC27rgu+zuU6w2ecC6uuMA8RZbsY2qZSiw/ESZwtalq58rUMpwdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1gnodYYxq4PZopWd/GG85O5jhCZYN7VGG42TBYFvWcXihBGpl
	yeV8xZKpiEmLwo1OddCV98vPaTaFKtbsPTW4x49NrT2USUr228uMZypaUOtfHApdp9kjRbYKkVd
	l1ifnOr0tbCfDMyc0DomQdn7aYvo9bxyGHyuX60tc81ABjiZbL4o2XtCpe1CM9uy81UKa3o26LF
	3ek8I1TsXfNuZo5G2cpU5qFaACnA70ElWP6s69
X-Gm-Gg: AYBFou1PClJkCUuVwvQ6Y+YjPncgTLOeUmj94rQDLphEeCUfT5aX14Gt08IFfhwm8Ip
	wA1uJv/m6tcpYXxUfQgV71+h9/l088iwqo7FY3CMoxJ8F73FSum+/SXhh1h2wzu8e2pNDxpr3j2
	2cQyEDK4ll4txw5Imo2Bm47litnl1r7jaLZFNhj9PE2RDJnskBo8U9ZMrAgQ==
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0bb60e74cmr11071536a91.39.1790688867359;
        Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071507a91.39.1790688866886; Tue, 29 Sep 2026
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:16 +0200
X-Gm-Features: AclHuK_IsoMVZ8jA--KFIskLK5LDOvw3Q0lyiLyhAEn2l6B1awM5w3Hl8Ax8gbg
Message-ID: <CAPx+jO9qPRgae_VqWrGQ8bhDOHBf+zDzw3A-BxCMa25XfPaa7Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
To: muzafferkadir@mainlining.org
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
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX+kVsRdQ4sHbn
 pWazMYzDqESdY/zz2ZSZX4VlYOZ4iNz4AKUrkLimS9s4vs8aWjOLEw7FmohoT3Eew28ScFYA5yR
 4V4KrX663Nkevq4qWHVeT+dTxN4Eb08=
X-Proofpoint-GUID: _hoAbdTn0-98xA1bir2UbYfdGFoGmb-f
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbbe64 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=wO7LUizMVtHDz2nkp9wA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: _hoAbdTn0-98xA1bir2UbYfdGFoGmb-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX0Kr4lUOs9XKa
 7B8vnE3nLtyxQKpDEqi8verbSfsZPlsv3nlyKLfL/NLqFXpFqwWvifEKZzmamMBJQTvtYpdxi70
 7njFno16EXDyO2jF3WA6ctKsPD4cWo2uCOufxfRmA6tLX1gDZGy4xm1hTIxIDUBk3zDgOk+i7dN
 zZMuhO+9EmqtXXfar/emYyGgo30PrpY4+bHzEuWqfIKoSy0QWXqurhFwhgJ0nU+L9tRAJM1rqMD
 hA4jNo9S/slyIuHDnsL4rgeHHv5d4fdi/0RtzUDGcqic+BTEpg7FupQqwZBZYFq9oMolM5iAEEQ
 h1OLfayGIZyfycvzonZTWqkgWb3GJwWBggXFF9+WX+XgC8w0HIlgXdXISd9X6HANuJGyXJmWhSl
 tcbiiZqheDjh75zX2wA6f21XUnwCQt1lkqWMlIvPADB7PzTBTgGTriE2+D9lDQyd2XQS0j6pQdr
 Z3UqOsAFmLCqs+q7Ysg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 69bd44e65ad7..9d4409c958fa 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,ipq4019-sdhci
>                - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
> +              - qcom,msm8952-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
>                - qcom,msm8976-sdhci
>
> --
> 2.55.0
>
>
