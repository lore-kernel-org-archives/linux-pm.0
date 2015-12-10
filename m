From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Thu, 10 Dec 2015 22:42:22 +0100
Message-ID: <1965611.CCxSd8EYaz@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <1449740630.25404.5.camel@intel.com> <3880444.CTtrq5s3vh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45111 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750960AbbLJVMV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 16:12:21 -0500
In-Reply-To: <3880444.CTtrq5s3vh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: imre.deak@intel.com
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki wrote:
> On Thursday, December 10, 2015 11:43:50 AM Imre Deak wrote:
> > On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, December 09, 2015 06:22:19 PM Joonas Lahtinen wrote:
> > > > Introduce pm_runtime_get_noidle to for situations where it is not
> > > > desireable to touch an idling device. One use scenario is periodic
> > > > hangchecks performed by the drm/i915 driver which can be omitted
> > > > on a device in a runtime idle state.
> > > > 
> > > > v2:
> > > > - Fix inconsistent return value when !CONFIG_PM.
> > > > - Update documentation for bool return value
> > > > 
> > > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: linux-pm@vger.kernel.org
> > > 
> > > Well, I don't quite see how this can be used in a non-racy way
> > > without doing an additional pm_runtime_resume() or something like
> > > that in the same code path.
> > 
> > We don't want to resume, that would be the whole point. We'd like to
> > ensure that we hold a reference _and_ the device is already active. So
> > AFAICS we'd need to check runtime_status == RPM_ACTIVE in addition
> > after taking the reference.
> 
> Right, and that under the lock.

Which basically means you can call pm_runtime_resume() just fine,
because it will do nothing if the status is RPM_ACTIVE already.

So really, why don't you use pm_runtime_get_sync()?

Thanks,
Rafael

