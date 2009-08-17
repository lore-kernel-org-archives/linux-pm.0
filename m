From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 20:28:26 +0200
Message-ID: <200908172028.26817.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908171103320.2644-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908171103320.2644-100000@iolanthe.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 17 August 2009, Alan Stern wrote:
> Rafael:

Hi,

> I just tried testing system suspend under vanilla 2.6.31-rc6.  I booted 
> with no_console_suspend and init=/bin/bash, then did:
> 
> 	cd /sys/power
> 	echo devices >pm_test
> 	echo mem >state
> 
> After the usual messages about freezing tasks, suspending devices, and
> the 5-second debugging delay, nothing happened.  The system did not
> restart.  It wasn't dead (it responded to Alt-SysRq key combinations)  
> but it wasn't working.  This was on an x86-32 machine.
> 
> It doesn't appear to be a recent regression because 2.6.30 behaves the
> same way.
> 
> With the gregkh-all-2.6.31-rc6 patch set, things are even worse.  After 
> switching to the new VT, nothing appears on the screen -- not even the 
> messages about freezing tasks.  I suspect there's something wrong with 
> the new TTY changes but have not tried to track it down.

I wonder where exactly it hangs.

Can you rebuild the kernel with CONFIG_PM_VERBOSE set and
repeat the test with 'echo 8 > /proc/sys/kernel/printk' before the last
command?

Rafael
