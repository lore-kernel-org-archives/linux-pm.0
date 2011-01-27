From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 14:49:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101271439020.2090-100000__6183.62826430729$1296157800$gmane$org@iolanthe.rowland.org>
References: <87hbcum9rh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87hbcum9rh.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Jan 2011, Kevin Hilman wrote:

> > Calling the runtime_suspend method directly is the way to do it.
> >
> 
> Do you mean the driver's runtime_suspend method, or the subsystem's
> runtime_suspend method?

The subsystem's.  If the driver has a runtime_suspend method then the 
subsystem's method will call it.

> >> While this works, I'm not crazy about it since it requires the driver
> >> know about the subsystem (in this case the bus) where the real PM work
> >> is done.  IMO, it would be much more intuitive (and readable) if the
> >> driver's suspend hooks could simply trigger a runtime suspend (either a
> >> new one, or one already requested.)
> >
> > This isn't clear to me.  Isn't the driver registered on the bus in 
> > question?  Can't the driver therefore call the bus's runtime_suspend 
> > routine directly, instead of dereferencing the bus->pm->runtime_suspend 
> > pointer?
> 
> Not sure what you mean by directly.  The platform_bus doesn't expose
> its runtime PM methods since they can be customized at runtime, so they
> have to be called via bus->pm.
> 
> Or do you mean using dev->driver instead of dev->bus?

You're doing all of this for OMAP, right?  What is the subsystem's
runtime_suspend routine?  Is it omap_pm_runtime_suspend()?

If it is, then you can call omap_pm_runtime_suspend() directly instead
of calling dev->bus->pm->runtime_suspend().

Alan Stern
