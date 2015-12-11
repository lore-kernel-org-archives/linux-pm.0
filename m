From: Imre Deak <imre.deak@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce
 pm_runtime_get_noidle
Date: Fri, 11 Dec 2015 17:47:08 +0200
Message-ID: <1449848828.11262.68.camel@intel.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	 <5590453.QflIsWdzXr@vostro.rjw.lan> <1449838485.11262.20.camel@intel.com>
	 <1751844.P6fyPGmQAC@vostro.rjw.lan>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbbLKPrW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Dec 2015 10:47:22 -0500
In-Reply-To: <1751844.P6fyPGmQAC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On pe, 2015-12-11 at 16:40 +0100, Rafael J. Wysocki wrote:
> On Friday, December 11, 2015 02:54:45 PM Imre Deak wrote:
> > On to, 2015-12-10 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > On Thursday, December 10, 2015 11:20:40 PM Imre Deak wrote:
> > > > On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki wrote:
> > > > > On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki
> > > > > wrote:
> > > > > > On Thursday, December 10, 2015 11:43:50 AM Imre Deak wrote:
> > > > > > > On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki
> > > > > > > wrote:
> > > > > > > > On Wednesday, December 09, 2015 06:22:19 PM Joonas
> > > > > > > > Lahtinen
> > > > > > > > wrote:
> > > > > > > > > Introduce pm_runtime_get_noidle to for situations
> > > > > > > > > where
> > > > > > > > > it is
> > > > > > > > > not
> > > > > > > > > desireable to touch an idling device. One use
> > > > > > > > > scenario is
> > > > > > > > > periodic
> > > > > > > > > hangchecks performed by the drm/i915 driver which can
> > > > > > > > > be
> > > > > > > > > omitted
> > > > > > > > > on a device in a runtime idle state.
> > > > > > > > >=20
> > > > > > > > > v2:
> > > > > > > > > - Fix inconsistent return value when !CONFIG_PM.
> > > > > > > > > - Update documentation for bool return value
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux
> > > > > > > > > .int
> > > > > > > > > el.c
> > > > > > > > > om>
> > > > > > > > > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > >=20
> > > > > > > > Well, I don't quite see how this can be used in a non-
> > > > > > > > racy
> > > > > > > > way
> > > > > > > > without doing an additional pm_runtime_resume() or
> > > > > > > > something
> > > > > > > > like
> > > > > > > > that in the same code path.
> > > > > > >=20
> > > > > > > We don't want to resume, that would be the whole point.
> > > > > > > We'd
> > > > > > > like
> > > > > > > to
> > > > > > > ensure that we hold a reference _and_ the device is
> > > > > > > already
> > > > > > > active. So
> > > > > > > AFAICS we'd need to check runtime_status =3D=3D RPM_ACTIV=
E in
> > > > > > > addition
> > > > > > > after taking the reference.
> > > > > >=20
> > > > > > Right, and that under the lock.
> > > > >=20
> > > > > Which basically means you can call pm_runtime_resume() just
> > > > > fine,
> > > > > because it will do nothing if the status is RPM_ACTIVE
> > > > > already.
> > > > >=20
> > > > > So really, why don't you use pm_runtime_get_sync()?
> > > >=20
> > > > The difference would be that if the status is not RPM_ACTIVE
> > > > already we
> > > > would drop the reference and report error. The caller would in
> > > > this
> > > > case forego of doing something, since we the device is
> > > > suspended or
> > > > on
> > > > the way to being suspended. One example of such a scenario is a
> > > > watchdog like functionality: the watchdog work would
> > > > call pm_runtime_get_noidle() and check if the device is ok by
> > > > doing
> > > > some HW access, but only if the device is powered. Otherwise
> > > > the
> > > > work
> > > > item would do nothing (meaning it also won't reschedule
> > > > itself).
> > > > The
> > > > watchdog work would get rescheduled next time the device is
> > > > woken
> > > > up
> > > > and some work is submitted to the device.
> > >=20
> > > So first of all the name "pm_runtime_get_noidle" doesn't make
> > > sense.
> > >=20
> > > I guess what you need is something like
> > >=20
> > > bool pm_runtime_get_if_active(struct device *dev)
> > > {
> > > 	unsigned log flags;
> > > 	bool ret;
> > >=20
> > > 	spin_lock_irqsave(&dev->power.lock, flags);
> > >=20
> > > 	if (dev->power.runtime_status =3D=3D RPM_ACTIVE) {
> >=20
> > But here usage_count could be zero, meaning that the device is
> > already
> > on the way to be suspended (autosuspend or ASYNC suspend), no?
>=20
> The usage counter equal to 0 need not mean that the device is being
> suspended
> right now.

=46rom the driver's point of view it means there is no need to keep the
device active, and that's the only thing that matters for the driver.
It doesn't matter at what exact point the actual suspend will happen
after the 1->0 transition.

> Also even if that's the case, the usage counter may be incremented at
> this very
> moment by a concurrent thread and you'll lose the opportunity to do
> what you
> want.

In that case the other thread makes sure that the work what we want to
do (run the watchdog check) is rescheduled. We need to handle that kind
of race anyway, since an increment from 0->1 and setting runtime_status
to RPM_ACTIVE could happen even after we have already determined here
that the device is not active and so we return failure.

> > In that case we don't want to return success. That would
> > unnecessarily prolong
> > the time the device is kept active.
>=20
> Why?
>=20
> If you have something to do if the device is active, then do it is
> the status
> is "active".=C2=A0=C2=A0It really shouldn't matter when the device is=
 going to
> be suspended
> going forward.

Let's say the last usage_counter reference is dropped and a suspend is
scheduled with some delay. Our watchdog gets to run now and sees that
the device has an RPM_ACTIVE state, while usage_count is 0. We know
that doing the watchdog check at this point is redundant, since nobody
is using the device. Also if the watchdog work would take a rpm
usage_count reference at this point, and the pending rpm_suspend
handler would run while the reference is held, it couldn't suspend the
device, the suspend would be delayed unnecessarily.

--Imre

> > > 		atomic_inc(&dev->power.usage_count);
> > > 		ret =3D true;
> > > 	} else {
> > > 		ret =3D false;
> > > 	}
> > >=20
> > > 	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > }
> > >=20
> > > and the caller will simply bail out if "false" is returned, but
> > > if
> > > "true"
> > > is returned, it will have to drop the usage count, right?
> >=20
> > Yes.
>=20
> OK, I'll send a patch adding this function then.
>=20
> Thanks,
> Rafael
>=20
