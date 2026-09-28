Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A84D489F
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603873; cv=pass; b=ow4KM2N+mKaCLj2OZDJsqudEXyjNXCFmn887FMykwlRU62dgjhRWy+ivyLLo4Hornk1VZ1eH9bNecpdwF8Fjg/yJb62I8e8j8gAkvR2fdvDcHPCqGIcm3cAiA8MKoEsdJHl8Yr3htE9eGqc6TblVN67cLwc+hHDFzVbWVZ8yXlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603873; c=relaxed/simple;
	bh=N0apPBi5a5rdeR6XkE9u3uUSLlm4uI9nB9Kynheh+l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9dEDmZ2ijC8Zu5WfaKo2v0EUhIQh3TEnSS9H4WgXMFWWrn05lsIH7845QgYMaub9AAu5j2kqw503xVkoGrzt6Dq8QJYGANztDeKpvgdO2dvAqhIwVy/LkgYHMebjNave1DCdBnoLDkS4EcnEAXaFCrhjtySMSmUm/kUMblj5bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4tRZgHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZm+5Tke; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4tRZgHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZm+5Tke"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAAPb1682774
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=; b=Z4tRZgHZskb8ptT5
	TWLgXlXd5ZEfOMXoSIMOXv3xiSCfmZPrN/BXEN2Jx/EI7xgxsl/mhtg23qiOqhBr
	lotZeIr931hrlSEd5cQ/+wfndIUB7MMIEPhy0N4qQaoL3vx0QDP3gKzGCBMkjA4K
	qZEViEARpzKBw/bZJdJ6k6fM60UXmpX36/eFY3dIVjAN/AFSwPSLBAOzinZyFOZG
	8mAxM8Svcg16uWsn2JDQlVfu7pS1jD7EKG1O73xL6IcpK9DHPvN80Fj2n8ZkDcIH
	gzgCPX/52m/fh2UgSttxIDJ4qB8q8S1LQf9euuiVEAdLjZcrqYl5RVZOicTCxXKu
	X1l8WA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkrykj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86ab8302b54so2399875b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603868; cv=none;
        d=google.com; s=arc-20260327;
        b=VXMPHPQRL8tDl/2RTpo4XcmfN2FbuzNH8yitzSs4AyymY0M8j3ubjRViuqnhpYY9+M
         GCB9SKatwLfJSkLbcqer3WIFUMClu8Xu8U94XgzYZ3ooBlVwEA7CWReNb36feWrl686s
         UFaU8Hti10Oo8Wu4S61+mi8S76QQ49XuHrTUTYssj+ckj3R9VGZmPrBAN1b/HYrOF/Cl
         HV9OP5IW+DkWLaZ/uznpzmFWNwKuBt2gEtligAXLA+S3YVu7TiHUUnHDsMc4/0tIoOV5
         AZa/icf138N/uIiC6Smuz3eCCaSiBsYXlBykxFmLm7nOwDr9/Yr8DUzIwJsQSFeW20V1
         m5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        fh=0vJNW4wH+FkC+FLf60ChYP06EZVdJsBaiAAK9z3xlgQ=;
        b=omtf1MoPxz+bSFn+AhtdnZrQrsnnN/q//B7Yng6ZQWuU0zAWbJK2fm9rhXHbLZPNdr
         eWhJFB5k5uZs39qpxdrce7JD0v1CL2rAdjKmJ4Qy7kcdHrpNkBfIVi41KjodcZfRBIak
         C/3/d8JXJF2YrI3qD4KwQ81MfhQMml1C6zYcMbWVo7XD5S6TqWeEvFP1UVhfyTrZZ2mY
         rKYywQSJVLOjhPcEnWb1XIRpVLd5J99597WA0bB6MThdifsr5taF3hJf+Lz0ltR4ldl9
         niGs2WGYvsS4tDjsVUW5nGwcyn4kLtTk5DeHD3f+uPFuI4YPD2iVn3vgc/dNz8JNvx4T
         j3wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790603868; x=1791208668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=gZm+5TkeNiuNCWoMFmByiGuXPWyeZfYVqr2uIkJNz73oKjT5kMP3a1/PLCH20oeLe0
         xcvk9SuiHU33LZ55Fbzpfxo1NFE/GBDg/vuoWelGhue22jmQ8AZDU0QRjzBVyuk62/HK
         pohM2L7obX8b66ghXXB9PSYRPQlEfxawvn88RDeEYywCxhFFV4rkCqwxuRdiC8P5I24e
         wA+SBuii5pGi4MhJHWIoXYSph59G0Q0iayJbv5z+vVNVBDBVkY21N9yu1IDSzYOFOi1j
         XrXt2aO9RGNzSTW5/ek7Wg9xq+o+xZaDAI6G3NrmZIDngCZvK9zlDMcXh3IiziXH73n2
         ybxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603868; x=1791208668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=T2DWF1lLCdVi1nzA/iHXnQZDmaGWcmFFTVaepRsKjvue0EkPXZY/lB3TLKh29DsraO
         zSEYw67ZygkypqPCqDQKjtopJ6hOze49UVT4CApvHDR9T+Q82FoMcwuaFd8tWyvJtPMN
         71GgSpnSvgjITzLun7RE+l+WCHi94ItRz453xVjRv7JIg5h2wCq9rgsTL5pBQ6+eUGc8
         y53n1dBWYt8CRAEyQKpOVcCSZ8rTj3nlqvi++XQxEj5h7gR/Cve8ieSLZhyXzZ/gfuss
         NS7baMFspmjlmCI7BqMbyvGnVxZ/CJSoJWtnK6yVvA1ISiZXxO5meIUGAmkf0JONYWeP
         M7WA==
