From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 23:29:36 +0200
Message-ID: <201106172329.37087.rjw__42636.7915854373$1308346298$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106171554510.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171554510.2143-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2011, Alan Stern wrote:
> On Fri, 17 Jun 2011, Rafael J. Wysocki wrote:
> 
> > Having considered that a bit more I see that, in fact, commit
> > e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
> > succeed during system suspend) has introduced at least one regression.
> > Namely, the PCI bus type runs pm_runtime_resume() in its .prepare()
> > callback to guarantee that devices will be in a well known state before
> > the PCI .suspend() and .suspend_noirq() callbacks are executed.
> > Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26 this
> > isn't valid any more, because devices can be runtime-suspend after the
> > pm_runtime_resume() in .prepare() has run.
> > 
> > USB seems to do something similar in choose_wakeup().
> > 
> > So, either the both of these subsystems should be modified to use
> > pm_runtime_get_sync() and then pm_runtime_put_<something>() some time
> > during resume, or we should revert commit e8665002477f0278f84f898145b1f141ba26ee26.
> 
> pm_runtime_put_noidle would be appropriate.
> 
> > Quite frankly, which shouldn't be a surprise to anyone at this point, I'd
> > prefer to revert that commit for 3.0.
> 
> Maybe we can compromise.  Instead of reverting that commit outright,
> put the get_noresume just before the suspend callback and put the
> put_sync just after the resume callback.

That wouldn't fix the PCI problem, though, because it would leave a small
window in which the device could be suspended after the pm_runtime_resume()
in pci_pm_prepare() had run.

Thanks,
Rafael
