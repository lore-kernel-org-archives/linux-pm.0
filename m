Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45A3DBD76
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956856; cv=pass; b=OmYFAOhJIcdtsZAedjvEB1J/hDDkPyFeweyuQwdhHnzldBK4F1sZXeGjtsn8YPPi8hqAn3Ls/nPlk8/xsQIzTYl60tYMPc4AXoDudhPUu4M+adHNW/1uIzb84Ixd1OEWroFQAeaXznNUWuI+4K58Sg0tU9WrmfRifpZpCfwuUaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956856; c=relaxed/simple;
	bh=fvcDsk+Dh9LbyHECz4bnznmrSq+OdCpbbeM5YLbTkds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrzmHh5ynjX1dYg8/UmHlGE5c3cmjDooNxvX1XjM95CH/kmv+/rouO0tS5jm+rzUovz4I4536U69elJFZqYEHUih58/16BxYCQ7pbAAd5hSUCtaWeZaou+MTb4X1zSpgyG+ZA/lWPYcVcvN6wFd901F6l5y+HHqMoffU3LGutGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeDrD7/y; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeDrD7/y"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2a8abac7dso4131384e87.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 04:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774956852; cv=none;
        d=google.com; s=arc-20240605;
        b=FNfsdWdn9Xxjh3hF3UnirdWZhdTkKdL5e7XFxec9PGU0/Q0WZGIwNhcxyYxbeCaHUU
         +KnzuDYBZF32vYiYWPy3gRSS0UVeStIKqSb5pU2ip4epn+IOuTKBsdsejZsSwYssNX4S
         73KoB0AVh5oLf3CDcH67A9/Xpw0jLBCuvHIkbGlfXTwYpSLWqvNN73EfX6q/ULYARgC5
         oBH5Dhcs4Y16//FhqTLGSuSmSB+j3jYnK00ENJQyqkT7QW9gPBG5CUMKt0b2csYYOEoo
         RqeoSGwGIqUelBA5sM6t64CY8aR4YSp8G4JYIRMi8yaeZCjrejQdTtUDhsqhAp3JLChT
         LUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGcYOF43Fmt+IF0mxxl7l+XSr0GQEhq288tkKBbNS6g=;
        fh=eRsqNbxeOLFFy7SET+I/AEFa2Llzaq4QOoOajinDNJQ=;
        b=YPAdW3X850LHlaRn6/yi6AOZDvkwhq/obc8Um1dppGOrwGOgzgrSTPF/p/oyaSaqG8
         S4f7bsRWqIN1yFj0POiYQmXKkfhuitxXXXtVa7gZl5KksHeUZHfHs1ZsS+9Z1qQzqNgr
         nkRMxuZnJOkq93NGQJjfNbco1DsgHWUcR0l0r9vbpjlCP+TyIhE7cZsuUPWNQGBRvQFJ
         gKtJ2zHFeLsOpzZSgRpoDH5zO2K9Upvv/j+RaH0957+oYZNj7leRad9fs9f3o4E7fU2k
         9XmWOTQrFFHW8v17+ZI5QIpv9eaqjzFwiuAs8UkM1ZnVieVfOPl13b/VIJaKeY8oH+Dy
         lu/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774956852; x=1775561652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGcYOF43Fmt+IF0mxxl7l+XSr0GQEhq288tkKBbNS6g=;
        b=KeDrD7/yI3/16ZEeMyZnj78MqSBCa/eNWnPEkeAYhLevO8maetOMhmPI1inSAE0K+j
         PE/CmpJAsbIIGb6mD5jZXCXs6onFAfWtTNpG1XB4E6Db/ppDhoIR0KNIvqC9HW81QAaP
         rJjsi6XhRTS3+eCW0VXhjIK/bj7BEg7wYhkeegw3eu3FNMYiiAKDxpxSFUQwiSRcS6ei
         XfyqZeCSDDVGL9/5nUN81RQpi96adVxov9hulCN/b4xQm2nhzhbE+/jqcXZ5xmEBKXBC
         msWwnM1xSSv53465TfU0cJMV3IutPU1jtY9DKfI1QcygSd2ODudvJc7RIFJ6PEDG8zPR
         bWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774956852; x=1775561652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGcYOF43Fmt+IF0mxxl7l+XSr0GQEhq288tkKBbNS6g=;
        b=JVNMFV7iHsoToYmvTpoUV2eq3uYI0bCRtGqD5ugLqqKUg8HCqs6YB/Agivk9yA+kFQ
         xUeaGuXoLW7dU0gSVXKm1Pj9GV6gEE3/KSVyTNayAw1oGA7ytSl5wDdr/UHgMS+aGirF
         5eudyDvy18Yp5cOVmDVU5qsaaT6BhBIgl6GvhZ+m8nrSIvIBk5hRsGYN6S+8zqOfpzxF
         sh2QSY+8iWPw5XPKTJtGz/EBTHF3Ufi5kAJm2a5O7Bs9YG7iQfHlhNGAa/ibGnkX51oO
         w3BRMNjHU3XQrZntFz2ahjoHlyd9wQx3nsLdNCNs18wpHc1D3nYQhUQeKu2GX5QHbLJx
         +Hkg==
