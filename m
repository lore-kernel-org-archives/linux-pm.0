Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC7439331
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115152; cv=pass; b=G7uiyumxjrU7fDVGaoLAHPISdLVfQJUSizw1xltYbzt0LWM9IqfvATLh1RQXe35JrDdMIQpGFwS/zp6/wlg4DlJe825ZaalDozZKp3v2SgEx0Vq415Wg4W2s6aEhrrNcvIe6waZeXxD9FUK0dmgaXHo7xDYwYrZiA13/V0bDah8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115152; c=relaxed/simple;
	bh=YvGJiLLSGEag8VAXDiCkjwNnc51Pcejq5U71ONdSTxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLfbbR5R5WN0LKD7xSJE7PWPy0WkU9t/+lZ4eqmQF4Dz+j5E+4QrLqKfFIlbCpsLy2CALmJwYS1p53Uw8BS+vfXAvK6hQ1otC39t86r1YxZt6dHjfg2b+kqBYp7R3m9NoRiewU99uDrG6PfWl6DyNdbXCHN6EZw1u+6iY5AqPGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqMLGH3p; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqMLGH3p"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba418c79ccso503797e87.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 04:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791115149; cv=none;
        d=google.com; s=arc-20260327;
        b=O+RLs/sT2ieoCh+L1BfjKT1tFA6lltk41Rnz3twm9QFtrBqiosjKx7Seh+EqX7nBU6
         /SHnytPAm2M90+dCUVLDHappd/PSAjKZxlSKm5sDyfHth4uL/+UppYYh6XqOSE1yX19T
         uWZfA46GT6w7UeDq0/tMQj+VBwonk7yL2iPsVnc7V+YkOulfW20SvEohET5pGSFtQ0GL
         7N0UWr6/3T7R1sgcjxQA5eiu525bIb+CUeysvlZx9xlvv1TTZicSYjyabvAMQD0oegHu
         UIvMM+qKhF8zDflMF1tH5HseTz2olqmbA8Lr8M9zcrpfx4b9y6M34AOvIIkvWoO5rWfm
         YuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YvGJiLLSGEag8VAXDiCkjwNnc51Pcejq5U71ONdSTxw=;
        fh=gN2thKUzOi1SzE+/PL4FED5nsBhx0QiL5hUnUGm8x3s=;
        b=QyzcZAa4W8cxyAToHkufyw6HeGMQhHcpishaINqJ1J/i0+8uxjIKDZutY/Py046I71
         SjlOIig1UB+CwK7+el+TwuGjKbm2y6KEM0pvZvQab+cpX03FKwDkGNd3CH9mqVmxGCzw
         faVEvztVcfLGvjieZEy/Ntwk2siLC8UYQjOJbguOrFkOAOiHMByjGKeKOOAhr1OZqgDq
         HvEvB3qm8IkGJ+b6nxYdVxhsrOEvMsKAuSB+Es7Hz3r+fp2tOI5B8GCGuvBEDjXa36Cv
         EZ+0GB2OP/a6rXWotif1IFfQVnuFBAgVILiahiJy5M/8xjIcIoXKNaP+d8akgFAhaK88
         2whA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115149; x=1791719949; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvGJiLLSGEag8VAXDiCkjwNnc51Pcejq5U71ONdSTxw=;
        b=VqMLGH3pwV5hY7J2/iWBbwzoGS6jiCnk7KAk6ke0Y5Pbrt6TuydcD9N4g2hrXLiZeH
         nfqcTfyvgbmZBqPRYMm1CrrLcaIfG7CkPST1xEi4FPj1oeTPUkYeJu/O5Zgm6sw7oHXO
         KF3o+/3OSdPKbPOmCaRirw+/mfU4t87U+nIUcSGRHpM/cToqQHKsl7Dkh6MsqYt89gEj
         RBMvD9gosXW83TSojA1gmJ+AUPGq2lQ4g+HWct0/fzC0fm9DXy7lE/t+n+Mq1xnDFZjr
         E0pWQZzloJ5S74WqosP0opk/LVMUy6mA9UQlPVnIIuZfghh0N4ByKelCKkoYTomRoR4/
         /ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115149; x=1791719949;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YvGJiLLSGEag8VAXDiCkjwNnc51Pcejq5U71ONdSTxw=;
        b=sS2zfoWIpE4aytgrbj6crD07eAaqzEHZ9JqnkK/cQcsI1T/v6w8b0u6UXu5jP4LLwR
         1R/rFICAPUWe6OF8zkNkrkYqSeR7WunmSASQfFYRGtEzp5EvhKxuLXl4CwKWOYnXow2m
         pUu3w8bvscuAUcPBWo/5lF/vHUA2HnKOql+7I7PJaZ4FdXWUW+y2ghA53iAKH2cjpC0K
         DYmIhFe/0h9KzgA0xKf7aGKeL0chFusyeFK6zQPWQWg2DGLmNs8s/ya/v1HMm2j/Ico6
         dHW0bKw12xSuT3Uzs50FC5HcVoCFVWbn5n/OIkxQe7gw2ufHbWqe1vwkjiRAcCCqb+aA
         iKgA==
