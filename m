Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832302C11E4
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383762; cv=none; b=M8ZyraiiBmfim8R59Z5cm6q3hCkoZLa9TsS1Oa4nckCrcVfKu9EyFw86PFRliNK/5+msIyVKIH23u8oQUZghZK3Fo5/qTJ/I0rHLadQziM1L56TEI8ujHROh85WucwDpBxTF2p7RoarJX0Fi1WVYqB7+qglI8jRkDeHOXjNuX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383762; c=relaxed/simple;
	bh=5y/ZJifa2iYhp1fa/YbHbuyJkaVFG1V1JiH/IvCgnms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8e4orMDKMZu0MJUDhuFVLXfQNeu8CviTDarRZLxI4ZDDX1OBA8Mes5O/Z3fxrMpGRcZS37UqkVCDjA/o1TKXN6N7FC3D9MnudIUVapYcJVUWgOFxAW2gZRNKdyBPJq+hSrkJcfBI3ExA/IsWbUrLjENQ4tuRJ3hSIq1CwcEJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CF7CHPmI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CF7CHPmI"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a68ca482e2so1336210a12.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788383756; x=1788988556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VULb9kS6gikSL4PV+t0LAPIQva7ggs1lcENE0RmVzBM=;
        b=CF7CHPmIGg5SlP9Guva8E9z24RWZg2JITS8xol9Rf2UA8kJ7pQh44Vskc+1FugBLqC
         cu3sCrlejNPpQ5+0UHQz2mONFPEBCJ4TpKL7jlVagTJlT+VXqPkiJgtsUriAcqVw8YUY
         Z1OwUg8L2DUnX2iRqaYLrjKNO8pWTvWI7pijA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788383756; x=1788988556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VULb9kS6gikSL4PV+t0LAPIQva7ggs1lcENE0RmVzBM=;
        b=g5c9Qq1R4hRO33LtGwJaLDj8IBl2KkKxIAibuOEopCpLPY59Xi4Nf43DkteTKWvLv5
         SNHoTSJdSPuvZhcLTSCDqpPL9PJ+xP/58LYWnBQgNB47fWg6+0B2nVaysVCw6BCeT8TQ
         bYTMeE5M91ca6Rw2vbx1QMCD3JTkQA0nVxhlGYwS7nqOeY0lgriFeJE8vBk1px0OOPNL
         +QDEbt+RdxeiwbDwMw9sbp9MME9UcDJ46PoTq5bbXXawUcflN9/yHDg3v/4535FA3suT
         e99kW3LBESHWJruR491KZQtWu8lIleXiWvxkC5EF/cZYnRrOYUyx8IkWkF1cI99RCjDg
         u+/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDa1EVBzG2aFzfzOLhpzq2zw+F3R7NRZfhYimqMkMoycWbeffKBP6e7/3z+vp/PWfmaAVwqQXFuA==@vger.kernel.org
X-Gm-Message-State: AFuF++l9WAhGwVz3GdaNtiVb8Me/Fi8lYOsaDPiUExBISgI5Ffe4rmMV
	Yh0XmPeh9gwqDNII6898IQTKbhfHVmgP2ps33PZyiCkJs6AFfcKlDQA/85mQnLIw93ylepF7Mpw
	wSLRA3w==
X-Gm-Gg: AYBFou2i4exa2y/TKL06F0I/nJTbfM4BEekF7ZRJK+RYROZOf0XWVfPB3iSwpDMLrWR
	gv1yFr2qfyJcuN83WjD85Chf4cF5CANba3p4K/SBowfYFHPLovkqJfv36YH/ch1SXKah474KkVW
	KGIOQ4apoH8P6yjRGcfADRznqJ/rQLQ2P0lN26BVqU62nQrG31mtn8hcaM1IWkcESnH2lkX/TNV
	RPzo7VgAGFINW+AzPZcKq+6osv+HL7VA+lkUfGWaOR+zZbF5ehdBx0F9Lx5mha8WLQPylxBir02
	S/TUuGDyd3YVQhxod1Ox7/qeKyn2eOkIUNC6RD3nhZT9wEd5wf34Ch/Wju5ybQl6sD4qHFR80ln
	LQtKVUdFJkLJIVT0mJA1pUM8+fYzdPjbcEH6K7kEpckrb7YjSdvh4kZeSwsWj73W3K5diHtYRMH
	ccRhjpez2INdH399CdpMOfvdwu9Si2sW+0CnH5DJG/R+WR2zcwAuoBMb1XGzskfnfyaJR/NEHdE
	xKB8smEDK2kPq4iyv7ZA7mluaY=
X-Received: by 2002:a05:6402:d0d:b0:6a5:f912:b09c with SMTP id 4fb4d7f45d1cf-6a6825659bdmr4240667a12.4.1788383755785;
        Wed, 02 Sep 2026 14:15:55 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41e081asm11527666b.39.2026.09.02.14.15.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 14:15:54 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484415c8cb1so1229212f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 14:15:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyZg9tkcEEAPD4hsOXS90yK+NSZxLZxDGTwMAyC4YzPIgdTCj3M6tq4Hw6MwvuoUORPo5WRn2ISg==@vger.kernel.org
X-Received: by 2002:a05:6000:2481:b0:484:3310:710b with SMTP id
 ffacd0b85a97d-484913bf064mr12406216f8f.23.1788383752177; Wed, 02 Sep 2026
 14:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821170648.3097673-1-mrungta@google.com> <CAD=FV=UDw4WEGAjr4eY2qoPVbs9h9J1SJU88OjHgTnqXUSwotw@mail.gmail.com>
In-Reply-To: <CAD=FV=UDw4WEGAjr4eY2qoPVbs9h9J1SJU88OjHgTnqXUSwotw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 2 Sep 2026 14:15:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqPTXKB2NgPS2hS5_9tdQbUyfXHFOARrX3rjzFra1Z1w@mail.gmail.com>
X-Gm-Features: AcwNN1VtZgFm4leH2DwT1nxdxS0xJOsopCt5xMdhkxv_e6dk6esNzniFp1LfiZU
Message-ID: <CAD=FV=WqPTXKB2NgPS2hS5_9tdQbUyfXHFOARrX3rjzFra1Z1w@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Add DPM watchdog to late/early/noirq phases
To: Mayank Rungta <mrungta@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 21, 2026 at 3:37=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Aug 21, 2026 at 10:06=E2=80=AFAM Mayank Rungta <mrungta@google.co=
m> wrote:
> >
> > Extend the DPM watchdog to wrap device_suspend_late, device_suspend_noi=
rq,
> > device_resume_early, and device_resume_noirq callbacks. If a driver han=
gs
> > during these transitions, the watchdog will fire and dump a stack trace
> > to help identify the offending driver.
> >
> > To prevent false-positive timeouts, the watchdog is set only after
> > waiting for subordinate (during suspend) and superior (during resume)
> > devices.
> >
> > Signed-off-by: Mayank Rungta <mrungta@google.com>
> > ---
> > Testing:
> > - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel wi=
th
> >   DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
> >   backported).
> >
> >  drivers/base/power/main.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
>
> I reviewed this patch for Mayank before he sent it. It seems correct /
> useful to me, so I'm happy with:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Since I reviewed this patch, someone pointed out to me that we should
probably also add the DPM watchdog to the "prepare" / "complete"
stages too. I know those stages are used less-often, but it still
seems like the DPM watchdog would be relevant there. Unless Rafael
chimes in and says he disagrees or that he dislikes this patch in
general, maybe you could post a v2 patch that adds that?

Thanks!

-Doug
