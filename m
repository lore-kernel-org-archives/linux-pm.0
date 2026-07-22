Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6D4968E6
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714597; cv=none; b=UWEPC1edyhqfTuOWRLSNUih82pKUSOqckN8z7FIgoCsJz3E4DL69NqYVlMuExcv2ICFLIBk1FzCK+O1tkhywZNRJyb+3a4/bPc004YCWjwtoU6UqOe7qkngNe6/tnmLBzWvknirkai7P+JWdVcd3UbimXZ9VhSUKExwyVkUnYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714597; c=relaxed/simple;
	bh=zoqfEescrEM4/AemE1soEzPnfcrpe9p3YE38rq4XzRQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uxseut6D1fBmwvT4DnzOG1Kypv6VQabqa+pMPN8o9nwEJyxwUj6dMGE/YL55fL+2GDWvMHnFFwPus4RH7n3UyyUobqaS0bx7SbJXkNHgCjyP+8Y8qsvhHzCI4pCHBRWnwZD76PYLPNu7XHhRQztDnESn4ZDvx3/xs+LxL9SnQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGMuUyLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGMuUyLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A8E1F0155A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784714594;
	bh=v2nl4VWueEk9cKUhbw+kqvh7s/L/Uh+km+tAT2bP7fg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aGMuUyLHguxVRr1lFjeEqsXxI5a3BDv/DaaV4zoODVdfUElN6OPq6bkx5ATub1s7X
	 NqCOBztx6noD+QfHAvSgTWe7vgJnIbtFqRfBncNwEd8MZhJAPkwQ6o1PmCErDh2eSF
	 54ujH4MI/X8WrSdzSMvJdDCh0pZpi+hUqSU2T1bUPAGLbQO4yixldnti713LXPNkci
	 YythZGNmbpNbSYX0SZ1YxdtUM26wau81e41aUGstklcHdYCONGNwfqBX6p8ICowp/6
	 g9HicL6hWe6OdIC4YCD4+8eDDyuWsnOkh3GMzOh/RFUuABV1W9tcDEy8Izwff+b8ok
	 dcHRMOjcvphAQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so11838748e87.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 03:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpAPIFypFe/Uv04WxPupje49ryzdqtGazSw2Df4wkXp2WVv+TbRFuXHTXbKq59c+TEw0SZi41cy4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pjnMFi1x5WQumeWbaHxu8+Y8sbzoEEb4X+Q3hIxwh1fR2uqP
	5qAAf+MmJ+3WHfH8S2ZhzoqUtzlAIOg1UupLXYDa47vTH/xlenusYn0zvnvVsGeYFJ1yS8qPg+0
	pyyLgW6wlWwt0Wm56igLqMV74Wuo8ljo68AegzjRBMw==
X-Received: by 2002:a05:6512:3185:b0:5ae:b2e3:fc24 with SMTP id
 2adb3069b0e04-5b28fabb0afmr5670333e87.60.1784714593132; Wed, 22 Jul 2026
 03:03:13 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 03:03:08 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 03:03:08 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5H_V+J0cvrYjMFdKAQVrPKxPdtimXMc+hwHenwxhb9mDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-4-wenst@chromium.org>
 <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com> <CAGXv+5H_V+J0cvrYjMFdKAQVrPKxPdtimXMc+hwHenwxhb9mDQ@mail.gmail.com>
Date: Wed, 22 Jul 2026 03:03:08 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfZ1Yk6OJaCGphTYToMVfe_UU4dhOGmGVCbwqBV9S-a2g@mail.gmail.com>
X-Gm-Features: AUfX_mz93U1zn17dWP9tyqRdXvFYbDQgxlYVyw0vjRryfcxfP9O2fsTk4G3zrhY
Message-ID: <CAMRc=MfZ1Yk6OJaCGphTYToMVfe_UU4dhOGmGVCbwqBV9S-a2g@mail.gmail.com>
Subject: Re: [PATCH v6 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2026 11:01:20 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Tue, Jul 21, 2026 at 5:08=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
>>
>> >
>> > +/**
>> > + * pwrseq_power_is_on() - Queries the last requested state of the pow=
er sequencer.
>> > + * @desc: Descriptor referencing the power sequencer.
>> > + *
>> > + * This returns the last requested state of the power sequencer.
>> > + *
>> > + * Returns:
>> > + * On success, 1 for on and 0 for off; negative error number on failu=
re.
>> > + */
>> > +int pwrseq_power_is_on(struct pwrseq_desc *desc)
>> > +{
>> > +     if (!desc)
>> > +             return -EINVAL;
>> > +
>> > +     return desc->powered_on;
>> > +}
>> > +EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
>> > +
>>
>> Didn't we agree on introducing an enum to make it future-proof for when =
we
>> also pull in pwrseq_is_controllable() from Loic?
>
> My bad. I misunderstood and thought it wasn't needed yet.

It's not technically needed *yet* but since we know where we're going, it
makes sense to be proactive.

>
>> I think this should work like so:
>>
>> enum {
>>         PWRSEQ_STATE_UNKNOWN,
>>         PWRSEQ_STATE_ON,
>>         PWRSEQ_STATE_OFF,
>> };
>>
>> int pwrseq_get_state(struct pwrseq_desc *desc)
>> {
>
> I think you still want this here?
>
>           if (!desc)
>                     return -EINVAL;
>
>

Yes.

Bart
