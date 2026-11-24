Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795501204;
	b=mQ0uEYDmAEamBSZGz5WpPujCMUzYEAaMmdymYkQaAkmIuOpOnPaa16SLHO1vZFXMGLeG
	 odqMWjKGSZtS7nxVZG9WvmG6hg6qKCBHgSWx6ASPhtyhaZr5NdbKjxcLXSQyeTpkNcQln
	 p/RJpLVjMH9URMEF7FL0/YNe3ar2DhCF89TmFzJAMB3hkRawPO0osWoStYgo9m/WwI+m7
	 7VEJgTlYkbZCiBUq2AdBsbQQOkk1T3f29wnGzlafsmUGpHgHo9m6C14nkQVk+vjdbhmh4
	 INByUci94COIpUTlNuiIA9qMk9+Q32eHGylXtjEdLNQT+dqpDkZ0mcL1U9IM34/QXXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
	b=u0W+ySKLxTLbTJrTlB7A81BhdFCknOw6KASco8sBWhynQy5nWJTHRtuVQiaUpcP55rTz
	 VSdqc4qLyqb5pPHh96mjNGd69c7GEjLLYmrh5Ak5euFk/FycmXrknP9+hAoAWmStozGqq
	 a3OLahmQ9IDJUllnpcz7Q8fVCOAOX4aW5BGJR/MQlx3lH4OT/MWJHlKYD9Fu3Cg6I+isU
	 RI5Vp11aqAVNRtyGMdxWSSNChucDuu8Fjss65u0+24ZxH6rxZ1R23GmDsKqd8y7d9Qoko
	 r30cnAykk5AP2DlAB/wxfeCdhbrTr3MZ+xnB3NDr6/0JaTO24J5FgJf51if9ettYMcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gLQh06ZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E5606A322
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 06:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827E5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gLQh06ZX
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b531cd9bbaso30831647b3.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795501202; cv=none;
        d=google.com; s=arc-20260327;
        b=i3sfgX9czuewBO78K/f/vYZeRZzBYLXwmCNkONZtbDEcFwNa0VbHL1lkzhBJw/U5J1
         Xqs5ef7NFslK/ib1yBZ80+tFtCsZp6Pa57NAF3WOBQjvApPl9u3GvGa4GMrqkMKGRm/e
         wPfeqY6cDyOsFKLSldrzLAcdj4TEhiSknNAsclwKCOIVpow5mAmaoqgL6ggsYCfMmK/w
         tKwTPWNaLgHLeXWBBhCOcY7OD5xr8Y7jG8CyDsIdsbPF6ym9itMXKIM1nzmKaO64r+J2
         7XYQe8k1QoBRgTz/7+myR8vBWBow0L+rjFK5nb8OZOzyuODhmtFxW2T7L3rpK7swxnEz
         +wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        fh=8qUbRnD3vCXpRsVT1DZSq7CVUoj1nbGzjra+AjarOpk=;
        b=rIqaFC+oMyU70lhJg5x1Bb1yxzkOa1jq0GYThBEeTSH4p2h3HPJY3gYiPIQxMDASi7
         EJ0zskHQ9Xp9bKB2jojCfrrW+LelO8J/LXH3SHpZBNKWu/Q3P5UJAKleI4eriaJw1LGn
         Neg7hDiI5nSnWaLyc0zcYggCx7X03F2GZNnEhDZPxINv7L4N5e+1+WVmTkHlJNjhTBk9
         K2tYUk3CzDUEUBGG0E8xr4nYqJVQyuWY6SUA4GloduhGLoVys28V7cfi0eDpyEE3pLml
         OgBlBrGpn95NDv6OV/t91oqcJNWKb7BvR1MNhKO/3sXXNOfym2Ih41WHN+tXbJOIZ9+g
         DEsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795501202; x=1796106002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        b=gLQh06ZXN+nXp1eeOgp/W/m9EQcb4H6xxbAtyBqkY2Re512Zn0YieDfPUaKgVNKnaf
         wsyJvbnWySDCo2sf8C5Mg56I+TKOuiVvALTqyjKc1h3eZrL+J8OIfnMcfXINEb/5SB4g
         jYSFvQACzQeoK7mOXSeU5JhFzNnUPbcoC20xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501202; x=1796106002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI4cY4bgznXKJ4A1hmZr6uhBddx8lY/IEe8WYtmh65I=;
        b=O3AmmRUHm6MPP0DUH/8BwDhKJFV12ukR37KbWsFYGNY45zZKuMbb6wHsCf+Q+23Xsv
         A6GnYTtlw0/YitX/g1sB5uqisrqYYNJiwwUiptC3HX8hFwempdtSONVKUHyKoTcH5hbV
         Vjc6P4DeX4SNRj6RujQbzLThNPqbIUr4C2oGHhMmBs6/3V6AcjnC3t4oPxe73AnGny21
         xSfZVzauWSokI60Xhg0HmbQNruWcoeEMxMNxsyN2ZshdwTCTbcT6atpiURlDYm7/rtNL
         OD9V5RFKJ12OcxLUFMnZfrCBNAkf6yDtFE5YfizZySjTB7dw7DGBolVhBp6Cw7Uy1oMH
         y+XA==
