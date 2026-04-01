Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E73BD633
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040788; cv=pass; b=jIsl2yi/EcW6uYGACsFKuYJr56wDQmFDHucC0AfTikgBYjrP0W5XoJP5j3/YtJJuyaR/vQ7S5fj79BOL6FKCT+e0ONsMK8lhkw7T3TOuOXYXZr6mPuxDYaOswBiGVYKkZq+o3j1Ox3jWj6C5ukS3kyKLfJHzBqQ1O9sNUpG91Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040788; c=relaxed/simple;
	bh=l0faMTnRkJlF5B9vpnXXp/ODNCleyJdWxYZ75rZZEH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSnl7ZulNVG2YdMj5BPr/HF0wSIVusQdixrB3WwmSopyMzwLohRXki44TGMCkNT+jqmuXI//uD3dSOl56qObqnoDPj7sGyI442wtliqNESF4u6XV55hJAtkRVBQTzYhoEJ1GQwf71y8RpHUd11hJ53YlGyYkAfGNUIpPRc6p9tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i80WsaGh; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i80WsaGh"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso4575695e87.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 03:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775040785; cv=none;
        d=google.com; s=arc-20240605;
        b=XHiz6sSm9DxA/rCpK8ztdFwRCXYnCWps5TMI6gbJQivXmGT92Io5NvN7aPnjiU24sq
         Em68XUT0pNthAF1ugR/wDInZkC5sR7g/mLDW7s4ULZHBF/IvvReDo2sh83ymn/vJ4OPI
         F9ZS0Qu06tONAVdJ4oiUX/6EIfbWa8i69Un2rNFBGdruWUnVU8zNDqTzXnrbmIDRqVGt
         tFdxxkjVYSsGH1Br8eyAgcw1qjedr9WCUTqP+4FBhuuLtmEV/nYKrUbHVkrJ85hEfUrC
         6Bz6yLak5B2JB5b8XDUvE0q8pf95M81B5fIyAm9g8SGijPZbP3BSX3TnIyuNQ+L1wVYd
         D1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qwWb6hPajDLQOtpfwOIrFtAsL1zH7jbJZ3Y7FZqrZlk=;
        fh=fgOKjUNBXY1yoYmghrKThmnEBbIipE0uOQbQIyvqva8=;
        b=JCu1tNMrd7K6sFc0L/EWGTr5LKcqrS6h1d+4UQD1lYJuxrbbxsOuiew3apORTRbGPo
         JEaxphVmnyxAPW+R01kvvxl6rpt33M6iJYrbrKcpu+Tr0ARwfJuCumLu/cJBverizfDW
         2jPf0p74kavBTc+vLQhUVFbNQQBSObuBDu+h4LMxkEqwFj/HnEzycwzRuM6bxBHclQ6x
         lRyvenf18y08/NDfbEnlZh29X2yqfwUoZFxjzUZMYdfrvUh5xOU0+w3ZkVKRB2yRHl6L
         TngPJULA1xBetzEEQYWfDhjjX0tB5k0hmyuxn7NVGiJp8uu2Ra5xf+73Ejt4LLNgo6hr
         XAJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775040785; x=1775645585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qwWb6hPajDLQOtpfwOIrFtAsL1zH7jbJZ3Y7FZqrZlk=;
        b=i80WsaGh30CIuep0tGX+iAWdtNlX5AAtFTcoh6ihwK2oa44KhK6RtOd0t/rYStgE7L
         MH2Q5UQxuRwsGbhCTwfzh0mYBnTz4yq+FyQrUZ+4aPSrIMylmhubQByDh5coIEdKYbSZ
         1MQyHorhcFcuhys/ZbT4iS1H7ntDGIU0XsrucT40SJxOxwuhv7MyUHKYcKaVTLV3FKX0
         LadjWZWf3mMePAeKZyvPvp0/RKBoDp7w4tLhcCYflUYptgKKlGoeGYuX/y6lTL8F+kHh
         NAnhQpQhVfstPfZPAlGnTkpVILUBETwIXdYqDVDmRDVSZAwuK7ulTOoSeqZZGw2PME85
         3/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775040785; x=1775645585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwWb6hPajDLQOtpfwOIrFtAsL1zH7jbJZ3Y7FZqrZlk=;
        b=fW6QOh9Nwen+zBvnYRiT2i6ptZS6HQMSWoyiAiFkQQcmp96ovrhposanhBe3boa4FA
         4kfb+s78XVRdQuff0VwRn2m0sMhmak6hXTNH1/5Nbo7kh3ephoWu95nnZbr/GVM6aT5M
         487gRxNnsxPER7j83vxxem4Yncy+yzFgfmRFgfNxWvN8aVRjgPfNaX1qdSH1UXZNfeYn
         OhKctZx2jVGTUMMNWoH84J1lxAVa8srpKkDPnhkb2YgNDGnyScVNfbzkkjBu1ZCRrs70
         kHknfdz5w/g0Shol0nb93QkFSJmwFsAg+WabZjCtmCNv5BLCKFDTKKm9mKm39IDahDgA
         EG+A==
