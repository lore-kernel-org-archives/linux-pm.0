Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8443900F
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447552; cv=pass; b=E7lrLKHWGF7KLf4iTwnfGPjUjWDw8NHuO5bjDY6s/pYaLE0ljaq5m1jMd0ZeJqFxNbcgaFH8fysmtKbbv6CW7bRLBTEQFaDMUYa+LCqVfC12aIGIXcEKxjWbX9TwW2KVD8b9537DpJdvA4xnzMHRBJyW7QeJX+EQ1yRKoCVHtv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447552; c=relaxed/simple;
	bh=i8lUUtdcjqnzF0iI1zLV7fE+XgW1j6mCz00AP5bqSqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf/VkGHeDcfihwoJZZ71wJLlgsvEAy3r0dLAtBBJGpXWK1Mg83R6kqsbGGUgipIvzf+VWZpsZkWbKJNqqRcHb8AhSstHYA8aQa1wSJjcGc/I0brf74mcVUgfpIuUixAY99sxRgrSh45ET9X3koXQ14Q9FH/6hHaGQ2wf2ZPNcMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbttgRWh; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbttgRWh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2940d16190so583189666b.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 21:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447544; cv=none;
        d=google.com; s=arc-20260327;
        b=gPEXE0gpXr7ae1XzvMRUKRKrkUm0fUftu1x3k7zYrEy3mDuezPZT8G6kloHVhUsauW
         b8SF9j+1ocL8qQKGbdZeC6uiAVTQr+jbqGOpXaPRejbCqDul1ic0ErVdyOk6PlNYPF97
         P3Iec8aCDKWynh5xfOqp2ZtOC6jtZPTBTDeGLkWpUAeIb22NnbHtUpYUChCEUTwdMSLM
         UiX+LXFztVI2bWX5L7oqkCpMVqCm/Co3YMSLqoUXvQ4sBiG9zJiSaAmWt3EDYuF9/P8r
         teAPKkCSDsI0wU5V4h749R73wnhTJbHCepZLK7N4Xk6t76dJALwiTdY46mJwzYti0dJl
         Mvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AVj6OOuw8+ZpNkuoXFcXlRxfZ6JLOmksHtPRzEkYO3Y=;
        fh=75iEbhvw0YYOTHoBgus43sJSo99K7Xg7HFi2Ic6u+KQ=;
        b=BvD/KrsszsiVnULXSvxq7SoyQljRyt1bwkvpFSnH+47XnjsgSoL/pq6Xr3esrTxyxb
         83BsHNY/UmUauxPaIBRusP4t4CWU8FonWkJDHiAxkO0sEHGON81E4zObjdsS7KCOwYDD
         UR3cBm1uTLT6H8Jeqezg1l3QDZLzWkOM7bEcNGjHtCZ8ziRpAZFv7oGeiD+Mpp1ivEB0
         8FfqLzvO7KoNNgtMuiRuvgL2gbJhIT8ikzdj8vDecrxJP4aPUtI9Y70B/jG0PT9nnHrX
         /Da+zp+aJQOLV0FkifJb8GLtmuCJwkOS086AEkzAPuIjjyq9DH1vwtIaCQtC3L6SOwgI
         lChg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447544; x=1790052344; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVj6OOuw8+ZpNkuoXFcXlRxfZ6JLOmksHtPRzEkYO3Y=;
        b=CbttgRWhtvI0N9xtlUCmv54XHEUwLxuuRs2Gniep6j59kPcZbgPj71uyWJBSwDoS0D
         Gy6CsWaqN17iZjEA4ohTnNdpeBkpOe0jpOFgyWCsaOEpxL2prsMtygtFAzp2I6j2NYrj
         aImaRZeUykYMYUvTODe4Ae/lqRZPcixLB+7HtDuxY+dOmg7VH1WBbOD8Wd5IPcqOnJq7
         aoBvKyX9F9M8F87sn1Zu5F++ssDnk6+J5M59ojf3/w1BhCZmp4nuaYbzD33yZE4JnJ6Q
         fIo9IOtuS7V4Q5e7NW9kJJvtaQBIbD+3G3/bNU9X6zA4+kAVLQ8eS9OmcTUDPU0UJOUG
         cpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447544; x=1790052344;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVj6OOuw8+ZpNkuoXFcXlRxfZ6JLOmksHtPRzEkYO3Y=;
        b=SkMaa3fb3bn9rvwZTl7n+7NWzHoLVOiS+DCJGhMwtq1SlNE6vbZ6F5ZXYZv4E8+sFb
         t5NJCx6T9IM5L/uSMPpa0aA1E0ev0WFXrWKs8PEQO70lat1UmkFHbzsz45J18jkbAicU
         ADpo3d65bo3aYXukSBCbmOdb4AlztW/ppXA//FcbuD27C87ylrfibJZys/6/qbeh9SmS
         kpTbKyIVhGpythg95sBI/+6IRs/GCscFL2zWHnhnD/C5TsWW22hhpoRu0Vu+D0E49cs/
         x2IXqUECZbFGhD7ydENR79ckdpgXLViGZ7UjpqoxYKL5XIx0R7/58ORivUhv9LAemGag
         NEgg==
