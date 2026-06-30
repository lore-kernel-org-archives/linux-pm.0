Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2853546D3
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835291; cv=none; b=TWC215aiOfXrN6cwd5Dq3bMh2f5gDG53Z4NLiiZVqnh4mCAUaYQWpul7j+3QTwHCmZ4hDhdyArTQfdUSF9MFkFsQMuqElqmb7x3bf2oJ6ov4IU6CLXITk2kI1EVcdJl45cv7Y+cWY8S7UUencYg88eQFeX6itoRsY54SgOrff1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835291; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8QysPvsqmTaDsQvxwv/n33n5ny5/ypU6MWLqTdsYOxSWBOYmhjSCXKQkO7k98iVq6HQKKjyRsAB2XOkjUe+G9r++jy8r/IX/SUqCIU2ER5i4X9jcpqPj098ONdHPoykkwDeqUdJPJDZN5T6nOvTejgkIsXmloGswWdHYvpBHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bc4a1130adso1059642e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 09:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835287; x=1783440087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=FBbqDgSLE3V819OupoiCBVdzWENIVbHEIcS+sOzh/maS5yzNVf5ZZuG1HOTaeG2zbA
         97TxM3qR4r0vHIB9M99DosfmuQEA0A83S62uE29j2hkFlHbjUWwAkc4x0TpRKTI88sxT
         oIvUmfddpdfzG3cRT0HCbDSiAGZUqO/i4XBHgr5SEtXSySwuTRjhkM9KPzOYiavmuFlc
         fU2TrNZCJJ/fa3Vj8XUhjL7aZDNFofQotniUkyC1zD4n9Ni45M1BmGsWtZnqkyvznk+U
         m9mNic2bL4LOM8XNvJUstHHAKgRB1nJwa1wo6A3VKLAyyAQb8QMJxVZU8BykpsLK3ZZ/
         eRiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXTUqlVp/xgSLhr3MaLBrsz5nHr3Fnrb+eYcxRng9PlIqEwsPX7wct61RrXoOk7PxpT0325208vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx308IFTEfLAfnA6jVTuoqLZCvwPqj6Cb6NplZLkAVMFH3a7UKN
	Lnwdb97t41d6V92LCBruijdGX1WmB4eF/aqXNqO4PcQ0hDP74d0jHJusUrObOz/7Y6o=
X-Gm-Gg: AfdE7ckDP6JzRthijBVYOGLNgSEDwHQfORX//F8Dw2hJtS+PNIzPgmIwxbXh/xst/V0
	yCVPbek7GZPGXkTlGaV+DPAoSxhgEfii9mlavZ9fkjMUwkH03RFlgC8W+TV8Fb2eFx6KaITrten
	FcGCTjtmA+oCwv+7nYfgCDlddLQ55bF+6GpYWQRJKNrhLhVbmZRr53vqN19IMRQPDDwe3G8sNpx
	3ZH0bk5Q5pqtYRVXReDH2nZwcf1u04FS8TPWtkXVb7bOEOvLMKXnAtsWl8PcG6hgxmz9Yfkbmwc
	EAyFo4kzC+fYf/RoSmM4bHktyj0jjGdmV+tXqZJx7ApbsLx6gOgwKczaJT/pun8DrlGqkBa2GkM
	SeyFTNwO5ija0ad3+XqRHnU6I/wfxaED8t9d4zWIeQx7V8DG/C0ejJFueXTiw9/zJsyLXvuY1hg
	kfDo0tRCczl1aQPtzps9VUfEAePq8FhUCT/yQsp2vEl5bSr5fc0AUGV51IXAkJ
X-Received: by 2002:a05:6122:1d4b:b0:5bd:ac34:9823 with SMTP id 71dfb90a1353d-5bdbec5fadamr1976666e0c.1.1782835283587;
        Tue, 30 Jun 2026 09:01:23 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc18469fasm1658356e0c.1.2026.06.30.09.01.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:01:21 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-73770fd1cd9so1110069137.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqOZ5RUKRe4Nr7JlnTwDoIfAukc5I/jeBclQaM+URjw1HG7QXpKGJFlPAKQwpThG9fFvvZj6zoQVg==@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
