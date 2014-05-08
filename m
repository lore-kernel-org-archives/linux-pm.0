From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 1/3] PM / sleep: Flag to speed up suspend-resume of runtime-suspended devices
Date: Thu, 08 May 2014 23:50:23 +0200
Message-ID: <2356017.WpDFDYKWcr@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1405081718200.995-100000@iolanthe.rowland.org> <1516837.oN5cf7KDad@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1516837.oN5cf7KDad@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 08, 2014 11:42:01 PM Rafael J. Wysocki wrote:
> On Thursday, May 08, 2014 05:20:43 PM Alan Stern wrote:
> > On Thu, 8 May 2014, Rafael J. Wysocki wrote:
> > 
> > > > > Wait a minute.  Following ->runtime_suspend(), you are going to call 
> > > > > ->suspend() and then ->runtime_resume()?  That doesn't seem like what 
> > > > > you really want; a ->suspend() call should always have a matching 
> > > > > ->resume().
> > > > 
> > > > Yes, it should, but I didn't see any other way to do that.
> > > 
> > > Actually, that's kind of easy to resolve. :-)
> > > 
> > > When ->suspend() leaves power.leave_runtime_suspended set, the PM core can
> > > simply skip the early/late and noirq callbacks and then call ->resume()
> > > that will be responsible for using whatever is necessary to resume the
> > > device.
> > > 
> > > And perhaps the flag should be called something different then, like
> > > direct_resume (meaning go directly for ->resume() without executing
> > > the intermediate callbacks)?
> > 
> > In light of what I wrote earlier, it should be okay for the ->prepare() 
> > callback to be responsible for setting leave_runtime_suspended.  Then 
> > there will be no need to call either ->suspend() or ->resume().
> 
> Hmm.  OK, let's try that.

Well, no.

The reason why that doesn't work is because ->prepare() callbacks are
executed in the reverse order, so the perent's ones will be run before
the ->prepare() of the children.  Thus if ->prepare() sets the flag
with the expectation that ->suspend() (and the subsequent callbacks)
won't be executed, that expectation may not be met actually.

So I'm going to do what I said above.  I prefer it anyway. :-)

Rafael

