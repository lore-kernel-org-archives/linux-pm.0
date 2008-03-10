From: Alan Stern <stern@rowland.harvard.edu>
Subject: BUG in include/linux/pm.h: remote wakeup settings
Date: Mon, 10 Mar 2008 10:18:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803101011540.3493-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Currently include/linux/pm.h doesn't define the should_wakeup field in 
dev_pm_info, or the related accessor macros, unless CONFIG_PM_SLEEP is 
set.

This is wrong.  Even though the system can't go to sleep, individual
devices may be placed in low-power states (runtime PM).  Thus the
various wakeup settings should be available whenever CONFIG_PM is on.

I don't want to submit a patch to fix the problem right now, because it
would clash with ongoing changes that Rafael is making.  But the bug
needs to be fixed in time for 2.6.26.

Alan Stern
