Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115A5AA68E
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174448; cv=none; b=FfsTYSY2IRQtZf83PKQOfXepNPJbI2Ai+LIj0aOUazaMxNMFdEWlIQxp7xWJGLtCzZHbYbJZe2hxNL2F+2+QHNQ1zdn91HlFbtdTpyVccQRdpK1HBJ9CzgDZsnr+OzlEXHirRCOkTWU5tHXJMDg3nmxz2OGnpIefaOlV6OVyUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174448; c=relaxed/simple;
	bh=zk5f7rYUCgAujA4xNfzK1tOFfboCm/vc3PI6IsXp2bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igjwwxy+0OzDj8LlNr55/1VVrTeGpAQsUM3l+9Kc3dKUKk0VnRE/ZNnFbZVLEfO0LI54Xj4no4qePfAmU4SgghF4CqAumyox2IYKotEdzjqDH33o9KnDXibn5c04lHDf/EzfhngTgFi1ro+QFDBeSb74hw9iyStf2//ACWnewLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og9i1Yby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og9i1Yby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270831F000C4
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174447;
	bh=zk5f7rYUCgAujA4xNfzK1tOFfboCm/vc3PI6IsXp2bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=og9i1YbyMvkGWE31YYjLLlCmx4TNbMU11jRMhoYA064UuP80DCTn1SgCFPDfND7dM
	 vph7ADqxASybnVV2dd20KG5mIXXUmlQGFgazScs5eIwaJ5uzIIsHapeW0PIwP3gSAL
	 RsDQRRwOvgktBxnMMKzW3PdXQxO14J+IcrNKoSW982fXTrT2vnVf8RnODIPy6A5lyw
	 09vPv3CfwmHqLsDIjkRobsOrhGyuO/x1mniIBLyPLz95U2oXLWlYlzP8eFJ/H9U7tz
	 lmkHYv+2dhx1+hvhozO8z1TBDXOpdU3hS2p4OJgcAlNS87QKvl5VpZnBOx7HyjRv0N
	 J4HyQdkWLU4LQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a980c01033so1246311fa.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 11:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy0FSGuGwoNoqPPljC9R01NWWM9owpK+TrS3i6fA3bunqIO9LKgPIRxgn+KT/QTzzGBZgcMfIEiKQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI91FzIxNdMfGuwh1iD4Xbq1jYW9Y5+WRObyPkP2F4JGd59k79b
	08OxM1og1HGsGjSqB9PS1BVOZ2Whn3upa7KQAgIuwKzODdyqT/UrsJk9sMkmtSkrEENFd+9iEzz
	h8WbmrjnaepDoUTzB2EyuV8kX93O2dBs=
X-Received: by 2002:a05:6512:318b:b0:5be:428e:2be7 with SMTP id
 2adb3069b0e04-5be50a4eedfmr94462e87.11.1792174445585; Fri, 16 Oct 2026
 11:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
 <as_i5MEz3WfnDQmf@google.com> <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
 <atE9urIHXAJZXu6k@google.com> <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
 <CAJZ5v0gNQqffxcdzWff=z3hi0BXzJBOV6WKgf6RXuOydzQJQMw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gNQqffxcdzWff=z3hi0BXzJBOV6WKgf6RXuOydzQJQMw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 16 Oct 2026 20:11:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQ35Xm0r8UcRVYq=ZBGyPcfkp5Dtbk5etnyMsEm9wjAA@mail.gmail.com>
X-Gm-Features: AclHuK-KnhYRgSCe8hzWRnOOPWPOm-JRlMsjeyojKk-1gcbbUhfQ7VLWB9vTpQQ
Message-ID: <CAJZ5v0iQ35Xm0r8UcRVYq=ZBGyPcfkp5Dtbk5etnyMsEm9wjAA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 8:05=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Oct 16, 2026 at 7:42=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> > On Thu, Oct 15, 2026 at 10:55=E2=80=AFPM Brian Norris <briannorris@chro=
mium.org> wrote:
> > > On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel) w=
rote:
> > > > On Wed, Oct 14, 2026 at 10:15=E2=80=AFPM Brian Norris <briannorris@=
chromium.org> wrote:
> > > > > On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Inte=
l) wrote:
> > > > > > On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorri=
s@chromium.org> wrote:
> > > > > > >
>
> [cut]
>
> > >
> > > I kinda think the point of most of this power domain architecture is
> > > that a typical driver just doesn't have to worry about it at all (in
> > > probe(), and if you use runtime PM properly), so I'd prefer not
> > > mentioning it in the Basic example. But sure.
> >
> > Well, your basic example needs to be put in a certain context because
> > it may not be generally applicable everywhere.
> >
> > I think that you should make it clear what the driver's expectations
> > regarding the physical state of the device at the probe time are and
> > the general rule is that it is better to leave the device in the same
> > state in which it is expected to be found next time.
>
> To be somewhat more precise, if the driver expects to find the device
> completely off and the runtime PM callbacks are set up to make it
> operational, runtime PM can be used to power it up in probe:
>
> /* Assume the runtime PM status to be "suspended". */
> pm_runtime_enable(dev);
> pm_runtime_get_sync(dev);
>
> but then in remove or on probe errors the "power off" state needs to
> be restored manually:
>
> pm_runtime_disable(dev);
> /* Allow the parent and suppliers (if any) to suspend. */
> pm_runtime_set_suspended(dev);
> device_specific_power_off(dev);
>
> However, if the driver expects to find the device operational (for
> example, because it assumes the ACPI PM domain to be there), it may
> just update the runtime PM status before enabling runtime PM:
>
> /* Assume the runtime PM status to be "suspended". */
> pm_runtime_set_active(dev);

And I forgot to add

pm_runtime_get_noresume(dev);

here (to prevent runtime suspend from being triggered by toggling the
"control" sysfs attribute from "on" to "auto" at this point).

> pm_runtime_enable(dev);
>
> but then in remove or on probe errors it may just leave the device in
> its current physical state (whatever it is) and assume somebody else
> to take care of turning it off subsequently:
>
> pm_runtime_disable(dev);
> /* Allow the parent and suppliers (if any) to suspend. */
> pm_runtime_set_suspended(dev);
>
> These are two distinct cases that are rather hard to cover in one
> simple example.
