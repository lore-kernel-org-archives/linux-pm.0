From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v3 0/5] Functional dependencies between devices
Date: Tue, 15 Nov 2016 19:50:53 +0100
Message-ID: <20161115185053.GA11003@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <1618935.9CTdqGRBy5@vostro.rjw.lan>
 <20160928114220.GA6113@wunner.de>
 <5477203.SfEP4qzOYB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5477203.SfEP4qzOYB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 29, 2016 at 02:51:45AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 28, 2016 01:42:20 PM Lukas Wunner wrote:
> > On Wed, Sep 28, 2016 at 02:33:21AM +0200, Rafael J. Wysocki wrote:
> > > I'm only a bit reluctant about advertising the usage of links between
> > > children and parents, because that doesn't look like the right tool for
> > > the purpose (as I said before, I'd prefer to add a device flag causing
> > > the parent driver to be probed before the child one if needed).
> > 
> > That wouldn't cover the unbinding of the child when the parent unbinds
> > though, so it would only be a subset of the functionality offered by
> > device links.
> > 
> > I actually don't know of a use case where driver presence is needed
> > between parent and child.  But the patches look like they should work
> > out of the box in such a scenario, so I was thinking, why forbid it?
> > Someone might just try that because they think it should obviously work,
> > and then they'll find out at runtime that it's forbidden.  That gives
> > us only a score of 5 in Rusty's API rating scheme.
> > 
> > However for consistency, if you do want to forbid it, I think it should
> > be forbidden for all ancestors of the device, not just the parent as v3
> > does it.  (Suspend/resume + shutdown ordering is already handled for
> > hierarchical dependencies, i.e. all ancestors.)
> 
> Well, there is a difference between allowing something to be done and
> documenting it as a good idea. :-)

I'm reworking the documentation and to address your concerns I have
now reformulated this paragraph as follows:

    To prevent introduction of dependency loops into the graph, it is
    verified upon device link addition that the supplier is not dependent
    on the consumer or any children or consumers of the consumer.
    (Call to device_is_dependent() from device_link_add().)  If that
    constraint is violated, device_link_add() will return %NULL and
    a WARNING will be logged.

    Notably this also prevents addition of a device link from a parent
    device to a child.  However the converse is allowed, i.e. a device link
    from a child to a parent.  Since the driver core already guarantees
    correct suspend/resume and shutdown ordering between parent and child,
    such a device link only makes sense if a driver presence dependency is
    needed on top of that.  In that case driver authors should weigh
    carefully if a device link is the right tool for the purpose.
    A more suitable approach might be to simply use deferred probing or
    add a device flag causing the parent driver to be probed before the
    child one.

If you'd prefer a different wording just shout.

Thanks,

Lukas
