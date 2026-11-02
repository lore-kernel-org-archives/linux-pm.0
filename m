Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657151;
	b=RH63KtdKLkxDbSwicwTXDbDsl2HzpeASFb2LKad2833ihurqBB+TeA+CJfrl3GIVqhvg
	 nfSwnaIbuJtVz7ZO+o/4+AgDqF//FxG8yqK/V4bsvbRosmyWMx2jQpIiHWjWhhKP62tGK
	 Jl+DDycdQ5yOIPkk+8BXiv9oIaoiX6Ky+vIy9bJwSGT8/Dmu3Ktq6yEhFSIyZ3SH/Ejye
	 vo0tHX1b7xwaIE+CWpAFTKJ/7o6tz8ys7bWAzZIlb4UqRrqJS1VnjsEC55dbmHn758DOg
	 R1oBXfRlC+hSm8bHSh2q7s5/C65KRMm6wlByO1njJNBsml9BkICBnZL/f42E5avAXgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WbO27fB9MCHWgmwd8K9aWTFM4mLncfhM2klGB0+xjUE=;
	b=LirLmHdJ3Oxv0jD4gn12Xr7tp+7HhAe0dEFX7iew5aEmM7G9SDNALoEkVtmgzxJfdG48
	 LK+vnP4cAxx3QFyKZO0gDnaptkmJqMbIau1OTVsoS6Rl/0Tc/4E2pjWmwh0Y8GdpKwdNp
	 SYxIvxkcGUbUDKgZLKKt5OgIQh8H4XVprQbx18XviGy4y4DurwTjjj4bmbp9GcdgxxDyB
	 l1r3u6XWtmAHh6gAgvaEG9KQ1FprG3D6Q8bF86Kqhs7pFzk49mcEaFDpPPqYsZe1CwN8H
	 NyhuxqzC5kCfQpjSFEXUOjztaTVTDLTeWZzj0ajZU66tAqTO/E06epzd45MP2OGXuGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjR47HKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87B606A32C;
	Mon,  2 Nov 2026 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjR47HKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA941F00A16;
	Mon,  2 Nov 2026 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657151;
	bh=WbO27fB9MCHWgmwd8K9aWTFM4mLncfhM2klGB0+xjUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IjR47HKYx7+3vt6N7O/fs0Hbtsx2Hrzt+gv6lOk1k6l7sXW0sgUAtjV0QX2XejiXU
	 5GpFhU/HfpQ/DHWoPYn/OCyWGOQZxjDnW6a1p39+OgXiEjg1xijv66dLPPklsNOhCM
	 mUrJIGw2mMYtkxSKVupQL5NtNQPLzFbFGVQhTEVVyYwaw5/+TqUZgvdpqh0h6CJ8nW
	 KLadvIpU9jA0bIgLaR8UTFW/nSqbt/J4RiuuaZSlhq2+hAhzJcmivrcCw65cGIyxXy
	 oToZrKsH3Ycp/seNs5VWHnZCerfYdlKZMWULrlY4P0y4MXkGRpSsEi2+iYGR6LGRHH
	 E1QqqEn07ftdQ==
Date: Mon, 2 Nov 2026 22:05:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Brian Norris <briannorris@chromium.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Rafael J. Wysocki"	 <rafael@kernel.org>, Ulf Hansson
 <ulfh@kernel.org>, linux-pm@vger.kernel.org, Andy Shevchenko	
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 09/17] iio: hid-sensors: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261102220546.6fa5c62d@jic23-hlaptop>
In-Reply-To: <84d712c6aa3df7df8fdb6cb85b85d720bdab5840.camel@linux.intel.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
	<20261102015255.487bd1bd@jic23-hlaptop>
	<84d712c6aa3df7df8fdb6cb85b85d720bdab5840.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Nov 2026 08:55:44 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2026-11-02 at 01:52 +0000, Jonathan Cameron wrote:
