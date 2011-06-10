From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 17:27:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106101720131.1812-100000__4654.78630872003$1307741339$gmane$org@iolanthe.rowland.org>
References: <201106102227.25391.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106102227.25391.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Jun 2011, Rafael J. Wysocki wrote:

> Next, what subsystem (e.g. bus type) is the driver going to work with?
> 
> If the subsystem is "smart" enough, it can take care of many things, like
> "powering off", wakeup preparations and so on.
> 
> Now, there are a few combinations possible.  First, if the subsystem is
> "smart" and the driver need not take care of the things listed above, then
> very likely .runtime_suspend() and .suspend() can do the same and
> UNIVERSAL_DEV_PM_OPS() can be used.  Next, if the subsystem is "smart",
> but the driver needs to take care of those things, then .suspend() has
> more to do, but very likely .runtime_suspend() and .suspend_noirq() can
> do the same, while .suspend() may simply prepare the device for the next
> stage.  And so on.
> 
> It's probably fair to say that everithing depends on the subsystem, what it
> does and what it expects from the driver.

Right.  For example, consider the USB subsystem.  It has separate entry
points for system suspend and runtime suspend.  These routines decide
whether or not wakeup should be enabled, check the device's current
power state, and do a few other things; then they call the driver-level
routines.  Each driver has a single suspend routine; all it does is
quiesce the device and make sure I/O queues are stopped.  The subsystem
code then takes care of setting the proper power state.

Alan Stern