X-Forwarded-Encrypted: i=1; AKwUvBxthlBflGB7j+e7OB2+2oqbYyRzjS9Jm4RwHnLeqHLNIYfofmwh8MfCpZFJVU4MiFGj/oWeWpMtpQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIS+w18hDYl5JfZFKtk4AJltC4Hc0NQI97dzza2DXCer3Geczwt
	AO+WSEuS92o56gvYhdOuTul5dM1pXzeoBCJyOee/fxa11g22R49CrLp/sV5g+GidfY2pqxRuC7o
	dAVM27j8a/RwIbcD4UkLaIUCKRVi2BwaqTh75DwI=
X-Gm-Gg: AYBFou2vEMAbem6plu/bJ0o+VHSX+HKz6ohy8+CjcPxik+HTxDLQxI/Qurqhx5Sh2MX
	9fqCIuFVNVnfrlfyraAWj8VyH+gYebw6mgubDvtF7L0pKRXg5mnzvwAC8VwLSmxsCyPMznLhjr/
	NXqXnyomb1YLmXuPz6HL1IFGjSmOUlDR14qoQep9M9sanMNDiuFbBawRfVHnidC2OeYIpfwCY4o
	FS8nR/H70xL5JCe6b0H1okKIvonK93hRRqDIN2H0SUxWOwKjRq66VKO4htzH0i3vIwXdjdPzUEg
	fT2tEWxGDJNPj/Z0weMiKthkFQ4RfeGvL++4aWYn/yr6ynI0zBbc/U7Vkw==
X-Received: by 2002:a05:6512:3c84:b0:5bc:b8d8:d766 with SMTP id
 2adb3069b0e04-5bcb8d8d985mr953656e87.16.1791115148823; Sun, 04 Oct 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
 <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com> <20261004-jovial-fancy-ammonite-f9fd1d@quoll>
In-Reply-To: <20261004-jovial-fancy-ammonite-f9fd1d@quoll>
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Sun, 4 Oct 2026 08:58:31 -0300
X-Gm-Features: AclHuK8XfUMsTrUjezp37dJXnfrGVlkqDXrTvYsOblQTNjNZvnfYIKp_Sma2dwU
Message-ID: <CANxzQdE8tmPLweN+gfs4DdpFJXpL7ruiyk1cwNA41TL8NbefCQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: qcom,pmi8998-charger: add chg-state-change
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Robin Snyders <robin@snyders.xyz>, 
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 04, 2026 at 10:06:52AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 03, 2026 at 04:45:21PM -0300, Fabricio Akio wrote:
> > The charger raises an interrupt when its charging state changes. Allow
>
> Each of the ones mentioned in the binding?

Yes, both. PMI8998 and PM660 have it as interrupt 1 of the charger
peripheral at 0x1000, as the downstream msm-pmi8998.dtsi and
msm-pm660.dtsi describe.
