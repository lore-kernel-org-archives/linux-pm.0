Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565202;
	b=eHozXjrS01BZfEoSgRzLzq92DmYeuC3NinYoKiu5NRV3cz4DEeQYNxMmq/gkxPeNN6xd
	 9pND4CunxnWDr7qEYuu14/NTrhlqTNa25P9wAkfCNCzzj1axdBI2OJOduSaVxtQY/mfqq
	 6+46tnf3PJnyZZP3serlUb/tM9rbuWx0VRqe8Cz5GayFK3Xrakw5wx+7AUuwMW8PFenhG
	 6fsUDWa7Mgt93eYhafhzWevuorAKddxWvH6qd8qvSWrRHeqyPN45CGTNuWqAV7fZP/nG/
	 o/rAOygr9li3nLuKc3TcKUCRGpy94T6168v+LMiZSvfU0q6eJJz7IGme/u8t+kFAKTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
	b=VHV4Em6Gm8LhsxY9Eg0W0TgLxWhvfrmyF0nxeL+9JytJ/eHt6xoG25Esa2gYAkLcpMvi
	 7JendCjbEHV4l+W6Xtq3GQazZCdbPgozj4wrLm+LTcVy6nxzVRvpSSC8deSs7JcGy1A+Q
	 E1PXY7jacFiS/kFtWssNu2L+GM1+jjZ956gHGJpfTH9+9/WvCyIpgfiyGh5XK9/W/YqUY
	 8eJX0cjFXhWWnN7SEx65/37XQJgrFWRBmvbmzr4Dx2Jky+CR+hdEp0Rwz8tZBFGNg6aDT
	 1lOIL7A8tgai/onYb3gi0rKmSmvoqjwrr9UsYPjXDvFZHQn2TUfShUKZMOmFQrXCGkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhmxhi0T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DE606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhmxhi0T
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35c76e9614aso705230eec.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 23:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565201; cv=none;
        d=google.com; s=arc-20260327;
        b=e0R3/Olr9WWwOqHWCR0bsnFL2bkbmj1TjXdXNY2CrX6sKl7Uo0k3zCk++OFif/wI4T
         uTWzyUXii6vXd67a0yOaBh/EY6wlT6CKYLi5qnX/98o4UgbILHxQSr1Mn6nKFYldB0KP
         mPfO4KRr4OtBCsuusBPYaWZp6+gVD6BBKg6iD7sGlVm+j8UFLbls75J129HuP+ORX/Eg
         8bjL7SZxVQBbB1F248KoajaXRLVfWCXIbTyhyLJzThwukpW++877lHdt62eS6fVClsOA
         t60kgyQyV/WXCOC/sl81C03mR+su7hI2uC50lX0/dtldmnTWfbAxzcW3EKDeE3B9p8VE
         k//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        fh=Z3HQ5j4qwMJ02HadUSnYwoevDERrrPev7kz0SglmG88=;
        b=e8yFlkThUB3TqMAfBFS3WWCEF2pcrPahh/P3rnzIPb9iOWwU5DboUSLyTNy+StLc0D
         G6+cRT6tMxzz1pytjIR5GLRoPbKrWteYU/UalXyAqH9+JI9pyDDbCcHZ4G4lC/k9zsQW
         h9CdKoR9Q3AwSnORyZs9yOpTesY7zM6ZI2l6iFE/sYBWIHMQHAkZWX6clETQvdclDGLC
         bia4JnJ92KEpfonoHkSQQgmOkScikAWaZlXGj0hXufjggVjxrJE/Nripc6kPtajP4JN1
         UXA8r/eGLuMOPqgTbstzsbOmPoh7Xq6pwkCxke4udukHnJwiiHHAsCjRyUZCgZuCFQma
         WbuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565201; x=1793170001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        b=qhmxhi0TbMwtXBvTVlFY4f2LPpHPl8poznD9dAUHw8+/Z9wZhQBqqYwfND7kTtB/dj
         BDT7fy1OHPOT3SsXcIJoCO2P5QWvHhSGsWpWrDlHwCxU3wdGdBZJo+CJDKK8hjNN6KtJ
         ZTBEpRPZ/CzppBKznbLND/WVtTUpHxpIjv8l4Dszl6GShVbqspGQMSfdEn1YLZCusCt9
         8XZUeUrLgiEXnrc9s2V2o2rhr6TPF2UsE6frYfs2vuDhFHmb1RIg6wUfaQGU2siObxeN
         QZxhnIASpBqZUpMRUn6UfJAhdRPi9Cf8ml1LkjDPLUFZ1OJH0H7A3t4eraOGGpReFZps
         J94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565201; x=1793170001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        b=n+3E5lSV5yxkG113fAiAqQ7e1GXKtkUdCkUBb/JHoTeBVrHCXmi/t/4dHbOPgRjH/C
         REsEqTB6iDHuEdFC0djvu5m0qL5lppd6Vh94xRyMbuhBsiuBtx9zssWbLMyo3rsae4Wy
         V3m6kqi+D70wM3XW1lOGpT+tErsEIHBPHVPu8mzE8rjxIGnF5nSo/0ShE/6ocxt+GR8z
         uPDwtVp2AihUckKKy2KaqLPwa1efYrq3owKckr/2u9VCWixfwkMSpOJ3FwgL55sWOYOs
         KZEGpsOsEdKB7QOx1FcVeVXaGrLjzhI4uq11KVtCeAilfi1LLvv3HIyaZzS0zaWfynq/
         i1kg==
