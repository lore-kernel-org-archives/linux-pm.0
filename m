From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Functional dependencies between devices
Date: Fri, 20 Nov 2015 02:11:48 +0100
Message-ID: <7413409.PUGjvNpUKx@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <564D919B.4030107@samsung.com> <5195200.TAaTCrzPYp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62132 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752854AbbKTAmQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 19:42:16 -0500
In-Reply-To: <5195200.TAaTCrzPYp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Thursday, November 19, 2015 11:04:00 PM Rafael J. Wysocki wrote:
> On Thursday, November 19, 2015 10:08:43 AM Andrzej Hajda wrote:
> > On 11/18/2015 03:17 AM, Rafael J. Wysocki wrote:
> > > On Tuesday, November 17, 2015 01:44:59 PM Andrzej Hajda wrote:
> > >> Hi Rafael,
> > >>
> 
> [cut]
> 
> > > So the operations that need to be taken care of are:
> > > - Probe (suppliers need to be probed before consumers if the dependencies are
> > >   known beforehand).
> > > - System suspend/resume (suppliers need to be suspended after consumers and
> > >   resumed before them) which may be asynchronous (so simple re-ordering doesn't
> > >   help).
> > > - Runtime PM (suppliers should not be suspended if the consumers are not
> > >   suspended).
> > I though provider's frameworks are taking care of it already. For example
> > clock provider cannot suspend until there are prepared/enabled clocks.
> > Similar enabled regulators, phys should block provider from runtime pm
> > suspending.
> >
> > Are there situations/frameworks which requires additional care?
> 
> Yes, there are, AFAICS.
> 
> A somewhat extreme example of this is when an AML routine needed for power
> management of one device uses something like a GPIO line or an I2C link
> provided by another one.  We don't even have a way to track that kind of
> thing at the provider framework level and the only information we can get
> from the platform firmware is "this device depends on that one".
> 
> Plus, even if the frameworks track those things, when a device suspend is
> requested, the question really is "Are there any devices that have to be
> suspended before this one?" rather than "Are other devices using resources
> provided by this one?".  Of course, you may argue that answering the second
> one will allow you to answer the first one too (that is based on the assumption
> that you can always track all cases of resource utilization which may not be
> entirely realistic), but getting that answer in a non-racy way may be rather
> expensive.

More importantly, the point here is not to help drivers etc to do the right
things.  It is to make it possible for them to provide the driver core with
enough information so it can take care of doing the right things by itself.

If that works as intended, the creation of a link between two devices will
automatically cause the driver core to take care of ordering things in the
right way etc in all of the cases I listed, so the drivers of those two
devices don't need to worry about that any more.

Thanks,
Rafael

