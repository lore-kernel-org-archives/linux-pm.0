Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F64A64C5
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050583; cv=pass; b=gcElF5kOCimNfqhFu/et6CdMaCwCT6PY4pttIk9SBEXWVehMZ+kTIHbGf41iUlZCbY6a9EEFzaY8TuWvjSV2Koh08r5apfCmpYdQpagE9Fa7s6Y5e99XWvu1QU1zJU6MH5S9efMc593utFeJw6/0CR4xKe9OzfJixSrIuvTsiEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050583; c=relaxed/simple;
	bh=s0GzHLToX8l2pJV6FGUrdQW+qoZWtYzYSSm2Om3AhAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVyjEkOF5woc/vbQg9F82Dqj6hh0n8g6kgIjYrR2ZdHaic+JazghoXtzjG2LqdN7EW/SmFDabAiNs2jfvjszeYEzcg1vHjl/W9iTUwRrMmwVWkqMi+912PPN/0YhHeAgeD46bUrEvy0OiuZgPRyVD1jwMa7Na5M15kviSY9T+VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0cx1fJ/; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0cx1fJ/"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f036b17easo1883890eec.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 00:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792050580; cv=none;
        d=google.com; s=arc-20260327;
        b=GyToD+/I2/P5k4mWRutQyGFJYPlk7EzpXCteBuBixECDv2b/2kiKs/RfsJafnaRx66
         Irzux4c+sKiZkdV9KeOjTb9ewgw398fa3tE1nyPs4G7XDnUuBn40EsUALpL3nWejgefG
         Z7SxMPYEyd2M74o8d8sS8+mM9m+//98rRafz0BA8C7vGsiNPRV0+wClr30ydHDvqxipi
         xqVnV0YUEGtLzAB5DCGgQRRj8tcPYVEHIrcvwjagt3reoXGSORMp9CvcZ6ci5wH++bQ/
         cJnldFy2HFpUkZSAEaFSDSVOhOa59Rz0Dn/btTOr7/udRq8LVXOR0t8KZHB4GGbqKgGN
         j3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        fh=ERcHLnPOrsrBem5j6qIwc/tJNpjH3PRCMKlZcfFRYWs=;
        b=gq3EhISECiX37GtI2orzP8cAeCcFMtt/qfI9H3i0eKGRKiOhEVjd5ys5wcgh3lQKVO
         a9VnRXG2zfX2Wzx8Z8Zz/LrWGGHgCHLGir6klaG0cMxNQucWMZqIjbUOFeaEdz2Yf5Kr
         RAn7CbSyX3ZpwzwSx52UMlt/Dd4hsVWqD5GEoZ5+VBadYTiMfdpJtC6UTDeW5if0J9K0
         2LQHFRXgGmJ6X/UXmqSyjz6m3QkUnrUEuA3yGdXUxuN0dh7quPueo/cGaPXmmqAb9SC6
         VVXbS+h7mjVXrKeDc51r1bMF3rQfWB5tOzpd47u3pjAaInIx9qlsNLp8IE5nFhOofgj0
         Icow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050580; x=1792655380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        b=O0cx1fJ/BDpY7KUOgOuGRDjQHPXU2Sax1fG8UyVch+sPis5isWnLDv1fKhlI82OOxS
         NIfC6XolPitBu+MBvV1+lbhC5MvQeuY4RdH7zDza7wN+PM+j6+X9KHsTn5XfMEVcHs4l
         UpBVMDNrxx8KWwTuYTO54TYGlMumcnqDAs3qSqNtkdiUb7ddZI52uT3FpXMJX65sPiM9
         LPFcp/qfPpW2gu7vMvqb0/okQ+p1ZpdJkIkIp6PxCru0wyxuXw1aX2f87vnqUsOxHTG+
         rv7Hekdck37en3gS4yd5UwKbomrHDGm7JXe7L6XqUwqPdycf4bKkvea9wGCccF/mT7KZ
         VKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050580; x=1792655380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        b=2eZJNvlf4nX8LeAG7SJlh3twtsdCMf2QN5hSjeaMqQ+LrqtPmP+5Cdnwwu5Gk29feL
         0Gsf3WYHc2h6RLevAlNHPrMfjwW9oWobH+rDW01waebL2WoRT1LCrNiIZhKq3c++a+/2
         N4pOR97WCKg8d4cLWQ9X69TVi1vUaa4W3NHbIX22phLlMpTuBI1z4gpCWFs5RBc/Ss+D
         43EvIZEfAADCFsvfgU9qHg7LP6NWjxztkojz3fM3vq9v3RbX83YSF3O2pwcnJvYDy64z
         MvIO3qX80bQVnJOAoimE3dvMgoe7A7K0Cop5i5i+nnVk5VgswG7tzMxAQvC+oQiW7utc
         7ogw==
