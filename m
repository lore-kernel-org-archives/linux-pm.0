Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D22389111
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252355; cv=none; b=qYuKNEA2IjjW17udCftRhg5NBwCA/4cCNAmd6mgrr5IXoGUfludW8//Z+zZU6Qe0bOwYVpBqmKZzRqo9No/sPJWJpTyfMUpEjFHpJcs+qOD/xVp5ANHsVBayODT39mQNDcJMwgwhKsmj51N+vYSy2ps/1iv1nW2vwxD+4FCtw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252355; c=relaxed/simple;
	bh=d8mAMhf9iSJBGiT1u1xILIwSPBafyy+Ax1Oi0A+xjb4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRLg8Ua/R27gM/rcPway4gTp/pG3YGLzmYPwlogmn8EkJvrzrIl19d3ZlxzyBMCu2csBW1fPSmhw8z1j6c3sd58MAXtVuI/IRctJka5ar0bs6u7Wxl1R7jNdmZ20LMAOD+RMRBX20gCUUCSrVgYPQyry9dix7A+LoSrHkl6HieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTu/pydx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTu/pydx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294C61F00ADF
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252354;
	bh=G+m/E2OXIlH6XRNv/PTM2a7wrjnKuTFZ/o/WupRLFjM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=GTu/pydxoNQU8z86JV8Y55LN09iXzixTuH1+1jmKRJGDwwOSA6gDHbjxqchQk2rE2
	 UdoFlsQKTBGNuwA6kP1MPc2X35tJsaCyWXEIe+inTZiT2vmTWWaEkjJEUkgIKCXQ1Y
	 0+1BX0DpjJAr9Q8eJPq38D7QS+fyAl0TJUdchiN2ftqVZOcD5YqWan4DlRX69CQ3nd
	 TkQhffhl+byn+oHNYNKCatDI3NXN0kfw8trXX8Q61/BPFWq3rots3WiAfcJhwDo9km
	 jpCcM7ftFq1ri0rkK8kD09e6ZiUQx9gQ2o9oIaW/TplLt17kMHaRKVWINprEpMNmg3
	 ta3+NO/ibq3rQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b5ef26b92dso4403821e87.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 01:45:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy0Hj0YkQa8/aKadnOPNsVftmi0WJhDCtgoR4Pq0WVXoDYTzuFmjEMHIKm8EUBA3OnXTFnh3/uE1g==@vger.kernel.org
X-Gm-Message-State: AFuF++nYuF9s7VEYG1BClRurS6wFygJKMYcGOeLQg+sEKRVyS30SZVZf
	JYwEpc1xYiUdamGtMVRgsXpetfAUqS4HwuztND2FOIcHjYr4UJlHFJRg7jQzj29QaTeSjTn5Oon
	E85USAN8IRymMY30B9ON6eMkKTBYTMtiqxUrkueWutw==
X-Received: by 2002:a05:6512:108e:b0:5b5:e092:c3ee with SMTP id
 2adb3069b0e04-5b603fd4aa2mr344797e87.1.1788252352786; Tue, 01 Sep 2026
 01:45:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:45:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:45:51 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260826102746.633076-2-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com> <20260826102746.633076-2-shengchao.guo@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 01:45:51 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me=8uJ6qr1Yx+_fczK5hf5rj4GqF+p1RdSgK=vmjTrovg@mail.gmail.com>
X-Gm-Features: AcwNN1UirMAFXAbFjaz_-3STnILcIuedXW_Vs0PtNFWTxzNYys1U1AFZNKksm7c
Message-ID: <CAMRc=Me=8uJ6qr1Yx+_fczK5hf5rj4GqF+p1RdSgK=vmjTrovg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: qcom,rpmhpd: Add NMXC power
 domain index
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Aug 2026 12:27:43 +0200, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
>
> Nord routes the NSP (compute DSP) memory rail through a dedicated NMXC
> resource instead of the shared MX rail. Add the index so device trees can
> reference it.
>
> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
> index 07bd2a7b0150..92c8408dbc57 100644
> --- a/include/dt-bindings/power/qcom,rpmhpd.h
> +++ b/include/dt-bindings/power/qcom,rpmhpd.h
> @@ -32,6 +32,7 @@
>  #define RPMHPD_GBX		22
>  #define RPMHPD_NSP3		23
>  #define RPMHPD_GFX1		24
> +#define RPMHPD_NMXC		25
>
>  /* RPMh Power Domain performance levels */
>  #define RPMH_REGULATOR_LEVEL_RETENTION		16
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
