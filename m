From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 16:04:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171554510.2143-100000__24640.6709230088$1308341121$gmane$org@iolanthe.rowland.org>
References: <201106172147.13189.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106172147.13189.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jun 2011, Rafael J. Wysocki wrote:

> Having considered that a bit more I see that, in fact, commit
> e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
> succeed during system suspend) has introduced at least one regression.
> Namely, the PCI bus type runs pm_runtime_resume() in its .prepare()
> callback to guarantee that devices will be in a well known state before
> the PCI .suspend() and .suspend_noirq() callbacks are executed.
> Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26 this
> isn't valid any more, because devices can be runtime-suspend after the
> pm_runtime_resume() in .prepare() has run.
> 
> USB seems to do something similar in choose_wakeup().
> 
> So, either the both of these subsystems should be modified to use
> pm_runtime_get_sync() and then pm_runtime_put_<something>() some time
> during resume, or we should revert commit e8665002477f0278f84f898145b1f141ba26ee26.

pm_runtime_put_noidle would be appropriate.

> Quite frankly, which shouldn't be a surprise to anyone at this point, I'd
> prefer to revert that commit for 3.0.

Maybe we can compromise.  Instead of reverting that commit outright,
put the get_noresume just before the suspend callback and put the
put_sync just after the resume callback.

The point is that some embedded systems may rely heavily on runtime PM
to keep power usage low, so we shouldn't prevent it from doing its job
during the entire prepare -> suspend window.

Alan Stern
