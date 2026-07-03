Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AE3D45D5
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084604; cv=none; b=la4cj3U8n881eDFhN7eDmw4GMbGT9yM7xmefxR8l3xR89ENfKuFKf8B52s4LE+yj9HXkWZq2lKfH6pmBU5A4i9HBy1xerBfWchAiMAXhg92HOGhxf1gkpBJEY9HNVYpvWMBjdh5bOQcDotK6JJVK4l3OZm151bJn3mfJpNVPJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084604; c=relaxed/simple;
	bh=gV0Slrjr8IXK+MlTCt7MN9hZHNcIK5BTbT3wdZMhFWk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrcAHEd79Y4oAOjD4I1vdZQAW1Z6+2FzWhmfy/8ajHF4gteoVKQcl/H3gbm1E8WnmlbEPReXwmcuauZlCY6PXIe1+e+SKs+Op0IuJIf6gwbMa/MTrkagkzo5qaIpdXG12yzNr7+EW8SAVHTgP1Y5V+rsNBNnxtfM7GaOWIpyt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSjWQJMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSjWQJMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD101F00AC4
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084602;
	bh=gV0Slrjr8IXK+MlTCt7MN9hZHNcIK5BTbT3wdZMhFWk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=oSjWQJMVtg8g/LXoUb/K2FqnMziWICTYSrswtHn0oREeAe9aGAEYylsP6FTuQE+dn
	 wjGcvMuvcRqlVqoh7z8fwaNzIObZDxlRBmXX30cJheTBHAMRiQRW2RuEZByS4wcOe3
	 jylAsGqYV5LUq0Mtm9kijSAaV4jz7Z1m1+pn3+uswdn7rouFE4CSzcakh1RFvjbTVG
	 TAo/PBKLlq4cY94y8732frnrFqI0G+57B/6Coa9bTvjuMcke80Ok/wRiEhvPcWYLrq
	 QZcgKjIj341ZG9DxLr1WSAQ9oGUWetnM5Ixk3cqNtqKBGe3XjpxSF3vLN/YA0yWB72
	 oPqwysfcEV0eQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b03d41976so4832311fa.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 06:16:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7YeArOl4xCAllrgjOtvpAsYXj94BeP5KvwEPUpNCwazaVHwf+WUhxYBZunQYoOnyyD3gR3Mq8sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCnwg7AoU8PljMGidnoa7wlzm+XtqEPhkn1WMmzEeMPmo60UJ
	E0UqQM3WMSkFfklCjMaeyYhzd6OssKz8gIop74bp4WlfGBpBE19UJ36iy5NWXiJoUh8hBTcIqBY
	jCObdhMNCaWqo2F6kGdKdZkxspx8YXdJbrIHMNOukaw==
X-Received: by 2002:a05:651c:2554:10b0:39b:90f:b1dc with SMTP id
 38308e7fff4ca-39b36e0af76mr18538581fa.13.1783084600750; Fri, 03 Jul 2026
 06:16:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:16:39 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:16:39 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com> <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com>
Date: Fri, 3 Jul 2026 08:16:39 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
X-Gm-Features: AVVi8CfEGr9ongua6ulDVSCJ0raV9SIaG27LcZHKlrYzQjvFFBvVAoVU8_PqL0s
Message-ID: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
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

On Fri, 3 Jul 2026 14:58:56 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>>
>> So this is only needed to not have to track the state in a separate fiel=
d?
>
> Correct. Reading the field is not the problem. Updating it is, as the
> fields are packed bitfields, and Sashiko suggested that locking would
> be needed, though it may have been for the peer port, which has since
> been removed.
>

I'm not sure if it is. The user controlls the handle. We could argue, it's =
up
to them to provide synchroniztion. We only assign the target and pwrseq fie=
lds
once in pwrseq_match_device() and only change the powered_on field later wi=
th
pwrseq_power_on/off(). Unless the user does something weird, we should be
alright. Maybe a small note in the kernel doc would be in order.

Thanks,
Bartosz
