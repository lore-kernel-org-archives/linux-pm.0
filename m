Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C8425CE6
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574251; cv=pass; b=eEN5JCEKIYIe6m6LaWe7VRVb2//IJpGjn+pLgggcr+ojPuk7hoXKTVE6a3qugEwg9YuwXFwfUZinPgaSdkI/UmXqtUHpINX+o+bG1MiDRyyZP3R8OpRsCGr0N5UDFupU5G0X0Uvn7RGITOqQP8pF4f7G8VqyyOZSS9uMJDpktmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574251; c=relaxed/simple;
	bh=I1IsJZ9VsoHWf+kU/vnao0WS/4NFd54dWmBswkYEDVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmZpUO7sDHlQINH4aqzR7a7uFIvyd/AjyYA4fZKEECXi32xpHqbQOo7uJWN7tokN1X5r4s8xmBMjKhc/sh4J7wrO8IBRnygI0QGqaM7fSD1n2e3hLAKAgHk4727wE7b1k1Hj+y0G7ykls9wSkyTxmNKudW0ABsdc9KD4Z5ZvghI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPnXKtOK; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPnXKtOK"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bebbc325000so79666866b.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 04:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780574248; cv=none;
        d=google.com; s=arc-20240605;
        b=i1v7Et/V5Goh0fVbecw7nIS8t5t4Y2E7VxLQwtU69aQY1O6dYYV0seKl/kbcX9lVlh
         7Q0dpKJLTkRB3fYyyBX9uqL4RIqx47/KVrS2mIph8MprEBPuQAgZfHtU3fAWubSgYuQy
         EAA/7ttGDWcPov3uACy+sSjUyoWIZ2BH2X/Wlwhv0vMo/b9cS9Xp29uj5rby+SDHkpp2
         g7RT1o8wHzXOqbEwpbxjgLfu+LGAHE4vnDwhTAR4mKTVIW32JJX6pWR4oZviIEcy1aOD
         mdMSeTfC0hNYOoKf8+5zaFcEqUaPDqMb/JT4ozeCzx7CVHSnNiBEzMx8N2IfqdEU/YQ8
         pjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        fh=aP7cazJZGeEnaPj7yoqu/Zf8VDL6BoQNXuZzbjmBa6U=;
        b=HNnIe9Twt/+pGSEuEbWVvPKbNyE4z7gCARnsz23zm0akLnWaRzJaw2LYR4bWuE83pY
         KbI4RMQVxUSutteLKqPj1zzHd9EwnZDdULVKrzm3vMjwwBmGdWyDQEFEINHqPLGguxDf
         fBFIFPXerhoIOopKr9lackBOTYAldp8Sb1s8C0oty9KdksOMFc2gRAYVeIOfRxrpIZE8
         IBdgykKnobvgNLrsiQ6wQzTvdmnqKSOi1g5xcRjTgbRP8MHrtFHki25PCb39TxkYAKFy
         HchHDtBa7JiOO917H2vZAtX8rpKQaPNNx5nVdx+JMR+XRC00u+CiDrxsX1Dfv/jkZxjm
         D6ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780574248; x=1781179048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        b=XPnXKtOKf7tGp762YdewelGto8+Vo3adIG8QvzPMVzjZt3ZYHiUIv3r0/QKt+jvmnc
         lXLc5W7u3XU87vcy7/TcfDT0XprbnyxRr0c8mFj4y8fm8tYYmOYkg4xfJpdOhAYvIac8
         oN5561bQ/a3RWQRCXBqbGomqxdRP4ir7QIHS7mzxxOG7z4zw8rZwJbDaCFvRUcL8TjVW
         qOsNHhxWPSpK09HS7YBDePTVFm1qIxB37Jk2N4KoVakvkFa3BZ0nnbcZxM/xVnOBMlhZ
         ejRppUE3WWIL2zUFOo0HKROm6gcsKbaq9QGSMiLkNhIuAFsY2JY2ZN+V1Dtpm8BeS8KZ
         LmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574248; x=1781179048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyEzb+3XRdRyr37ys5CCQqDn980bHp2Leeui4PMQv/0=;
        b=MgRg2Wcx9RabzPlauBgO6zfnJdTRclxamoMnzEI90bMLlnvpyNYHUzc0TlQocYyc09
         pB1yDjhsne0+HeKqBvFbijHLv6qYL+GSZkFhQaO90oSsK6qBs5nz3PAhHYAhRrZMslJN
         taZ/o5uPmIR7FEDgBSVN319bsenBW4u4Zo+B6MzXoTRH/GWhGlLOdNvRX1gI1BHB8opx
         LE6hXq3MdlE4UNjyxs2F63st9xz5dG/PazjqEznLo12fdZbdFztYpUklQspCxZwLn4kF
         VukBES50EBMi/TgYq7uCFhxzpXusOR+1wqm0RSf9ZJguPXjk2ivyWVH5LRuf5A9ZNioE
         7UZA==
