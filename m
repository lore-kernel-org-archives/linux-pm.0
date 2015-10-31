From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 31 Oct 2015 03:23:50 +0100
Message-ID: <3097692.FmXPBhB5oa@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510291024190.1647-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47446 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754167AbbJaByq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 21:54:46 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510291024190.1647-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Thursday, October 29, 2015 10:31:08 AM Alan Stern wrote:
> Good grief, don't you guys ever trim unwanted material from your 
> emails?  I had to erase more than 4 screens worth of useless stuff 
> before getting to the relevant portions.
> 
> On Thu, 29 Oct 2015, Tomeu Vizoso wrote:
> 
> > >> Also, have you considered that not only drivers request resources? For
> > >> example, the on-demand probing series would probe a device that is
> > >> needed by an initcall, simplifying synchronization.
> 
> Did Rafael ever say that only drivers could create these functional
> dependencies?  I don't recall seeing that anywhere.  Presumably any
> part of the kernel will be allowed to do it.

Right.

> > > You really need to explain what you mean here or maybe give an example.
> > 
> > There are initcalls that assume that a given resource is available.
> > Because of async probes, or because the resource's driver being built
> > as a module, or because the resource's driver gained a dependency
> > (direct or not), those initcalls break unexpectedly at times.

Well, I'm still unsure what initcalls are in question here.

> > If resource getters could probe dependencies on-demand, those
> > initcalls would be more robust to changes in other parts of the
> > codebase.
> > 
> > AFAIUI, your proposal would help with a device's dependencies being
> > there when it's probed, but initcalls could still run into unfulfilled
> > dependencies.
> 
> One possible approach is to have a "wait_for_driver" flag, along with a
> timeout value (or perhaps using a fixed timeout value).  When a
> dependency gets registered with this flag set, the function call
> wouldn't return until the target device is bound to a driver or the
> timeout has elapsed.
> 
> This would make it easy to insert dependencies at probe time without 
> relying on deferred probing.

I'm not sure about this to be honest.  It seems like implementing it might
be sort of tricky.

Thanks,
Rafael

