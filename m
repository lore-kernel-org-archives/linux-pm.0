Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AA37F8A1
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775941; cv=pass; b=Sfi7vwtkZxu7B+SWbjuUu0b5QpOxVo6iPNjCI6fgavtqTcEmMKBPiG9KCe+Hv3YaMUPQuv4SHjlsIJ7iM2rxdozEgji8kv9+ZPjzXgJuqMi63yoKFSH6AJ0KXD2uUxOe0lLsifgFZWoNTzjDuFBMZAFw/i6defbbgXtBbQHgsvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775941; c=relaxed/simple;
	bh=6WaRfwC9Cd5kM/ixVZ9/4tMUscSveT87eGc4uHnIFFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWdnindhB73R4/hHYyDhuRT2H/hSuAGE8OiiW/hjZfXUj8v4hEepmjUHEo67sLa21YvrPChjo0RtFqttXINwOhESCS4ToY60YS4oDu7BdfZP7SmlW/b3WwgQLV4Szfi4PDpXuMKpGuCVx+/hViPGnSYt0K7XdMNuTFSmXO+xedI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzt93V0f; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzt93V0f"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bb7d20ad9so996402eec.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 02:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781775939; cv=none;
        d=google.com; s=arc-20240605;
        b=XNlPmsGRn011avY1YOG7su7+uBoe4N2i0lKXzQMAJ1MnJ0vRZrrB8/jwQlDBoxaJj4
         aXGsa+FN+u4NCY8a5NZ19Ev1xKkiB1RY9piFQ461Lyn8aj/wixy5TfVxXVzAQUOJANUc
         bRczR7aoi4X6vnx35zFy1jMjv2VzB/rB/Lhyz+NSwtB93LpPlOIkcAXHbBs3A5EhyDr5
         ntFYc5y4SOM4pAv4xai6WlFBX0E3AGonF1iWefgFz5p5AIvtQ9gVwgXPOYM9fbrc9kP9
         sK1gYiH3E6qBwpoxVQY7J7w9sICYCbL4OBdV76MWmfKYZ5OVKqS3wJV1E/MfxWPZULjX
         3QiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6WaRfwC9Cd5kM/ixVZ9/4tMUscSveT87eGc4uHnIFFc=;
        fh=SXh/yymLQKxc75nt7ZMmnlrUvysIgWeAUzYQlKBpXmM=;
        b=VOf2268+oYOZGl99Kgo3SxKi0JYzqeLIOqXseyY7t0Z8Me8Ztiwt0w2+TQigTUIkUO
         wWle0LWDO4QxJyEkD6o+dMx79o3bXk3KpCzzT2hwK7vV5lXRKNAExxxP2JfDPkAa7np9
         WvzS0t73moVXPpKpicjqzO42q9nfehmZyoGIFRiXfuVS2jrnRMrEgFe3k579YhN/90XO
         9XcnulDYp91eQDz6ybilyyzqogtcnAzQcfT19ficgDnMcdoX5MNd2lZ7srJCjQkYscAt
         aviVUvWV/wrj9aXRExWQLKzK6Nf21bJIy3TF3VmxTh/p1I///yO5w+s++U+VFVzimdCS
         4Otg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781775939; x=1782380739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WaRfwC9Cd5kM/ixVZ9/4tMUscSveT87eGc4uHnIFFc=;
        b=Uzt93V0fxC7tDNJATZGvQ0/4lzHFccitA2lXeDlZHGrEjcIQSKnBrne731repvUD74
         W5/RQ999z+zohFq5ghTCIQ37NQsuSIGYY0w7GbWO2boR/ICn628Ud3Km97QYNVYsdlQh
         L3WDiVHdar50458I8k9cwpal600yaJJ6WmwyL6Caj2IEtbRoER8DJwzCbZz6aFu2NRTj
         S7p8l1304sP6G/XXjZKem+lx4Sv7/NmQFwF2fo+Y3X/0rVop2VS6HvLXzwaLzG/oG+dt
         RB+OQWxVW0ydv6FfKVvvr5dxLAac6XQ83NW2+zi5QZ6YJ6z2dwUrR87uBtWcXJs7rrC7
         BdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781775939; x=1782380739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WaRfwC9Cd5kM/ixVZ9/4tMUscSveT87eGc4uHnIFFc=;
        b=iF7xRvg221vSY9p5ow5TvGNmqteReEcu75mya8taUlJXKswTI1G87iBzPYclnXkrSy
         IsuAozSsYfIcl+08Zahui9afyhUnOAVKnTfL8Z5cGvRU9NkOhywXjZsaEYIj65l89j6A
         pLTKjjRIlMH384SuUBMwkGTR0lz/8A4nVj7ZFAlfim3aX6hZjlOi/5rPwMH2aOzW2/Aa
         A2b6JPiqC1icYgU7Hqe9ZCuR5VyygDeRWcshC7hwv701bnfATjI97es8KgIC7r+Uuy2S
         aunk3SjlvshN6d+2VABqfYcTOwp7pit57/WGvoZfoQ5rSjfM95EQ3arnCakuN/wpEYTo
         GofA==