X-Forwarded-Encrypted: i=1; AKwUvByzBVSKQRUpBaEASZ5tUJxeXyg4f93KY1z8D8CaP4USBQNOWffnLi1mZ+6M1HcEWQ73Mxei7XmyIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6fpKmD3X2ajQ3T2mjd90+KUw0xfsWIoqKHOt23jCbe5i0byiV
	kCxJ55C3uaqiZ104UcbTK+RNMo/PUVaY57RuE0FHeBXqqJ7AxU0qFb8RK/ik0q9RBVza6pL55VJ
	FL7H725B51c0+0R9SK8mwiatovS8au4u2/1gHi/7SabAWlQxC97g7BLHHKiWsMUkc6HioojycL5
	1EoNZan0gf7w0ep0dq1Mdj4Y7tCAMV7FDHIXtE
X-Gm-Gg: AYBFou2obfWuuj+YJM67LUHbsg/z6wD1JjXmsUqmhqbZR9q76X4gNMzgjAPjVSb0XIs
	Zos38nOF/bjFMQyLG5TdMj1dU26WeES2Z7IMQ2dV1agH5NJKfNpOiFsQJMCnHEM7hcc6oNzpPlG
	teQxwxsktlBgYS1sYKrVg1cV8fBytTqnweLyzSyQ7a4BB7WHwLX7bIiBSn8w==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-881c8819a45mr4006743b3a.23.1790603868154;
        Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006707b3a.23.1790603867726; Mon, 28 Sep 2026
 06:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:57:35 +0200
X-Gm-Features: AclHuK-nE9h16BssbY-0V-0Lcqrz78yNjoqqCVRnCD5BWpC1wzqbo2Hd-T05VXY
Message-ID: <CAPx+jO9Vj=42dHEwLzTHe1b+nrvip+ibVv4iPquxwJKbFAkm=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfXx+X8IX2mARM9
 NrW0YU0oeXtpJPZpN0Q4SLxGQ8S6DQvKakxNX9HXaXJssfAxrGbeuhOPnw5/Ftwypwyh1ggbg2P
 M55ZlFS2ygb2TJrFtqxjvuhthZuusKuMStXPGhUOHG0uYFNBkK40KQM04c1jisHjMR72EBus2to
 tSEfi0bMZQbidtmzvLAL5iyXcnjYCGvPYQSF9AF2j9VNoj7tXfYiP+QLMGohvXkoR43sHuHNhu0
 IUZwmQ2WZXeghuysryN0u3FClV9syQDGESn6qFx3xGYocDqqhVSnS5vKqYvOoM8Q7fackXJ+kDG
 /6sFKyZ4FQIDEBQX+kNa+3j8MvXXq7IiCGdHW7ELfK+Dtb+agyccIpMn5osm7wslMW7kiXaA/jq
 6vYzWiJ0Tl06B7qmIOuPFVSXPJR39QWJKfdbg76eJjhxjOGZ5Sg6oVB7w2PcFt1QMpUK3Ay27SX
 +jYxxmfcTsu11iI3RUg==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba725d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=xo1k5ONJVskqAlz3UKAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: kMkF46E0UFJp1WqW8roWatcsDQadzg1O
X-Proofpoint-ORIG-GUID: kMkF46E0UFJp1WqW8roWatcsDQadzg1O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfXzGEdEAvzKgh1
 aks8EVyJE0fftfiewbEUBwI5C67Lq/pFYgh6A4PaaxIJMLZUZ9TGdJOba6dbbUr1mBA+3/HVcwt
 ZqVPb6BcWiJovjjwxCNT3zYRazYsxNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280055

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible for the rpmpd found on MSM8952.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..8ee1c25a7c9d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -76,6 +76,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,msm8937-rpmpd
> +              - qcom,msm8952-rpmpd
>            - const: qcom,msm8917-rpmpd
>        - items:
>            - enum:
>
> --
> 2.55.0
>
>
