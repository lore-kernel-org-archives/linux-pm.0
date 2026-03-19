Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B63ED127
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939596; cv=pass; b=p3+FDHWUlLkRUGs5Yo5cjKpw49gtGAvFfiFDniaJho1glL3Avirh3b/fVWMGqT7byBfhNjSea3uYZVNNc+1zZIHhbhv0yZU8iOjl0ImrAlCVTqO7slfLAB48xT0gz+nfvRNc9y+SUry7G6kkHeMhufw1I3Hbj168Qpa0B7amwyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939596; c=relaxed/simple;
	bh=hj0WH+wQcNpKvF2np0hdYd1racOk4kU/YqVOzBmoLd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwbAGOJfeW4HPilvaEhVPN5OAHywGqebRM26NMPmGN/KGnZhqPDRRUrfw4JxuOm8bNoCz5ZSpzvMCoZctJAP7xvB0e0hgH8BPHAd6T5EEHKocsti3WXpcq5qNC0V9ql8XnPH1YNQUmOMs17FPQd9JKbo4YLC+MYyLbs193tWboU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLcS/RCe; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLcS/RCe"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a278b4c1a5so1035010e87.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773939592; cv=none;
        d=google.com; s=arc-20240605;
        b=T1oLEoHFSnV5HnHFRsCGN/RfcDzbL+TwzyNs+bh2axWxafFQ7H5SKzQq0+pC22ThH6
         TjSJBWhaOMqjR3UPC0gk5tHVTsqRPXY5ixgm9dgdG4AF/zkZPmhZHrolAN7NC3hZ57Yf
         SQbJPm4nNVEnT775/0DoQ1RvtRC4hqepiLAbj3f63RGsMSQQk7aEjF0+eBMtFE3d7dOc
         hfPsqrbFbwlmghqZZbJyHEF1PiFXJWZmNmhJ90iPO/lU0wd9pcEIPR8gY1+pYGkVTFqT
         DIAytb1bUTJgM8vVyg7HVKfmXmWICPSj7d132XLzDi4HUjStnbgbYnfMHGVSLC5TmrQm
         NEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=27yAPs+HhqFzoHuJl01kUQFhB7PF3j6LuIGuksYyV+o=;
        fh=32KVj2RhQzzi1198wWLf0cnJFl5IWt3yMwTOY6vWFiU=;
        b=W6yPsZjmU8Nw6UThPXT8w8BqrpHSD6xjc/HfdcyGXX3otdBnIVvB6ILfd/BiuNjDd0
         +7kOBzBMXkSKmHKB7Pca9FITn+G0pI3Yp66jhlx7gkKtk0SFWvWHT3A4SxwnCjYKUwnG
         7Nq0cfRagVbtLKKkgchvOLHqf2+ndaOKQGeSLbB36foDLuj3hfIPLFGNCQpgawbOCTVj
         nVGDGwLatojYvE/iYnR0yxbf0wdvJsb443FCYjVdNyPT/WZgfi3ICUZSTMsvh3Krh4/R
         XawF4HSe1PZWp+SA+mqt1tJsnFi5uHxjkFjrMZkSSzJ6flWBjWNZC//+2XOiOSoUn/w9
         cTEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773939592; x=1774544392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27yAPs+HhqFzoHuJl01kUQFhB7PF3j6LuIGuksYyV+o=;
        b=tLcS/RCeRAxCDUrCcF4xsVWuk3GH2bgiUmJQQnpAqLJvGGQnZSLYKZzZWLAZzU1PXC
         c+xbomPFVIhxmfD7c9W4fU91+hlkVo8GffSMrRqunKSRwOeJeAjMu7y8nT+MGHP3LxyC
         5G1WzT+xr2SJUGoh7SiU/yQzO8bMdwp0TfiGQ8KDEgvmxIaEOZ3U/NYoDv22woXsSuxX
         jMmk/gLlY3GMZV4g49YojbsBaVOqxVx/aBy40/IiJs6gR25rw3graToPkxd683q5YP8k
         ZP4wb4jjW9FTtxTNc/RrBjNr0+0c5s/WZTPxptSXH73DAf793FzroiSeVIS+2mLBotfL
         kAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773939592; x=1774544392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27yAPs+HhqFzoHuJl01kUQFhB7PF3j6LuIGuksYyV+o=;
        b=kJVRW0F/FvGFhkregxZJ5p+KejViZ4vk5bjKDZtdUEK+yhN8Fufwq22AOf4Pp6neJG
         GPK9G7KvaX9JbMd85/yalCo8Gt+QsHDkCc3TXxg5dc5b8nRzMIlNv74/YgZyBGI4EeQF
         N38B/WnBVs4g4FzjrHgGMqWG5MO9/t0XqbDzFc+b80yF/UspCPc6fwP3uVCoUfWdh6gv
         Wf0SxI4QC5GIG2RcnFN/LWw4o8OwTL5zcr/OLO71JMaeHjFKJcdvyl2cONrKT1Mey42b
         L01H45qYWbJ8zlV6zuXcKEdE8y5gScyQAj5A+P8CLwvFJVzTmqzAMc5WAvUpoqUdPILy
         9/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWGsNDIF4BwG5+89Wzg9FeaZhT7peHMvayf2vcjJIGEVv1mmQJk7PTl/eNCKi9QSkrZde/CbgJFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2Z3yEl068GYGlYaR+ZUY2X+uKIIBXCcxzcuwudTt4eP+0Gkj
	EomRXG3Aorumi55U3BHm5ziAAIQL6uAV61rT+QG0hGAbKW0zEN0vbcgmvxdIytR+jZQdL9BbyCU
	oVkyphPGmAov9JUvdTlfX3cQjNap0Kk6mYIHerTWbWx58S6uSmVE5Zk4=
