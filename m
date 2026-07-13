Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07D382387
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940785; cv=pass; b=gOWNK49pZWsandaFXadaCPq/z0As0Iukvda0BIQUjnLnFXe409boALGfBocv8PV27k/79YJ/GeSM/d8TcdOvxYR+k0x5PNaUKYuwYEW4JxVOVtKzV6DhzzlQquaNJPtdefhIw3EoqTfHbaMSHzt7omFp6iEMqsH0jhk1W9t/0Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940785; c=relaxed/simple;
	bh=sI88CLDGwWuLo2vHkcEpUE+bX3EFHUFXza+GIHzjOEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKtnJ9J07RYGx7IxcuomI1CuRihXljl44oD8ctqAg6rWTDJp6dlSG33BU0Xo5yOGfVB0QNnybR2UeTHuddwz+RBHYZtGJZAugIE3ThfFF7IzGbzaUH0e5DF98tKheXc0WwiMMaeArUa+JUUhFzosS8jbW0pk4x6JEi6iiixw4M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+gPTAlh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M37C/OE6; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+gPTAlh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M37C/OE6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9MC7h1090728
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80U/u6M5Yt6MJmBPkEYyvS5rDUhvm7mS2yGSTVzGn5c=; b=P+gPTAlheUScbQBB
	bUY6yAoBV5NeeLwuHAojtVABBUwXQ5FvsmDzR0jYBGfZs1xGG+a1qhEMviOrhJFX
	63tFchkgcS9PhfusR0BkdodSE+IEl0gKJpIGpFgORl2Ca02IxvV0ww3/SW0KKau2
	U7xBeFdqcZVY2q1ZwUwA0zhi2Fxb82Iw2JwQiSFZBdRfu66UV4j0o2u38QtmcsY1
	AihknM1sm2GJbdYQ6UBGE+Cbt/IkiSUgY01DCJh+3qNIDuOMTD7YLyxVEtgLvaV5
	wZqr5CyKOUPDz2+oXNIdti2wWyIxRM+nwH8Mz7phE4gSlx3aRSVysBm99QLXAxZl
	BRowmA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrc1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f45dde7595so38310376d6.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940782; cv=none;
        d=google.com; s=arc-20260327;
        b=Odg1m10xJX11B2Sh3/QG+1Y4mwudA1sEfA4jJI2TrdweuGOXl2B8b2tNFaw0gX62UE
         0FLWwXEUHYd0jpn2v+ZpXkCI1Sw1V4D4/fVDbBiTM7q8LcsU8DeC9TyTU5b+9zmHieG4
         wPEf49lrj8bXzbFOwmTvhyufaR9T2U0XdU+SLiSWSgad+n8PyNogbGZHKU8bT6QlxycQ
         PVUyqsybhWfR8W0RTRFIa3fRU7otp+qqNHwVtpQ7ldpja+RFUG8EmKlc0D56bhuh5b7X
         QhcQhar2VE3J/+FoDabFRE6N2jvrY1bH1OMDMWeSeiaaMMvq7wR33OYHSvmN+H5K1Saq
         dGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80U/u6M5Yt6MJmBPkEYyvS5rDUhvm7mS2yGSTVzGn5c=;
        fh=dkGmRpkn37rv86cuCcCiZtsY28kd29kQLPyneNSiylc=;
        b=Ldn6T36EU3/ZJst6rzIMEVditi95Xdaay5TzBO3vLdfSDqsfyqXIvTqlUfqjyXc1PX
         sBbFGVg8O7khzBl945Unqa5AJXtXWe0Kq78oLbf42IL6yu72k0ZX0m7hWCEXxbOVkNLN
         24N5l2Jz9j0Z56rxPH1UHKOewk39Fux8aTej76x6UeGP2zp0nrPQMuHSyGYQ0xO8sJAe
         F15yb/U2wOcdKEHlCsgw8e/zuWuZMQIC4oMLdX5eyIl0BfDWUev5NZW0DsBIkZpB+qO/
         0mzMuBGx29oQBQ6Eo2Dq7b9hL4eyChiUjSTk2mNpuVV5cvmT77iJ+BlAfnUv4SYhyXu2
         w88Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940782; x=1784545582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80U/u6M5Yt6MJmBPkEYyvS5rDUhvm7mS2yGSTVzGn5c=;
        b=M37C/OE6QVACpDSXbRXFZNMKZEmiShiwZHiAnhUKL6FDjRIFWiMHklDoixgWCeDJt4
         P0/pH7WZYsT2s8HWsn0Icf/scGlcxqIJOIiWofR0oXADwP0a4dhgqvauWCB6W47MafZE
         9SOMTnn3d6o56jRRYdS4WaEDLU1PD1MEZ9KAtX5McTWYJA15rfHW1OFzUunsnADL5DNS
         Kqb9o/VT2qtPCFWteOQ5dfHWff5MDo7lZm8GzM94JLG+5r4iAF/DbNFmBglmJEZCYiwT
         qFRhGxnfh6m6bGrswRBREcZflnIhhiep7/bq4xTRKLnudAMdZERcEUbo9lHvEE8g4QTS
         O2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940782; x=1784545582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80U/u6M5Yt6MJmBPkEYyvS5rDUhvm7mS2yGSTVzGn5c=;
        b=YTl8IwMbU5dzRtOtFdb5x+UmA02OGoYzFBACXQHuMT/FHkP4yCaGIMVUxYCmx7W/a+
         /yT8lVWsPLusm13Qc8cknoAf6hiYLjrZDrk7z/E4itj7FduXs9JcqKz2caJ3iRW5UQBH
         AvL8W5DB84QR30Nl4xPwSNTduGGQwVC+krhn79PMvIiAs4Qt7i391SCm+mE+JxGKqcj1
         +cYJcA3g9gBPFz57nae8Izsm39+J/+aVBaNfZI9eXotGHhci/mKSUOl07iW4zhSF+1w6
         4cN1zrHS7RDXqcZusMB6dPzz3NE9UIhn9UKhNFo8EU5L5I2oe1dfYNuyCbMoSQJWkgKC
         xcZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwkPHt9VFVAZ0WNyS/NxXQXQL9cU1+NVRZkZUvXs0I0w496vr9HlScVUE3ai0CkLhQVFXMNrPKqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOO7imhcc1PReza1rSTUGokF7yf1MhW1ZbOtIwy8K4adeNFxG7
	w3deDtD2T4oB6JXNEM7AJ3XRmyReA8y9fJpuhWqfkga6+nXHtxwvLZkhkenTkL+6nvUO7syZsqY
	dMES2kpJEBqP36iZend1jF/so+om0UvWeVvu4TMO5qCD3Wviov18zQQdSOXlxupK9TIhOpQlyMH
	q8G6kl7sRrGvVOKQw0tMHys3OQEgPX6BrWRd1c