X-Forwarded-Encrypted: i=1; AKwUvBzVOPJzvNHKkoIloexWavS8ZX46MGT9DAH+cbD3pf6lLQhd5hoOACQFKDYwcJZnRV4J9OwwmSklTw==@vger.kernel.org
X-Gm-Message-State: AFuF++nkODx9RPP23MESs5sqkueNbxF1PhYET6MvHgPfNg5OyvvJu6hi
	/Zvze+Y4kzgaIPF4mU1ObB1NpeA+yj2d/KMnDBG0k9BIapaEItFLPgCFwIzX172Mtw7Pjhm1I+I
	KUA0KpVfKuoYRdbHLTYaoad71i09G/cE=
X-Gm-Gg: AYBFou0l3r1GVNSK7ZEd2caxveWQXCIFD1OfVwwT3rwCoDESFTO2JXAoaX49N1v6WFJ
	n1OfNWGGhvTv80Y5G4EoY/bDa3/S13dH1/AbQ2f9CHijWXrHSZ8F5WdtJ8830PtJHSqP9r9LH3J
	BbFMyFIPWhBWeDnaZ1LF3vpiYkV8pOffWK26Ijxi/JnxJ97bg8NUQAd1VgHYNrCzMRRudDJq5x5
	UaGtULUfbgi2uxxDqSB8dWUF2uYcQ/9Xazk1llIO+Zn9kTaBToF57TwVdvOF7NX7uCCZE+OqJcY
	gVSQJGhfzsq5xwpnPriGZFq0pzBT+lvnPCPKB8X/po3hFrNZUKxD0nQ=
X-Received: by 2002:a17:907:d8f:b0:c25:c54d:d1a2 with SMTP id
 a640c23a62f3a-c29b864787dmr350678466b.18.1789447543614; Mon, 14 Sep 2026
 21:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145905.9404-1-linux.amoon@gmail.com> <20260913145905.9404-10-linux.amoon@gmail.com>
 <d4174f6c-2ced-4827-b579-c54b37619023@kernel.org>
In-Reply-To: <d4174f6c-2ced-4827-b579-c54b37619023@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Sep 2026 10:15:26 +0530
X-Gm-Features: AcwNN1XnROT-wl_Pv4SIRl9gq2osyQZq9QJ7pS3eOAiL7xJk3WzBKCm1k8F3Pac
Message-ID: <CANAwSgQ1Uno50rGMW3Mrtrmm_DW22fgOzbLZH7uHu=StQ8_t8g@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] thermal/drivers/exynos: Select thermal emulation support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review comments.
On Mon, 14 Sept 2026 at 12:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/09/2026 16:58, Anand Moon wrote:
> > Select THERMAL_EMULATION when EXYNOS_THERMAL is enabled, as the Exynos
> > TMU driver provides thermal emulation support.
> >
> > This ensures the thermal emulation framework is enabled whenever the
> > Exynos TMU driver is built.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/thermal/samsung/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
> > index e1e8035d24fb..7d5590f78185 100644
> > --- a/drivers/thermal/samsung/Kconfig
> > +++ b/drivers/thermal/samsung/Kconfig
> > @@ -4,6 +4,7 @@ config EXYNOS_THERMAL
> >       depends on THERMAL_OF
> >       depends on HAS_IOMEM
> >       default ARCH_EXYNOS
> > +     select THERMAL_EMULATION
>
> No, drivers should not select user visible symbols and also this has
> absolutely nothing to do with Exynos.
>
> NAK
>
Many distros do not enable it, so I wanted this selected by default.
> Best regards,
> Krzysztof

Thanks
-Anand
