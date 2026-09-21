Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3642AF9B
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976059; cv=pass; b=Pl5qQwkldZT2mJBTcp931ZdAyJI8ZbYZ9b1CYPOgKigUW9q2sbRudZ1OKJAnRu+Kq1uJ9r/hfxwZhootJT18Tmttuy3lIFP2vn1TXJuWOWaeN86Al7v0s838/B0s1zPrZsj7EdsB81WWHNpc7Jch+KlVFYFO79z8az+G93ByozM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976059; c=relaxed/simple;
	bh=57Sok7jJDa/57dP/GDfeHEhYnwuYZlpWnaikd4BSZrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crniq+feB5WmMHNDANb/c2OA1NuEKdbR/FlV1v4ni+xNe8bWgkwedSTmGmruPKR86QphKorQx0b0D8tStmDP2lU26xxYWr5+qyoVEDrXgAfyCRwvR9L6M2BUViUDyEFf1qBqzM4nLZQwVod6GofcsaSOfsF93zOhexxBggPAeUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRho8oHk; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRho8oHk"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2322591a91.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 00:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789976057; cv=none;
        d=google.com; s=arc-20260327;
        b=Ek1jO/CZFq06fB8s4Etl6eaGy56h7pgbDyb+p/Jmno4CTAQMrwAONouHMB0rO9Aybo
         gIdj3mvjUxKFChjQT+xiZvtoOMGR5k2p/LgCH3ylhKeTRb5LojAocYtDQDYDl5B5NziY
         0JaYGMbHKcGm2Fr4Ri1x4MS1mocf2lyX7cp9loi3G5yHFF5LtjRFTVhBxbdSmEh1TeMw
         BQYFxtO4mFDWdcdS0n1tSWx7papBT58qEdzEyuCcR1Iq4uL1+FxvaVd5bJCnSQGNB5Fc
         wY9RzHOr/CBt41ernKTBDLgfEX0AfA0Uwozb3taeR3P23Y5NZ388+9BNE3hzSyWloXpw
         SgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        fh=QerA8Gn8mWxkqnsK7CxPgUX2rGgBviUc3k3RYDtw9o8=;
        b=aKQ6INc9RFltI2vG89mTH8+7cvFIqCkOQZ6HoQsy1CFwQkLdhl3QuJEyxEbAl2/RJP
         5ZPRxGvhHmCW3Il/xIKiNuX54oHRTwnXCmJUXx5s3C61PMc9F6u/J2+CL8ne+0LChi3V
         6ZXWEidLz/PSwPMYQJoWUrWZVKWzehmrG33vVkaejh4+AXxf1ctfG8M3bmFvTBFcRNwy
         Gt4od5Fr5Lm3GNvhCmq9/Xv1uSBLZHY5o1mkLzLKY2b3OuQFbAT3t40j9GSj7bozUF2B
         K3HlxxFYxC6vLDeDY4Kvv+Prb9QOYfyEVXLchu7lRe6QsiELEa4a5RJlMUH9iEzip4pw
         Mb1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976057; x=1790580857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        b=bRho8oHkSZ6eNFFlMVFarqQ5ou6tGwP6n0eX0AMCacl0jOnq/EcGvM7lHBlgkmMQP7
         zLLh08JXmiwSrxOeMNy0Tw7uLfdHnUz1OHewAdYTttaeLiZZIRbpdqKAm1exhBXt0SJ2
         uwLkghVLI+wKYXaKcDPzLNu4LmatZLIhyK9LSr7vpCufUr4zYs+7bCeFlZ0tLLW0hSZD
         TgyIWK0sBY2F98z5zFIvPOsTthpcp0n1jNIxNiXIZlkb07px7TcCrRNBMw8uaYpQmBZT
         ni3Oas86iQDAeF7bEgd4d758qslkBQczuds/1ZuAokt+/PN415MLqRAZdPxSP20gQeeM
         UVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976057; x=1790580857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        b=g4ZO/jw+vtjQByRGNjhKERTwINnHni/oBK224eM2RrGr9m9o/hL4OHXUOT2Nvy3QqL
         yBF7t70OgiFZts9p7JJvrRi4hO8L1bK7UZBlQxEtKs7jwg/6qfaZc/nrXq8Ogi5zKjrh
         lx5OCkprYj3mwwZ7BfvTWgcQk81d0Twg4WlTHI2o6kkYY+Fa04TVrYIi/riY1IgH7dYD
         JK0x26OqWcyUXL+OssvpXSOmvtTLKr1PjCFoH7dfCTIvzBFjmKV8+P/c7bq4WIyMyDDA
         Qb5g0DIUY+e/XH7ADbuVnr6i8a1kMspYngY+1zT2ZG+KE9RQr1lpxx8DOF2Dnp9pnTgz
         St1w==
