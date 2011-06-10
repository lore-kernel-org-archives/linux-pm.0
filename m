From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 15:36:57 +0100
Message-ID: <20110610143657.GF26441__8858.28802497617$1307716673$gmane$org@sirena.org.uk>
References: <87hb80546c.fsf@ti.com>
	<Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 09, 2011 at 09:56:48AM -0400, Alan Stern wrote:
> On Wed, 8 Jun 2011, Kevin Hilman wrote:

> > Runtime suspend
> > 2. activity finishes

> > system suspend [echo mem > /sys/power/state]
> > 2. prevent future activity, halt/wait for current activity

> > The only difference is step 2.

> That _is_ the main difference, and it's a big one.  (As Magnus pointed 
> out, wakeup-enabling is another difference).

...

> They don't have to be decoupled, and indeed they can share code.  The 
> point Rafael and I are making is that they have to use different 
> callback pointers, which gives you a chance to handle the differences 
> as well as the similarities.

It seems like everyone's agreeing with each other here - from the user
side the request seems to be largely for core infastructure like
UNIVERSAL_DEV_PM_OPS() (which I'm not sure is a good idea any more given
that it doesn't do anything to handle the runtime/system interaction?).
Right now this all feels like more work than it should be in simpler
drivers.

> > For many (if not all) devices though, what I suspect we would want is
> > for devices that are runtime suspended to stay runtime suspended across
> > a system suspend *and* resume.  That would mean that the device power
> > domain would not call system PM callbacks on devices that are runtime
> > suspended.

> No, it's generally agreed that _all_ devices should return to full 
> power during system resume -- even if they were runtime suspended 
> before the system sleep.  This also is explained in the Documentation 
> files.

What is the reasoning behind this agreement?  It's not immediately
obvious why this is useful.
