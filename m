Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A9487CE2
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174047; cv=none; b=qZnMIojR7oHoK8lNsA99dJvYHybsHwRBUwEPIRnrWG3Wi0QE2XSdY4v2sjTpEE35ACd/o0c0WTwrqMGRvufXUE5+x4kOoDpWaV3A7s+RbfjUJsT6p7GiZub+mquawBRystuzZ8iln4NijpyvCK3wa7/SUyuMoUG1sFEoE9oelWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174047; c=relaxed/simple;
	bh=fOPONE/qJIlIU+Jzg1y7JgvnTtAaoti/FDGk/Xww4Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6qBNIcDU7Q00noPoQYa0nZ5LZQOwL88yy7srjkSroSsOVoCU5+pjF0OpDiPgVfjDzNYDtWMd5d5VgvQWR5DNQ8Xs5ggaq4L656ruf7czhCJXN4wD1ezOhK4f8L8DfB7LOx0p1SX434ruruoJX6YOuUVYPxr5hdihEe5PhVKKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llMY71ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llMY71ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D71F000C8
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174046;
	bh=fOPONE/qJIlIU+Jzg1y7JgvnTtAaoti/FDGk/Xww4Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=llMY71ruDgforWY4R0EbAe+fRsHPMlysRm53CZk2X4FFzUwUtXXejzHByXYEtZBcA
	 +fRlfTFJL2UUCeJ2Ci6I3mJ+m2mpN7eSCwcNjjBoS3/qoY+dtAAs9WEub7Ln7+gbWk
	 uK+/25jGRPZM2kiINuOIp6PSMkJfS3BgfNDIxTF0lNh1UoTAWfPi3cW5Iu3iC62AGV
	 Uk1eGSETWA+WDvDhj+2tStuF8/5cT5BqvAAt8Vzo7blG3RXO8OH9DuFkQE6tFMjlG9
	 GXnm7DuXnJnlxb8BoimVQDu+qDYep63GwaHPz+oeFZC/n8REtbOEYrIVxzqtHBwuzP
	 KDIXbYoHhzCow==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so233604e87.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 11:07:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy7aKUbu6WkZOY228tUmvfq8bl1TlALUXtmUSzDsnB7OT+beMs9D06OPHA13T02l/g5ItHIMoS7IA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgivvuHie9je4ppG2QDwjoxmkBVRr9Pos4pZK9C6NEDbyMr6eF
	bWTU1dXUDTJFybK+uoxtWKiZgLaF/xfYCuaKhmNdE8N+4dWfM7JZ9cZZbEhpmjwzyK0LqFZo3wd
	AKj8qIqmIL5N/e+GWEtIablcIXgMjdrI=
X-Received: by 2002:ac2:568e:0:b0:5b8:f0a4:3501 with SMTP id
 2adb3069b0e04-5be509ef4b1mr131455e87.2.1792174044892; Fri, 16 Oct 2026
 11:07:24 -0700 (PDT)
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
In-Reply-To: <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 16 Oct 2026 20:05:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNQqffxcdzWff=z3hi0BXzJBOV6WKgf6RXuOydzQJQMw@mail.gmail.com>
X-Gm-Features: AclHuK-_yBC6d8kzcVp_W8DXOmsw3GBEaUg-TmgYG396XRvYg6GisvbciFhwYyI
Message-ID: <CAJZ5v0gNQqffxcdzWff=z3hi0BXzJBOV6WKgf6RXuOydzQJQMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 7:42=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
> On Thu, Oct 15, 2026 at 10:55=E2=80=AFPM Brian Norris <briannorris@chromi=
um.org> wrote:
> > On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel) wro=
te:
> > > On Wed, Oct 14, 2026 at 10:15=E2=80=AFPM Brian Norris <briannorris@ch=
romium.org> wrote:
> > > > On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (Intel)=
 wrote:
> > > > > On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannorris@=
chromium.org> wrote:
> > > > > >

[cut]

> >
> > I kinda think the point of most of this power domain architecture is
> > that a typical driver just doesn't have to worry about it at all (in
> > probe(), and if you use runtime PM properly), so I'd prefer not
> > mentioning it in the Basic example. But sure.
>
> Well, your basic example needs to be put in a certain context because
> it may not be generally applicable everywhere.
>
> I think that you should make it clear what the driver's expectations
> regarding the physical state of the device at the probe time are and
> the general rule is that it is better to leave the device in the same
> state in which it is expected to be found next time.

To be somewhat more precise, if the driver expects to find the device
completely off and the runtime PM callbacks are set up to make it
operational, runtime PM can be used to power it up in probe:

/* Assume the runtime PM status to be "suspended". */
pm_runtime_enable(dev);
pm_runtime_get_sync(dev);

but then in remove or on probe errors the "power off" state needs to
be restored manually:

pm_runtime_disable(dev);
/* Allow the parent and suppliers (if any) to suspend. */
pm_runtime_set_suspended(dev);
device_specific_power_off(dev);

However, if the driver expects to find the device operational (for
example, because it assumes the ACPI PM domain to be there), it may
just update the runtime PM status before enabling runtime PM:

/* Assume the runtime PM status to be "suspended". */
pm_runtime_set_active(dev);
pm_runtime_enable(dev);

but then in remove or on probe errors it may just leave the device in
its current physical state (whatever it is) and assume somebody else
to take care of turning it off subsequently:

pm_runtime_disable(dev);
/* Allow the parent and suppliers (if any) to suspend. */
pm_runtime_set_suspended(dev);

These are two distinct cases that are rather hard to cover in one
simple example.
