From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
 resume} helper functions
Date: Sat, 27 Feb 2010 10:43:09 +0000
Message-ID: <20100227104309.GB2994@sirena.org.uk>
References: <201002262224.02694.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1002261702070.2029-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002261702070.2029-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26, 2010 at 05:06:59PM -0500, Alan Stern wrote:
> On Fri, 26 Feb 2010, Rafael J. Wysocki wrote:

> > I have one problem with the design.  Namely, dpm_invoke_runtime_*() can
> > run a callback from another subsystem.  Say you are a device class and you
> > decide to use dpm_invoke_runtime_*(), but the device's bus type implements
> > the runtime PM callbacks, so they will be run as device class suspend and
> > resume callbacks.  That doesn't look particularly clean to me.

> That is a valid point.  I suppose there could be separate bus-type, 
> device-type, and device-class versions of these functions, but that 
> seems like excessive complication with little real benefit.

I do agree that it'd be good to avoid adding any further complexity here
- the use case I have is devices that only really have one suspend type
and don't want or need to know if it's a runtime, disk or memory suspend.

> Mark and Kevin, do you have any thoughts on this?

It seems to me that since people have to explicitly choose to invoke
this behaviour any such cross calls shouldn't be an issue.  There's a
reasonable chance that class or bus callbacks are just straightforward
pass throughs which don't actually add anything except moving the
function from dev_pm_ops into the bus or class ops and changing the
parameter to a more specific structure type.  Having to decide which
version of the functions to use wouldn't add anything for them.
