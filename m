Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795508310;
	b=hw9S6cv47RvrhastG5lA082ysq68B+EwXIVInaWe7dDpMw6Lp/OkXWvVv6ymVkPghddv
	 uron+ziSdWLSmRhFYdU4+/YVc6rSkgPkAu9XHqSbm+Agv1luAq8c/t+9wXoVoSIfBy1FW
	 bNRolgD9pa+dS8Rn/FgIbHwW8olMqhHwWQhl0Zkh9DEI2USQjWInu7h165i0PvpKFhhKt
	 9cr6pF5rUR4U9UZUNeIyQkVPwmw/cc1YESXTBfMjLvcNobICCIB5OUv+trQiayuT7jDhx
	 hYxEtKmIGCQzVlZcGkEvLb4cMwHi99dYuo1USfNXhIwGAc0hkpai0836yLrY6LaEAvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
	b=mSuXw2J3c9uVhoJNK5xaEszlc3uyuBpNc6BRLLZ+u1jxkGGm0hR0g1wUG30QigymA6P1
	 C6g2I3ZQTgVY5uXjnsqe4Guc17+ykHb9SmZNn8bXQ8diE6L7IJVEAnO8teoGwnIlhE+Tx
	 2+wXUgb892zBCRF1/paRqo3JHKWkOB7umyqK8aUazyqK620skjO5CiodMhEMDXF8th+ZG
	 8879bDMEhwhv1IvC3QgIEJDLDYJcanPEW6/xuYzALvpQBFmrt0kb36lhf9zE5e77CjsQ3
	 eRyrxu3yPMdz2q4aaGKU+3RygU9y7Gyd5+kz3Fmvr1pO65G3CQVVxuwAQlxLbFBEyjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ll7ATE9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305B606A32A
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 08:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4305B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ll7ATE9C
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4d86f5328so27677897b3.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 00:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795508309; cv=none;
        d=google.com; s=arc-20260327;
        b=L9rYbs79ytSwH7q11CrxSvh1VabYD03rDD0jF2Zj/yawASKnZQeB4t2xPJg/Fyu3ZQ
         mMX7V6/MbtXrYrRsK4UT/sN23yfEV2JpRmy6GvOyqgerBNTYpY3VA1mQMuRiRPuie27L
         Lh32phjkaGGkTwvJoCnCSPiw7vcXE1cSi2a1P+W2aF/P5CM9TIk6Z5PwoMqnFeY2qmV/
         AT2vVwzKMgwj0bw+Q4/+SYLSIP7mrzmGDZwQiOgFgtktWFnykw0OWjRJndew/QDZlPNQ
         Z5ih+YHRUBEIBLq8hLqAiGwTMeekHKUW7xHumhUaawxt5NzC4wGOY8OMFkkZ/FSIBHC6
         QHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        fh=annUS9V4iSAmBE5qogUjey2mLdfwE0SJ2VVAPU561zw=;
        b=p0HeZg6Ry4HUAjR+hxJ57vabAYI26q+X3yN67f4gx49VIMNEWXyeK/2LXvnjxrIDnL
         WKJADOACFVGK2RoMDhnJGY9Fq839NWQ/x+rj/1Pb5pzk1cIbuEzFuHZ1Hmp4EM6/q7ka
         T3ZnVhTyi0rCisqtQMTs5Yr6AftDUS7B+8KJdWz7HD96Y9am12YpK3YAMtFh3xSs5h32
         0c0ZkZSexO0+hXD6hLbaofxX3cl33jjwGbvV7Kigyq+Q5tGapPgTEmpSa0LdbKDsRD7I
         34e9xiLr21y3HhQYECg4FU1Jaf95QfMjHduSxCXVyFYN3Ik7p+3DJlIsrFK3oh44uMjv
         pOJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795508309; x=1796113109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        b=ll7ATE9CKmIrwUX3g3Zv2JC7GAtNOZPkvnuuZRvuDOQVJHCfRZS42uyl8Ousr70zpo
         E+JUXVypDwOOTGzcQpXv5AfZBKFGfeLzBF8+2RNAVgngMOQcHa1vmynvstej+4s9Mgzj
         SX+TCBB1uf1lgyrZsPzNDT9hxJMfHhmuuSPgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795508309; x=1796113109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClzsYNhGBIDno1QrHtcA7NKXp8FCTC3k0xH3/ql+Q44=;
        b=CGlFVOOvO+4nU+ktHbD7LHx/gBNK1VvIdmuPGgfaiWUTx3dGCP+rXBCIk5Gg7z/KDs
         8p+jNLbnrGgdVhspOa1meNgDhNxt24uGrAJERatydPee74edSxGNqvmwKXx9gx/wy9w/
         p8Yv6wKzWIMdtkbY26vUyE3e4gIv6kbSOJNRYSB3B5dpJVI3S7kOBFCbWF4ebobEwL6a
         e2mTF97poRAzycLImgcZzZkKSTh8UL+zexR4rcHjvAzQhlzboRMC6QKoS5nBBD/5FHY5
         UyKJ3DCB0NY/gL8bGX3zz295VzxhMuT0VoN2C/MCRAnBghgOe7mfOT6wlZYkcNBlL9uh
         4IJg==
X-Forwarded-Encrypted: i=1; AL+hErHY7AMj8Ncl/A2pbvzAEnJqweYv9+4IQsFQ8pByz7dPyW3879+OsYQFvbaWLQ6WZiMQPfgms084lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9r1u9xRxYOQ3LGZ5Z3yazq89GxeLHmC9F7GUB8fJ0Hvp4zB93P
	8UKk+wKrBTPVOhXGQ3hd3twFbfxuN4zNuAwYiT1tpHS6KeYL0B+xmAMk+e4ZzzNwzacuvk0zFXz
	4XJ4gtkXQRTMIoTIaKwdGTLxLNgsKSKGfHBRODk8Y
