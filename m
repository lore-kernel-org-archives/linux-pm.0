Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CC43C7C5
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444259; cv=pass; b=cn+56D/B24YPAFPy8mRlCh3mNDw05khmtnSMqHF3EDbtO9wqw86ojL/ZORQHTbfwA3X0sPkyQmBrWlf4wthNmBZNbtI0ExDLVgv9Xxlbx6QNkT6F0ia0fKp9UB3cWVR/dl2nOH6gor6WvUmSgzuGPJhq7TSiXSLJzsnadHBz6u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444259; c=relaxed/simple;
	bh=5dJC5lLl7nj9N7EaLPnc6FIY6FRga+mf+WjyttUUkJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZjXId89Deg+nYwmKYMlVIOjS1lPyWCE8GAf2r+kKbj07b2ge1e1U58lwTyIwTPwXKTEPrZdNNIQIkl7iMa58sqhNJ9nd7KqQ6m/UP2UBX3J3D5G1UMgMeJzcSTMHEOWmnzlQH1DcB4rLqNF87IHvy93M7yYHrEACgEOkzE5GSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jyxmGWf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZlUfVTN7; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyxmGWf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZlUfVTN7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BALoXw3288821
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXWu/GrTSykJNOgzaotxL33AiVhilc2AYNz0X1SLNyo=; b=jyxmGWf1UnroC+GM
	nUl/4DhZfXSR+ExeIs8zCv/OBzsU8N08OgsmTYZGPKUZJK/sbp7aDr/G/WIyc+UM
	dh+iz2pNia3iCLy0cg53tGXH+43QzPP8CEp28hrfroVvLOJJHfRN7eoPRgm6fgL3
	gytt3wg1+cosRx35jLr87ZQ5Z2AKaAUv31Te/JQHQ6pAzb1fuE9pVUyqeEA/8C7a
	C9muxQmcD+jtgOgykNh89QnFxQzQvEpXDFLicUdMz+s/pm1YBcLOGytfWfMZJzGk
	Qd0q8BqiiJJ7YY50OcGfLYZLK5nnIFocpSU54sNje1OAohE9Lsa9qxAGzNwHhQn0
	ktTuZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwertje-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:30:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e1da97175so3982533b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444255; cv=none;
        d=google.com; s=arc-20260327;
        b=npWYmbzHscMfZQZNss88cXxaybpFvfKzwnJ/tpdXiejBQRHCovgAhxstb3J6JO8Trx
         zY4WaI2Sdss94eZK52+qkt80NrLSeV8kqxVzU60+qfGOnyghwi/LBMfymdc/LmcOMRKy
         FscnwxBmwQ0gUJlqQspmZmfwAaMxFeJXhj76XJya/tAJLH2MgoKp81/s6e79vMlcknUy
         fHTei8blzuKNo6tKCVeRTwpFyBJaNsWsRMDCl6/jLipGkhlr4LAOCQjqDl/DSmKBmSvv
         UgVV+Iqk8joCc5KMnuPpq3gtkI5THQ+mSygx9JON7ExLWysWlMHJFUFMTvedREQ00+cF
         bmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXWu/GrTSykJNOgzaotxL33AiVhilc2AYNz0X1SLNyo=;
        fh=7HZQF7BA2XN4M8vm41ZNINcGV+Q3Tb2D01174bSCfus=;
        b=oL7Q2UPlWGQjsQ1MYtHHf7ioCkKnrvqIGQpReCpJhluXFHaGQqGeUGbKCnHk0EPnYr
         OWbufTKPtSyewZzfhpyfsbXQVVC6HOFEtQ9CamJV+tOiMuCmTfVpgwM3dm5zS0XkOIKm
         ga5Vn0mRIob8xbfmXE1Gx2OY2KmkafuIXK5tYnWWi/meuHt/ENGN+1Rnsl+nu+Oitxfu
         qX62T8VOl2DcjBIt05xL2MCGusWpPk9vPidMBOwlad7vP1bjs6S6f4Gl2U6z8xo4R8Wg
         tji5ptObABGY2rfgKsWIF5DTybnjcvmxUOH1dyfLIsHUWKCz2MhYvfJh6UJOpamfmaIm
         q4pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786444255; x=1787049055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXWu/GrTSykJNOgzaotxL33AiVhilc2AYNz0X1SLNyo=;
        b=ZlUfVTN7topFK1Nfe+nKjV2M4ud0cUBBf0gGZafRKryH6XjG6LYw7pc66KUy9NfkcX
         dMUTKS+IQwSQ6A9YF4CLlrbcSO89SdLtIEG90p8Ttlbxxn7ig0IjSZ9yME0Zbg9DgT3M
         FXFeYtIiapjgmnv8w48oT7FHC5vQsZAgI+YeXTStfc8/oOVGXnq+nPYwGNGdL18brvfT
         BKBmVcgLA0KLQNmGAi1fSm1MSRsDf+uma4fgPPH2D3xO8NYMgBltQGO/YDgbAsWXnVyW
         UTFL/ns6BBpwxW00qk2s65rjVtUuRA6C+R1gig9JSNEZJBU79u20SSaC+Xa4luyxsX/v
         UnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444255; x=1787049055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXWu/GrTSykJNOgzaotxL33AiVhilc2AYNz0X1SLNyo=;
        b=HViIk+MxROyv4MeVEuQ+RO28q5mrDfkFc+iFxZgtPNrr3oFRFu49ssG8a1xU4y/am7
         qw5Lc2nxN5/f0/6MIgQ38FJK4ON6jRLTA3l80P6d0og/TJPH2geAR16+9rSn8wZSM7/k
         nzru+icwHtbn6slm7USP9xVDx6jQCi71Kh6L/uh1AlSlsEFOKxcttQXPpCs3kt08EsJo
         aIRUGu7uxDByTtmWj8Cqh2u9zHp04PlUc2IkvHuEjuYe8nYjH7LDl5UfyusqZAK4DSG+
         uPF7g6FST+ZErEdbu6TecQJIfoA62DMUeg5GHBItYq4U8tRSSyON6cdF9UicLvJg8IyJ
         EnBw==
