Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387E3BCD3A
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170530; cv=none; b=F2rsUDTruhhV/2y+qXOPrsqcXyH7ohD2dpOCy4rO+e3Uy3/BFC+W1BldHDLdevXoiVQ5kKg+WAxRKIG0QaB7zeTtjcsL0LGekfbmJedomcaMnCH1t0T7d8TiQJ9L5s++VE1yrtJhm0tDvxDCVWBPkzQlOdGqc7WVzJuxAmWQK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170530; c=relaxed/simple;
	bh=Ov574hmILB3pdxYdVww1k57wi7RZAzJuxmEZc5khEpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzOEHwTeqgzM9F8XtzKzWxPe8oa0MTZwsN8S/bnAsAyp6H7oXNWgiGks43yOSG9cnUPPuR8bx9jP+2CeU0JG7qCswlnimYLMFjyiyp0+nn5m+Ov18MW5B/kmWl43Xj1kflDTpnEVjiEtN31bGLaxPeLUzTEdirWIhqRDYfcEGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1/pVACi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1/pVACi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FB81F008A5
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781170528;
	bh=Ov574hmILB3pdxYdVww1k57wi7RZAzJuxmEZc5khEpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A1/pVACiTZRAyvqSvqEomemy4em1jq1mn10xf+YddyDmO+LQsyXzcnpO+6OdkAUdi
	 yt34E2hgTuHynVkbQ+G7v+YhIYRTHl0CedAwB54FM/vhiIG2jKUJde3lnJAjtuutTM
	 nbOC+ZA9BDBl9yKwb6CLfM/2miWpqts62qkiO5uoMkBFw5qMVp+gNi9r4ypV7ZdXXy
	 utPeojc90hX3TyUAtfygwQFWHYpvCz7deOF+NgKmVqcR3EJtoPqp+B54tJBAAkZYgF
	 poIqSVcChK12wjfXWVIP8xYLTHrHTRdakNyGwz6XbRWEH9G1GPXNksQKqmu5S1kjSx
	 kOI/cBXt1aO1g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-396753f343aso77104931fa.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 02:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97SV6uFCpeAw3pJlZ1pcYtnEildwBoFgFRfoiUONAoauhh+e2f3vaM5JQrcDjQkKcPtBTXvHQ8RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBU8LD1Yy0qJPpAwXUnRfva8tpuLGE2bn2dZy4Y8hVUUQuRRX
	ro5T/ma0oLo4jsZ7KDiEgm40cCi+irsxkorjdbxrrU5DyUH4tHv7VhPcwnYTiakQ03cdcL3hQHi
	AKoZtPhMK6NOXeiUrE2I5BbsZZj6AYNn5fmsZV45KFQ==
X-Received: by 2002:a05:651c:248:b0:395:6085:a15f with SMTP id
 38308e7fff4ca-3991a037f82mr5814191fa.9.1781170527256; Thu, 11 Jun 2026
 02:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-6-wenst@chromium.org>
 <ailxrP-_9_NL8qnN@ashevche-desk.local> <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
 <aipz2zMFcdnZYTxS@ashevche-desk.local>
In-Reply-To: <aipz2zMFcdnZYTxS@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 11 Jun 2026 11:35:13 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>
X-Gm-Features: AVVi8CfSg10E0UvFAW373K-Jcv4BNuLaPDP9X_vJcmiaG1CmuHb8KO5g7-SqyaM
Message-ID: <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:37=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 04:20:58AM -0400, Bartosz Golaszewski wrote:
> > On Wed, 10 Jun 2026 16:16:12 +0200, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> > >> When a USB hub port is connected to a connector in a firmware node
> > >> graph, the port itself has a node in the graph.
> > >>
> > >> Associate the port's firmware node with the USB port's device,
> > >> usb_port::dev. This is used in later changes for the M.2 slot power
> > >> sequencing provider to match against the requesting port.
> > >
> > > Okay, would this affect ACPI-based systems? if so, how?
> > > Can you elaborate on that, please?
> >
> > Is it possible that there's an ACPI device node associated with the por=
t like
> > on some DT systems? I don't think so and there should be no impact IMO =
but I
> > also don't know enough about ACPI.
>
> The API is agnostic. There is a possibility to have software nodes associ=
ated
> with the port. I think the best is to be sure that ACPI-aware people who =
are
> experts in USB will check this (Heikki?).
>

Even if there is a software node - it shouldn't really matter. It will
just be assigned to the port device.

Bart

> Also note Sashiko complain on reference count leakage.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
