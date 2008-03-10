From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG in include/linux/pm.h: remote wakeup settings
Date: Mon, 10 Mar 2008 16:06:37 +0100
Message-ID: <200803101606.37723.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803101011540.3493-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803101011540.3493-100000@iolanthe.rowland.org>
Content-Disposition: inline
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

On Monday, 10 of March 2008, Alan Stern wrote:
> Currently include/linux/pm.h doesn't define the should_wakeup field in 
> dev_pm_info, or the related accessor macros, unless CONFIG_PM_SLEEP is 
> set.
> 
> This is wrong.  Even though the system can't go to sleep, individual
> devices may be placed in low-power states (runtime PM).  Thus the
> various wakeup settings should be available whenever CONFIG_PM is on.
> 
> I don't want to submit a patch to fix the problem right now, because it
> would clash with ongoing changes that Rafael is making.  But the bug
> needs to be fixed in time for 2.6.26.

Well, I'm going to prepare a "for 2.6.26" series of patches to send to Greg
(that won't include the "separate suspend and hibernation callbacks" patch
yet).

If you post a patch for this (with a changelog and s-o-b), I'll rebase it (if
necessary) add it to the series.

Thanks,
Rafael