X-Forwarded-Encrypted: i=1; AHgh+RpioRt13oqVTWbw0wZ8UAVX+n1qfGwNM4oFRIqGVAgdmMPI+Ltw1zz99Ef+v6QkDNcQa6d7m73zXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbN8P5bP187JcBJCoRoqkZT3arvHT1FGzCh8jJDJ/ApquyIpt
	L/xrfciWDE0frnGxu8MG3TUR6oj/HPoGM5gEbukR3k8Z1TuMbb/0558v+kz4vuuaUj74fDiyBOc
	6G+Ku8CEPfMxUyTKwrlYMBoWXaFpIzU42vt2eI/zrUlIG+M7D75RCEuIbpKTYBZZyOh5NHo9+zB
	82+u8yWc4nav1qhyCkvIpty0yUHfVn5wiCD/u4b+DH7+CL
X-Gm-Gg: AR+sD12bmRtbwOyZlZzIPYyt1ePDbAKlaKlO0fCLVKiKUaI5vPSDR/eWt0t6WCTU6BE
	FUgGz80PUqQjhdKeu18jMenVKw9bonJCYn+B+1nT6Nm9axqv4ijv1lc1Tp+ivSMqtsTEQpP5eTo
	tCoTelkzKxB5Bl/teikxawKZXjwWDCB+HRSA7tLeYesM4fo+gbdKHxJcrc1g==
X-Received: by 2002:a05:6a00:9283:b0:847:8971:87de with SMTP id d2e1a72fcca58-84fa88425a4mr1764014b3a.28.1786444254406;
        Tue, 11 Aug 2026 03:30:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:9283:b0:847:8971:87de with SMTP id
 d2e1a72fcca58-84fa88425a4mr1763944b3a.28.1786444253587; Tue, 11 Aug 2026
 03:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
In-Reply-To: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 12:30:42 +0200
X-Gm-Features: AUfX_mwU4bxPLY6qXeuFq8BJo4JUTXUdkjrsGSNnAvO-_gRbiBggvLao-DbwLXY
Message-ID: <CAPx+jO80r_QF-hqGuRV4BnHyKoub3+j3EPbnZ81ejz+wKBBQ+Q@mail.gmail.com>
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
X-Proofpoint-GUID: MlWS0mI7JxSVtHcsivZcla1qvfuOUHx4
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7af9df cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=yp59m6hDsgm-mfU0uHUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: MlWS0mI7JxSVtHcsivZcla1qvfuOUHx4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NiBTYWx0ZWRfX/FObZSq0pwqE
 Wus10zXYXsk6GnZ7Wx4nmD0ibibplDbNkfVNeICs2zpLNsnZw9i6Z0Sbyr8s+2tpADzN5kD2OAi
 fjouLJBHydLKQ31Qax62IhWXn4EREkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NiBTYWx0ZWRfX71xiWh49imze
 ELIqvkfvspWRMtJff7cSn5ZbYTG7ng8nHnf4go4l+zpP+L3tzlXvHA4xihaEUJ0atYvHun7Sfb4
 Sd+zlIvbnK8srDwMxEq3Sr0wQFdl+dLb0hdxxfsbK+WfzAuod/9AIjNDzcsw6PLm3bgG6NKOOV9
 aw3mZz/RyqHvyq4MUnOCn3DiZCCBJQR5hi08Vvto3NOofTYd40zziAh2xVFirgFXLEqgPnrcmzM
 LY60VfnNq/u/VJDRNoL3Ps+BunipMHvcF4G5BrcaFZsWr+/6wXN5tiiATTsDIQJhxO1OeAFENyJ
 O4QSU60KHda47ko6PCMT0FVKdCq9wXugVqCNMJRCsio6ePmbs3yAbcO/bYor5FxVFcqj2TNmAOg
 PuiHBgT9Ce+qx5LTMZ1cuom3rIcow4fbSF836YbhMFqqLUaYETkWTljG8Y3TrhEIFZcBuXJInMF
 ijU1yIlTcQVLLPFj1eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110086

On Mon, Aug 10, 2026 at 1:10=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> MXC and MMCX were initially omitted as they were believed to have no
> consumers, and they were not present downstream either.
>
> The Iris video codec requires these power domains, so add MXC and MMCX
> along with the MXC_AO and MMCX_AO.
>
> Fixes: f387ecdd492f ("pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domain=
s")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index 90743275942d..96e4bd2f5a14 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -241,9 +241,13 @@ static struct rpmhpd *eliza_rpmhpds[] =3D {
>         [RPMHPD_GFX] =3D &gfx,
>         [RPMHPD_LCX] =3D &lcx,
>         [RPMHPD_LMX] =3D &lmx,
> +       [RPMHPD_MMCX] =3D &mmcx,
> +       [RPMHPD_MMCX_AO] =3D &mmcx_ao,
>         [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
> +       [RPMHPD_MXC] =3D &mxc,
> +       [RPMHPD_MXC_AO] =3D &mxc_ao,
>         [RPMHPD_NSP] =3D &nsp,
>  };
>
>
> ---
> base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
> change-id: 20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-6fcb519048e5
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>
