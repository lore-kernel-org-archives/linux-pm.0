Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2863C9ED4
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857990; cv=pass; b=hMnTKvWieDnTiIc8H8RpGvThtZ6KTnuGpXxCxWro2sdQTFq8aFFKZmO+Q/8IV1hxBVDOZvb0eNfJ7EOxnNaNeWDWPBy1o9kcMRYcQR/VGk0t1ZNPMFConZS1VKxa6mSqlfgObqcLhopEfQm/GF1OBCgrDKxdEi7WiNDdekhHkZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857990; c=relaxed/simple;
	bh=4oOVK2Ujr3IB7OHZL7BqydDFONcShnL/O0sVh9dCeBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kT2JV5T+zigfPBp7Ktwg1ZwUF5/C6aqHQqCsHVbyFthkSkiD4qq7d8ohpX3edqsgWcnsdj7nfrcoUspV3ypeygb1VBHxqiNM8rbE6SRIZUADhhdOehgDeqwmqZ1D+FHxyDU5u6Lev9wIRAv/+0gAx1sLnOR+iYBtlUFJc7H/I+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HV/mJafS; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HV/mJafS"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2793d0d6fso160921e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 11:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773857987; cv=none;
        d=google.com; s=arc-20240605;
        b=DW1+efTIp3wQPRbk28t4jqrNxgWq5haUYJujucz6yjnDORKAOg5usxQ4JAEuufejdQ
         WGEuz3BGGaV7lkp8gcDXgma2aOhhEPkLLYFj8lmq/ZzcbTcUbOoDHU2PAhmCv6wWWxxg
         Ex5l3lBy7zQ55LrM05yrRSDiep26UMRIn3WaDK8xlz9fCNBxq9Ol2+/67vzYtqLBlMHb
         FiLPvA3xV+ACwBTqdRdANPWnZ0BzZmJBTlw9KF6sdIDNjyavkOqdfGZ4VEgk/7MkUsIt
         5vwksFjMURxOoiYoAy7VPDbh31fFhUoyVwvv1PMYafyqJO6KqreC2iu6eGPXJ5L+oBoT
         5c3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRxDxT2gnBNASiQ3ruLdElFAagcbSYIjGNtCyJjVGWg=;
        fh=Cfs9L6OABxBjctXqvcWFtWtgQ8cYu7tc3GE3IFkYhZ8=;
        b=IvekXe+ArQhc3O02lWQwplFj9e/uOGIA80bkhepJtWwE30YWQW8/GL5fvFWSFOk4M1
         fWSOqAUONmAOT+JBQGOHQv+XNAKXKe2//IY8XVsN/+T5kjFuFl3XxM44pRVDUlY1b4fR
         +No9JlD2MjuGmISOPen1DWB+O7xach7ZP2wIgB/awfG+ZvGFb6YXuJonZz+CY2x1sN/+
         xSCHInPDDJu6UvadTQmw11aeJUUQxFkOTqYSQuTSwiFVCHfvu9xbA5WdGD7UgmfHbiTR
         niVcqg7ZDv49MPOdBchecbX67Ur4Y31niWwW9uZYNCw+3gyHSzYxekHVR7szFe0Ybxe8
         Whjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773857987; x=1774462787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRxDxT2gnBNASiQ3ruLdElFAagcbSYIjGNtCyJjVGWg=;
        b=HV/mJafSETLKojrCnjxSwkP4Vph73CetiDoc5/LMw+3qfwBLusrKzeyJGN6+xTPw/2
         9rwfybPOT5Cu+juPm8XCyTmJoESiMSd01O+rdVPz2phi32nSUkQB5/LY+4zDAJisVpMU
         Dy+gErH/Kb7Sc+RM1mHszNGgPDvCOGfyqT0qpjQfzp21aMkmL9UtDxqB+PHi6p7oOGDs
         H3CUIGFVHspRBpB2vM/vU8sqUO+PoHEobzmafMA+8TY/Zf6CrT4wdlciqzeDwLMb7Zft
         tAwNc2hZmGa7gCMXQ5Ye4Ov3yHSFIg6K2nS8cs50dUD/D2dGOjuvMserCEzeSRH59K2V
         w5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857987; x=1774462787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRxDxT2gnBNASiQ3ruLdElFAagcbSYIjGNtCyJjVGWg=;
        b=JaHmWUzgbEUWymCdpQVYZf1kWMBvbcvitBnujWIRJjsIpjursk20Z773hZJqHCM7x6
         XwBdnSjioY1ilmRp3sz5TnggDOPQ/u4pqiqRhqsGNCmqrgCtIJJvzG/lwsnQ65e6Pdpc
         wyIa8uu7B4hzzNYBw96UJt3If6cT+rG2W3cdb1CWg/fo6HrbPMQ+He/SfqCrc2qvpQI+
         gRIxs3nXhVVszFBopqQh/BEcLiD1dYJr4fWcXNYKfH99JmrFGF2AcrxV/zUWA5wPTUs3
         nFKGetcsCDnkH5EwM8DSl4YcHtTa53P047PCrX1fAzGMYnTfJ2CJooyMV3EY8rzg7q9n
         OMVg==
