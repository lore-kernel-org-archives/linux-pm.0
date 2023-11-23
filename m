Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tp3RPnxg"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF18C19D
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db057de2b77so998024276.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757555; x=1701362355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eTdj9miWeM4U+bp189+wCGxZuG/z71lDB6h3m9Wk18=;
        b=tp3RPnxgavkp+8Ls+BdGNu+yTGMAMwPL1bsD7oxXawfeMMySkuamNgStNXIqUv3KLE
         l5dsXwuDKPLCMC2aSG2D1L4wWm+kKbJ/uJlnxX/uqTq6RYG+qhGITTyQ8WCiveud1waf
         fcJTtWoEDfhehzOW/zhaO3dXye9wvfIOmQ3vUrhInnImmCPKY/6mpL4xHSDqAtkQpCjt
         lckXAc8HQL+KFIfHuMrPSCItsihpI6Xad9gWmW3BLHLl6Rhe7v/Ut4YNa3O2mLwdTTCq
         jCZCxJhay8p8mrb4t/ZivakfTqG3yg2Lc+i4z8+LAFWwZ3Dn59FJ3D3YKnwFP4WTDigP
         3rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757555; x=1701362355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eTdj9miWeM4U+bp189+wCGxZuG/z71lDB6h3m9Wk18=;
        b=YJQRntsoFIgS0h6WncolqvqT+f/EyaGC65kwXMdXCdqzUmTTmFvM7CkHxVZfEbXHsO
         V7ztWpO4LjJGdOyVvDNcPzRx5Txtzd8NhTPMoiDcPQOElKGEeThQJApSN0A82fNCeSt0
         rPlAHh1ozDkt6ONDc/6S26V6ouNhY1518hG6Y+uTQb4wFovK6xNx2RWSVE/p0LoM+7vp
         fD2jwMZSaXlg5Oi8YDd8+ngq+7b8NuGePlWxm97N9Q5fcthEWJhfR4O0K8/5cBA1/628
         plkPKwvl/uTaGrOFTWHVd0TvFuGYE2ogRHeo1VudzOor/aSWaE3LPeRQRewPKOhxb5uo
         011Q==
X-Gm-Message-State: AOJu0YwZfO2DeXn+QEKeUh9TXC44OvIjPoDUGA4M4STPT9mDa9saiTF/
	ePsGJjQRop0KOhnY5tvT2QXZVjBMIoLO7N4ih49njw==
X-Google-Smtp-Source: AGHT+IEvXn81cNYK+IH1RhWt+nLuhiDh2Z0MjG/kWfFXbI01hwighqvsvEk41nf/V7A86F7avZeTYr0TTKlSd1xH90o=
X-Received: by 2002:a25:d08b:0:b0:da0:470c:868f with SMTP id
 h133-20020a25d08b000000b00da0470c868fmr5952168ybg.51.1700757554924; Thu, 23
 Nov 2023 08:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123100021.10918-1-quic_sibis@quicinc.com>
In-Reply-To: <20231123100021.10918-1-quic_sibis@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 17:38:39 +0100
Message-ID: <CAPDyKFo5Jb=YWCZ9QvVScUDpbLAFehuXs4BBAHuCERsGFrdS_g@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] pmdomain: qcom: Update part number to X1E80100
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, agross@kernel.org, conor+dt@kernel.org, 
	quic_rjendra@quicinc.com, abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 11:00, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
>
> V2:
> * Add more details to the commit message on both the patches. [Krzysztof/Konrad]
>
> Sibi Sankar (2):
>   dt-bindings: power: rpmpd: Update part number to X1E80100
>   pmdomain: qcom: rpmhpd: Update part number to X1E80100
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  2 +-
>  drivers/pmdomain/qcom/rpmhpd.c                       | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>

Applied for next, thanks!

Note the DT patch is shared via the immutable "dt" branch.

Kind regards
Uffe