X-Forwarded-Encrypted: i=1; AJvYcCXy6PnF3982/h+OSNlmoRrTD64OLB/ScXESnCm0Up6Nh0AUfywXh4OkjTOo8iu915xixirIQrTOkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVLwjfpFqYHjXNtdR/wZ47XLMWLdDmoo3gD1+7KdEWwPQ8q08
	rYjcgNcm0dL3WOqTvBBOJN7IjOYNNhsIR9NRj5I5K7l5bPwgCuVOZqVYrJeXKkUACwWYGKuL8Nn
	v7XZ7owbu3IYnIye3YZpmTRucuh7GTAtbGnMyBuj23A==
X-Gm-Gg: ATEYQzyAT6EZYgIGxPAVuMNV9Z17AJjvtKwIaRgiS9rd8k3BhrRuxTau4ghUeCfkUSS
	kIoPvLsy6Ze8fycSkIxvB+NAJyirUiz5gTlfbZdi2ASbXw0rsIe6g/HCC0VbI6mCzkbuJby8bD8
	9ebFKfStFhzEzZMYrNfljVcCb6KuQH+agsC4YaVDlB4DDiF96LKAFXTLnAd4PzI2wpoGzFl8zDv
	GjQJ9T0cIOgkS4WeQsIAe1xiTjbRUsZSNvE7Frlub92wiOghmVUCc/B+eOQneMd08RRQ7VLfSnw
	PgaiaEUR
X-Received: by 2002:a05:6512:3053:b0:5a1:337b:4af2 with SMTP id
 2adb3069b0e04-5a2c1ef85afmr1126928e87.10.1775040784655; Wed, 01 Apr 2026
 03:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401091847.305294-1-arnd@kernel.org>
In-Reply-To: <20260401091847.305294-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 1 Apr 2026 12:52:27 +0200
X-Gm-Features: AQROBzDnlDhL3CPC6t3e6D3yLO3B1qc8eoFxAH1pkWXcytS4EAMsXnENli5d0-I
Message-ID: <CAPDyKFqYeZAdbtVDFBW3XtMs7E-MCdYOvy-DrBFUpQ5Gh2+vSQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: enforce PCI and OF dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 11:19, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver fails to build when PCI is disabled:
>
> drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_register_notifier':
> drivers/power/sequencing/pwrseq-pcie-m2.c:368:54: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'pci_pcie_type'?
>   368 |                         ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
>       |                                                      ^~~~~~~~~~~~
>       |                                                      pci_pcie_type
>
> Similarly, when CONFIG_OF is disabled:
>
> drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_m2_pcie_create_bt_node':
> drivers/power/sequencing/pwrseq-pcie-m2.c:191:9: error: implicit declaration of function 'of_changeset_init' [-Wimplicit-function-declaration]
>   191 |         of_changeset_init(ctx->ocs);
>       |         ^~~~~~~~~~~~~~~~~
>
> Make both dependencies unconditional to prevent compile-testing
> in either configuration.
>
> Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/power/sequencing/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index 1ec142525a4a..77c6d9227251 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -37,8 +37,9 @@ config POWER_SEQUENCING_TH1520_GPU
>
>  config POWER_SEQUENCING_PCIE_M2
>         tristate "PCIe M.2 connector power sequencing driver"
> -       depends on (PCI && OF) || COMPILE_TEST
> -       select OF_DYNAMIC if OF
> +       depends on OF
> +       depends on PCI
> +       select OF_DYNAMIC
>         help
>           Say Y here to enable the power sequencing driver for PCIe M.2
>           connectors. This driver handles the power sequencing for the M.2
> --
> 2.39.5
>
