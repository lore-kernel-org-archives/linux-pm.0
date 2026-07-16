Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87C3CF20C
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189683; cv=none; b=m16btdjsoZW1KCQvJXZRRprgawf4LFuUVjFhQdP6UB4OftYdYEWuji45c+NQehAH6XYdEmtJzejcYQ1ctUh55duiNlDmrMb3sbADdSH+8unVaz5ykfLJbv0SbGtfuNNL5c1VeT/cKzEn/8dYYXNws1A4IvjUHiL/qZhmd9AKzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189683; c=relaxed/simple;
	bh=NXTOoEEEs1TNjwS3eVeqIN1iuZ+ICzInI+C7HcEYipc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diOr7fLD5y5mI6D59ty+WuijTsFM3jIHr3d85wCQ9b5/7YOv8jY4p2xyrfJlyj+u00dmTBS3tPAbHTMGx8X/zd2GJ0T/3CkCZhE3NQRNwLzYBoDk1Ghl6e6B3MvsCJWuI6hDpu/1uaVW2D12xRLMCqY61G+OZo2ql+eROYXqvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILXJIECA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILXJIECA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEAB1F0155F
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189681;
	bh=S6dzhBrZchW3iZvyn1hIvbsasMrCxNEsko6TeLvbddM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ILXJIECAsF50gCjzfPbo9WZ++uCuclPTHWsj/RRBjDVaQXiS3A7eKkrJVaM45nwRq
	 vsR1AL39qNsL/TTa/+zhzhQr29o2VwZneXGkKEgx5yicEAaup/pXqZ68oTzSJneAyH
	 a+FRUiiHHdUA7WHqKNVU/W60AN0scXOCedQyLqpc/HK4PgLeXxvTPVL1F0+L2EKQNX
	 f4hTAs5bekpCWzp1JXckxrMcTSkYloomfCYNDgvEkzvxRIIhdGW7a4oZccDNG4fm3a
	 JQ+dsMXn47utt2p1g69B6V/aJc5bjHuE9GewcW9IgwAZw4lT2SjDrlVI/EzTMYOlNM
	 37zTJ6KOsRoOg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39b3931e259so57831191fa.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 01:14:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpxhtxmDy/GBc3wE6mae5GTCfNi+iM1d3NEQVLYcbAOyqhSz1DcC9T56EBlNWaZOPgo4ngqlUh2zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMoZStQ7Ep4FnqzgtofqiV39ww+MUiC7tjw7Q81Wv4qK7YbxB
	TPW6tPWX0VxepJrwCikdKCQmg1+xSxd3PdFGD/a3G4MMerudFIApK1T5k7au9FLxzXPMexqRDti
	HB0oLt4CEd5MIJAjCXcMpu/iKKe6jU4+xvp8BmHmYoA==
X-Received: by 2002:a2e:bc82:0:b0:393:6934:6104 with SMTP id
 38308e7fff4ca-39db6c2a16fmr12970681fa.19.1784189680282; Thu, 16 Jul 2026
 01:14:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 01:14:39 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 01:14:39 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5HGjGTrqqzJrpiQhLrCn3C6H20LXq3niPnoujQLOwgqPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-4-wenst@chromium.org>
 <aldS3qTympJuVXYj@ashevche-desk.local> <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
 <CAGXv+5HGjGTrqqzJrpiQhLrCn3C6H20LXq3niPnoujQLOwgqPw@mail.gmail.com>
Date: Thu, 16 Jul 2026 01:14:39 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com>
X-Gm-Features: AUfX_mxn6Bl7rEMqDoJ22rvXDaXvLC48Woi6Y6ypETbOrTpITKxwxCyFT1q8e60
Message-ID: <CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 06:59:01 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Wed, Jul 15, 2026 at 8:10=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
>>
>> On Wed, 15 Jul 2026 11:29:02 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Wed, Jul 15, 2026 at 04:53:33PM +0800, Chen-Yu Tsai wrote:
>> >> The power sequencing consumer API already does power on state trackin=
g
>> >> internally. Expose the state to consumers through pwrseq_power_is_on(=
)
>> >> so that they don't have to reimplement it locally.
>> >
>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >
>> > ...
>> >
>> >> +/**
>> >> + * pwrseq_power_is_on() - Queries the last requested state of the po=
wer sequencer.
>> >> + * @desc: Descriptor referencing the power sequencer.
>> >> + *
>> >> + * This returns the last requested state of the power sequencer.
>> >> + *
>> >> + * Returns:
>> >> + * On success, 1 for on or desc is NULL (optional) and 0 for off;
>> >> + * negative error number on failure.
>> >
>> > I would rephrase it a bit.
>> >
>> >  * On success, 1 for on and 0 for off; negative error number on failur=
e.
>> >  * If desc is NULL (means optional) return 1.
>> >
>> > And this rises a question: why 1? Shouldn't it be some "unknown" state=
?
>> > (But since Bart Acked this, this doesn't prevent the patch to go, you
>> >  got my tag above.)
>> >
>>
>> No, this is good feedback. Maybe we should prefer an enum like so:
>>
>> enum pwrseq_state {
>>         PWRSEQ_POWER_UNKNOWN,
>>         PWRSEQ_POWER_ON,
>>         PWRSEQ_POWER_OFF
>> };
>
> Well I think the crux of it is whether the API considers the descriptor
> optional. The power on/off functions suggest that is the case.
>

True. That may be an inconsistency of the API contract on my part. There's =
no
such thing as an optional variant of pwrseq_get() so perhaps pwrseq_power_o=
n()
and pwrseq_power_off() should be converted to returning -EINVAL on NULL
descriptor.

> I modeled this on reset_control_status(). I believe the rationale is that
> if the reset control or pwrseq is optional, then either there is some
> other mechanism to deal with the reset (GPIO) or pwrseq (GPIO + regulator=
),
> or it's always on and operational.
>
> In such cases and the rare case where one has to query the state, the
> queries are possibly chained together and I think it makes sense to
> assume the "operational" state as the fallback.
>
> If this returns an enum, then I think the previous approach of returning
> an error value for an invalid descriptor is better. One doesn't need to
> learn a new set of return values.
>
> I'm fine either way. I would just move the checks over to the consumer
> side. But I think the principles guiding the overall API design is
> something you need to provide:
>
>   - Is the descriptor optional? What should the action functions
>     (power on / off , or query status) return when NULL is given?
>   - Is the subsystem optional? Should the stub functions besides
>     pwrseq_get() return 0 instead of -ENOSYS?
>
> Right now the API feels like the descriptor is optional but the
> subsystem is not. One has to add IS_ENABLED(CONFIG_POWER_SEQUENCING)
> around the consumer API to make it an optional feature.
>

There's one more use-case where the power state trully can be *unknown*.
Please look at the proposed new function from Loic[1]. Here we deal with
targets over which linux has no direct power control even though it may sti=
ll
control some of its dependencies. This is where an UNKNOWN state may make
sense.

This is where I also floated an idea of renaming pwrseq_power_on/off() to
pwrseq_vote_on/off() for better clarity of their purpose.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20260710-monza-wireless-v3-3-46253587af64@o=
ss.qualcomm.com/
