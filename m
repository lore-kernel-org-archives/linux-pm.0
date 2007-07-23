From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 16:23:17 +0200
Message-ID: <200707231623.17958.oliver__5571.02482202954$1185200534$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707201820050.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201820050.5241-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Samstag 21 Juli 2007 schrieb Alan Stern:
> On Fri, 20 Jul 2007, Oliver Neukum wrote:
> 
> > > We already have a pre-suspend notification available for drivers that 
> > > need to allocate large amounts of memory.
> > 
> > Is that facility fine grained enough?
> 
> It's a notifier chain that gets called at several points during the 
> suspend transition.  One of those points is right at the start, while 
> userspace is still running and reasonably large amounts of memory can 
> be allocated.
> 
> Is it fine-grained enough?  I don't know -- hard to tell, since nothing 
> much is using it yet.
> 
> > > You are correct about the need to delay/stop device addition.  I don't
> > > know how this can be done in general; each code path calling
> > > device_add() may have to be treated individually.
> > 
> > What about the old API?
> 
> What old API do you mean?

The find_device() stuff.

> >  Do we have to block module loading?
> 
> No.  Registering new drivers is okay, registering new devices is bad.

What if it is a driver for virtual devices that don't need probe()
for actual hardware?

> Of course, some modules do want to register a new device in their init 
> method.  I don't know what we should do about them.  Force the 
> registration to fail, I suppose.  How often will people suspend while a 
> module is loading?
> 
> > What happens if a scsi error handler is woken? If it cannot be woken,
> > how are errors handled?
> 
> Why should the error handler wake up?  There isn't supposed to be any 
> I/O going on, hence no errors to handle.

What about shared busses? Firewire, FibreChannel? They can get external
resets, etc ...

	Regards
		Oliver
