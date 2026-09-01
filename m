Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01F38A70A
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252014; cv=none; b=NRFf/GDcqV2D56+RZZ1C/35+3Xnuwoxqzn+TARm0cGN4NP+T2XSLVnh5HETo0UZQ1f30wrqBDRrWU/sBvI4Um5QvPCP1w9qqtWZc8GDFHNGfTJyJjMyc+T/kjFw7r2Oj1FyrjRvxIc58WUqm2ZUcQ9RTTty6nH89XCvuntkQ1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252014; c=relaxed/simple;
	bh=LmtwnVM9wvRfR0wHIHOhtdLvcOyfBAHXYxI+v0qt2Ds=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtRrpZfzeZ5g08NB02MERMgVya7T4pn/KCs3nc8O6ZI8Edbb2OEh6aoDfBjoUGB+EC1g8vzavVnKlzIsbU/UP4q9g9EFIwDublvpFj4qZSe7ZSl4QsEJyC/8SoPuLYgk72s8a7q7EHnVN+wc0IhpssW+vaqOW1TrHqWeaYyaIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYbfFpMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYbfFpMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA71F0155D
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252013;
	bh=r7xYjB1JLDV+AUhQJIpnIb/S9CVT5PFO2ocKRTTD4yg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=FYbfFpMsAs2NeGWjECcwblMlB7PpVYIjIEKAS/Xs++CdZ7bFotMyY7Gs3wDNcllWd
	 RtwBNNbuFRsTRSx1BE/fGNsLUPjrgyG7RrMx9Wm27qOR59UbBdoaEbjo2sWszXGcaK
	 ngsia/Ckx//R+msxvwUB1FhJVOScCrHscVF0ggarUREDX8+G7fhSWGTw6w1YHtqctP
	 XEvoiasO1IzZVK2wDq7OAYe3zrgPJv2bltVHxE54a9pxsowKkHqDxkhT1akXc4kiOj
	 lRxjhs29hjknU+Sp9wezzSOa3pG8648PXzaSGKLPDF1YLikWrpdZQyWW8IGkSLzM3/
	 y7XH2cZjXG2Hg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4ae3e201cso4160172e87.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 01:40:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByiw7Msm4WG6z34mr2jb9ZZb1qrPaxKg8VSTdADgDYlLIWj/ydnWu6PHnfiIBVUZ79s3GcWhdHwSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mhpvizFtkBQyVafsaSYsSWV6A5XTH1d/QxX6hmo0aQBMOFLslM
	ALKvN55uxzbbyr//GSRIUlnbhtNqRw+P2gwlN2UZWjrPVSxSSLVQS6zMSGNM+l4z8VYR/ujgXcg
	TE+hOhuqnGGfT15ZqmqNnW9HBgRkJfPvcoHD5qyR8og==
X-Received: by 2002:a05:6512:2345:b0:5b0:cd1:1f84 with SMTP id
 2adb3069b0e04-5b5e68ed01bmr10096072e87.18.1788252011671; Tue, 01 Sep 2026
 01:40:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:40:09 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:40:09 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 01:40:09 -0700
X-Gmail-Original-Message-ID: <CAMRc=McYnNi0kUirdRS5EaEcOM_O04LssnK=NHQe3qG3wXcv2g@mail.gmail.com>
X-Gm-Features: AcwNN1WyA6ox9fd2cV9CQbuAHwr9OEp2ZgxoMmSV5lsmeHSqgbZVMDKzLA9rank
Message-ID: <CAMRc=McYnNi0kUirdRS5EaEcOM_O04LssnK=NHQe3qG3wXcv2g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom,pm8775-mbg-tm: Document PMAU0102
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dhruvin Rajpura <drajpura@qti.qualcomm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Aug 2026 12:10:25 +0200, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
>
> Document MBG temperature monitor on PMAU0102 which is programming-model
> compatible with the one on PM8775.
>
> Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
> index 2e084d040625..ef8361a55389 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
> @@ -21,7 +21,12 @@ description:
>
>  properties:
>    compatible:
> -    const: qcom,pm8775-mbg-tm
> +    oneOf:
> +      - const: qcom,pm8775-mbg-tm
> +      - items:
> +          - enum:
> +              - qcom,pmau0102-mbg-tm
> +          - const: qcom,pm8775-mbg-tm
>
>    reg:
>      maxItems: 1
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
