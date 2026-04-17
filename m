Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680E12B94
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425282; cv=pass; b=Tmz+Tp3Z0TKoruE2HsQ1eQOeCyxcZZJpMN//1SqbYsYf7Ucyjq7fjnlnrsO2BkLBLRvDvCCA5+pIajcS57A1pPzZMTQchOf0lFUGpN/8DgX2mk7pl8s+B2DJmWH6NOsIj9PfrH3tBZfu6bnvSQIN89BJLlGaV6e09zjU/TUDWBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425282; c=relaxed/simple;
	bh=FmWOJojSfeMllnzKUSgymkOh8QsCdGPI85X7CDp++D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4I0egUrDivN4y2JGwR21lzGLQk3ur/hyNNrhD7UARbPUrtg8AK5Xz2xbdptazM5ZrH19OWWp6z1WbUxoIKimY+KNH/6nx7qCRPX3iTWO04jH8wuGBOzExU1VRKQQ5vXGLeSLlH3FzXaXW7vNQvhlcdRZGXHYPEXAZA+xskMt+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=No6GepUI; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="No6GepUI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38be5e86918so6373121fa.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 04:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776425279; cv=none;
        d=google.com; s=arc-20240605;
        b=JPbFkG1gxq8GNX11FeNcLxzvI8H0j6gnA1b7aS8mxwLgmGA9iPNc4tb3lqEMJ8C7f1
         XYbfbStq+R8XS7JvAmQMlCITGCDysL/5CGO3YZolNFaYPLxrPwLlC/aBHFxGJ6VC5MlU
         H9JM5ZHHWLwEYjY/19VYiNmpGg2zVM3AFq/W0sFHw6MwAMUx2E1rDcyWFPxxHhW6LWQv
         T1X7rvTo7Qx2nEm0Vk8dbdVgl1GmpuN+6roGz0f8aDI1FyhF0I7r78LrAECTHry180fD
         ff8Jv0u7h3gttXkYO1voPYjo9cndvkNGAFBx5H5QDB6U7POgFzDSICoY6yVD4XoMgt15
         QASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rYOW0Q1+IpjwaJO/WtjuDhSG5gnZpYesgmlqbMeuVlo=;
        fh=QuHfoq9g6gLbo1orzyewa/RKihL2gmLX+6TV9on9FPU=;
        b=TCWbuNfLEtV7v+TyMNe6TDXBp/g+ozvDPZFb6H6+zC10xwklytoRWsh4DQ/XXGklZy
         tkDxunIbdDVYkm7Ugs2kzlCI+GFDp0C6YNZByLn0rbCL07BnqeL7iW2QXH37zgZUVqJ+
         lzZ9fdqkz4YUWizFt1y4njqMVJBE+ITXi4kLz3XBFJ4AJMS1xTGZMOOeFEdldHgwJ/44
         WN8xD2SU+2vb+fJ0q/0L8mtle2VWDeJB/sHtKgr3wPy/USDkLwblQ+utsthUj7wdvPkT
         Livr33EQuh7dX8FZcjF551Jr2GA5t6lFf3YysFTHAIPoFXnY7r5yoKWK4xDcqsW33D25
         Gs5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776425279; x=1777030079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYOW0Q1+IpjwaJO/WtjuDhSG5gnZpYesgmlqbMeuVlo=;
        b=No6GepUIi2dxD/POnyW5W3eNujzfaUKk5AOEZ+ZwFThfJcsl2zlhE+lyP8dXb+N6Su
         4aSOQodMhqrLlef1BVke6gKYFQ6bK83lARmhy/xJtDgcd4jHdRedRYJzSntfk1b6DCDi
         5ZmJufLDmBrtMETwkGLJ0SpdvfQ4glWoUx7W7yolPa7gjH34uYlZmmkV/8JnqetrQLvZ
         cJrKmM/XrVpV42u2u4MU4tCeEHix3Qk7p1i7Gts6RZodj3/YfqVsisN+9JoLF+UspKDC
         RVc7/i0XqLYJkHkN5YknLoVtM04XG7T/OvxXe4se22wmDkvNcwQLLnkLIuokpkB0lmpk
         3GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425279; x=1777030079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYOW0Q1+IpjwaJO/WtjuDhSG5gnZpYesgmlqbMeuVlo=;
        b=UBknb+yB9gRKCjXVKUBGLGvEvK6wo1ZpK8/Fttc4XGe9MRDdG83LFJKBV4oCTMYJU6
         RBLM3M30NAgYIOx1EVs24Q5XVous2EONbYRYZt6wB42OzM2Korq4uBpBpPGjWf3I6iVS
         YDiOJGi2RCWULaY5Gcw/QCW2u0vcXv/sn5LUGduI5HPxpmzNJBAdh7927pmnx3lw5wvK
         l9StDshMY9xbvCyCP3nSsiulaEjhww8Mp0HvJg5+SBGRdzSdmrIpB9kgASld09wSGaI2
         lEfrUOyIkXmVG0QtB0KxN+J8AQdScecSNSGbG4zFKhteHTMTXwD7P4EHyi6Ub8OuTuG0
         YPEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aDi9TKOuqnGi3cgaytPuO6KfoDPxm1odKifhzOQ4EXVufWrxFGQ/34xOAxxnuA75WhIkRQqmxJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1eqJv/I5AOFj7BkX3iAcGvmEP2WGpcad2wSM0w/Ikzppdoql
	83hqSbeNA4vSeVz9GIhw5ZmKfsVpIAJWGecUrc+wdHoqUBpN+d9SiCmkCU73R3i00y87eP35GKt
	F0/TmfouoHAzJ3VeWPt9qMXa2fW9N9ILOmJd30bjfYg==
