From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 12:28:55 -0800
Message-ID: <20141117202855.GB5258@dtor-ws>
References: <20141117191755.GA5258@dtor-ws>
 <Pine.LNX.4.44L0.1411171447390.851-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:51027 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbaKQU3A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 15:29:00 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411171447390.851-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Mon, Nov 17, 2014 at 02:54:53PM -0500, Alan Stern wrote:
> On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> 
> > > For devices that aren't part of a power domain, things are simpler.
> > > The bus does _get_noresume() to make sure the device won't be runtime
> > > suspended while the probe routine is running.  It doesn't do
> > > _get_sync(), because that would end up calling the driver's
> > > runtime_resume routine before the driver was bound to the device.  (The
> > > bus could prevent that from happening by taking special precautions,
> > > like PCI does, but in general it's a nuisance.)
> > 
> > That's why I think we need some new call that would mean "make sure the
> > device is powered" which would properly handle power domain and bus, but
> > ignore all driver stuff since it may not be initialized yet. And similar
> > call for asking to put device and maybe domain in powered down state in
> > case probing failed.
> 
> I can't imagine how such a call would work.
> 
> The PM core invokes the subsystem's runtime_suspend/resume callback, 
> and then the subsystem's routine is responsible for invoking the 
> driver's callback (or _not_ invoking it, in this case).
> 
> Thus, the PM core has no way to tell the subsystem's callback not to
> invoke the driver's routine, and adding a new runtime PM call wouldn't
> change that.  You'd have to add a new pair of callbacks instead, which 
> IMO would be a tremendous waste.
> 
> Furthermore, the subsystem already _knows_ when the driver gets probed, 
> because probing works in the same sort of way: The subsystem's probe 
> routine gets invoked, and it is responsible for invoking the driver's 
> probe routine.  Therefore the PM core doesn't _need_ to provide this 
> extra information to the subsystem.  Rather, the subsystem just needs 
> to keep track of the information it already has available.

You are missing concept of power domains in this picture. True,
subsystem knows when it probes but power domain does not. Subsystem has
no knowledge of power domain (devices in the same subsystem can come
from different domains).

We need to have either subsystem or device core to indicate to power
management core that we do not need "full" runtime resume, but rather a
"partial" one since driver is not ready yet.

We would not need new callbacks here I think, we just need to be able to
select appropriate set of callbacks, depending on the binding state.

Thanks.

-- 
Dmitry