X-Forwarded-Encrypted: i=1; AKwUvBzn6GZRkKJIvwgpAdSmuwTE2acWTMZg1ds97/2LrraqDiCqCBcmtK5CTyrs4tsv5nMZG5HX85o1Yg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvfhc1IAHMJQZwxx+It7j4gueDJ1Jd/49d6+mGG3YgxNk0B1Dy
	bknyvzlNjOIVFkzIBdikT0BKM6QoqTY9+fAe8wl/9EQwh6EqnGFs9kadwjB8ZsCfcVCz3E5pTuc
	P+7HBbLzkIVwvh8Gtk7qcQFvN04o543E=
X-Gm-Gg: AYBFou0NzYrj/PppwAijDUT9qxRdZJk3WAGxt//EMZlHtyaFJckMx5i2KGtPj+ehvTU
	bVJ5JkAQ68GTtGVVEqjNRYwN/TNvKRD0bha+fzlBfINi4lxPQLZe9HvTCBA/9/IDkVF7MUeSnLX
	nhKe9l+6zR1U9ui1e5e5aI7RFpLD4dcS/8WgwO9gV8ew5WSvDa3kqWZ2wcdssByp/r/iV89e8RD
	sYAOymT00kC3Dnd1FTWpKcNsC2QLL9KKAUJbvOJmF2raD/Ssm3e9iTd+JqBsOY3MP+2CkxBhErq
	CFGb+QfUF9ZMBaljWf2o1L4muXoUvENR2D6cGRa3J+EckHye0dNTOC1UVLIcpt96aWVLHMDbuYd
	Cg+9lOKG+8wvnUAzyKkFgvTl+ml6zU1JVLD3r8ZGe1sQ2JpX6d5FpCUf2vailRDQP4ODx4w==
X-Received: by 2002:a05:693c:88c7:20b0:366:703c:5f0e with SMTP id
 5a478bee46e88-3674ef1f33cmr2092100eec.35.1792565200654; Tue, 20 Oct 2026
 23:46:40 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-4-clamor95@gmail.com>
 <ate5K6ZdrSoBUI08@google.com>
In-Reply-To: <ate5K6ZdrSoBUI08@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 21 Oct 2026 09:46:29 +0300
X-Gm-Features: AclHuK9vSBGobmYgXVnmsJbAb2zJc_kKp_DYHLaIwx6A0bp9NGDYceSKiyk9FqE
Message-ID: <CAPVz0n13NFbY1ChZRkc8_2CQd8HfjahA-gcRWzxsv7KbAxf5Ag@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 20 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:0=
4 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Oct 19, 2026 at 01:04:02PM +0300, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add input driver for ASUS Transformer dock keyboard and touchpad.
> >
> > Some keys in ASUS Dock report keycodes that don't make sense according =
to
> > their position, this patch modifies the incoming data that is sent to
> > serio to send proper scancodes.
> >
> > Co-developed-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> > +static int asus_ec_kbc_probe(struct platform_device *pdev)
> > +{
> > +     struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +     struct asus_ec_kbc_data *priv;
> > +     int error;
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     priv->ec =3D ec;
> > +     priv->parent =3D to_i2c_client(pdev->dev.parent);
> > +
> > +     error =3D asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> > +     if (error)
> > +             return error;
> > +
> > +     error =3D asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_A=
UX_SEND);
> > +     if (error)
> > +             return error;
> > +
> > +     priv->nb.notifier_call =3D asus_ec_kbc_notify;
> > +
> > +     error =3D blocking_notifier_chain_register(&ec->notify_list, &pri=
v->nb);
> > +     if (error)
> > +             return dev_err_probe(&pdev->dev, error,
> > +                                  "failed to register blocking notifie=
r chain");
>
> I think sashiko is right that we need to register the notifier first,
> and in it check if serio ports are ready/registered or not. For that we
> probably need a lock and set pointers or flags in serio's start()/stop()
> or open()/close() methods.
>
> This can be done as a followup I think.
>

FYI, Sashiko likes to hallucinate. Initially notifier was registered
after ports, then sashiko suggested to move it before. Then in v10 it
fussed again and suggested to move after. Then v11 passed without
regressions and now in v12 it fusses again that notifier should be
before.

> Thanks.
>
> --
> Dmitry
