Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8423909F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800122; cv=pass; b=Wj3ZN/qm7ClXu4e0qT3Yq4/LuXxgsKXjLEKXNY3Xc6K+ShS2PaPBwQEXKb8CzKWG0GLjmAkAG6YNpg+O13eNOE/wutp1hSkCfQJAkX1z/evgVkUlquIrZDobPnIdeKx5JRugYyMYwvGCjWZrjIVcNLpITPn3Np2UVqpfWUI3Sbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800122; c=relaxed/simple;
	bh=NPceGcX3PswichgjQ3Txb5qWCLz/58AAZcjid0lj8wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7RNExAsEW3ITiU2WpGOzUYx9hFcKoLNHlcvWpmqCiXeIcNcsmsc98mW+BAZb8qymLSaCBt4sqGLhrjZCdm/Q3I51ffg4DBwhHvRhPsqnoEU5zdHcflVUYIpkqEKYByXKCYq9M5URfjz40t12Ck3NBUuKTX0GKiYwyglYvcCQow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMHj5qIZ; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMHj5qIZ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so34723538eec.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 05:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779800120; cv=none;
        d=google.com; s=arc-20240605;
        b=Ftj2wibNd5GTH8TIuxt+J3LfEjJbFtGnuSogOSXwW3lXQZPLK1ZJnTcggqAfYC4Cqc
         QF4LoTHL9mjbbYIOUNmn7lQftwwl4Qcu71YKjdIjKQ5IlNJDG80y6SCSBBMHxX4fYy9i
         HGM/rKvkTJABeHy2vHsyIiLVGdMKkm3ogVF+Ig/ro2xRKffiLU1FHxEftPhEXYdCP4WG
         j2p9FD1okL189sqo6X2zVY1+uAeGaxzxAI5AAsnICBYIRqjVbtptYEZa1k7tV/T7xkj1
         ikyI2BOL3UqXxo54DDvLxqxsZ3kqBY38zepXY8TYCvA9SnYYhHneQLlTSU5AMd19gM7C
         gTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kzs/MAQKWcUn71oLtzdfn8RCw0kMPvaTRDu9OkTS6Wk=;
        fh=znQouLyXvq2YbiOM6b/DNdbLPh3z/3cQG6wO7vioiK8=;
        b=NSz1GTeErTVyc/qBPn3Ks41TADqC9pb4lpK/zyWGg1ORi0bQto4sA+BsAX+IkZv7gb
         UgBT0xXIIxl9ffRtf9cfAmMkXhCuZOeY6Va5VbBBaX2EpEXjNioy/ih+EJab+GC5Gx/M
         kMINYr9/b1AVdkV5sUhAVshetqCAJ8bUgzh/psGUFaA9UajXmhv/XVnPeJ5f25/mSbp4
         7S0acLpi+YCLN27JAFsi4rAI4qFaeqNnfThVfT656EKzKGJZ58nfSNJWjb6QhDbx8as9
         pBMOjKAqyRJUzGFY8eEMYGSakmy2Nu4b5vq6b6Sprf40CZtb3fsN2H17vTk/VNzdCyTc
         srCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779800119; x=1780404919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzs/MAQKWcUn71oLtzdfn8RCw0kMPvaTRDu9OkTS6Wk=;
        b=HMHj5qIZOSSAZ3YUxZvOk5DybWyUJ0KFBMaYJQ7yP9DS1Zq0n74/jikx6k9tk6wixN
         yDqxurLqxjoxgVMkXvLDl+M/QVeQMXo3GcMm1XxpKhlIbvoiKKOgUnAFvlz4/bBDdvMs
         Byxml+vTBSuVk3MveAwMvwhPD+0PwYIlSMTBYetjisHx/4J+5e7owBalLn7pzcDNj373
         VQLA9rv1GI4XN9GsGUSoQYmTnN0C260D4hB5MB4TuW57cQ0hxhwMqRsqrW2SF+pPstsM
         A2DUFb289rm2dL5MFZ9b18ybVJ3Px5jRs+/OYufoANM5dh2vGR33SaChwipGDb9CylEl
         6aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800120; x=1780404920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzs/MAQKWcUn71oLtzdfn8RCw0kMPvaTRDu9OkTS6Wk=;
        b=ebx//YeVlFi2M8aQs10NI6sSJ5sz8DC/rIq0yGaWqK4UbF6JLZ6a4387O3/f5Z4sJI
         /kj8Wyh3CUT/Lm+KnIsZ/Jc92CF0MXDian526yR46kFeOzdOiEccVS029fCOgR/6+HqX
         aR26JTHo2h9tfzJqfwO5vdxft3i+ngzfW/UuTVqM4NhAGMp2pIpJ1ZfLOidHtb8U9Grf
         BEPz3ZfPIAsvaoMJ6oSzOk47S5g+RjKQvNzUtEfzNMxI+fnKt7rumChY29P7MA41uygb
         19p3Q/WMHRkQoTAxOkphM1gSsAMcO4i+oi3vmDy3zKa5Of34Q3+IrHvJXEpnTzAHqo5E
         6GxA==