X-Forwarded-Encrypted: i=1; AKwUvBwQRNSRhcGTLQtdNY0z0+4fJu9tJlGuZpzz0PAMQzSP3SISsqk6vHFmUpfJ4W+amXIZ6VV6ZeJ94w==@vger.kernel.org
X-Gm-Message-State: AFuF++k9ZHpSseArQaK6VnxxdCHV70fAD4Jd0zAch0bWm6XEzXXfXWAE
	ZKF2PAFLHraLIQeLp5A4p0lMZV/FikVxDgfF/9L4gSpk/jdq03trvnFz5lTjqDY7aLwB5Ie+4QH
	HyBJBny6AD4S2fZov7DzVgmmxyDp5FME=
X-Gm-Gg: AYBFou33dYJTtOBgH0YZeQOW2OGq8HLhVCcvPtyVRss21tVLv957EpV6X/AfJF7P+ER
	mGDOlzK4pZ0akuEdVxO8JmXcblsx49/wYrBvTbnTCQ/yxADlZ1hJBogGOK8+dB5z6E691wioq9I
	OR35orozJB7IPce00gOngofzPj3ZlI0Drpx0/WOuox94VB6MxPAChOhSa40Awpz9l/vIdCAhCgo
	XYu7FBEBvfltngjryZ8N+YtaxElOfYDjHOZkGSDGsmP9kmb13+ic/SvLf87FWzb8aTL/Oo+lP4s
	0ObB+2NLqNmsdvVHMoMt0Du3akbYAdgyeQ5BXEYuVm4X+IlQMa/iQayOhQSqfjkfFKQfciKbcjv
	6kRNnWyrjldSM
X-Received: by 2002:a17:90b:4b87:b0:39e:345b:3323 with SMTP id
 98e67ed59e1d1-39e54fb121dmr14066759a91.22.1789976057124; Mon, 21 Sep 2026
 00:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
 <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com> <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
In-Reply-To: <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 21 Sep 2026 10:34:04 +0300
X-Gm-Features: AcwNN1W6gcxmcfy1bLN5jucC74BzWiaaqHA32OWE3YHnq2Or7J12ypc4KJW69uA
Message-ID: <CAPVz0n2ZeYk8WbWfW7L1kLsQN4e0mdQ7nM4Lozy16z9X8kPCWA@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 6 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 20:22 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 19 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12=
:20 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 =
Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > Add support for multimedia top button row of ASUS Transformer's Mobil=
e
> > > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > > default which suits average Linux use better and with pressing
> > > ScreenLock + AltGr function keys layout is switched to multimedia key=
s.
> > > Only Dock keyboard input events are tracked for AltGr pressing.
> > >
> > > Co-developed-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/input/keyboard/Kconfig                |  10 +
> > >  drivers/input/keyboard/Makefile               |   1 +
> > >  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++=
++
> > >  3 files changed, 321 insertions(+)
> > >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> > >
> >
> > Hello Dmitry!
> >
> > May you please take a look? ATM only ACK on input patches left.
> >
> > Thank you!
>
> Hello Dmitry!
>
> May you please take a look? ATM only ACK on input patches left. I
> would like this patch set to move forward.
>
> Thank you!

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left. I
would like this series to move forward. Thank you!
