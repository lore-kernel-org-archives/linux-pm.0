From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Sat, 18 Jun 2011 21:42:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106182137100.3523-100000__15574.19766109$1308447769$gmane$org@netrider.rowland.org>
References: <201106190157.31526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106190157.31526.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Jun 2011, Rafael J. Wysocki wrote:

> On Saturday, June 18, 2011, Rafael J. Wysocki wrote:
> > On Saturday, June 18, 2011, Alan Stern wrote:
> > > On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:
> ...
> > 
> > Well, assuming that https://patchwork.kernel.org/patch/893722/ is applied,
> > which is going to be, I think we can put
> > 
> > +       pm_runtime_get_noresume(dev);
> > +       pm_runtime_enable(dev);
> > 
> > in device_resume() after the dev->power.is_suspended check and
> > pm_runtime_put_noidle() under the End label.  That cause them to
> > be called under the device lock, but that shouldn't be a big deal.
> > 
> > Accordingly, we can call pm_runtime_disable(dev) in __device_suspend(),
> > right next to the setting of power.is_suspended.
> > 
> > This is implemented by the patch below.
> 
> Well, it hangs suspend on my Toshiba test box, I'm not sure why exactly.
> 
> This happens even if the pm_runtime_disable() is replaced with a version
> that only increments the disable depth, so it looks like something down
> the road relies on disable_depth being zero.  Which is worrisome.

This is a sign that the PM subsystem is getting a little too 
complicated.  :-(

> Trying to figure out what the problem is I noticed that, for example,
> the generic PM operations use pm_runtime_suspended() to decide whether or
> not to execute system suspend callbacks, so the patch below would break it.
> 
> Also, after commit e8665002477f0278f84f898145b1f141ba26ee26 the
> pm_runtime_suspended() check in __pm_generic_call() doesn't really make
> sense.

In light of the recent changes, we should revisit the decisions behind 
the generic PM operations.

Alan Stern