X-Forwarded-Encrypted: i=1; AL+hErGQE7H5zbR9zk72EYR+vqnqeWG3vrCUTUD6UcfvWDLYuTPR6/EcAc9SrJkAn//2k9IIidgEOfjJTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hit9Acz5vWRnSnA0obmsxsI0oXNREzxtnPlx71ah3mxbLbv+5
	FU4GmhTTzw9/estmICoHKGA6Lg3FavdVIyp6vgVEQh26W/3BrXsgaraMcGk3vOtIKFSfu279pgj
	S+OeA/WMRXFdwaGnhkIvMEM4vsHiSdc2XeAEkKKO0
X-Gm-Gg: AZFdTZeaGos6qnlMpqeEtr/yuAHxCQOPb9G8DpKSo1XOl75U2DrM6HF7QhfIBzRF0qL
	uWHpXjiN4LmHTCF4BlObtA9HjkszN/0UE4DJ5Q8AMinUVZYHDo2vmpKkKZIW6eKjzR2sBfejBRC
	3Nb0qq+gUmCUcpchWNKo6VZ00ynOtXxJMnvCB0zmtpT1KhLrhRAca98JzEikUqwTzgLh750I+ek
	2wRWUBVMVlpUoesYQAw0fJqYVT34Wf6MNCBDzW3kKWmUn2+/Rgkh+1EH3LYgRMayBMXCmjgIOmn
	3+NMpOEjbl8wU3t/8OAIRZFAA7+4FxqMsoUFcepnTb+jtQ1RCZqtPKdQ7SOKQ+A2ykemUNW4bjO
	JhpuyQW51GHFCeiFclFTVDbpz5PEP4c2T4IoqV5+nZjnjeXa9NEBKpzDHAtjYXw3BuFA=
X-Received: by 2002:a05:690c:2a87:b0:8b3:3fe5:f6b3 with SMTP id
 00721157ae682-8b520537719mr57934737b3.50.1795501202456; Mon, 23 Nov 2026
 22:20:02 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123113755.3033436-1-wenst@chromium.org> <20261123113755.3033436-2-wenst@chromium.org>
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 14:19:51 +0800
X-Gm-Features: Aa3M54ojNfKajFSsYfJiknRIvLbdnHGoigTuXBmWZPLKOqIabbjntbCzug34xtM
Message-ID: <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 8:36=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Chen-Yu Tsai,
>
> > -----Original Message-----
> > From: Chen-Yu Tsai <wenst@chromium.org>
> > Sent: 23 November 2026 11:38
> > Subject: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in enable/dis=
able stub functions
> >
> > The non-stub versions of pwrseq_{enable,disable}() are no-ops when the =
descriptor is NULL; however the
> > stub versions always return -ENOSYS.
> >
> > This would require more code to deal with on the consumer side if the p=
ower sequencer is only needed
> > for a subset of the supported devices.
> > One such example is the rzt2h_adc driver. Only one of its two supported=
 hardware blocks requires a
> > power sequencer. The driver could be built without power sequencing sup=
port and the other supported
> > hardware block would still work (provided the Kconfig dependencies are =
changed).
> >
> > Align the pwrseq_{enable,disable}() stub functions so that they also re=
turn success on NULL
> > descriptors, acting as no-ops like their non-stub counterparts.
>
> Could this make debugging harder? If someone disables the pwrseq Kconfig =
option,
> the stub returns success, so the power sequence is silently skipped.
> The resulting failure (e.g. card not detected) would then look like a pro=
blem elsewhere.
>  Should the stub return an error such as -ENOSYS instead?

I think it depends on your code? The (devm_)pwrseq_get() stub still returns
ERR_PTR(-ENOSYS), and if you pass that to any of the other stub functions,
they also return -ENOSYS.

This change specifically targets code that expects pwrseq_enable(NULL) to
succeed.


ChenYu

> Cheers,
> Biju
>
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  include/linux/pwrseq/consumer.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/con=
sumer.h index
> > d24b5af3e49b..5b3c61e963eb 100644
> > --- a/include/linux/pwrseq/consumer.h
> > +++ b/include/linux/pwrseq/consumer.h
> > @@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *tar=
get)
> >
> >  static inline int pwrseq_enable(struct pwrseq_desc *desc)  {
> > +     if (!desc)
> > +             return 0;
> >       return -ENOSYS;
> >  }
> >
> >  static inline int pwrseq_disable(struct pwrseq_desc *desc)  {
> > +     if (!desc)
> > +             return 0;
> >       return -ENOSYS;
> >  }
> >
> > --
> > 2.56.1.831.g720f3f5937-goog
> >
>