X-Gm-Gg: AeBDiet+jxVvsoR366LKqeuPoHkOmPdAN4+fdhOw97rJPRMN70FZ9ayZ43QPy+L97ZM
	MtzkekgoDVH2XR3F6OKD7Iy984SCwf5/2m7wyn6+T4lUT5GDtEeKijets5umrqdmeEicvqNVAPf
	YfQK4Of1kQHv22Oy8a+6xHFXJK7EgzYTT7YJYUhhTYQYmUu43eKt5sareIfxJ/mkjg78yJCYH3v
	apy2glZS+qWIDW2py7I3BZ+xJRO0Ey5HhhGvzD0qcoTrT6aZIoE/1VvHBL0bDwsVC+ZVJCbu5tw
	o6mbHZykql/LJVUUmkNCF5zt1zjdWw==
X-Received: by 2002:a05:6512:2385:b0:5a3:e7f6:fc1e with SMTP id
 2adb3069b0e04-5a4172fc805mr733517e87.30.1776425278741; Fri, 17 Apr 2026
 04:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Apr 2026 13:27:22 +0200
X-Gm-Features: AQROBzAqQg5sMpRE7NutG6ReoXdRhkBYhSHEGgSBVqcN3w7-ZC_YCfha80lSfvE
Message-ID: <CAPDyKFrPz9gaBBp6xV1=KkoemEfapc0p3POZxuBTvDw7Vamxtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core / pmdomain: Add support for fined
 grained sync_state
To: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Danilo (for the driver core changes)

On Fri, 10 Apr 2026 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Since the introduction [1] of the common sync_state support for pmdomains
> (genpd), we have encountered a lot of various interesting problems. In most
> cases the new behaviour of genpd triggered some weird platform specific bugs.
>
> That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
> remaining limitations that we have found for genpd's sync state support. In
> particular, we discussed the problems we have for the so-called onecell power
> domain providers, where a single provider typically provides multiple
> independent power domains, all with their own set of consumers.
>
> Note that, onecell power domain providers are very common. It's being used by
> many SoCs/platforms/technologies. To name a few:
> SCMI, Qualcomm, NXP, Mediatek, Renesas, TI, etc.
>
> Anyway, in these cases, the generic sync_state mechanism with fw_devlink isn't
> fine grained enough, as we end up waiting for all consumers for all power
> domains before the ->sync_callback gets called for the supplier/provider. In
> other words, we may end up keeping unused power domains powered-on, for no good
> reasons.
>
> The series intends to fix this problem. Please have a look at the commit
> messages for more details and help review/test!
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
>
> Ulf Hansson (9):
>   driver core: Enable suppliers to implement fine grained sync_state
>     support
>   driver core: Add dev_set_drv_queue_sync_state()
>   pmdomain: core: Move genpd_get_from_provider()
>   pmdomain: core: Add initial fine grained sync_state support
>   pmdomain: core: Extend fine grained sync_state to more onecell
>     providers
>   pmdomain: core: Export a common function for ->queue_sync_state()
>   pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
>   pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
>   pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
>
>  drivers/base/core.c                       |   7 +-
>  drivers/pmdomain/core.c                   | 205 ++++++++++++++++++----
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
>  drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
>  drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
>  include/linux/device.h                    |  12 ++
>  include/linux/device/driver.h             |   7 +
>  include/linux/pm_domain.h                 |   3 +
>  8 files changed, 197 insertions(+), 42 deletions(-)
>
> --
> 2.43.0
>