X-Forwarded-Encrypted: i=1; AJvYcCWrhRdljUWvQ26QPbeNP3uZdVQAvUYiE2lbKtDZZ5bQ+BPiNPRXqvSRzXiUun5hVr4wpUM/7wKu6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YymFFGL9FJAW+SfugBrhyJwFU8h/1qUZ2S3cPol6KAfcM88VfwD
	Hojj/EnZwRpOTQDNm2hXX3pp3D0H7clrW4KrZLPG1IwXNbTaGbTL42nflkjX4haZhpFKwcq99s3
	3xSgTDcJD1IhUpg+HFyxbFUQnoUvZ50UMTqg9PQXVzg==
X-Gm-Gg: ATEYQzxefDs9PElzZwpf1gubBcC4FOyyqlx5KOY4m8e2PPNA3fO/OC6TANheTga/bXa
	Vi/r94paTRWGyslgNIIV9Q+663eNww9BSljcTHMa+VjSXHc0myFo2/Rt3ejUx6tnDkOMI9hae+2
	Glu5tgr7SxVnQ+SJqPNe2dbInmbrUBytF2agE1C6JGk9Q24qD54YcxOxzTAeIVy2aW4PY8O01Df
	FwDtVdDza9s0RmzX9nVmlwYhaY/CmsAouopx7sLYJ3lm7HtaeW0ceDrEfGckOBRayoayxNZwHhv
	oxSlhsZc
X-Received: by 2002:a05:6512:2554:b0:59e:171d:a68d with SMTP id
 2adb3069b0e04-5a2796a8fc7mr1439815e87.27.1773857987280; Wed, 18 Mar 2026
 11:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com> <20260317-bcm2835-power-timeout-v1-2-19db323c51f9@igalia.com>
In-Reply-To: <20260317-bcm2835-power-timeout-v1-2-19db323c51f9@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 19:19:10 +0100
X-Gm-Features: AaiRm52B3afGivAWtwZPnIEqWUc7ueqawx3ytlYolTm7X3odgd-DJ0WgKKEck8U
Message-ID: <CAPDyKFoFp-YSqSm2YXJywNk6=nhhdOtijS9ONdaw7PCe+Oj_iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: bcm: bcm2835-power: Replace open-coded
 polling with readl_poll_timeout_atomic()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Rob Herring <robh@kernel.org>, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 at 23:42, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Replace hand-rolled ktime_get_ns()/cpu_relax() polling loops with
> readl_poll_timeout_atomic() for the power-on (POWOK), and memory
> repair (MRDONE) waits.
>
> No functional change intended.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index eee87a3005325848547ce1f5fd729b168a641460..b76d74e3849be0aff226cfbe3=
11970c9557eccfa 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -215,10 +215,10 @@ static int bcm2835_power_power_on(struct bcm2835_po=
wer_domain *pd, u32 pm_reg)
>  {
>         struct bcm2835_power *power =3D pd->power;
>         struct device *dev =3D power->dev;
> -       u64 start;
>         int ret;
>         int inrush;
>         bool powok;
> +       u32 val;
>
>         /* We don't run this on BCM2711 */
>         if (power->rpivid_asb)
> @@ -239,12 +239,8 @@ static int bcm2835_power_power_on(struct bcm2835_pow=
er_domain *pd, u32 pm_reg)
>                          (inrush << PM_INRUSH_SHIFT) |
>                          PM_POWUP);
>
> -               start =3D ktime_get_ns();
> -               while (!(powok =3D !!(PM_READ(pm_reg) & PM_POWOK))) {
> -                       cpu_relax();
> -                       if (ktime_get_ns() - start >=3D 3000)
> -                               break;
> -               }
> +               powok =3D !readl_poll_timeout_atomic(power->base + pm_reg=
,
> +                                                  val, val & PM_POWOK, 0=
, 3);
>         }
>         if (!powok) {
>                 dev_err(dev, "Timeout waiting for %s power OK\n",
> @@ -258,15 +254,12 @@ static int bcm2835_power_power_on(struct bcm2835_po=
wer_domain *pd, u32 pm_reg)
>
>         /* Repair memory */
>         PM_WRITE(pm_reg, PM_READ(pm_reg) | PM_MEMREP);
> -       start =3D ktime_get_ns();
> -       while (!(PM_READ(pm_reg) & PM_MRDONE)) {
> -               cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000) {
> -                       dev_err(dev, "Timeout waiting for %s memory repai=
r\n",
> -                               pd->base.name);
> -                       ret =3D -ETIMEDOUT;
> -                       goto err_disable_ispow;
> -               }
> +       if (readl_poll_timeout_atomic(power->base + pm_reg, val,
> +                                     val & PM_MRDONE, 0, 1)) {
> +               dev_err(dev, "Timeout waiting for %s memory repair\n",
> +                       pd->base.name);
> +               ret =3D -ETIMEDOUT;
> +               goto err_disable_ispow;
>         }
>
>         /* Disable functional isolation */
>
> --
> 2.53.0
>
