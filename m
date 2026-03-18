Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A32360753
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857986; cv=pass; b=D3R4wFw6hDcj5yQMdbqijddO/351loCjMOb002ZyQhxN5CsOb4K6Hz6dN7L9tPL9Md9st04+XRuMn/4Bi8Tuzi0npY7vF9toUdv7foHmHsNyI/5AXeKPLDW26W/6zPWNzYll5ItVOFF1X3F3i9+ibl6towjU15+VmfJGlC10CvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857986; c=relaxed/simple;
	bh=PoIXV/SEiAxyp3zTzsVrIIEiDO8ISD+QIm/nqSAV+Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUcDnnGX607uL50rU6hvi1aqRtbmzBGAKHBpSZ1O4PFlGSRaD44ZgXFIHyYrvf5LQtjoxBRXSA+JIG9V13H9+EsSZ2Tyc8tgUL7Kb3oBG7IGWpm+lZZe7kx14+oow+XyHJkwUk5IFgQGQ/l+1ZTSQUSDpDD5YBxbuu+7St11Gd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y96hdK+F; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y96hdK+F"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38bd15d82bdso1266871fa.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 11:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773857983; cv=none;
        d=google.com; s=arc-20240605;
        b=H4IKzQCVBMpSrzoLIdh9FLVv7S/ndNK1WrZZ9igaCeQPo19xI9wUISCtF0PZhYMuDf
         Idb7y2pizWWO9FrP7TBte7DTh4WXdYlX67IlPVfbl82/KeuxuvUtKk+8v5EcNXDUXtYK
         lktDTVVyw8s05uD1UxkbUPX1GrkkJ70vkP7Cygy5XKKZKcsdvoveGFzPnW9SSlZyUASF
         MYhzSYijn39j1ajR0/fZWfdTGjbfCh0Fivr4eI9CXl12+vgozARYDpS2waVfCpz17gts
         b1ONnQ28mqeZeh5Pgxbq0sZNmrje0A4+LOkDYPJhi3DEGA4hzjBUl8oi7G6TiwAkkUfW
         semQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        fh=0fE5dYOpRzCQf1lGfI7ZTafpnKK+sj6y/6Z0uId9Qqg=;
        b=h1Y+9MnapRcER4a2sv93FdUlmMUd24NExBBH0yotm0ZBSj65FvwS6l4m9zNuu6h1iT
         ah00b8DGdaGpBirlUrFmmNygZ3nJXPwFvBxBt1cTwo/t9QwSEhyeKGFqK/WZWdFj9/WW
         01aNVph9E6M+5TwKdYV+MZLB15IiM44PTLj8WRlFu9BYv7IhAKSMyTXb0BJ42zYjyQQn
         6NKpKKtP+gV5ntVxjR+FnV67ulcwj5y82GMw+aTofYFQ2XTKgxgr4T6tyiS7JPlw5qJF
         qo7w9UbooHnw5WhdXWSXywJnn6z283I3b/tXkbd4cuZnKlCvLXCRoFyzxCwITYTVUHYq
         Vo5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773857983; x=1774462783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        b=Y96hdK+FmAMlEguDsq60cO/prB51d1xrWEArIEKHPkIV50nXwLtM8FbY8WihgQ0Nj7
         xBP2uD6sHDL4C+6XSE+ES4opC2alwuORuSA5EOa1vLg2PrVgILFoUCAUzoizCueQsIGv
         oSAQMHV3EJzTPVN8uHTQ7OWx5wzM+tjfHp0dI1TFTbx5aLa+cFaZKDLJsrhMxOKeVrsK
         YU58d8qALA2cF5Hxs8cb7NnCAiPNgKvwA3mwu0ZsboAu9dC7jW0CBvXAH5b3v7nKmU5R
         VTSoSTi0I5JUGXe/qKvruwBy2oViRPbCWmOotU9FzAccAgBlxb4JOHnPwQk2u+m7Rdx+
         tWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857983; x=1774462783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sh96NpHK/Gnjs5OHX/qQC171dH+qdnnnJqOoacHs10U=;
        b=aUPK192UIl4ZXK7Fd09i9rJo/+gLZAlXsuzcdO+fhW040gr0FqBl2fl+C9IBMaVctz
         T+u+uQranpVZawkeTTTtIYsRfE1orN0FJWmg8CZCGq0jB7Mzhu47Zf289F3Qg0fge/eT
         NJARxFmuyYckQAPOsd0t2/KeW4e2egfdbSMpwnKu3mW+Ed3kOwntz5cDDxhpTOJZqtnf
         3rg5E0e6owvU/d087DqaPVSa2UtH8XFJu2qDKkrKAtAeKaQD/fvw6GOQC1nR2NmHQwcL
         P/VsAfBc6hEtZmQ99EUcROQg+K3FGhgRzWWVRz0xWrDzvGSoUcTwZQeTO2gHN+yQo8pN
         9MsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWldNvVhSEh9h+C5J1KbkYd2p8ToofnEKy9sodYIyLgbF64Kxp7k+qc48XFvWBxiAQsyFCnl/QlyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuBUAmmmb0xInaqZtb3LJJSLllWvcgiXGR+2FrsiKATFZ5Zpr
	jGcaQD+VzZErXGONPu9x198AWTYjs9V92bRtpiKC1vAheSIVJw52hYUjWtz359JFgbYY0v6gVPF
	0Nig5VoTBal/67yC7vdEMCgCJ+arwvDp9Knw4FHqphJNZgmK5imRWXp8=
