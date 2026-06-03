Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D411405869
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481678; cv=pass; b=YPkbIGIQInobD+2UPkEWfDS/eJcQ8cjNu5eq3j/88NlQHibmQNIzLyx/60JtXe5eP5lSSqbgavDYINN/W3nA53k2e6cjJUv/ZZEir6HCaxYPPF6KobrgpYeL7l3NyiNAD/tBOgG1+2WQVb9ImC3rxHIXm5N8R5Pk44w2rhUJ5/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481678; c=relaxed/simple;
	bh=1IDDVycyuYiAT73daLM5xt6RQklHIkSdwBOUQrAETm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXIZim47cBAqAp4wHLJWJswfSocuuPnMCtku5U6hfy6WzIMTQDHJBEMKqkjH7hCP8l7K2+ir78PBAZGSUbbThX5KffWVuYg7dZJYX7Dy05d763OOYeUq9TmX2ryvr/jXBSZ/+AJOqBWmBNsk3rCEuhrVCVd0L24MNjts+vHmy4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqI1t6xh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a1xJnPhu; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqI1t6xh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a1xJnPhu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395r0w780730
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghCWI4MXSHnJlpFxIlCK4HFx0WZhMo7JQ6tx6m7dWpo=; b=pqI1t6xh57ry99Yi
	cThiawRQKNtYIeJAveL6wcu8o/yZCFQjfVPCD/qlQgzLSxoArBopaIrXVnopnnL4
	6qKw9+jMcOxxG2eWOWObJBh0dQl+R0lvz+GZ+YARVfTs8zE6srmC/ZAbalX2+b/g
	Z55a3X/j86C7J9uoMTRGNORlZ5uWRVh+zw1jJ3/lPr5qIKHHGLnh9BmdUEMkOCtD
	IPAvexghdEf/aU9EbLpOaYLHNM23wBvmUF5UuMSi+iJ14wpbzWAvQQllrUJwThOY
	+3SYv5KOht4hjNpyTW7gbugxnvW0Hho7PYPfJ2qqna/5h3gFHggTW9yv1qcoA46H
	5NtoBg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb09vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:14:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51776d4355cso12447501cf.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481675; cv=none;
        d=google.com; s=arc-20240605;
        b=NcN7g9v0La1/my3ui4vmzZkqz6HwhZCPlJhe1ktnB6xCXPgQxChFNrznd9OKiZmBjU
         5McwvQpfS7Vo4T5VmYnpEOMOklTFk1WpeV77ShuFiH5x+ZPwIfdk1YI57Lx2XpPJR8R3
         hG5q4cKh6XFiPlA9xNan94FAG1qB0y/pBE7rPYESiQ0+ZCfAOjt5IMw2nzAe115uy/RW
         ro2G/KP7tSl/DmVmrhlRHNjgRecRfKnWPhi72jMvB5zbmLzrWSvOIujB66+OjCqAhA+7
         WhJxxj59N7MzKYrSNNgGSXrmSCDZix6lkqcVko+Dxt3lOUbHDs+D/ueeoGZ/mvO3CKPT
         tNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ghCWI4MXSHnJlpFxIlCK4HFx0WZhMo7JQ6tx6m7dWpo=;
        fh=67OJSpUXV/3rl37HtUIHG8Bzs6sSN3x9d95fwJyGGXw=;
        b=RamVny7cCC9X9TeV+I5fBXBGg9ML65c0ircYEvbFHfc8SduELjOwleORLRQffYxA+/
         fXgVYZ7fa++fVZg/9TXQFCX2xbH0+xDr8oorJ74UjQK8Ei0iz2fGG8QHPv1N71W4kcUx
         R5LewMM1R0aGilqivyUNoIs7yZ/cq4EgrcoUrk1F77HHDTWBhyh7rhNVC9C59D7cWme0
         JIblJLHqVlXQXDAWMYthkJiN5USNjXcV+fBbouKrUbQT9PTTLYxBSBSwDbXqfOb+R6fY
         ttrPQFQUw3w3ciRq7Gf6x9y3XNPoQ21qy82iED+JNDPpxl2NTMHOr2oe4zcSNRPxIrQ6
         HU/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481675; x=1781086475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghCWI4MXSHnJlpFxIlCK4HFx0WZhMo7JQ6tx6m7dWpo=;
        b=a1xJnPhuKqcP17K7LMwgthiihn2V3unndKjcLjvYDVqyp523CDLAY47xfx76FgF3zT
         CB/Zc+Fog/vevNzoQk++KmU4GoTAbZ5lv7TwlThZnfZK/gA5iygrGMd60BC070oI5cyf
         nHlc7tOE7IRi8h3aJVNl+O2m/IVt+eSV6LOJpaOdyFJuTCKjkRMjHaL8Zg+ujVDKORQF
         4xZCKXkd8id6dIUvJ8+c/+Ya2Db4vfZ4/LWQCJtKqTlz9yUWD14pW4Wq1uKprRGXLS5c
         EEPVcPz70XFfdqsDr+LTsk96i+ZSxyWR9SIo45UzggTSBwRhQAM/PBvmzs9KqZrJCU9V
         BxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481675; x=1781086475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghCWI4MXSHnJlpFxIlCK4HFx0WZhMo7JQ6tx6m7dWpo=;
        b=eD3CWDiSgR0MhV8EFobuzP7vlwBQHiX4E7IpKuTXry09BFs4KGb0aIAIklTwxSyt/d
         nX58H0f6rbbnsVRxdbo1/KnKg0pJpPpoBAzwW0tFKHJVsOWhMQEVVQE8b9a96xXGprk8
         WOvelCSAE8ZQUhz0GrGEkT9nadfvTLvpefeGDYdtrYH+kgFtoOn0Zm8HBIOP5aBsAYia
         yFoegBwut5GyfR28KFvENWJunwLCdF8K0LHUe2TEoQsCX3O6Mwi7Op5wVJcli0Y8pZoZ
         V9pqdGcTjKXKlu7/uSYy14rlvEUwMnSyPdkmVrGk68BK47RFvSY3zN0izcBlYNqnXsp4
         MYdA==