X-Forwarded-Encrypted: i=1; AFNElJ8fkfi1SipHBP5UDE5BY4dxSAkr2y+LxJ/NINW5ERQJDAh/2j0AnNLSBFY9uzL+WU3KHkEIqm4yLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtafH8D2EM85zO8MpyRnbaAqzoKz6VObLxQkHa5zN7y420OEX
	DIAUJrg/8NyhLf75g/LIPp9TCH+BKEcFIrPrE2XKHHpaK6Vx75YOBj8F8DXgB4tFP3WUL/XlS8c
	f0afZAji8mOxV2XrKrOLDl3+kXEqIVwg=
X-Gm-Gg: AfdE7ckdZiGmaGqGCX7gngtpDEdTqi7wQ3hGslYv/UTtzVaJ/+cC3V473TRQx1vqEcN
	+BfxKL7/f29ZlPu/k0Gmhfg5GHBo/MOWmmvLxFObcNwg8qLjQt8Bt4Pg2yjGDrjDWt627ohPZli
	heH125csZ+oESP1GRLyvYFBAFp6jw6U0VjgZjxUbtgEr+nJ4HJrdcS5dDDvgAOQ5b3xe7yoa38r
	S0Nefn+4TfCB/W8Az99aWIp7xsWFDDZWCe7j/OOB51Er0QTclxIImLcKPUL9djn80ZOtSkyNw==
X-Received: by 2002:a05:7300:cc0c:b0:2d9:db50:c6a5 with SMTP id
 5a478bee46e88-30bf022da31mr1835449eec.0.1781775938951; Thu, 18 Jun 2026
 02:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
 <ajDPtOyr8GJYaVYQ@google.com> <CAPVz0n2fnM6zYtP9bCtsY9mcLdce_R+1UPmMo0o4JRgjnhuhKA@mail.gmail.com>
 <ajGyejCSRMhY4G2R@google.com> <CAPVz0n0r-1SXH_dfS9HkQJrF7e-6+O5Me2bPjcscnizmfTfjZg@mail.gmail.com>
In-Reply-To: <CAPVz0n0r-1SXH_dfS9HkQJrF7e-6+O5Me2bPjcscnizmfTfjZg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 18 Jun 2026 12:45:26 +0300
X-Gm-Features: AVVi8CdfRDGSXHDp2X9UrO1uFXgv2RAPSbOTQtrf0j8x2fqDzF-6zwOjp7eVP4g
Message-ID: <CAPVz0n1E5w6TB2empDF4TgVvMbNDwDRi31rQ4TFj-7voGf_i_g@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 18 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:1=
8 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 17 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 00=
:23 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Jun 16, 2026 at 09:25:25AM +0300, Svyatoslav Ryhel wrote:
> > > =D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 07:26 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> > > > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > > >
> > > > > Add support for multimedia top button row of ASUS Transformer's M=
obile
> > > > > Dock keyboard. Driver is made that function keys (F1-F12) are use=
d by
> > > > > default which suits average Linux use better and with pressing
> > > > > ScreenLock + AltGr function keys layout is switched to multimedia=
 keys.
> > > > > Since this only modifies codes sent by asus-ec-keys it doesn't af=
fect
> > > > > normal keyboards at all.
> > > >
> > > > I think using input handler to intercept ScreenLock + AltGr is quit=
e
> > > > awkward. I think this also passes the original key events (unless y=
ou
> > > > make it a filter not a regular handler).
> > > >
> > > > I do not see benefit for reacting to AltGr+ScreenLock on other keyb=
oards
> > > > to activate the special mode on this one. So given the fact that yo=
u
> > > > already mange the data stream when you split it into "serio" ports,
> > > > maybe just intercept this key combo right there and create the inpu=
t
> > > > device and signal input events right there?
> > > >
> > >
> > > Though it seems awkward at a first glance, media keys are integrated
> > > with a standard keyboard in a detachable dock. It is highly unlikely
> > > that media keys will be used with a different keyboard then the one
> > > that is integrated with dock. Additionally, the ScreenLock key has a
> > > code specific to this driver and is not in general use, so even if an=
y
> > > standard keyboard has AltGr but none has ScreenLock specific to this
> > > driver except the dock itself. Handler is also set as observer so it
> > > should not interfere with work of other input devices.
> >
> > I am not concerned about it interfering with other drivers, I am
> > concerned about it unnecessarily connecting to unrelated devices
> > (anything that declares EV_KEY).
> >

I can add check in asus_ec_input_connect() to strictly connect only to
dock keyboard, will this be sufficient?

> > Again, I think having input handler is not appropriate here. I would
> > fold this patch into the patch that introduces the 2 serio ports,
> > enhanced the data stream analysis to detect your key combo, and then
> > report through this new input device. You do not need to have the round
> > trip through atkbd and the new input handler for this.

This sounds like a load of additional work, I would rather remove
layout swapping entirely (even though it is a useful feature) then
rewrite everything from scratch.

> >
>
> I will try with filtering first if you don't mind. If that will not
> work I'll consider folding. Do you have any good examples of handler
> with filter to use as an inspiration? Thank you.
>
> > Thanks.
> >
> > --
> > Dmitry
