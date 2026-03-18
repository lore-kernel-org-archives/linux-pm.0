Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7443CE4A3
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858029; cv=pass; b=pldJJtkBVRXWTt/j9MVu9nysiMq91iqSSD2r9cxEl5fziRze2MkkP4neE3b4CyFYDd3ysdvCC2HkOkdL8pfpxkzZex3AWfUV1n/0+Z3Pi/sMkpF3O8BwzpQUQZG6AXGzD5/t+m1Pz5UUvIqovjLkylu5jqxJMG3AxycmRUuoYZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858029; c=relaxed/simple;
	bh=o2AlAnMddYyM3GRUlR6Czl0IFVIjXXrBXoY3tjJ2NCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oobB32ytZz3c7BYjyIvtIu8QIlbC2/I1wv3nLblhYDYffv2i7pLD6fYfUTPFz9Ia9sDgD7nQqbnAHtjBi6vgyyYkHwHaQ0/Wexd9DUYqykUzZw3xL/ZZ/ftt367uIvdUvDAUVujrWMAYMjMv1OzuRqhHHThG45QMhtLt/n9gqig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mI6V35NV; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mI6V35NV"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e4a04f059so161097e87.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 11:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773858026; cv=none;
        d=google.com; s=arc-20240605;
        b=BDMgp4Bg4EkW60f+qd2bU4FDH09cpS0BueJUwpCOqMdhyhDsQYYgy0WHhs7f31iA59
         7Do+xaYP9C6Dww3F/c6x9PMa3yqizrexy3DQ/qmGAt2xAjC/TBF/mby4Tskm4XY1iWzq
         M5KZgKE2Nl0GlF73Aty92CTf+nyGv0RaEauyRMvCjRMVRk/ndZXEiKEvDMdqpIZqE63v
         eqczLu0gu9ULiF6B5LgxrLvaNEb8JTPJw+vhlt+6QKWW7loc+FYH3K583vzW0+yYvSQo
         Pm6rR6JEaSWi6FhufUq12yMtk8TlUWXbrUdp4gdtWylyPjVnupwTtJAPJtNCtmFTc3OX
         hLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQ1x2ihDMnnywua4CVQQdfzwfLUYhJP99revvTgTk0o=;
        fh=q9pYqqmZSSFCoGsH9IOFUAfUQdFwFS3M03SFRgyhPDg=;
        b=evvSyxXJrRvcvvXsFJGZXVaeDspLk5OcJzcnnKI87KuA1bGMLeQ7RewPH7ME7zEMQa
         lK1ELs3AtK8aP1gzW1LjkFnAg024g2DAhKVqXE+6qCWj6ANS26vuWtrdqL8/DCodpg5w
         HgKoTeMQdmWunUSj2+Fbhb3fxVb+U73EORTz3Kdvlf8LsXgZhj3TEcEmfLUcEjfJAM6T
         rldBL/Lu1lczfMSWUrqrKsoyCL5P6RctcfUlG0rrQQvrav8xbAXQSRzYLVbde0zIw4r5
         0cGTsCXHY1e2ZDXdXKBPujOVF294+9CuBKMNldOwFo721VDzP3qGp7J/lgkqPMobTUM5
         oGNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773858026; x=1774462826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ1x2ihDMnnywua4CVQQdfzwfLUYhJP99revvTgTk0o=;
        b=mI6V35NV8ZWus1QtxqcWcFu7cx86rkGqhoUIR8ptZvCoq57Y8NoeSWyMY+knpIGMpU
         BpZStWyG+GeeetaECaDMjqOoC1O3ENiIF1Wlm9VDxhqMkgH8Rrku7JdywhpNwkR+s1oG
         0CioRCsUFUOkqDYa8KQwPBbqowNfK5mg725LQu3I2VqXzO3QUowqJUcd9Dj3vEW5yMnv
         dXILrC5+5/lgq0XBYJ9dryfydjoLr8egZEzHj89QPaX4qDocwSI5H+G9/B9EO+e8/4uB
         qhq8RaiUcRhEV3ltZzwLCKdE5L32BrQaywJo+Oq7we2DimHkOgTO2C5sQU/VQQ10lTH0
         d2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773858026; x=1774462826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ1x2ihDMnnywua4CVQQdfzwfLUYhJP99revvTgTk0o=;
        b=aQemDMIPiVkxEzj4j2SG/ejZZCIw5T2J0EbPPn5dw+mSI3d1U4VxPHUBmgYiBsyTBF
         kXrHM/UDGlpbBAk1LnU7h6G51WKKDslC7GYMWoqcCVHFY67tY8sHehaWvNTefeBosj7u
         uvtkd82sUNIMXchrxSe7xmkV6UvgD85z4QGUQVl6wYv/BdFBn09r4LiGGaCKD3fDx3m4
         dEniTcG/CvSrtK6F4dZkhS580gGKGuOsLEfWPb8lcBuwGu02U7NjBBzwjlQD1qsO+Blj
         XSLidlgQ5JQQzX6aOvqG41QEKLfIxqOX9VBLfb+VYTycV4NPNlKMc6gRBjuqYr9unS81
         VwyA==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZxalovGkhQg5/cgI932phrxy4vkAl/1haNAKsvJs9EMnRCYXNaUVzD5t0QorIjv9Udh5wLEv3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SW7wQE92LcEJR8Xa9mtoMKrtQUPcEZL3bSdl3U2LWecbWlMq
	ql9ny3uqDn/cc11vi2dMpaeUmAgV79QfhU0lhoafbm8ybbOSUE9z81xb0491z8ch3uvK2KPVZKJ
	56kHjWHEYQ1XpULQxbH+6tfVKDPIxpUMvwVdArY188Q==