X-Gm-Gg: ATEYQzw6Gp0XCtYSyvdku6lu8450dtHKrJHDWr3XQaSbcwFynTGQ1XOb6fRELprcg8F
	Ybe1atai5NFLHJjTLafnOeSVa3KKXavTr19IbGbhnUMSJRFst0idUJCqFG5cNvXiw4BTs8qYQA7
	cF/QGWB7oINTJC3DbwNeK+3Jwh6jtrCm3PPEenJmHt//sVmPTvWRP3kBUM6W/4Z7IxnN+/RwDj6
	SYGov04phAby2fnFf54KaQLwEpK0Ct41ox4tQ1zMqDJDN0rVlwJYNbZz143UUyn+AqlfgkPcoNK
	4STd4Gz2
X-Received: by 2002:a05:651c:b23:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38bd57b7f5cmr17915201fa.9.1773857982777; Wed, 18 Mar 2026
 11:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com> <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
In-Reply-To: <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 19:19:06 +0100
X-Gm-Features: AaiRm510MvoJuvyX_yjMZMwW_dgWQm9TQabqsR1tmMTEGls5Ev4rqc21mGQKDYQ
Message-ID: <CAPDyKFrBazYFcWxMOrmMThuatqrAq0kFG8nnYi8xQ2OJg3LeXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Rob Herring <robh@kernel.org>, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 at 23:42, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> The bcm2835_asb_control() function uses a tight polling loop to wait
> for the ASB bridge to acknowledge a request. During intensive workloads,
> this handshake intermittently fails for V3D's master ASB on BCM2711,
> resulting in "Failed to disable ASB master for v3d" errors during
> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
> a broken state, leading to bus faults or system hangs on later accesses.
>
> As the timeout is insufficient in some scenarios, increase the polling
> timeout from 1us to 5us, which is still negligible in the context of a
> power domain transition. Also, replace the open-coded ktime_get_ns()/
> cpu_relax() polling loop with readl_poll_timeout_atomic().
>
> Cc: stable@vger.kernel.org
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains=
 under a new binding.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied for fixes and by re-adding Stefans's reviewed-by tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5f=
d729b168a641460 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mfd/bcm2835-pm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -153,7 +154,6 @@ struct bcm2835_power {
>  static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, boo=
l enable)
>  {
>         void __iomem *base =3D power->asb;
> -       u64 start;
>         u32 val;
>
>         switch (reg) {
> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *=
power, u32 reg, bool enable
>                 break;
>         }
>
> -       start =3D ktime_get_ns();
> -
>         /* Enable the module's async AXI bridges. */
>         if (enable) {
>                 val =3D readl(base + reg) & ~ASB_REQ_STOP;
> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> -       while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
> -               cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000)
> -                       return -ETIMEDOUT;
> -       }
> +       if (readl_poll_timeout_atomic(base + reg, val,
> +                                     !!(val & ASB_ACK) !=3D enable, 0, 5=
))
> +               return -ETIMEDOUT;
>
>         return 0;
>  }
>
> --
> 2.53.0
>
>