> > On Wed, 21 Oct 2026 16:57:10 -0700
> > Brian Norris <briannorris@chromium.org> wrote:
> >  =20
> > > The hid-sensors driver propagates the return value of
> > > pm_runtime_put_autosuspend(), which is not particularly useful.
> > >=20
> > > Returning an error code from pm_runtime_put_autosuspend() merely
> > > means
> > > that it has not queued up a timer or work item to check whether or
> > > not
> > > the device can be suspended and there are many perfectly valid
> > > situations in which that can happen, like after writing "on" to the
> > > device's runtime PM "control" attribute in sysfs for one example.
> > >=20
> > > For this reason, modify this driver to simply discard the
> > > pm_runtime_put_autosuspend() return value.
> > >=20
> > > This will facilitate a planned change of the
> > > pm_runtime_put_autosuspend() return type to void in the future,
> > > similar
> > > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put()
> > > return
> > > type to void").
> > >=20
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com> =20
> > +CC the various hid-sensors maintainers.
> >  =20
>=20
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
>=20
> > Anyone remember why this does
> > pm_runtime_use_autosuspend(&st->pdev->dev);
> > in this code?
> >=20
> > That is unusual...=C2=A0 My immediate instinct is to
> > get rid of it, but maybe there is something subtle
> > going on. =20
>=20
> When reading sensor via raw interface, you need to power-up, read and
> power-down (This is done via runtime PM). To avoid repeating this
> sequence of power up and power down for consecutive fast reads, auto
> suspend is used. If there are reads with in 3 seconds, the sensor will
> keep power up.
>=20
Ah. I was too vague in that query.  Why is it enabled only the power
state interface rather than at the start when runtime pm is enabled?

That seems to be done via a slightly unusually on first turning on
of the trigger rather than more generally.  Normally we'd expect
it to be enabled in driver probe and all paths that need the power
on to do a pm_runtime_resume_and_get().

I'm not seeing why it is in this particularly location which doesn't
seem to be particularly sensible to me.

Jonathan


 =20



> Thanks,
> Srinivas
>=20
> >  =20
> > > ---
> > >=20
> > > Changes in v2:
> > > =C2=A0* Split iio patch into per-driver patches
> > >=20
> > > =C2=A0.../iio/common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0=C2=
=A0 | 14 +++++-----
> > > ----
> > > =C2=A01 file changed, 5 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > index 60808e2430ca..d76a6d9f04f6 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > @@ -154,21 +154,17 @@ int hid_sensor_power_state(struct
> > > hid_sensor_common *st, bool state)
> > > =C2=A0{
> > > =C2=A0
> > > =C2=A0#ifdef CONFIG_PM
> > > -	int ret;
> > > -
> > > =C2=A0	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
> > > =C2=A0		pm_runtime_enable(&st->pdev->dev);
> > > =C2=A0
> > > =C2=A0	if (state) {
> > > =C2=A0		atomic_inc(&st->user_requested_state);
> > > -		ret =3D pm_runtime_resume_and_get(&st->pdev->dev);
> > > -	} else {
> > > -		atomic_dec(&st->user_requested_state);
> > > -		pm_runtime_use_autosuspend(&st->pdev->dev);
> > > -		ret =3D pm_runtime_put_autosuspend(&st->pdev->dev);
> > > +		return pm_runtime_resume_and_get(&st->pdev->dev);
> > > =C2=A0	}
> > > -	if (ret < 0)
> > > -		return ret;
> > > +
> > > +	atomic_dec(&st->user_requested_state);
> > > +	pm_runtime_use_autosuspend(&st->pdev->dev); =20
> > This is odd enough to make me nervous even though the patch is
> > obviously a no-op change.
> >=20
> >  =20
> > > +	pm_runtime_put_autosuspend(&st->pdev->dev);
> > > =C2=A0
> > > =C2=A0	return 0;
> > > =C2=A0#else =20
> >  =20

