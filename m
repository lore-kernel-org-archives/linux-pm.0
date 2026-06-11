Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08733A2559
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169112; cv=none; b=LwcrsGhHjUq6mfAffuecEafPKPqFGC6l9/uvD3Gherneb9bVUyxza9CFI9yW9rFGEOLL0Jk4mzuY+XbbETFLZIIMRx4GJkW+jZJGGsRs3iXa+rkgg5RjvMLVVHCmpq/U5Hue2O6gWln5vQkzdVyI9mP0KkogQ387SXXe98NEqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169112; c=relaxed/simple;
	bh=B1t0eMpqsT9YaBJXmjRvQgx584lO6Eznqq7E3RTSQxs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+FB2rNBT8Ay3A2kkOIsR4ARvLO7d/3Yk0ZLiL30MomrggvUXkHpOAjsvzVrOoHJmM4PgVNZjnbXftHOyK9EL2x4SwWRVgp9DE0zOqdPMoahPYcVzZGXdB3OE3QEsTDGQsUqFJDefuVfY1xGXCRhPElS0+rqODx+wZfD8b0U/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSUSCOOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSUSCOOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B92C1F00898
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169111;
	bh=B1t0eMpqsT9YaBJXmjRvQgx584lO6Eznqq7E3RTSQxs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bSUSCOOlUoqkjxfDipdP4ZN06c+kGoam+HOQDbIvwgi3CyDkonEwORRznXaYiPTg3
	 LYiVzvjqTLedwOJohBXfEpJGHs0daYzk4JuF/vsucz8NGce0N4CCtgT+b0VuWlIVF2
	 Nm5xBnbizAA8pmP9frj9IdPeljD4n7wwJruC5jnaHkJ/YXmiMxC2u6kXjQIbT4TKwq
	 k/tCiNYYQLbiHyx0O5zC1cDUbv2OJF9a6wrVlbTHgu8Wb+ZYP7Kf1b8YjmSXXg9oHm
	 9O+RhqNu2KRj0vB3DiSTCkVshTiw2TU9x4iLP0mHiJn/4iTPM5PrRTjO8Yz5wzvIpi
	 RlGk03VX6ULGA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396775c26e0so71045981fa.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 02:11:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9CliD1xVvQ+/+4JalGWJrrCqm3tRJtH/YupvzdK2i0vSZgLWB4zC2EKYz+XbvJPqjN77Tc6y9U0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjSAA6vECy2Y/rsFNGu6GAmDRtoWen5hby9vYAZOdqc73I3Bh
	R2sR4SYlcAMj5kncFybrSrE29BhA6Hcs+wKrC0nhfjbNcpgOdTqsoY9hqoEkV3/u0Jpyjt/zO1k
	y6ipVQ881jfElkmR47RVQUdGJeas0S7XpVLnxCiWe7Q==
X-Received: by 2002:a05:651c:1545:b0:396:7fa2:e095 with SMTP id
 38308e7fff4ca-39919f96cbbmr4986331fa.6.1781169110130; Thu, 11 Jun 2026
 02:11:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 05:11:46 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 05:11:46 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610084053.2059858-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-8-wenst@chromium.org>
Date: Thu, 11 Jun 2026 05:11:46 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com>
X-Gm-Features: AVVi8Cf4NRlpEgfQOjedOZVIy3kDaaZ8Xbtl_Xw4Hfg6m7nAFQEWNEvJmcMEnDE
Message-ID: <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] usb: hub: Power on connected M.2 E-key connectors
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 10:40:41 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The new M.2 E-key connector can have a USB connection. For the USB device
> on this connector to work, its power must be enabled and the W_DISABLE2#
> signal deasserted. The connector driver handles this and provides a
> toggle over the power sequencing API.
>
> This feature currently only supports a directly connected (no mux in
> between) M.2 E-key connector. Existing USB connector types are not
> covered. The USB A connector was recently added to the onboard devices
> driver. USB B connectors have historically been managed by the USB
> gadget or dual-role device controller drivers. USB C connectors are
> handled by TCPM drivers.
>
> The power sequencing API does not know whether a power sequence provider
> is not needed or not available yet, so we only request it for connectors
> that we know need it, which at this time is just the E-key connector.
>
> On the USB side, the port firmware node (if present) is tied to the
> usb_port device. This device is used to acquire the power sequencing
> descriptor. This allows the provider to tell the different ports on one
> hub apart.
>
> This feature is not implemented in the onboard USB devices driver. The
> power sequencing API expects the consumer device to make the request,
> but there is no device node to instantiate a platform device to tie
> the driver to. The connector is not a child node of the USB host or
> hub, and the graph connection is from a USB port to the connector.
> And the connector itself already has a driver.
>
> Power sequencing is not directly enabled in the connector driver as
> that would completely decouple the timing of it from the USB subsystem.
> It would not be possible for the USB subsystem to toggle the power
> for a power cycle or to disable the port.
>
> This change depends on another change to make the power sequencing
> framework bool instead of tristate. The USB core and hub driver are
> bool, so if the power sequencing framework is built as a module, the
> kernel will fail to link.
>

That bit needs to go away I suppose?

I see Andy has some suggestions but in general I like this approach much better
than adding the pwrseq_get_index() function. Thanks!

Bartosz
