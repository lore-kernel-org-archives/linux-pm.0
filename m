From: Imre Deak <imre.deak@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce
 pm_runtime_get_noidle
Date: Thu, 10 Dec 2015 23:20:40 +0200
Message-ID: <1449782440.28642.5.camel@intel.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	 <1449740630.25404.5.camel@intel.com> <3880444.CTtrq5s3vh@vostro.rjw.lan>
	 <1965611.CCxSd8EYaz@vostro.rjw.lan>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49362 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbbLJVUs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 16:20:48 -0500
In-Reply-To: <1965611.CCxSd8EYaz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki wrote:
> On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki wrote:
> > On Thursday, December 10, 2015 11:43:50 AM Imre Deak wrote:
> > > On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, December 09, 2015 06:22:19 PM Joonas Lahtinen
> > > > wrote:
> > > > > Introduce pm_runtime_get_noidle to for situations where it is
> > > > > not
> > > > > desireable to touch an idling device. One use scenario is
> > > > > periodic
> > > > > hangchecks performed by the drm/i915 driver which can be
> > > > > omitted
> > > > > on a device in a runtime idle state.
> > > > >=20
> > > > > v2:
> > > > > - Fix inconsistent return value when !CONFIG_PM.
> > > > > - Update documentation for bool return value
> > > > >=20
> > > > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.c
> > > > > om>
> > > > > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > Cc: linux-pm@vger.kernel.org
> > > >=20
> > > > Well, I don't quite see how this can be used in a non-racy way
> > > > without doing an additional pm_runtime_resume() or something
> > > > like
> > > > that in the same code path.
> > >=20
> > > We don't want to resume, that would be the whole point. We'd like
> > > to
> > > ensure that we hold a reference _and_ the device is already
> > > active. So
> > > AFAICS we'd need to check runtime_status =3D=3D RPM_ACTIVE in
> > > addition
> > > after taking the reference.
> >=20
> > Right, and that under the lock.
>=20
> Which basically means you can call pm_runtime_resume() just fine,
> because it will do nothing if the status is RPM_ACTIVE already.
>=20
> So really, why don't you use pm_runtime_get_sync()?

The difference would be that if the status is not RPM_ACTIVE already we
would drop the reference and report error. The caller would in this
case forego of doing something, since we the device is suspended or on
the way to being suspended. One example of such a scenario is a
watchdog like functionality: the watchdog work would
call=C2=A0pm_runtime_get_noidle() and check if the device is ok by doin=
g
some HW access, but only if the device is powered. Otherwise the work
item would do nothing (meaning it also won't reschedule itself). The
watchdog work would get rescheduled next time the device is woken up
and some work is submitted to the device.

--Imre
