Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25543B5304
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642607; cv=pass; b=l+PjuFyHqpQtSCGPX5dOi2Y/fG9SAgwfTs1qodTCGIJe2or4/l3MIPjoypxAIwlagfHJI6aVpyq+qQSXN6YLsbKC8dhDfXQ8uuDhCr+jah96bz9vDQ9Pqm5bDjB0r5+vmJMixoleez2Aww3OXy0QnAzMt4KGDcBIAx+TaJxZhTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642607; c=relaxed/simple;
	bh=pp052ayrbRL4wt7LydpOTffYxrE1Uhcra5kIgYO9sag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkwB7L9d3qDPajECdn+Xw8Veax7PTPULAeMhPnZtZJmz35M0D14gXJT8G9OE01Xi24NxOiC9mXsTR0g+0KNiMIPpZhDEOdxkYsummW1HEfr9AshWbyMcsrIiXV+raCIuNEvaGtUYxwZHKfFt1N/UGlYfuCbfLE3t7y2Qk5ktPYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqLwfpPJ; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqLwfpPJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso5707417e87.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 03:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775642598; cv=none;
        d=google.com; s=arc-20240605;
        b=gtorumPVw2U8Ll5OQxUaL8V5a52LZZBmtfU4HqwBcVvew9eKIF6+RmN8Q43XC7yScK
         //4jIoxYF+uWKVybGpMZBWmGg1iHROp3KCRy4LV9UuOSofDWy7rHZl8EDQI4cgV5rJ8w
         WTaX1HbUjmroMm48uiIMlgJzmZnmscP1JwnoIj11zVuY0lSCtnjsHqaxbiEFSTz7dHdq
         4XSsKN4R0q87++1ySZuyVAGdoLn9N72PFjgxfwzoIZaR/pwS6jFyRm0dGnusaN92bZhG
         2+D+Mf9Id4bnZJzG9/BFYPv8pNlbL3OOgBtp4brRfu3XwdpW9TakPDhuFdjXAU2fIYME
         +D3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ml/GrUmk89MnBxJYMCpl21fN05QLwN5VJJYiJr+miYs=;
        fh=fiykvvj1/9nFZMdZAyP2DNgfVvNHXjTZkifwmxMBIds=;
        b=MxwnBllwxCGQg1TNwY52RKvYuuG2JwjLcAomMJei7Bs1p5A3UxonQCm9EUDH9CF4X+
         Q0JCLoTQV9mDDLJeGf1a9kB/F6fBN2CJF4RfF6D8Wqtm+yJVceeLrhlAAHnaTsVsyRRd
         c3SVEgZ37KBQ+nmo0j7RUo8bo8iVq3KIlHYaeX63o6eIwkkYkR8hvaf76nxCj26XN3cK
         VR26x6pm6aKrR39TPsdEtHan26no4OTaxR8ha8l4wBi7I0GhsOv+WUm8+RpXe/AxrlUy
         ICC19oJLkXwKYc88RU3O9ecl0uEFFG03MxaovTmhDJIgb3pyOjsVXzPNoL2fbQZErxH5
         cU/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775642598; x=1776247398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ml/GrUmk89MnBxJYMCpl21fN05QLwN5VJJYiJr+miYs=;
        b=WqLwfpPJXb0FnBNpVIWeM0Dwru/UevT8kZD9bitjhnbCPaLuocTlb9JovbJAA3ZWFo
         WSCLAwukrlQsDJJvVLVaQ4SkbO99DxwKiCErs6/dbECc7p+Fz9leXAx6hVQTUhpvFFS0
         xa74u2rLdqia9Ph7J2hnxeOs6fxKbJ7la64Ab+qigbamkPFl7OWH2CUlFXONcmj7hXS2
         rMko1YN4cHCBJS/Vx+TQMUa3kDjkljuAypb4IalqhYALzHmX82vOy0HZNjeysINtjY/Q
         41IWJEBI7gNzyLofj33V2CQo4/WG4gGKnbW+E7DshMBUlduwqvq9q925a5uqY55//FMu
         XX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642598; x=1776247398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml/GrUmk89MnBxJYMCpl21fN05QLwN5VJJYiJr+miYs=;
        b=QCkh8+TDlBMP4dM+cRHgT6DYxiz9SjGtR7IJUzmbhlP1m5lhUdCQcexhVd9LSqkAf6
         aMUxoLG4ygrFWY43fcdkpzpolUrng1zLSKa1WabilKyT2u8IAJy+aJXjq3Gy+RicWuPy
         PXBnSvGvk5USKsQPkz8C7AJGUNY1SnIwSGECKSWU0dpvmf1TqxS1lfTNCG7GLyRMMn3r
         CdAzyAIa05MyTR96cOTapib1DyY6ejwOO7eWD8zKSJ/Jd+EDtvcd+aW6Nri4FLygrgyh
         FxWGxA5BgaF1xlK9+SgapS+xZLj0gVpPy4r7olqwnFD1sWpQ4huYnG7Om/eHMEueU/tV
         76Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUL/EcD1iR5H9ljpz1HWiQmzrZJQrzb4PwYxI1DngvtR5YllTa5OGQW7gaNb1yeP2jKsir8qSbWDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLcBGGn4r2MtA5JQmjg1fUA5ZD0vKSj6AGmQx5Jo0xV3lqJYb
	GNI4xgjdSvuNRtzZ5U06+jO7oZYFG1MUgwQ4y5WtWq1jxfCNIBONv33pVFQsnR2oFHy0x4nkW14
	LQUDqTaIfCFQ58FfF/sq3qW4dK7F4kykkOTZdkmYbQQ==
