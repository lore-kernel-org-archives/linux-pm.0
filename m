From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Mon, 20 Dec 2010 19:57:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012201946330.19558-100000__4235.59998530454$1292893157$gmane$org@netrider.rowland.org>
References: <201012202217.09374.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012202217.09374.rjw@sisk.pl>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Dec 2010, Rafael J. Wysocki wrote:

> > > In that case, if a device if flagged as "runtime only", we can avoid
> > > calling pm_runtime_get_noirq() for it in dpm_prepare() and, analogously,
> > > calling pm_runtime_put_sync() for it in dpm_complete().  However, we will have
> > > to fail system suspend (or hibernation) if a "runtime only" device has the
> > > power.runtime_auto flag unset.
> > 
> > Or more generally, if pm_runtime_suspended() doesn't return 'true' for 
> > the device.
> 
> That's not necessary, because the device may be suspended using
> pm_runtime_suspend() later than we check pm_runtime_suspended().

What if the device has a child in the RPM_ACTIVE state?  Then 
pm_runtime_suspend() won't do anything, even if the child really is 
dpm-suspended.

> I'd use the "runtime only" (or perhaps better "no_dpm") flag as a declaration
> (if set) that the device is going to be suspended with the help of "runtime"
> callbacks and the driver takes the responsibility for getting things right.

I'm still not sure about this; the design isn't clear.  Are these
runtime callbacks going to come from the PM core or from the driver?  
If from the driver, how will the driver know when to issue them?  What
about coordinating async suspends (the device must be suspended after
its children and before its parent)?

Alan Stern
