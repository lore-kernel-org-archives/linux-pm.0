From: Imre Deak <imre.deak@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce
 pm_runtime_get_noidle
Date: Thu, 10 Dec 2015 11:43:50 +0200
Message-ID: <1449740630.25404.5.camel@intel.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	 <1449678139-17782-1-git-send-email-joonas.lahtinen@linux.intel.com>
	 <1472993.ZDhaIi32oY@vostro.rjw.lan>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45461 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbbLJJn6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 04:43:58 -0500
In-Reply-To: <1472993.ZDhaIi32oY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki wrote:
> On Wednesday, December 09, 2015 06:22:19 PM Joonas Lahtinen wrote:
> > Introduce pm_runtime_get_noidle to for situations where it is not
> > desireable to touch an idling device. One use scenario is periodic
> > hangchecks performed by the drm/i915 driver which can be omitted
> > on a device in a runtime idle state.
> >=20
> > v2:
> > - Fix inconsistent return value when !CONFIG_PM.
> > - Update documentation for bool return value
> >=20
> > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: linux-pm@vger.kernel.org
>=20
> Well, I don't quite see how this can be used in a non-racy way
> without doing an additional pm_runtime_resume() or something like
> that in the same code path.

We don't want to resume, that would be the whole point. We'd like to
ensure that we hold a reference _and_ the device is already active. So
AFAICS we'd need to check=C2=A0runtime_status =3D=3D RPM_ACTIVE in addi=
tion
after taking the reference.

--Imre
