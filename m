Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22233B6E3
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839236; cv=pass; b=BP1HcMN2sKzeHt7T/cNnER2FaWfzxjK+8D0Ooy4J7HTBj4F40kRe1/Miqm9RFQuYfLiCPC13PQhqmKg1+4tJPpJ5XWIIXFkqoDbTXxw8UjZz9vdupxhPLTQe15Ca/jL1YWhUSqU0+Jl5AP6EkNlz9TylhUJRFJdJCYM7R4kiR2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839236; c=relaxed/simple;
	bh=lt+ywfAaR1Vf4CU8mDfXb4qsSFqZ/g0PCAg3+I2clZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfKaBJaujhhlViQYVJGegVNsampuviseh4WMcOKKvkU3T447+8zjXjMQ2MIoogZcMBEHhSZ7y7FVvtspXHJvnyQuJj1C4S8vtj+FLS86oWO+ED29mlTPddgKRymuFUewh7xKjlPN7kD/9FSDpB3MRZJvZ+MpFKcRAtnBvsnZxBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpIgNrQX; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpIgNrQX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a41026318so59213801fa.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 06:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773839233; cv=none;
        d=google.com; s=arc-20240605;
        b=buDuwue3fYJX8fe3cUOH5pWUFFmM1TFuSno/Yib5xMrY/PVqFvW0rzDt9KHAqI9VO8
         PVQgX3ypbYOi7iPP1WaD1ZHgTdD6j+JoEZSzK7NxE1pyDAcKUVPUOHB8HctiXbsVvv2T
         64XOn0pZGNcHRk9QaNaAiAGS6wJ2N/0xM19qjNwypSzmKthuGhZ31g2NFkE4kr4Aqv3D
         40ssXodRse1vsqyLQWWvpqCjthzvirh1A0OhhR3lZV3KQL5OWemMoT6Ct8iv3W8T2P/J
         n+oaX03Y2mFYG0qL8MOnH5kfF9Ex7cxT9oLHsAbOXluwJw2qKE5dpTcb4dDI+QhU9Nb7
         QCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        fh=eTeFnndv6Lpt9uq4R1fmZ0nnPsHJsBN3VUkxZpWWmTE=;
        b=aP5C6LGy/Q8T3ZorBGvlCfEKM+avaBE8EKV2CrFdvz0Pk+LkbEteh3JKoODx0YFMti
         YwEc1w/yPI1hZ7dBYSr/Sv9gEYtSVIjmH8KRa+HpiNgANdK29IIhnjW8YtNty8oq8QUl
         0o5xmnDUiL9iqFKT1q6iJMxsKPYYL0EbcQLFYQvpU3CyTPjy+WLRyBLthgYcvnsBOQBo
         xTg7J2uiDbKzsFzU4DHEwGCHTMGmmo+3HnT07n9Au2hqcWJDm9TqR/8LhrW5C76pSi/L
         KHd/xagDsfW6q/j2ocP+vSqG83A+wDUVLlD/pRfsApRMMawQPpyYGUzZXLEQCr9Lbt72
         Qk9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773839233; x=1774444033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        b=wpIgNrQXqNCy5/541IV911CuWAYpy3kvXTUMJW9Gvx7Z4UNRyXOGGeEAYsZbQGy4GV
         o3lWKU/lkHJDS9Eiv6YWx0CUzTNleMcP8koMje7q401wTK39i2amZhvN4n8xEv5ca04H
         QLt9O4NBKhoairs7RS3rtXqmfMDuvNnbBmjjzpGqXiqmQ0kkshvRpddVH9y+dXZoxPGK
         18F2XTYP5N0AY+bFgsQaZKcwak0H8+hp+1q5bySlyqKET8kCs/9lSa4omQSpudLoF5in
         sZOxn+vc8Cw6M3Bm3ffsHk4fQjEZJFS1hFQWjTUkGU+IzX/butKijRqvaeyq6FsqxRI8
         E03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839233; x=1774444033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ns2P3ggM46Yr88OF2vB1ZSaRsJzPAmjjEjQot/+oNY0=;
        b=kayfUcaXxK2/nZJcGwwYMjabRLEtdzDo0mKyz1jTE/wde0upJIoSUU8mscMn6Vbwqn
         kFofma1NPcLRqedSGT+JRwTuJ8VQasBNbQ96XSTlmqHc2o5hAW3S+VNQsx3UBVExBv3N
         PgzCRrcHwyEIYYQtllf/AhdAtMjWMntsy/PsJmd7z/Porcdaf2wHDREnJPc2mhUUFKcv
         MZo38Ovs0WXRnalghtg9VRIWwjQN4mGWA3s9/BznSYknffWHNFUvlpTya2gp6KZKuw+8
         itkh+ww9DWJpBh1mdfUdlG5Fo6CETfz+r2HEbv1mQMxOX/6brZDo7vTr3+kEgRkkoF3H
         4xYA==
X-Forwarded-Encrypted: i=1; AJvYcCU0c4rIlDy+YtHe+7XpklFz56P0D5qfnY2MyEnT1klag93XWvgPwbBIn7pUV8Y9qcfn4Cxil0xRLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmw5sSWGD81qEBfTA6w7JBG4dkjpux9XTl4qJAcSENxbkG176Y
	ouF3aHB+4HXoa0RcgKUyyZIhEX15LlJq+OKzWofXxAw2B2H9XlCT7JGLiZmc/UhuVEFIzhSKNJe
	e/S3K4YDqwM5XZ8PcQSM4KTxW5oM98pwctWZLVPczsw==
