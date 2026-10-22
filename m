Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661032;
	b=j9vFKBc+tqfJi8qPg00OyqjX1/PwlUK4Qjnn1HC/O8TAB8B7oqdXQgSsBCULzsFKz+w7
	 xr7Noq149iXAEh9uvpxswGXb6U8r9KDXVf62hIeDk/arrvrwUwU0Ur4ZYEbg1ndwihmXE
	 i4N3Rz66ozA8cFLdgXwON2saNSwbZLBZPFMBd1fnZ/v0OjfHj1xP/WGTac/7sYhzwwAW9
	 4UQqXagY/KBPbMSrQeJzvBGhW+VO3jAr786sQ8o4OzwwGrHTj2Qv5kojCY8ex67JxkVRJ
	 Aj3pGSkvB+w3+IA0suxbrjYsC5NdkiVqfzRz++Zp4cwk2F+Q2io3WjXg6sGpApfUtHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661032;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gkhBBRoKjdMjfG0Ulhfds5pPtjNKOakoMGJLQPu1F7U=;
	b=bv3BhUtskw36oFkIn1Nk9hsfJ4Ko1Z80fTgQHJaDZn1y/kMlfdzrkd4Et5nNECyiN2gq
	 NGKDIJJXYwkgKnO4bPNldKHgEiyqq0ZUVnnb87pSaBzjm9FziqiitSvwSctzRv029J+PE
	 1cDNGh+mTJ4wvz4SYoKEwmWgusaS9LY5kjmO0wu7Ki0q7wxK6CI/xz9LugrVaW9VqF2iG
	 Oa5MpkZw7lei7SK61sf9CeL7Yo7QzD281pQqdZXwRFS+wut2lzXikY3O+QiTkcSMjJc1i
	 uIeXq1CFE9B2vko013Hx4dtPvMIj5vwnDHP88vM5Ympy+DfS+Ev7GQmB637ZK7ec9aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF390606A319
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF390606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eadea8f0edso424622e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661031; x=1793265831;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gkhBBRoKjdMjfG0Ulhfds5pPtjNKOakoMGJLQPu1F7U=;
        b=p50IOCgnvvxJ6V34w/BLu0+gQ+ScAn8kVpQ7OUtwcOynFAOaFHk8Z2ra+cfQT8ASWk
         aPRgN3Vq3anCHKjTL3NRnrq0D/9a5rUPI/5oZ+PaFL+x7jJ6fNmxuz2kWh4xsvn6SgKi
         HnFkYUlKNItEZQQDnhthZcEJ+kCLTmjHD1Oo2Z67MZMA5eSj+ylbXX66NvbipSf1487r
         CRzBs3OhXNVcE2uYMpCpAL5rSBr0PtRJNS+b2LpSxAhhxoGO1/9vJPx5I7kI819+z4Nf
         ILe7mF0rboTaXNjGUHjtLC50sSWIrnDNWucdHRAxQTHHncRA9Xw/0D933F32KvCvR1Ik
         VuBA==
X-Forwarded-Encrypted: i=1; AKwUvBx16uINcaiJOOJ3DxPWl+PKGm4LSkZu11xBEc/czNyJ7bYcrLPTujzc7pfuUX8/A81E+TUzhfn6hw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIODG3r8cq2vc5URQae3aepJaGgm+TQSiByksFGs/AcGMtopoAN
	lGaptUYpioyQ0kEyvdRAk2MRIOusMhU2HHViA6gjYKrKcqwQ8v2r97kc/2/KpkQt
X-Gm-Gg: AYBFou0Gzx2IFQYlrbfxISYcPb7fSYLpPaxrTGchD1oMZ44fH/FPY5FGLOlA6wRS943
	wAHg86RKvC3KPfX3KHFNE8ZHARQWZeZuQzukZsLIbFeSzGRxHvyY/vNxx0jPztd/D3oFu+WKsmo
	gX3GBR39Pe8ldGIsF/2fjXly9qFUc07GYnItVnM+kX3mQOr1RyOggj5nbCwmU3QEndXL3jXA8gl
	t+Ex4Q5lXMwAZiiOlLz4K/pnUee//az4Wm+Zxrb9FY8jGc/zH+RiKleXqQjzub65M6yhV7U1qvy
	+jx7uRRW6BIpPvawi8de7J7NMlkY5nGDug9K22rtjk9dg6b7NCTKjVKFMQdVppZOVJ5zD/GzoNr
	YSyDfIrUXEclwl3S9hRnwpnBmJW2O/gyA4mo2cjX59007hux/dlyensRPTmtx0HhCTA1K1RBvz5
	DUJv36w9lrcFGkhR/LNomMawrAJaS2bUdM0iQVJ2kGfFaw3v527aaDTj5eVN5qme4Jasi4GtqTq
	Few1iiI0wo6QYNpn/NyLd3ExWGj1h4SqH1sHCjRdX9IhQVzBW8S3Ovr7Fla8SdqPvtoDsVhLbER
	cXM9wRC+B7cIRkplfFSL7/4fPcRtIk2rLnP2M1A=
X-Received: by 2002:ac5:ccfb:0:b0:5ce:fc2e:d0e9 with SMTP id 71dfb90a1353d-5eafa49bd44mr421768e0c.13.1792661030827;
        Thu, 22 Oct 2026 02:23:50 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9697814sm6218867e0c.1.2026.10.22.02.23.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:23:50 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9902a746546so404498241.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:23:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx1DOPxvwHfjUDrFY/yYUhvj4nIwzwW2BKY+hdrPeCDcaWIbEquSeYTPrjXUCSJIB2ZMKMJIKiyqg==@vger.kernel.org
X-Received: by 2002:a05:6102:5093:b0:7b1:3ecd:3d8d with SMTP id
 ada2fe7eead31-7cca9a1a007mr483763137.7.1792661030261; Thu, 22 Oct 2026
 02:23:50 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021235818.3059519-1-briannorris@chromium.org> <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
In-Reply-To: <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Oct 2026 11:23:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
X-Gm-Features: AclHuK9DeixcMDu5pJYEJIO6mwWZklXvy1cHSqlxPpUgEBM8a99XYlxTEG_tKGQ
Message-ID: <CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] iio: adc: rcar-gyroadc: Discard
 pm_runtime_put_autosuspend() return values
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 02:01, Brian Norris <briannorris@chromium.org> wrote:
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
>
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
>
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
>
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
