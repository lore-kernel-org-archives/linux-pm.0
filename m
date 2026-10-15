Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D453C3A5
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077353; cv=pass; b=W163DfTDaSDlhkgv+TOU9uGUREMBbJK2tFm31feTcnXabdGNwzKqO9UJOFfI0zEo6RGC/qzB31tmh3OQALJxyXYvJrz8A7aKgtc7VNCI2hiA7zzsjB3FZ1nNZlRZOWmMPQZehR0ENEleOg8Grfgppi2/yVpz7xm+p7KhGeCCF0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077353; c=relaxed/simple;
	bh=IH6C2ITjynYuyHLytAInZHJ667Lrpx57dguMaAwX600=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8Zca7jGSp9DUx+/1aY/wH/OxwsROUySMEIzKCn/THVgo85ucVniQ9TpAX0NppAOmqL8VS/Zb7CIElm5AmYFpAzRPFytKLiVZTrNGPqlPzp84Gw9Lrw2udwXP+SiUJCRi25iGmmBqYFLQ6ta4oz41GhzdEfVGoqZTw+joQQqpvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKnu4UbX; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKnu4UbX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e8c710847so679413366b.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 08:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077349; cv=none;
        d=google.com; s=arc-20260327;
        b=gmhY6WOmZOoVGg9PC5QKY3LU2BnZMmMS39sKcDzlcC6rn1JXV1DZ9Q0nDn4yCy9wYF
         mtuPmepwFu6NiA+E9aE2ON1xTcm/LZdt4NqJSJtGM2d4EcgpT1b+uUnlzRe6BVbFVHB4
         LVFqepUs8tkLzM62kI8Pympd+S0B/ZV+lG3dEisPEGVnKEM8raV1O2IFMRvT9V8zaUn5
         ukgz6nYP3g8kDhQCh99+mKgd6SJsMcbv3zX/hRBUC3cUOQBJmman+0xO69ea4gMpqmwU
         IO/2UIbJeSz9tb+jxCi8mnszTw4Ut6NfUiFsFme5PDX7kUnqTmT14wHzBu8xnaQvQtJY
         +6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0qzPWVIlKwsrNYhk0FU474psXi0lgPudC6/799gRiGo=;
        fh=Zg5g+rkpVdpBDY2Fhx2iK2+cRxch2KXyULw9MMNUkrc=;
        b=ZtY1sg6ChxGMynBB5mykkvaLH5KnMOC20/iONLWf3zkUHtBSFw3dbxESTR6PEJGk2O
         E2z6ZyQgZZ6hB+bS9JXyfnA0SNsssbU+yJKRn6h7NBa5gacxfoBxRcbSrcg/3LX7cEgy
         zN1WPUOCcG+UkWi5O2oNsGrfXV6DoAoVw7DK/cozHudQnWnP7svlJ/tjjtK9q6kHJK8A
         3AkpG+GWFCFics8QeZselbiI2y79IkgCb8o0kwqRcI9M0p1QlUoJ93dXwhg7QZFEe2ZN
         ZSoHmFip5VsG1J4/skcVhVfOgszfLUh6tvqlDMljDKK/eMa0Lg4dHcN03z9BJ3NiA6qS
         /ohQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077349; x=1792682149; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qzPWVIlKwsrNYhk0FU474psXi0lgPudC6/799gRiGo=;
        b=nKnu4UbXM55FqTwsXsL5rqRbhxYX57pXWxdWa1UIfw/Csfnu/EABonwqCW41UjrO/S
         PBC8cak+s77RlztOUXxE0XyKjCDRZBaDuFgLcfuMpFXYXH6X3LnIUoZK/S/dsCQMGDTt
         DJ1nkmmtzlF+s72190lS6CJoMmrXM+kP6VhRyIKVmF1eaSf7HuoksALVwaHXZag9tbIc
         4NaavsXfG1fqgEbIqqPfjb/Txg6crHj+1zmHr2zHrt1s8mntv1AFLb5IBO/6kXlElJea
         QJnZyePcN4+yaZ2edvoUtAbu3NHu7uZbbDNTAs8Mh1AU2piH0hpBAZVpLGvA0CIN0rEL
         udJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077349; x=1792682149;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qzPWVIlKwsrNYhk0FU474psXi0lgPudC6/799gRiGo=;
        b=Ja1l3WUkHvJShhNVukuozRJZ9Awr0ZECXXvm91wBZg2mHaO6eS2KfG6kiVk5oJNEWx
         zZBnfJQrOzzCW6rya9njgzZOzAR3fhCS1rbg1+sGww28scBK+2CIGBtq8+hhgkwKmX0o
         o3eJDBbzjjL6mVNCqiYnEQ3Uu5wIBHOJymvdHHDpqCFTswNihsMuz0x4kQJkoJmm1qQY
         uvG96nUQZbrguF/M9LybgTkKuMe4tYEPrJUh9zCkB1i3uyUGmjm89e8jgUQe+wWKixiJ
         +igKlG7/D90gxVkx6l0PsSSUXCC2x7ja1vWFwcfAENb7fBbZ1rerWPzL/IcTS3CMfTXp
         RSAg==
