From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Sun, 8 Jul 2012 16:59:23 +0200
Message-ID: <201207081659.23600.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1207072155400.508-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1207072155400.508-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, July 08, 2012, Alan Stern wrote:
> On Sat, 7 Jul 2012, Rafael J. Wysocki wrote:
> 
> > > What is the right way to handle the runtime PM enable/disable in a
> > > failed probe attempt?
> > 
> > I would recommend using pm_runtime_disable() and then either
> > pm_runtime_set_active() or pm_runtime_set_suspended() depending on what the
> > real power state of the device is at this point.
> > 
> > Anyway, you can't force the device into a low-power state using runtime PM
> > after a failing probe, at least in general.
> 
> Right.  About the best you could do would be to call the appropriate 
> runtime_suspend method directly, instead of going through the runtime 
> PM core.  However, if the probe is failing then there's no reason to 
> think the runtime_suspend method will work.
> 
> Basically, on the platform bus, if you don't have a driver for a device 
> (which you don't, if the probe routine fails) then you can't do runtime 
> PM on it.
> 
> But what if the device belongs to a PM domain?  Putting the entire
> domain back into a low-power state might have the desired effect -- but
> the probe routine wouldn't be able to do this.  The platform subsystem
> would have to take care of it somehow.

Yes.

For example, on sh platforms we call pm_gnepd_poweroff_unused() from a
late initcall (drivers/sh/pm_runtime.c), which causes all PM domains that
only contain suspended devices and devices without drivers to be turned off.

Thanks,
Rafael