X-Forwarded-Encrypted: i=1; AKwUvBxVed14Rg3C2IIkCSz37e7jm9WqfO7WIaHsshuvNTeQuQQ99TaJG8LJlmhgaLfCrt/1k06BNqcedQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJGowYwkeDxFkwjZ9CoB2Mfh1LgzcjtvpGmn+2ngI5ZdLR9+YCA
	74rEUuIs8EpHD5SDIX0KRi873ItJTcQa5nYP39PtJDmJWW6if6CqjcId/SuFzZOPUTZaO9lxO/q
	KM11fNboJMwzOevP6AlpeR2fjwNcQETg=
X-Gm-Gg: AYBFou31LcQGcWHAjYHQ3ZMpH7Pe2l9VHpIEUomVToKtEjZ88JNFW6Shva6LuEi7EW+
	Lp9UfbzBD213MrF/2VMUVWUkTs9nxpzOArGU0H9XM0g6FiINPh3mo953f3C7F/nMtcWEGP/tIB+
	PjoyS5peHA3DufVXPxG8SHH0N5d7zX31detmP9Xg9sqSGk+t0i+jx/Mm7kx0LeJf35svPi6/mOn
	wrJTvm3KN2jnXKwYsGdzmU3qC37Ly3fPNgd2quS6SS2E6DQEgH0Zs4z2xkYE7PUfEURbdroU8La
	ls0a/G5M4zviIiFMY4kUY4g/8anF45/3Av5ucM2WAPhzn+QkHxie1BlWlNAupMjlswL0ppokHLI
	YU8k56vdEb29k
X-Received: by 2002:a05:693c:80c5:b0:35f:6d9d:af68 with SMTP id
 5a478bee46e88-35f6d9db757mr1154283eec.23.1792050579562; Thu, 15 Oct 2026
 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-1-clamor95@gmail.com> <20261013173504.451391-7-clamor95@gmail.com>
 <f5d367e3847da2f3d3db0abd0a099920@gmail.com>
In-Reply-To: <f5d367e3847da2f3d3db0abd0a099920@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 10:49:28 +0300
X-Gm-Features: AclHuK_Oo9j5QRqhps9x8wmywtw4oQlKiNMQc_P7VxvfWQOhI0DwxVL2kvoPOvI
Message-ID: <CAPVz0n1YcHwH7b8kg82Gfh7GaT=O9Sx0YEhx9jAGkZ=C1JV_JA@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] power: supply: Add driver for ASUS Transformer battery
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

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04:3=
8 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Tue, Oct 13, 2026 at 08:35:02PM +0300, Svyatoslav Ryhel wrote:
> > +static int asus_ec_battery_get_property(struct power_supply *psy,
> > +                                     enum power_supply_property psp,
> > +                                     union power_supply_propval *val)
> > +{
> > +     struct asus_ec_battery_data *priv =3D power_supply_get_drvdata(ps=
y);
> > +     int ret;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             val->intval =3D 1;
> > +             break;
> > +
> > +     default:
> > +             ret =3D asus_ec_battery_get_value(priv, psp);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             val->intval =3D (s16)ret;
> > +
> > +             switch (psp) {
> ...
> > +             case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> > +             case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> > +                     val->intval *=3D 60;
> > +                     break;
>
> asus_ec_battery_get_value() returns a u16 (via get_unaligned_le16()), and
> unconditionally casting it with (s16)ret sign-extends unsigned 16-bit
> properties >=3D 0x8000 into negative values.
>
> In particular, when the battery is not discharging or not charging,
> TIME_TO_EMPTY_NOW / TIME_TO_FULL_NOW report 0xffff, which (s16)ret turns
> into -1 and then -60 seconds instead of an unsigned value (or -ENODATA).
> Should only signed properties (like POWER_SUPPLY_PROP_CURRENT_NOW) be cas=
t
> to s16?
>
> Thanks.
>

You have a point. I assume that using val->intval =3D ret * 60 should be
acceptable.

> --
> Dmitry