X-Forwarded-Encrypted: i=1; AKwUvBxdl34nMbBrr36wzrkH/ZG+T0g8KzoeTUkGeQJJn1dBDdAnYBWYd+Uqeld9V57xk8PtKzJjLclaLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKule22eT7RR3ITnNVp7FMf3AV5rXieCb23/aAVX6sWozfKsdob
	b7WiM3aedcHoGwfP2EZLVQi0O5N47xhbeHsR8zdn3GQgo/fuz6qhsA/CHIUAk39UUPc/wgLJf+e
	zr58SIJudtgybNwOqzCAtyjPHZ8Hweig=
X-Gm-Gg: AYBFou3elTrV5qOxfpQm6iLl0CmY/8QvyUe+AeL0xB4oRa8BnLX7RNvqSdQ4yvTuz3m
	VmN9PsBkxxGxqEeMPghzZhfewH4OWEJQ5m+xmrYzyPsmeXafWAcG9+wf4Qr//wgdpB9u4rkRFSe
	+fSlhGQ+x5ZfEDAw6DXx2rgaY7OSzmBA2mZcw0GY9zfozV5NzAVP8smwl6YwKPNSk68Rnl3RC2E
	/VUA4q2jCNzNyRF0kkQTI4vMem/rJdtm0lznoWZqTme21l32GOpw+G0xuGAVLGTm6DY5wbAQn+p
	mskEr5idCZ37O9h2iU0fbnPjAPlHLuh/Hpx8sSjhnA1MKZc8y5rDOnFYYj40yjWbQO69PHDXhDo
	wmDAwP8OAWED9OQZWQUiKVJyn6hKgY7MWK1zNhJOfgzY=
X-Received: by 2002:a17:906:c155:b0:c2a:d65c:c194 with SMTP id
 a640c23a62f3a-c31a9d56761mr1838328566b.29.1792077349343; Thu, 15 Oct 2026
 08:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015051926.13752-1-sreeshankar0910@gmail.com>
 <20261015051926.13752-5-sreeshankar0910@gmail.com> <179207236622.28934.8455006218721757519.robh@kernel.org>
In-Reply-To: <179207236622.28934.8455006218721757519.robh@kernel.org>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 15 Oct 2026 20:45:36 +0530
X-Gm-Features: AclHuK8CtOHEeDeQkZ6GhBte8PNJPOJgXaJdB95NIQjYT2X3-p2J5_V6n9AGVI0
Message-ID: <CAA-+uk+iNj0TxAkUgGSHhvBjDf7_EO_q9Zv6N1f+eoHBJf=q7A@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] dt-bindings: interrupt-controller: qcom,pdc:
 Document SM7250 PDC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, davidwronek@gmail.com, devicetree@vger.kernel.org, 
	krzk+dt@kernel.org, viresh.kumar@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, danila@mainlining.org, 
	jbrunet+clk@baylibre.com, linux-clk@vger.kernel.org, sboyd@kernel.org, 
	konradybcio@kernel.org, andersson@kernel.org, radu@rendec.net, 
	robimarko@gmail.com, bmasney+clk@redhat.com, rafael@kernel.org, 
	tglx@kernel.org, mani@kernel.org, linux@gurudas.dev, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 19:22, Rob Herring (Arm) <robh@kernel.org> wrote:
>
>
> On Thu, 15 Oct 2026 05:19:24 +0000, Sreeshankar K wrote:
> > Document the PDC block on the SM7250 SoC.
> >
> > Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Applied, thanks!
>
Thanks,
Sreeshankar K