X-Forwarded-Encrypted: i=1; AJvYcCWGwXorJXOVe1TLK2PX3KtZnLBDSGnXQPQdmlfG4Dd1TScApUP9R+3aRVnwcfWaFQz/j0sIiEQGVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJFVP8Mg7mXbfJ+wSnEIbmMBTv+EuWSLCMNHseSEyEQovzOxR
	0ofsMNl/w3D7tx3392sslKLRUk2OLiZ+9rsbDP3uZc4PdtwzZYjw6MbqquFl5mdifXHEfPH+Mug
	wQy49dFOhJe7q1JCCJ/p1f2NQ/V7khfE28RznpcDGdA==
X-Gm-Gg: ATEYQzwKFw8otcxdPaRrqfpB6VdsnliuiORZvo+DVvbNTCcHiauWMP8zp2RkL+U9Btq
	YKf8TLz4u8WX16cgFRInenz597Fqay+LqLhJQvhQGCHHFvO95FYmWhzNWUk6sayZ31yYEendXcc
	zlru7OFMZsEVnJO1Wne2gSWAsueLvuKLScQxnAFXtbjQ2S93Nbvi2ChMAhPrO7tJjLqNZYUDDeD
	GNkcXmXU7bYnA58xRcS00ypkYYXRvyLco3EJJUkvScdhzOPmMDPb9L8Cjl1zoAKedMjEVgWhj/9
	ml9c/nrFCuaCTk8b7KI=
X-Received: by 2002:a05:6512:31d6:b0:5a2:bda5:c4a3 with SMTP id
 2adb3069b0e04-5a2bda5c5cfmr730600e87.11.1774956851831; Tue, 31 Mar 2026
 04:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-2-0a22365d3585@oss.qualcomm.com>
 <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com> <x5gv6dxdum5klzfjyo7xjqull6o43okkmkn7avssg26epbvrz6@z2brpssbk7iv>
 <0b41ee7c-83fe-d604-b750-8a5a0bd62bf8@oss.qualcomm.com>
In-Reply-To: <0b41ee7c-83fe-d604-b750-8a5a0bd62bf8@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:33:35 +0200
X-Gm-Features: AQROBzB4ctl2c0yLSalbIIkWrD6Zd2w8t9cdNUGWWq81ZnkBTRFdQQbrOgG2lXI
Message-ID: <CAPDyKFrO3DzfG0aW4z4w87j_iWM=3dpvp=2Wgr4MX1Bin5-6ZA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] media: iris: scale MMCX power domain on SM8250
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Bryan O'Donoghue" <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dikshita Agarwal <dikshita@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026 at 15:06, Dikshita Agarwal
<dikshita.agarwal@oss.qualcomm.com> wrote:
>
>
>
> On 3/30/2026 4:45 PM, Dmitry Baryshkov wrote:
> > On Mon, Mar 30, 2026 at 10:55:02AM +0530, Dikshita Agarwal wrote:
> >>
> >>
> >> On 2/9/2026 7:02 AM, Dmitry Baryshkov wrote:
> >>> On SM8250 most of the video clocks are powered by the MMCX domain, wh=
ile
> >>> the PLL is powered on by the MX domain. Extend the driver to support
> >>> scaling both power domains, while keeping compatibility with the
> >>> existing DTs, which define only the MX domain.
> >>>
> >>> Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM825=
0 SoC")
> >>> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>>  drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
> >>>  drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
> >>>  2 files changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/=
drivers/media/platform/qcom/iris/iris_platform_gen1.c
> >>> index df8e6bf9430e..aa71f7f53ee3 100644
> >>> --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> >>> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> >>> @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[]=
 =3D {
> >>>
> >>>  static const char * const sm8250_pmdomain_table[] =3D { "venus", "vc=
odec0" };
> >>>
> >>> -static const char * const sm8250_opp_pd_table[] =3D { "mx" };
> >>> +static const char * const sm8250_opp_pd_table[] =3D { "mx", "mmcx" }=
;
> >>>
> >>>  static const struct platform_clk_data sm8250_clk_table[] =3D {
> >>>     {IRIS_AXI_CLK,  "iface"        },
> >>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/=
media/platform/qcom/iris/iris_probe.c
> >>> index 7b612ad37e4f..74ec81e3d622 100644
> >>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> >>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> >>> @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_cor=
e *core)
> >>>             return ret;
> >>>
> >>>     ret =3D  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,=
 &core->opp_pmdomain_tbl);
> >>> +   /* backwards compatibility for incomplete ABI SM8250 */
> >>> +   if (ret =3D=3D -ENODEV &&
> >>> +       of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venu=
s")) {
> >>> +           iris_opp_pd_data.num_pd_names--;
> >>> +           ret =3D devm_pm_domain_attach_list(core->dev, &iris_opp_p=
d_data,
> >>> +                                            &core->opp_pmdomain_tbl)=
;
> >>> +   }
> >>>     if (ret < 0)
> >>>             return ret;
> >>>
> >>>
> >>
> >> Hitting below compilation error on latest kernel
> >>
> >> drivers/media/platform/qcom/iris/iris_probe.c: In function
> >> =E2=80=98iris_init_power_domains=E2=80=99:
> >> drivers/media/platform/qcom/iris/iris_probe.c:71:46: error: decrement =
of
> >> read-only member =E2=80=98num_pd_names=E2=80=99
> >>    71 |                 iris_opp_pd_data.num_pd_names--;
> >
> > See commit 7ad7f43e568b ("pmdomain: de-constify fields struct
> > dev_pm_domain_attach_data")

The intent was for this patch to be part of v7.0-rc1, but I failed
with my pull-request to Linus.

Instead this will be part of v7.1-rc1, assuming everything goes as expected=
.

Is it possible to drop/defer these changes until v7.2?

Kind regards
Uffe