X-Gm-Gg: AfdE7cn+SwsOUnCQSDSGMS3tNO5sOp/vl8Qu/RsIe2OgKUG0lFSSZK1czdxPdFRfv4k
	Et1eyZMVoc7RVEg6wFVso5fCY8zztl+gMS5scY4z4zM9jIqZXuXgCICV3HgYRgJstjcxRrfXS8D
	kbfbgUwwjghrTV1oAGaewSke0A0oT67vDveCfC6cZymEoW+KSSuS8XxjWFkc5RW/LqxWQ8
X-Received: by 2002:a05:6214:4d06:b0:8fd:6de3:dd88 with SMTP id 6a1803df08f44-90402967e79mr83477236d6.62.1783940782125;
        Mon, 13 Jul 2026 04:06:22 -0700 (PDT)
X-Received: by 2002:a05:6214:4d06:b0:8fd:6de3:dd88 with SMTP id
 6a1803df08f44-90402967e79mr83476766d6.62.1783940781520; Mon, 13 Jul 2026
 04:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-rpmhpd-skip-ret-v1-1-d94180ad9a29@oss.qualcomm.com>
In-Reply-To: <20260629-rpmhpd-skip-ret-v1-1-d94180ad9a29@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:06:10 +0200
X-Gm-Features: AUfX_myGsnTpzeCLUzCCdEEGEMdmUEnmiVU6eRml5SOsa6NlI_DndZfCYLoO0mI
Message-ID: <CAPx+jO-hFpXe8WUA+b=jDqXu_+RmU+AsRWr-XXZh5v_DoUd14Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Skip retention by default
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: p9yzvAlS3K1rQvqh1FY-ffCSmR_R5aSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX84jyL5q/f9/H
 3im6a9zpiRbbg5xGA3UnTmxSKWro9qaGXEYHAjb3MRJ3z17YN9gDIvpyDUjHs+Ej/TQ+6Jra9dC
 ZW8yQtdd+XEG5h6CLkBGIjH4zO8nU6wq9Toi4CN7EEJTVOoHZTQi3mSAjdjhg6lZCAURNklBWSL
 ZsYPAA5LB6uukwQs07oOsSdY/2859Iw0UQG8QjqnNNiy0oNa6OgTtwoUtsZzHhtFJidsY0WieZx
 I5SVDhmzH8SinZqdo11swv6m2TCVX5bkc/YUDNOqJGf+5iL3ibZm7T7Opkg3Z0ZOqkWQohaYcnz
 zvq2IWxT76u4cObx0nl4LwHfx5+NVau/LXns660vyvTVBFqKZk7xvNoJWK80f2CiuHWiJH1M7td
 QlKj0h+NGYJMUYPzSCdZy/rQTTOoACV320M4O4AoltMEZbCuh5cHyN5KW9vAYFKA9sZJzXV7geg
 zb0o5T6h5BEXNpkK32w==
