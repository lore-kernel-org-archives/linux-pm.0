Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74D217F24
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658982; cv=pass; b=Ik4L8qbeLffjrPvY7A+pRxLqAj2xlMuzll08z8j1XeOG+amzWdfQkI5cDC6URWF4errLUQ2NwJlGR8K1XT9NizU1vKp4PyTc/dnzcfGEGorVXAdFw7m/f/X1klxADzSNiLTgd3Q3DySR2GoPjQ3hDmLBreWBiahWU9zJNt/F+K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658982; c=relaxed/simple;
	bh=ps6KqBz3Tolb4OztqKZDKSfuCF/1Zo/6VCi2Bz089KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrxrIWYo5EG4Ktg4aPwQ6baiXutI++dtsRlFXBkGRquIhc5J0frbm4dFMRiszStpUpFnlU1Q3J0JDDoUepl5iEPu7p8HnauV/CrryQLRf/dBPHTNvrQe7dtNdZEkXZ5NHIZMysvWfAR0iGBvSwW+eDa5trQzDO/GQ9QLyzMSoMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ei+aqoCN; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ei+aqoCN"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so3996615e87.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 04:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658979; cv=none;
        d=google.com; s=arc-20240605;
        b=RvOUERN1rvtaN5dkzB5nZZbve16R1AJg/8CQQojszdiP3Gf8J4x6NrjjGNp8T+BYGo
         gexaYDhzzQta5d5A3Iv8Hn1QAGWnEsJTL+2h3G9DrM2CmQA0JaUWaRRSZQ2q3HykLljH
         4j6Osj7DltAJy/2DczyntGcR67f5Bj3gy/pdkkrmvgL2ZMs4jzDY0U4Zn/fPXfGIs2+R
         SToB8nMeU5wouYzj6dJHc9GP6GiiPJmRFfrb+dhN7GDDdN9MtXITwVA38urqjXlfMyew
         KUT2FFPoik02Q/BmpY9gQ+Z1vfhr4sR1DlSjOcxCS/nsa//n1M7xXLIXoR7uHD6Bc6i6
         J8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        fh=pdKLhqJmsGo7krvfmKl7M+aJfLI0QIJR4ngLtVmx7K0=;
        b=ObMwU6P+SIcB9Z2fKwjaAGtr7I6nOWB0KjhDcCFw1rYM0Zsh3QNsYknXifjRvam52o
         3vOX7+ci2DiFnMcl/FisraQwgF5KfnhTm2jUtLBwvt00CYJNeD4MYVA+I//7B7N9eNJn
         5wEBNxSOnt2PzilI79x/qkxiFyPWnuoPQh2WmrhM7FPrg0Y1lJf5GUSw6aoYXunUGplz
         hVBuoF0/59V+ea57QfPtTk6j2C+cNtVFfAjUAOQKl8bEo3xtTI9pC8Sha8E3EhL/ml80
         usGtKZ6+IPh9ghElLkybmQ73/cUD1sPy3pdrESOTWVQvU1vxdNpGsL/EO6M+xFs3YLx4
         8VTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773658979; x=1774263779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        b=Ei+aqoCNSVPXPa76BzbrgxSc4q7IzkNfHuc0dlBwMcmnbKbCi3Bb9wERR8FK4iGk5P
         VF5lKXdfxqCXu5MAVy8aXm41UlQQwb1MrjkyUCnJetXuhGDq/gO5bR1nntx4i+9jm7el
         H+1lzPjEIF5+z7WlYe+1IAK/vWHaxmEPN2EvluBiJbSDbSJ1+CcMHR4UfWYXpQqUa0qs
         c25p+tWIScmB9bLl0Dknre+gNPFbbfnGxZUanu0q6XIMxOKEK8WLrYvfBcmdRh5WhblE
         R2Dl4xLKEyO6iRJQrJlfLfNPPYxTnwKs9LekvYCVnSG11Uj37ejbx6ykG0H8/W82hWl+
         1eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658979; x=1774263779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
        b=RR8K+xOEvFjj/q4+GbHYZDc8z7cng8r05OrBaqv0fjoHApwYLrKK3IwNVwA9est8KT
         h//znDc80S8skCZn+zc/CQfZ/t9vXS77G4rF7Xecu1+0d4KhG1QmoxnbeonMgD+vdYe1
         TgrfTn8HAWeDbu2Z02igVTAMfVeFscNKa/JBJIpA+BIwUC6CKm495h8a1q8UQWqER/eH
         lEEUx97pkAW91BlwkWsc9SJ8w7VwF270DgoauQMS+RrFSpUSdaVUxSmOhdsPFHxVF4Rd
         6dJEcW09b2hb3RD37NAlr1hFbNyKvaOEb/kRXP10IOtmfJVkglm4zVPW+dd96krjaSPP
         uyyg==
X-Forwarded-Encrypted: i=1; AJvYcCXLGsrbfuJ8KIffUASlnB1gxUT6uwdqcLs+FB+2DN5auJMhmGGwC2Ld2P8vEj5s+p6CepXj4o0x6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwisBlqToIG6rdRrmUWBePdXAHbfDgkR/agymuWq330klroG0
	ytPrFpd/Ds8PMO8W2Y+JBoF/cyN0xjWVn7au7TY2la6JUrlEbeOjej6k/tli33h2o4UPRbu9jGU
	k98Wgls6BV1gL23E+jCXlZUOGWH0KG0OAtPj0ZdchTg==
X-Gm-Gg: ATEYQzy4XunZ0rnxj75nzWxPLhgnvsxoiyCMg3D/nIvRhOCJJr6XAuW5WL8IOpeHt8K
	thc+/R7BjjGX7irewD59K74BefUyjNEBp9v2Ve/HeCVr0Di20Z4eYHRqG6en1rkstV5zqL5Bp1n
	PGzBWVuf8lEBsQYBt2Kmvccc91ZwC2nSxeKodqQtp7pWo2o5nOHzx9i2uvOPAckocS44fhoJ1aa
	W+VtvSogPnnSBuztoSOqEAov/Xd0guWSwYxHyYc/iwPMSZcXlKZVF/p/6ZSH+Z2cIeTXfIcdRWy
	rBLhEg0W
X-Received: by 2002:a05:6512:3d08:b0:5a1:476f:bbcd with SMTP id
 2adb3069b0e04-5a162b1febemr3904293e87.44.1773658978742; Mon, 16 Mar 2026
 04:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com> <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 12:02:20 +0100
X-Gm-Features: AaiRm53iPYU3kIDyxQsV0KhFz9ohyZ2kXqcNJl_f0uC65KcEG9ey-Zyr9y0Dr8Q
Message-ID: <CAPDyKFqqdGG34+a7hY8feNHsnJsHvq0M45Y5-hDJp=bedHcZpg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>, 
	Iago Toral Quiroga <itoral@igalia.com>, Chema Casanova <jmcasanova@igalia.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com, 
	stable@vger.kernel.org, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 at 22:35, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
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
> power domain transition. Also, move the start timestamp to after the
> MMIO write, as the write latency is counted against the timeout,
> reducing the effective wait time for the hardware to respond.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Ray Jui <rjui@broadcom.com>
> To: Scott Branden <sbranden@broadcom.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e31440=
2f1cc9897c57dcb 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
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
> @@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> +       start =3D ktime_get_ns();
>         while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>                 cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000)
> +               if (ktime_get_ns() - start >=3D 5000)
>                         return -ETIMEDOUT;
>         }

Please consider replacing the above polling-loop with
readl_poll_timeout() or use another one that fits better from the
similar helpers.

Kind regards
Uffe
