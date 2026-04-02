Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C32D2385
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144351; cv=none; b=lXLbyv/ANQAyaLZh25FLXJ518jei8toBfDn1AS1+0O9U/SmxFdjmcbRU4btZ6jJ1lFy78rDGinrq++IE6SE+B1VL17xAcsVAsrcRjfNildjxN28MsI1oAHaxMANEWzfFqW/kbiSsvI+ve3ZEAAUCYOt6SsSk3BkdG5ybYKVkAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144351; c=relaxed/simple;
	bh=LUZRbB/e5IA1r0sYzL1ym7iUF2Ma0Q/dKqS2pFekDjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUJYuS8j0UFYExPR17RYJEN+PXL7NaGtL003bfnl1bpd4j72kFEv4IXmIcKxkql1KGS7kH39FG5/hCT07vSG6c7r1XWvpUIjUD3G26XiqJPX1VMC07olJ88AuQX9Ecoin1iecP/PvWPckuYSeyAVgEFclZiM+jtrAKFMG93UBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM9Y0cQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM9Y0cQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEAFC116C6
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144350;
	bh=LUZRbB/e5IA1r0sYzL1ym7iUF2Ma0Q/dKqS2pFekDjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oM9Y0cQXib4qf8YlZgEK8172SNIB6QHm9GwqBvLDQf3B0ZfDhVr9de51mkUyV8a5R
	 lZ7wF7ENRvq0CakCuvAukXq/H3t/4HS/cxLvhlcKZLAfCpDHEEDKdLLZFSFFPyg9mF
	 PACMW60Azuyn2s6cM7gSF4IiKW8Wq0H3s40wmuQOigTefj+4PYG+h5MepcFb7OaLHo
	 eTKGZJDn9OOLRG92n/HcxrBNUL5uoclTfjz7QRKJltPlljcyR8qPUK5xIQpSh9fW4V
	 jvJj6aPuTsPZXBg5XKwZYKbPzAawgH1MpRnKUZgDR39Ymza19aT5xEtRLCygdVRrka
	 o7kxPXKnDULeQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2a5236811so1193832e87.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 08:39:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvMCkgvVmteEybPSd2JuLQ1txNMcfd7+q2yC446fAoK4yiWe2rCfCVJKUncg7i5CdEVn97oNxWzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPNFsv6G/5EntcjSAfLB5P+4oN81F5Ky929g0ikkMf487lhL3
	L7ktgoClVXsoPKyefhmIyzhvxzhQ7AnPqxh1q1tMUVzqU5sRviYuDK1fNa7fLfzy9lasp862V/Q
	En98vbqJ/XcHJh6mbZsI6p6NgaxSnjOaPwJH+PQhhcQ==
X-Received: by 2002:a05:6512:a86:b0:5a2:b536:6b8b with SMTP id
 2adb3069b0e04-5a2c1eec554mr3164371e87.3.1775144349551; Thu, 02 Apr 2026
 08:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191030.948046-1-arnd@kernel.org>
In-Reply-To: <20260401191030.948046-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 2 Apr 2026 17:38:57 +0200
X-Gmail-Original-Message-ID: <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
X-Gm-Features: AQROBzCnEFEvk-zv9v5zLQWjdx3ajdiLjU0gfS8s0fgV9pWfpIqfd8Dz0iZXDxE
Message-ID: <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 9:10=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added serdev code fails to link when serdev is turned off:
>
> arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in funct=
ion `pwrseq_pcie_m2_remove_serdev':
> pwrseq-pcie-m2.c:(.text+0xc8): undefined reference to `serdev_device_remo=
ve'
> arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in funct=
ion `pwrseq_m2_pcie_notify':
> pwrseq-pcie-m2.c:(.text+0x69c): undefined reference to `of_find_serdev_co=
ntroller_by_node'
> arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x6f8): undefined reference=
 to `serdev_device_alloc'
> arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x724): undefined reference=
 to `serdev_device_add'
>
> Add another Kconfig dependency for this
>
> Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device fo=
r WCN7850 bluetooth")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I noticed this one only after I had already sent the patch to add the oth=
er
> two dependency, feel free to combine the patches into one
> ---
>  drivers/power/sequencing/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index 77c6d9227251..1c5f5820f5b7 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -39,6 +39,7 @@ config POWER_SEQUENCING_PCIE_M2
>         tristate "PCIe M.2 connector power sequencing driver"
>         depends on OF
>         depends on PCI
> +       depends on SERIAL_DEV_BUS
>         select OF_DYNAMIC
>         help
>           Say Y here to enable the power sequencing driver for PCIe M.2
> --
> 2.39.5
>

I assume with this patch[1] from Mani, we no longer need this one?

Bart

[1] https://lore.kernel.org/all/20260401070735.107162-2-manivannan.sadhasiv=
am@oss.qualcomm.com/
