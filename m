From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system suspend callbacks
Date: Thu, 21 Sep 2017 16:44:20 +0200
Message-ID: <3931370.5Uq9JPS6oA@aspire.rjw.lan>
References: <Pine.LNX.4.44L0.1709211031120.1423-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709211031120.1423-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Stezenbach <js@sig21.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 21, 2017 4:36:30 PM CEST Alan Stern wrote:
> On Thu, 21 Sep 2017, Johannes Stezenbach wrote:
> 
> > On Thu, Sep 21, 2017 at 02:39:30AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Sep 20, 2017 at 6:27 PM, Johannes Stezenbach <js@sig21.net> wrote:
> > > >
> > > >  E.g. an audio codec could keep running
> > > > while the i2c bus used to program its registers can be runtime suspended.
> > > > If this is correct I think it would be useful to spell it out explicitly
> > > > in the documentation.
> > > 
> > > That's because the i2c bus uses the ignore_children flag that allows
> > > it to override the general rules. :-)
> > 
> > Ah!  I was looking at Documentation/driver-api/pm only (which is
> > changed by your patch), but this is documented in Documentation/power
> > (and obviously I hadn't checked the code, shame on me).
> > 
> > > direct_complete has nothing to do with this.
> > 
> > Oh?  Reading again, do I get this right:
> > 
> > 1. simple method: always call pm_runtime_resume() in ->suspend(),
> >    then suspend the driver again
> > 2. optimization: if pm_runtime_suspended(), the driver's ->suspend()
> >    can possibly do nothing if conditions permit, otherwise it calls
> >    pm_runtime_resume() and then suspends
> > 3. optimization: tell pm core to skip ->suspend() via return value
> >    from ->prepare() which sets direct_complete
> > 
> > ...and your patch only deals with 1 and 2.
> > 
> > Sorry to hijack your thread for side discussion, it was
> > inadvertant due to my lack of understanding.
> > 
> > 
> > > First off, the PM core does check the direct_complete flag in
> > > __device_suspend() and does more-or-less what you are saying.
> > > 
> > > However, that flag is initialized in device_prepare() with the help of
> > > the ->suspend() return value, because whether or not it makes sense to
> > 
> > you mean ->prepare(), right?
> > 
> > > set that flag depends on some conditions that may change between
> > > consecutive system suspend-resume cycles in general and need to be
> > > checked in advance before setting it.
> > > 
> > > HTH
> > 
> > It does, however the question remains *why* it needs to check
> > it in ->prepare() and not right before calling ->suspend().
> > Using ->prepare() for the purpose seems wrong since it traverses
> > the hierarchy in the "wrong" order.
> 
> No, it is the _right_ order.  If a device's ->prepare() says that
> direct_complete is okay, but one of its descendants disallows
> direct_complete, we then want to clear the direct_complete flag in the
> original device structure.  We couldn't do this if we checked the 
> descendant's driver first.

But we really clear it for parents (and suppliers) in __device_suspend(),
which is still OK, because that is first called for the children (and
consumers).  So the ordering of ->prepare() doesn't really matter here IMO.

Thanks,
Rafael