X-Gm-Gg: ATEYQzzFSAA4OXY0JYiN2tHFJBM3M5GgwBS/50S4I7REIjZaCpcrUAM+Hjb+tSbV/7J
	VnDoeIldvsg0X1ieqW+t5pvqZbZt/VGoltK40ks6lJlum9acDPyqhRVvGRXQYQlKw35Q2mqnzv1
	g91mqlvYJBmg3KQo51kEqYWxRiKs0YpEYGjS9F43BzHHi7On4DskqvLSOJvoAgKeugkBf837rxJ
	EyRdgDocAVgjRfyZGRiPtPYWHPpSF/DnrdQqdTksRxoac1pbUQqBDqktb3qD+a/uDiMtmWTPhCa
	rP9Z0L3K
X-Received: by 2002:a2e:720e:0:b0:38a:4de2:85f1 with SMTP id
 38308e7fff4ca-38bd58b92e0mr10200901fa.32.1773839232816; Wed, 18 Mar 2026
 06:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
 <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
 <c803299f-709b-4b57-b7fc-46ef3bb4c9ee@gmx.net> <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
In-Reply-To: <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 14:06:36 +0100
X-Gm-Features: AaiRm52m5cJvt4QR4VS4vXBV8Ahr79JL09AakQc1EBgijJMRaGkvQqTnXJFDsT8
Message-ID: <CAPDyKFoooZbU9W_Y1aSx+HuCfjHZGn9XR4_CB8YgDmCBWTB-Tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2026 at 13:54, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Stefan,
>
> On 18/03/26 08:51, Stefan Wahren wrote:
> > Hi Ma=C3=ADra,
> >
> > Am 17.03.26 um 23:41 schrieb Ma=C3=ADra Canal:
> >> The bcm2835_asb_control() function uses a tight polling loop to wait
> >> for the ASB bridge to acknowledge a request. During intensive workload=
s,
> >> this handshake intermittently fails for V3D's master ASB on BCM2711,
> >> resulting in "Failed to disable ASB master for v3d" errors during
> >> runtime PM suspend. As a consequence, the failed power-off leaves V3D =
in
> >> a broken state, leading to bus faults or system hangs on later accesse=
s.
> >>
> >> As the timeout is insufficient in some scenarios, increase the polling
> >> timeout from 1us to 5us, which is still negligible in the context of a
> >> power domain transition. Also, replace the open-coded ktime_get_ns()/
> >> cpu_relax() polling loop with readl_poll_timeout_atomic().
> > personally I would have moved all readl_poll_timeout_atomic changes in
> > the second patch, to avoid possible conflicts in stable. But no strong
> > opinion about this.
> >
>
> TBH personally, I also agree. But, as I don't have a strong opinion
> about it, I prioritized addressing Ulf's feedback in the last version
> [1].

The first version of the patch moved the call to ktime_get_ns(), so I
thought we might as well use readl_poll_timeout_atomic() directly,
instead of fixing up the open-coded loop.

Kind regards
Uffe

>
> [1]
> https://lore.kernel.org/dri-devel/20260312-v3d-power-management-v7-0-9f00=
6a1d4c55@igalia.com/T/#mf96146960ec7ffeea32e732c95ccf9548af21748
>
> Best regards,
> - Ma=C3=ADra
>
> > Best regards
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power
> >> domains under a new binding.")
> >> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> ---
> >>   drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
> >>   1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/
> >> bcm/bcm2835-power.c
> >> index
> >> 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5fd72=
9b168a641460 100644
> >> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> >> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> >> @@ -9,6 +9,7 @@
> >>   #include <linux/clk.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/io.h>
> >> +#include <linux/iopoll.h>
> >>   #include <linux/mfd/bcm2835-pm.h>
> >>   #include <linux/module.h>
> >>   #include <linux/platform_device.h>
> >> @@ -153,7 +154,6 @@ struct bcm2835_power {
> >>   static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg,
> >> bool enable)
> >>   {
> >>       void __iomem *base =3D power->asb;
> >> -    u64 start;
> >>       u32 val;
> >>       switch (reg) {
> >> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct
> >> bcm2835_power *power, u32 reg, bool enable
> >>           break;
> >>       }
> >> -    start =3D ktime_get_ns();
> >> -
> >>       /* Enable the module's async AXI bridges. */
> >>       if (enable) {
> >>           val =3D readl(base + reg) & ~ASB_REQ_STOP;
> >> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct
> >> bcm2835_power *power, u32 reg, bool enable
> >>       }
> >>       writel(PM_PASSWORD | val, base + reg);
> >> -    while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
> >> -        cpu_relax();
> >> -        if (ktime_get_ns() - start >=3D 1000)
> >> -            return -ETIMEDOUT;
> >> -    }
> >> +    if (readl_poll_timeout_atomic(base + reg, val,
> >> +                      !!(val & ASB_ACK) !=3D enable, 0, 5))
> >> +        return -ETIMEDOUT;
> >>       return 0;
> >>   }
> >>
> >
>