X-Forwarded-Encrypted: i=1; AFNElJ/CGSsQabSVhFBSTGmcaoYx2PatQ66xAxI5DMoKu0s71OYsJmAZf0wyKG3ZuyjXRepWE36UscuANw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjI0oBM6NnIdob+on4g74PPrA8SkQI7rmAUUPIugVhHjE6bgO
	xGMxOT0QFmpHxt6XLAy0H7muLNHOHT5RgNHiaA9+zBGnPIvj+9x9ShgDVXAWctbkWJ0EvTMzJTG
	umHd6UyDs5P+oyFGwOj075TUXXBRvEmg=
X-Gm-Gg: Acq92OEZ0XWFUtk6atUODbIoVpn7DvgNw08INW2EzFMR+nGnCycYSfPRMln8rs8RAjJ
	qHrQ4Sm7xw+0GLxymZo3xc8vPsymdEp7SzI4BN+ic5smeJwZFcPJy57wgGyn8PmQyuGQgaxw0aX
	ssulndz7To+ikJwAGI8Ny1+vNcIaxiM0ONHddRMFpYXv94GY/hs0Y1h9epwLrLzC9x29ne8g4F6
	01Cd1CSo+V0W4A/qN8HfI8p4Crtxi+66BBufVjgNY0YZIS1iBJN1tMVrKRTD7dFFfbYR23ghQ+4
	c0+OFep0
X-Received: by 2002:a05:7301:d0f:b0:2ed:e15:c923 with SMTP id
 5a478bee46e88-30449142740mr8172308eec.31.1779800119575; Tue, 26 May 2026
 05:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
 <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
 <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
 <CAPVz0n2P-zB1_uetZN9pVcQChK+FkdQowbF4Z0YZOBQBsB76WQ@mail.gmail.com> <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com>
In-Reply-To: <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 26 May 2026 15:55:08 +0300
X-Gm-Features: AVHnY4JRp0uoVu7T9D5O6sRRvjrX-3sJh-DKTWd-v6Qt1vrT7npN-zOtTEgIKHE
Message-ID: <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 15:3=
5 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, May 26, 2026 at 2:29=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
14:14 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue, 26 May 2026 12:03:59 +0200, Svyatoslav Ryhel <clamor95@gmail.=
com> said:
> > > > =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 12:51 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >>
> > > >> On Sat, May 23, 2026 at 10:51=E2=80=AFAM Svyatoslav Ryhel <clamor9=
5@gmail.com> wrote:
> > > >> >
> > > >> > Document the Tegra modem pwseq used by various devices based on =
the Nvidia
> > > >> > Tegra SoC, describing its usage. The power sequence provides int=
eraction
> > > >> > between the modem and SoC-specific interface configurations.
> > > >> >
> > > >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > >> > ---
> > > >>
> > > >> ...
> > > >>
> > > >> > +
> > > >> > +examples:
> > > >> > +  - |
> > > >> > +    #include <dt-bindings/gpio/gpio.h>
> > > >> > +
> > > >> > +    pwrseq-modem {
> > > >> > +        compatible =3D "nvidia,tegra-modem-pwrseq";
> > > >> > +
> > > >> > +        enable-gpios =3D <&gpio 165 GPIO_ACTIVE_HIGH>;
> > > >> > +        power-supply =3D <&vdd_3v3_vbat>;
> > > >> > +
> > > >> > +        nvidia,usb-bus =3D <&usb2>;
> > > >> > +    };
> > > >> > --
> > > >> > 2.51.0
> > > >> >
> > > >>
> > > >> I assume there's no such component as the tegra modem *pwrseq*?
> > > >
> > > > Hardware component, I assume no.
> > > >
> > > >> What is the relationship between this node and the "infineon,xmm62=
60"
> > > >> compatible node?
> > > >>
> > > >
> > > > The xmm6260 has a phandle reference to it. Since there is consumer
> > > > matching logic in the pwrseq driver I am leaning towards removing t=
his
> > > > node entirely. This patches is still in non-final stage and I would
> > > > like to hear any opinions on the way to improving it.
> > > >
> > >
> > > The node attached to the pwrseq provider device should represent a re=
al
> > > hardware component. Are the enable-gpios and power-supply lines conne=
cted
> > > to the modem package?
> >
> > Yes, enable-gpio is connected to the modem and signals that USB is set
> > and ready to work with the modem, while power-supply is an optional
> > supply connected to the modem's vbus input.
> >
>
> The modem is a hard-wired USB device? Do you implement it as a
> platform driver or a USB driver?
>

It is not a traditional USB device. XMM6260 is an embedded modem used
in the Tegra phones, it is linked with the AP using USB line in HSIC
mode. The driver is implemented as a platform device since it does not
interacts with the exposed USB device directly, it just ensures that
USB device is properly configured and is ready for IPC.

> Is there a connector of any kind that could be used as the HW
> component represented by the pwrseq device?

I assume control over USB line is the HW base, but as I have said, I
can integrate binding in the modem node itself, and pwrseq can get all
it needs from the match. Pwrseq framework states "This framework is
designed to abstract complex power-up sequences that are shared
between multiple logical devices in the Linux kernel." it does not say
that it must represent some specific hardware.

Using pwrseq allows modem driver to be SoC independent since USB line
handling is moved into SoC specific power sequence, and this modem is
used in Exynos and OMAP too with similar setup but they all have
different USB controllers. Maybe you can point me where SoC specific
USB controller handling can be implemented?

>
> Bart