X-Forwarded-Encrypted: i=1; AFNElJ8zbYarV0TCQJQTIXLYASx6nFe/X1UauIB/RbilKwVDhNkfPgxFXr3ODaki+DNWIa2K7WXojB3KvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/uxpoG8RAKVZ2wgElpCDsUOYDfH/9OWP5Xx6rynHuvv3r/rT
	FYU2XVUVeZULbolLx/czN3jFUa3h66Fl3XWHHQyBu1cdmv/o5EM2Uw6myAPciILS2NVos9DDKtf
	bLvRfPOlJd+Vf9PyDBMS0i19hEpz3oWj85VYhhm7Lbu2CBmAMsQAdcz7Ja6qdqT4P0RMZLN1tLx
	FelKd0g6caUR6vvaGubuEyVzXA0d0MM6jMb6z2
X-Gm-Gg: Acq92OF8wpqLgAZd9GmcWLGJcD51jBv/eIPDKHWoakYM8cFOK26IVOs4VYiMHkSdnG/
	TpcoWHQXoehTfUUpLuZrwMHUR7C0HxtzYC+5QvLRpG6LRk2pO4G+CvNZ1uU7FLuPvjtLmDTGUH3
	WzMnQs7bVqsEnmbY28+iVB0calPglUvxLvcZ17i/pkTNbOahLQNdVjDohKBYvTF+R3jtn4OkL5p
	YrVni8wKYKTqnpO
X-Received: by 2002:a05:622a:4b0f:b0:50d:ea1f:f99f with SMTP id d75a77b69052e-51779828a24mr25488121cf.31.1780481675458;
        Wed, 03 Jun 2026 03:14:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4b0f:b0:50d:ea1f:f99f with SMTP id
 d75a77b69052e-51779828a24mr25487271cf.31.1780481673950; Wed, 03 Jun 2026
 03:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422083341.84390-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260422083341.84390-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:14:22 +0200
X-Gm-Features: AVHnY4K9f5e64zUzf2cnhxXXE_-89SpPyP6r7QenYJF8MW9ObIsbNMowlyBMopY
Message-ID: <CAPx+jO-S-quvUj_mc5fTWwF9FiB8ZCed8eMj4hsAfhVp0kAJGA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: Unify user-visible "Qualcomm" name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ueODrDJXEQWAJEUOHEOuGBpP8bx66YwM
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a1ffe8b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=S_mEzXSMrObp8K1ydAIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ueODrDJXEQWAJEUOHEOuGBpP8bx66YwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX/7U4fjeHI5GZ
 MNqTBNVlUD2kH2yv9l6kxxll3n4pvNsUOBX04aBh34RMg8iW9EY7eZiExrU9Gn1lag12Db/qbYp
 9aOq05Dlzc6tl9mOsay5q+cfamdPFJ7rAgX9a0CVu1rO0XOcl3xged444nSSENt0Grnkpw8uXq0
 vK6DfOHDv2eZygUg7WwYyOl3weIwNS2HPD6zAoNNB92uSjhSLMw5z4qyIUFL9Qd0fQLMIHmdtQi
 8vC/jkKsQXrssGH74chsn+f+wPlJIXqWjOpKswKKw9K3PUYE1WtAH5f9HUvrV3bLd9c+a85lL3f
 4Q198ApHIS9xIDi32WRjDDZSuudEQx0AdvqQo+Aatuw1WmL1CQQczIFAp2bIrxXUdP9JglX9kD9
 DXXAfC3IEqMDTNcRgnvtRWnx0M3cadu/lxU0HtGx680CHjiw7ymE62quWnIjut/Nai3YC2BtYD3
 QdUBtDWVsEYDsXZqQOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Wed, Apr 22, 2026 at 10:33=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> And "Qualcomm Technologies" has even variations over the tree:
> Qualcomm Technologies
> Qualcomm Technologies Inc.
> Qualcomm Technologies, Inc.
>
> I am doing this tree wide:
> https://lore.kernel.org/all/?q=3Df%3Akrzysztof+s%3A%22Unify+user-visible%=
22+s%3AQualcomm
> ---
>  drivers/pmdomain/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfi=
g
> index 72cbcfe7a0c9..4abd43a88d08 100644
> --- a/drivers/pmdomain/qcom/Kconfig
> +++ b/drivers/pmdomain/qcom/Kconfig
> @@ -2,7 +2,7 @@
>  menu "Qualcomm PM Domains"
>
>  config QCOM_CPR
> -       tristate "QCOM Core Power Reduction (CPR) support"
> +       tristate "Qualcomm Core Power Reduction (CPR) support"
>         depends on (ARCH_QCOM || COMPILE_TEST) && HAS_IOMEM
>         select PM_OPP
>         select REGMAP
> --
> 2.51.0