X-Forwarded-Encrypted: i=1; AFNElJ+giNeSL1d6WBvD6q+P0P7sDa8EWtBlAsGgxDrkXIxuYPsrOZipmU58jwTxCrZNmHb7wI6h0JjgLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2319AFLe+c63ZgfrZQomcGTT7awB3v1gEs0LmRg55T7tMPsgX
	DLZcfm7Zzk7YP8w6WBKsuGCmPVjY2womQZXabzDUKCzQdYs2e1A8q29u3V6obxy86M2wormJ15Y
	1QparXCe27HL4Pyj+CxuYMcfrmm/4/21WZvpSg+S4ag==
X-Gm-Gg: Acq92OE2SVDj+wIY0GW1kcfyOsTT5jZK6bsf6Hj2VzkyDb4fTRcfZ5yt7xMp6tYcrBo
	ElnVJvsMigCzCWOr3mjejJGANQHdBYQZH5cGbAp0Gedhj0+t+LmOVjgQkCptllOmf+7Lp1Q2LQ2
	wJatQR5zTZh1y8KQ1hT7/zHTyZkZeGjMFd8WatS0ZZ1/zL66Z2XKyHWuRloJRkmM6cM17FPV8c6
	RKCAZWWjxH8ATgh7Z6sRAsmNaZ1gDwR4BKkqalULbMPV34vaFNzFTr72l2bhzWd2+aHO6gcFTt9
	JZCPys53q3ij/OxpxQbVzshx3zY4lRj0e74gpUqepfblzmgH
X-Received: by 2002:a17:907:cb89:b0:bec:fa92:d370 with SMTP id
 a640c23a62f3a-bf0b32b528bmr439481266b.33.1780574242197; Thu, 04 Jun 2026
 04:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 12:57:10 +0100
X-Gm-Features: AVHnY4KWKy6Zaqr6HchCfbtUy4GGigvt_YXk_Yu2tFv0GUwKJqXP0QbORP7VN80
Message-ID: <CADrjBPrb+3pFPFRnufY+wYvu_d4NH5a0ZXLXEju9HB1=Tc3rVQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8218c2749b7..6a8521270daf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23661,6 +23661,14 @@ F:     drivers/clk/samsung/clk-acpm.c
>  F:     drivers/firmware/samsung/exynos-acpm*
>  F:     include/linux/firmware/samsung/exynos-acpm-protocol.h
>
> +SAMSUNG EXYNOS ACPM THERMAL DRIVER
> +M:     Tudor Ambarus <tudor.ambarus@linaro.org>
> +L:     linux-kernel@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Supported
> +F:     Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> +F:     drivers/thermal/samsung/acpm-tmu.c
> +
>  SAMSUNG EXYNOS MAILBOX DRIVER
>  M:     Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:     linux-kernel@vger.kernel.org
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