X-Gm-Gg: AZFdTZd4Z5DG3TbRxmtl0jAz/YR1QYF58ew3+G1LkhZdQ/RLjemwXsFBKwU6JnuXRoS
	feqRXvZRliJmPgxLqli0/g6aw+F12hUCRSv89JZ5qFcs5yh5PJV9qo8+AYFQgCgV+XZwAsFxyca
	GKyQoBCq0pkwUIVUZ1tBJs+YxjRu8T1UW40jQEF2zK749ibOqivzAm1bCsQ8wQk48QUDCnTmA0j
	LVq6lPMG687w4ugpLDGmtvxvJMhtDMG+OrnlwBsECoKvsjE1Ia6aVXKjnKNTCdR25R5691VeggG
	On6VSuXwmW3kdgHYf29QL3jOwY2+HNBFFnE6y6EST3iR10puNS7E4rbfKgGb+jJ6kK7l9gU3ghT
	FfmtCWKX40kidJmprSkNWkqtqQTsLhSqx1O8d3NM1t1MhoDtwHZDusmop5G7Bw6Q/imU=
X-Received: by 2002:a05:690c:998b:b0:8b0:9f2c:cfa0 with SMTP id
 00721157ae682-8b5204d651cmr57190517b3.44.1795508309300; Tue, 24 Nov 2026
 00:18:29 -0800 (PST)
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
 <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com> <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 16:18:17 +0800
X-Gm-Features: Aa3M54qAJz3E4lCBf4pR4hRw8s7Agur21vfzxnOB4r_CYaJwBGfQ8glnAjpqec0
Message-ID: <CAGXv+5HmXyVn6dY3Ve6ot28p=08giJ00SoXmpfcaSLoZVgbCyw@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 4:00=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Chen-Yu Tsai,
>
> > -----Original Message-----
> > From: Chen-Yu Tsai <wenst@chromium.org>
> > Sent: 24 November 2026 06:20
> > Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in enable=
/disable stub functions
> >
> > On Mon, Nov 23, 2026 at 8:36=E2=80=AFPM Biju Das <biju.das.jz@bp.renesa=
s.com> wrote:
> > >
> > > Hi Chen-Yu Tsai,
> > >
> > > > -----Original Message-----
> > > > From: Chen-Yu Tsai <wenst@chromium.org>
> > > > Sent: 23 November 2026 11:38
> > > > Subject: [PATCH 1/2] power: sequencing: Allow desc=3DNULL in
> > > > enable/disable stub functions
> > > >
> > > > The non-stub versions of pwrseq_{enable,disable}() are no-ops when
> > > > the descriptor is NULL; however the stub versions always return -EN=
OSYS.
> > > >
> > > > This would require more code to deal with on the consumer side if
> > > > the power sequencer is only needed for a subset of the supported de=
vices.
> > > > One such example is the rzt2h_adc driver. Only one of its two
> > > > supported hardware blocks requires a power sequencer. The driver
> > > > could be built without power sequencing support and the other suppo=
rted hardware block would still
> > work (provided the Kconfig dependencies are changed).
> > > >
> > > > Align the pwrseq_{enable,disable}() stub functions so that they als=
o
> > > > return success on NULL descriptors, acting as no-ops like their non=
-stub counterparts.
> > >
> > > Could this make debugging harder? If someone disables the pwrseq
> > > Kconfig option, the stub returns success, so the power sequence is si=
lently skipped.
> > > The resulting failure (e.g. card not detected) would then look like a=
 problem elsewhere.
> > >  Should the stub return an error such as -ENOSYS instead?
> >
> > I think it depends on your code? The (devm_)pwrseq_get() stub still ret=
urns ERR_PTR(-ENOSYS), and if
> > you pass that to any of the other stub functions, they also return -ENO=
SYS.
> >
> > This change specifically targets code that expects pwrseq_enable(NULL) =
to succeed.
>
> Can you please point me to a driver which expects stubbed version of
> pwrseq_enable(NULL) to succeed?

It should be the case if the power sequencer is optional, or rather only
needed for a subset of devices supported by a driver.

The rzt2h_adc driver binding to "renesas,r9a09g077-adc" does not request
a power sequencer, and thus calls pwrseq_enable(NULL) in its runtime PM
callbacks. I'm arguing that it *should* work with stubbed pwrseq_enable(NUL=
L).
Obviously, when bound to "renesas,r9a09g057-adc" nothing is going to work,
because stubbed devm_pwrseq_get() returns ERR_PTR(-ENOSYS). But that is
expected.

The rzg2l_mipi_dsi could be another example, except it works around it
by putting the pwrseq_enable() call together with the pwrseq_get() call,
and both are gated by a hardware feature flag. And the driver never calls
pwrseq_disable(), instead probably relying on the implicit disable when
the descriptor is released.

A third example would be my USB pwrseq integration [1]. Power sequencing
support is optional, and the pwrseq_enable() call is currently gated by

    if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
            return 0;

which would not be needed if the stubs are no-ops when desc =3D=3D NULL.

And there's also reset-rzg2l-usbphy-ctrl, which has:

        if (priv->pwrseq) {
                ret =3D pwrseq_enable(priv->pwrseq);
                if (ret)
                        return ret;
        }


Besides making consumer code easier to write, I think another point is
to align stub and non-stub no-op behavior. If "desc =3D=3D NULL" makes the
call a no-op, thus implying the descriptor is optional, then it should
be a no-op for the stub version. Different behavior just makes it harder
for users to write code around it, or making POWER_SEQUENCING a hard
dependency and not dealing with it.


ChenYu
