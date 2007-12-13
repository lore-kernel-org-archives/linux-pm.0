From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Thu, 13 Dec 2007 11:02:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712131055570.4414-100000@iolanthe.rowland.org>
References: <20071212234201.a8932915.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071212234201.a8932915.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Dec 2007, Andrew Morton wrote:

> On Fri, 21 Sep 2007 15:37:40 -0400 (EDT) Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > This patch (as994) reorganizes the way suspend and resume
> > notifications are sent to drivers.  The major changes are that now the
> > PM core acquires every device semaphore before calling the methods,
> > and calls to device_add() during suspends will fail.
> 
> Causes my t61p to deadlock during suspend-to-RAM.  Really late - the little
> moon symbol has started to flash but the LCD is still powered and the
> cursor still blinks.  Only a poweroff restores control.

Is there any chance of debugging this?  You have removed the patch from 
the current -mm source.  Does anybody else report a similar problem?

Proper debugging would require, to begin with, enabling 
CONFIG_PM_VERBOSE and booting with no_console_suspend.

Alan Stern
