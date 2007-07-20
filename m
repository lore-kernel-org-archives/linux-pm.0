From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 18:25:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707201820050.5241-100000__43469.3852476359$1184970387$gmane$org@iolanthe.rowland.org>
References: <200707202335.05519.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707202335.05519.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Oliver Neukum wrote:

> > We already have a pre-suspend notification available for drivers that 
> > need to allocate large amounts of memory.
> 
> Is that facility fine grained enough?

It's a notifier chain that gets called at several points during the 
suspend transition.  One of those points is right at the start, while 
userspace is still running and reasonably large amounts of memory can 
be allocated.

Is it fine-grained enough?  I don't know -- hard to tell, since nothing 
much is using it yet.

> > You are correct about the need to delay/stop device addition.  I don't
> > know how this can be done in general; each code path calling
> > device_add() may have to be treated individually.
> 
> What about the old API?

What old API do you mean?

>  Do we have to block module loading?

No.  Registering new drivers is okay, registering new devices is bad.

Of course, some modules do want to register a new device in their init 
method.  I don't know what we should do about them.  Force the 
registration to fail, I suppose.  How often will people suspend while a 
module is loading?

> What happens if a scsi error handler is woken? If it cannot be woken,
> how are errors handled?

Why should the error handler wake up?  There isn't supposed to be any 
I/O going on, hence no errors to handle.

Alan Stern
