Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B94749F4
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348860; cv=none; b=RYeNHnJ8RCAGDUooRvW2CQ19MT8bMhMcxJI1PHgWOtK7MNOVM9/t/rAKJHAyl4ZwxPRNFeXrD4OUxOZbuilxn1VqrwRmWJ2Zsn5gCHWBPqU9Y6S4ifEKw4lg8fYR6ZD0uJ11Qsei6wUkk0tJTF+3rn5LdIPDr5JS6n/fZDDGNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348860; c=relaxed/simple;
	bh=c8cVDH4+60eN9JY5piPPVSkAJg5r/Dt287R6xlSNjmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqysoQcRhOqE79u3zIT2nrw/jQny+gQ0HYDdfl64GOSADHH8lhBnq0zxMhaNAEwBl1HKfctSirDmQRf0z+XT6aH8Zv6YkBqwFjAXdFzhqZO4WaeE++oASsF38OWRZgG1LKVjEjgJvPCxu7w4EfVoHwiF1KGpLtUO829X4UBbha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-785d603efdeso366757137.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 04:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348854; x=1788953654;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZX9X5hy8bWZKgZ28xeKzE387jyLfPdvXwed5OH+/3k8=;
        b=o8WV+Fum2jT8j4sSImXq5o1t/Gqi/3d0+9hIlUBdhVM5487WCUOJ22+bcY33jSZgMp
         Bv+f41ICfntXeiIHV5IuoOS4p+tOjEEVojjtaSywlo2vJ5H6UzjYS6OXo/XHBi0J2/35
         7E+UP4UkpeAAN9MznDvfrRzu1Z54FqCu5gR7INhxC/KfIiKyq7XMbYc9deGAil9cKWg4
         gE1T1OsluCKE16Tk7k7llc9Vir1SNHNlG0DIX6pX3jT9kGWeH8wvCzykPoLPpKDl+M9f
         oJkTBgWyS0qCKtNk/9WOEx89XALp4E9n4qnrHXWAu3yQ5Rsgb1Uv5gw9gQztfKE+a4hf
         7oMg==
X-Forwarded-Encrypted: i=1; AKwUvBzMuFzL0LU8c0o5Xdlmd/fGB/2QbEnSWz97FhmRbxDmQHTUbm53aFtKiZ50cEF57LJsh3rcPeEzfg==@vger.kernel.org
X-Gm-Message-State: AFuF++nRA4dmuFJhTuKkGBOb+qiwFKEUCU4omvNUVYR+IWOCPYbSxXpM
	RtVBfsFv3JJgqYyA4H3oKlzYVETCLvs9RRfMKTFSxSd3TxONMN5/VGTKrV4hcbmU
X-Gm-Gg: AYBFou01usJokJmIjB/YaITbm3YHYmFdj5q/FhzRavSHp86EXZiKM4D8SlorlG375wS
	Ykr7OBAGOz676mgwyzqPSXaLr4zRGaW+K6ozdAvHyaD28SWqd0qRUNtPnDVTfuAUjMl4SiOiqC2
	TzHEP7OA7y0KoJ4uaPpyDIVXixjZjw287Nf6S1Lq7sC9c+bZ65Q3uRjr1QuAmuz261EaAx09TDA
	FpTKr4jk5ddrenp299wTAVcelG12CvAsH7I27duBHppuairnHPDJXVPkY0oSqlbYAijLIvHPURN
	had+8iTU0EgetQrPZIUClbKlL13/PGv6kjLHuAThm6LBpXuuZ8uYH0qBvCgCo1oM6m3nOvH7Lwe
	s6RT+M6hpfIS9Brf26Y2bePoF8T4QSMT1Fh0NxuppOZFmb0QjucG/ZpuxtCAbOIoQoOSaSod9q2
	BPJEj3BMTgXcz+ygT2W20tAZ378iwuWLBq5RIcu/4zKP690auNRrtFAIRghwlhl8rVayWwjQGuy
	8e7Now8QacqIVJCHmrA8eG9cGtlXlu5iUSB6g==
X-Received: by 2002:a05:6102:3c8e:b0:78a:8a0:7126 with SMTP id ada2fe7eead31-78a1f3178a6mr1345636137.10.1788348853811;
        Wed, 02 Sep 2026 04:34:13 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd76ac6csm1772366e0c.6.2026.09.02.04.34.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 04:34:12 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-784980b88acso405120137.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 04:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsZiBzrduYkIwIyJuCYQEYQBxKQptoBdYjt03CofRJNHZ2WXXS8ZjF3h/qQ6MiWw2ltjz7oc29Lw==@vger.kernel.org
X-Received: by 2002:a05:6102:6d2:b0:77b:2881:580b with SMTP id
 ada2fe7eead31-78a1f1aff84mr1204735137.4.1788348851833; Wed, 02 Sep 2026
 04:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
 <20260826122742.153643-4-biju.das.jz@bp.renesas.com> <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
 <CAMuHMdXmn7B_UOb8f2j0_BOx3d55nA0-0Auay-HLFYWtziS+6Q@mail.gmail.com> <CAMRc=MewW5aLqY66i-uUor3ke6k25rjZh3z7Cn76e_KhHQWoJA@mail.gmail.com>
In-Reply-To: <CAMRc=MewW5aLqY66i-uUor3ke6k25rjZh3z7Cn76e_KhHQWoJA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 13:34:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN_JUzcF-ueAABOsfvvYuZ6r8Zf_vcBwsrb5ArVXWriQ@mail.gmail.com>
X-Gm-Features: AcwNN1VKD0uOf2MvN-4alfN6qZQtlFaKLsibUAqjRFeDI3iaU25OL_kOcxy9-xY
Message-ID: <CAMuHMdWN_JUzcF-ueAABOsfvvYuZ6r8Zf_vcBwsrb5ArVXWriQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Wed, 2 Sept 2026 at 12:49, Bartosz Golaszewski <brgl@kernel.org> wrote:
> On Wed, 2 Sep 2026 09:10:45 +0200, Geert Uytterhoeven
> <geert@linux-m68k.org> said:
> > On Tue, 1 Sept 2026 at 18:15, Bartosz Golaszewski <brgl@kernel.org> wrote:
> >> On Wed, 26 Aug 2026 14:27:25 +0200, Biju <biju.das.au@gmail.com> said:
> >> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >> >
> >> > Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> >> > which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
> >> > SoC. The driver binds as an auxiliary device to the parent SYSC driver,
> >> > using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
> >> > {usb,dsi,csi}-pwrrdy pwrseq targets.
> >> >
> >> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> >> What is the merge strategy here? Are patches 2 and 3 independent from 1 and 4
> >> at build time?
> >
> > I think so: one can safely select a non-existing symbol in Kconfig.
> >
> > So once you're happy with this patch, I can take patches 1 and 4
> > through renesas-devel.
>
> I picked up 2 and 3.

Thanks, I will pick up 1 and 4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