X-Gm-Gg: AeBDievlNSzxvqwBwK/KU2RO2gXkMKsw3JlMeYj6HO616DS0GJ/uRbQuplIYEGRYHDW
	683Oykh9fJMqshjPaetpbDg+q165ChYmodMH+4TLC15T9kHwCJAEkqLaExcZNC0ghdScJxaqdJ+
	+iYnD+dsMCxhbu+isJ086wGucmWlCJgsp9LolRYXkCGsO1D9MNzldUmwP4LOHt0WIF7UUaYOCO+
	Pj3N1F+8La7YYkVpbfBXJdXUzBtMNFSU0Qh+ndRi5h1if4gEUqqrKRwTY8zCUk0nAVfOCqbVVCm
	nDa78zs=
X-Received: by 2002:a05:6512:6d2:b0:5a2:aec9:95f8 with SMTP id
 2adb3069b0e04-5a33756030cmr6987228e87.17.1775642597659; Wed, 08 Apr 2026
 03:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
In-Reply-To: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 8 Apr 2026 12:02:41 +0200
X-Gm-Features: AQROBzDtafMmoyr_uPgMdOXiZvaWXClGB1QtNrcyqaeePtY9aOvDKCGpYJCPudA
Message-ID: <CAPDyKFqMp-uJouJuPNMmq1r8GTX4boVdVv4QqyZTpBqbQjD5kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] power: qcom,rpmpd: add RPMh power doamins support
 for Hawi SoC
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@oss.qualcomm.com, 
	Taniya Das <taniya.das@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Apr 2026 at 02:36, Fenglin Wu <fenglin.wu@oss.qualcomm.com> wrote:
>
> Add constant definitions for the new power domains and new voltage
> levels present in Hawi SoC. Also add RPMH power domain support for
> Hawi SoC.
>
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

The series applied for next, thanks!

Note, patch1 is also available on the immutable dt branch.

Kind regards
Uffe


> ---
> Changes in v2:
> - Squash patch 1 and 2 into a single binding change
> - Add trailers for the new patch 2
> - Link to v1: https://patch.msgid.link/20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com
>
> ---
> Fenglin Wu (2):
>       dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Hawi SoC
>       pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                     | 38 ++++++++++++++++++++++
>  include/dt-bindings/power/qcom,rpmhpd.h            | 12 +++++++
>  3 files changed, 51 insertions(+)
> ---
> base-commit: 33b1a2ee3a3df63e7a08e51e6de2b2d28ddf257f
> change-id: 20260401-haw-rpmhpd-b40a68a3ce79
>
> Best regards,
> --
> Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>
