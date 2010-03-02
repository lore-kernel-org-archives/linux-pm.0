From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Tue, 2 Mar 2010 01:12:02 +0100
Message-ID: <201003020112.02114.rjw@sisk.pl>
References: <201002262224.02694.rjw@sisk.pl> <201002272350.16523.rjw@sisk.pl>
	<87r5o3adcw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r5o3adcw.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 01 March 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Saturday 27 February 2010, Mark Brown wrote:
> >> On Fri, Feb 26, 2010 at 05:06:59PM -0500, Alan Stern wrote:
> >> > On Fri, 26 Feb 2010, Rafael J. Wysocki wrote:
> >> 
> >> > > I have one problem with the design.  Namely, dpm_invoke_runtime_*() can
> >> > > run a callback from another subsystem.  Say you are a device class and you
> >> > > decide to use dpm_invoke_runtime_*(), but the device's bus type implements
> >> > > the runtime PM callbacks, so they will be run as device class suspend and
> >> > > resume callbacks.  That doesn't look particularly clean to me.
> >> 
> >> > That is a valid point.  I suppose there could be separate bus-type, 
> >> > device-type, and device-class versions of these functions, but that 
> >> > seems like excessive complication with little real benefit.
> >> 
> >> I do agree that it'd be good to avoid adding any further complexity here
> >> - the use case I have is devices that only really have one suspend type
> >> and don't want or need to know if it's a runtime, disk or memory suspend.
> >
> > What about the patch below, then (untested)?
> >
> > Use GENERIC_SUBSYS_PM_OPS for the subsystem and then
> > UNIVERSAL_DEV_PM_OPS for drivers, possibly passing NULL as idle_fn.
> 
> This looks good to me for what I'm tinkering with too, but have not
> tested it.
> 
> One thing missing from the orignal patch is a publicly availble
> version of pm_is_runtime_suspended().  I found this useful in at least
> one driver where I needed a slightly different suspend hook from he
> runtime hook.

It is present, but called pm_runtime_suspended(), in the updated patch I sent
a while ago:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-March/024535.html

I'd appreciate it if someone could test that patch.  I only could verify that
it built correctly with various combinations of .config options.

Rafael