X-Gm-Gg: ATEYQzyKmDPA87FidoUvmijjpWJZGdBx17jxsExkPkrQ+SEtl93X7iEGt3Oe2ENs54T
	DNAg74NqOaAEKunj2mIXQ4jhc0FtBxmT649FQ2XXn4/pVRe2HXQK8ioaOxNOwe85wQKuWxnrPgc
	hzk/1+4UjDhfnoBaRpLhfRDErgPEY8aNDsGsMOmgHTYStJ9LSw3wQOIbZIl2sxa5kuJcrxFcqsh
	/ECs9bkcOvNfoRK93efe+dqukMbbdA22175Rynf6OYuLqbiMnm2ENfHRsd22h8vxmGPDWSB7WgO
	9v2q2pOe
X-Received: by 2002:a05:6512:24c5:20b0:5a1:37cd:7f10 with SMTP id
 2adb3069b0e04-5a2795903dcmr1158473e87.10.1773858026058; Wed, 18 Mar 2026
 11:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
In-Reply-To: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 19:19:50 +0100
X-Gm-Features: AaiRm50uzOde_q8t8Y3YJeSNhx4Hb7KPrmeaUA5JiLmoBH5vpeZt6VfvtJkYLuo
Message-ID: <CAPDyKFoo7HXuS1OQtt6Ku4O23pvFOvaG3g1_N7SPV8uB+ckt-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] allwinner: a733: Add A733 PCK600 Power Domain
 Controller Support
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 04:34, Yuanshen Cao <alex.caoys@gmail.com> wrote:
>
> Hi everyone,
>
> This series is to introduce Allwinner A733 PCK600 Power Domain
> Controller.
>
> Allwinner A733 has this one power domain controller, PCK600, which
> shares the same BSP drivers according to the package provided by
> Radxa[1]. Unlike A523, A733 does not require the resets, and it also has
> different delay values. Apart from these, driver wise, everything else
> is the same.
>
> Add support for A733 power domain controller by making resets optional
> on sun55i-pck600 driver, adding A733 sunxi_pck600_desc and dt-bindings
> definitions.
> Tested on Radxa Cubie A7Z.
>
> [1] https://github.com/radxa/allwinner-bsp
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
> Changes in v2:
> - Fit the pd_names into two lines
> - Link to v1: https://lore.kernel.org/r/20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com
>
> ---
> Yuanshen Cao (2):
>       dt-bindings: power: Add Support for Allwinner A733 PCK600 Power Domain Controller
>       pmdomain: sunxi: Add support for A733 to Allwinner PCK600 driver
>
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml    | 17 ++++++++++-
>  drivers/pmdomain/sunxi/sun55i-pck600.c             | 35 +++++++++++++++++++---
>  .../power/allwinner,sun60i-a733-pck-600.h          | 18 +++++++++++
>  3 files changed, 65 insertions(+), 5 deletions(-)
> ---
> base-commit: 0031c06807cfa8aa51a759ff8aa09e1aa48149af
> change-id: 20260304-b4-pck600-a733-1790e0e48d49
>
> Best regards,
> --
> Yuanshen Cao <alex.caoys@gmail.com>
>

The series applied for next, thanks!

Kind regards
Uffe