X-Gm-Gg: ATEYQzwoMFBGGmysHIUQe3mwFkiAzgo6A6vFfW9TnxtrQX64ldOD2ImMZjbRZI0QmMv
	vEIJ8tGoNKewHIs0A744JAf6rlksIdwxmA36obt7G6D3mT4P4nVWWpdoVK2NJaC4CUQVFL45iFk
	wFf8gK/YMp/uY1MEl/jmj2ckoqVi5zezL/bX2z8ZycoCq/aE85XpmlMabcQgBcucuvNKwF58O+B
	lUpdh+WEeNn4XLpjddOzo3sZYyzSSFAshuvijfM84G/ngcadGR35usmqkBC4+mpU6kTOocMhvbj
	ATZnmfPO
X-Received: by 2002:a05:6512:3d10:b0:5a2:7e83:32ff with SMTP id
 2adb3069b0e04-5a27e833888mr1478227e87.31.1773939592231; Thu, 19 Mar 2026
 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Mar 2026 17:59:14 +0100
X-Gm-Features: AaiRm51ZTbjGFpP143fXcYxyckRNNuh4DLi9mrrTmtm7zrisbOS504AGBpxTqGc
Message-ID: <CAPDyKFr25L0Omm_uCjZp03_ptnrKR_P2p3e3qxDeUoFFKJg3bQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] driver core / pmdomain: Add support for fined grained sync_state
To: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
> In these cases, the generic sync_state mechanism with fw_devlink isn't fine
> grained enough, as we end up waiting for all consumers for all power domains
> before the ->sync_callback gets called for the supplier/provider. In other
> words, we may end up keeping unused power domains powered-on, for no good
> reasons.
>
> The series intends to fix this problem. Please have a look at the commit
> messages for more details.
>
> Please help review and test!

Saravana, Rafael, Greg - any concerns you see with this approach?

Especially I need your confirmation for patch 1 and patch2.

Kind regards
Uffe


>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
>
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
>  drivers/pmdomain/core.c                   | 208 ++++++++++++++++++----
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
>  drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
>  drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
>  include/linux/device.h                    |  12 ++
>  include/linux/device/driver.h             |   7 +
>  include/linux/pm_domain.h                 |   3 +
>  8 files changed, 200 insertions(+), 42 deletions(-)
>
> --
> 2.43.0
>
