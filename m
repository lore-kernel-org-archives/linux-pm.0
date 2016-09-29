From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3 0/5] Functional dependencies between devices
Date: Thu, 29 Sep 2016 02:51:45 +0200
Message-ID: <5477203.SfEP4qzOYB@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <1618935.9CTdqGRBy5@vostro.rjw.lan> <20160928114220.GA6113@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44558 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753963AbcI2ApU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 20:45:20 -0400
In-Reply-To: <20160928114220.GA6113@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Jonathan Corbet <corbet@lwn.net>

On Wednesday, September 28, 2016 01:42:20 PM Lukas Wunner wrote:
> On Wed, Sep 28, 2016 at 02:33:21AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 27, 2016 02:34:29 PM Lukas Wunner wrote:
> > > I made some notes while reviewing the state machine in patch 2 of this
> > > series and thought, why not rework it into something that could eventually
> > > go into the Documentation/ tree?
> > > 
> > > So here's an initial draft.  There's some introductory text plus
> > > a description of the state machine.  Just putting this out there now
> > > to ease reviewers' lives, despite the obvious WIP status.  I'll try to
> > > amend it as the series converges.
> > > 
> > > This is already rst-formatted but I haven't actually run it through
> > > sphinx yet.
> > 
> > Thanks a lot for doing this!
> > 
> > It looks good to me in general.  I think it would be good to add it to the
> > series at one point (if you don't mind).
> 
> Sure thing, thanks.
> 
> 
> > I'm only a bit reluctant about advertising the usage of links between
> > children and parents, because that doesn't look like the right tool for
> > the purpose (as I said before, I'd prefer to add a device flag causing
> > the parent driver to be probed before the child one if needed).
> 
> That wouldn't cover the unbinding of the child when the parent unbinds
> though, so it would only be a subset of the functionality offered by
> device links.
> 
> I actually don't know of a use case where driver presence is needed
> between parent and child.  But the patches look like they should work
> out of the box in such a scenario, so I was thinking, why forbid it?
> Someone might just try that because they think it should obviously work,
> and then they'll find out at runtime that it's forbidden.  That gives
> us only a score of 5 in Rusty's API rating scheme.
> 
> However for consistency, if you do want to forbid it, I think it should
> be forbidden for all ancestors of the device, not just the parent as v3
> does it.  (Suspend/resume + shutdown ordering is already handled for
> hierarchical dependencies, i.e. all ancestors.)

Well, there is a difference between allowing something to be done and
documenting it as a good idea. :-)

Thanks,
Rafael