X-Proofpoint-ORIG-GUID: p9yzvAlS3K1rQvqh1FY-ffCSmR_R5aSx
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54c6af cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=NH0glHQFlFSo9nq5Qf8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX3tN+9pnzy+WW
 vUPoZhsNz0akfzfAcGEY8fB9075V/59zVw4lPL7mBSyAwNyT6TOHFRDQe1XSQ1SAhfOeEjY4m/G
 Wp7V8dhNaYN4qRyhtFuEakQyGkTHO9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Mon, Jun 29, 2026 at 10:37=E2=80=AFPM Mike Tipton
<mike.tipton@oss.qualcomm.com> wrote:
>
> Retention is very rarely an operational corner. In the majority of
> cases, HW cannot operate properly at Retention levels and so the minimum
> operational level when enabling a rail is the first corner above
> Retention. A small subset of always-on use cases can operate at
> Retention, but those aren't controlled from HLOS.
>
> Currently, we allow Retention by default and only disallow it special
> cases. But this leaves us open to various failures when the PD is
> enabled without first being voted to an OPP above Retention. Such as
> when a child GDSC PD requests to enable its parent RPMh PD. In this
> case, the GDSC would get stuck powering on.
>
> Newer chips have started supporting Retention on rails that didn't
> previously (such as for MMCX). Instead of adding more special cases to
> skip Retention on MMCX, start skipping Retention by default since it's
> almost never desired from an HLOS perspective.
>
> Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index 63120e703923..35c598b33ac9 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -41,7 +41,6 @@
>   * @addr:              Resource address as looped up using resource name=
 from
>   *                     cmd-db
>   * @state_synced:      Indicator that sync_state has been invoked for th=
e rpmhpd resource
> - * @skip_retention_level: Indicate that retention level should not be us=
ed for the power domain
>   */
>  struct rpmhpd {
>         struct device   *dev;
> @@ -58,7 +57,6 @@ struct rpmhpd {
>         const char      *res_name;
>         u32             addr;
>         bool            state_synced;
> -       bool            skip_retention_level;
>  };
>
>  struct rpmhpd_desc {
> @@ -191,7 +189,6 @@ static struct rpmhpd mxc =3D {
>         .pd =3D { .name =3D "mxc", },
>         .peer =3D &mxc_ao,
>         .res_name =3D "mxc.lvl",
> -       .skip_retention_level =3D true,
>  };
>
>  static struct rpmhpd mxc_ao =3D {
> @@ -199,7 +196,6 @@ static struct rpmhpd mxc_ao =3D {
>         .active_only =3D true,
>         .peer =3D &mxc,
>         .res_name =3D "mxc.lvl",
> -       .skip_retention_level =3D true,
>  };
>
>  static struct rpmhpd nsp =3D {
> @@ -1093,7 +1089,15 @@ static int rpmhpd_update_level_mapping(struct rpmh=
pd *rpmhpd)
>                 return -EINVAL;
>
>         for (i =3D 0; i < rpmhpd->level_count; i++) {
> -               if (rpmhpd->skip_retention_level && buf[i] =3D=3D RPMH_RE=
GULATOR_LEVEL_RETENTION)
> +               /*
> +                * Most HW won't function properly at Retention. The mini=
mum
> +                * operational level is the first level above Retention. =
The
> +                * small subset of HW that can operate at Retention isn't
> +                * controlled by HLOS. Skip the Retention level to avoid =
HW
> +                * failures when the PD is enabled without first having a=
n
> +                * explicit OPP level set.
> +                */
> +               if (buf[i] =3D=3D RPMH_REGULATOR_LEVEL_RETENTION)
>                         continue;
>
>                 rpmhpd->level[i] =3D buf[i];
>
> ---
> base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
> change-id: 20260618-rpmhpd-skip-ret-430a25af1cce
>
> Best regards,
> --
> Mike Tipton <mike.tipton@oss.qualcomm.com>
>
