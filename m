From: Alan Stern <stern@rowland.harvard.edu>
Subject: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 11:11:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908171103320.2644-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Rafael:

I just tried testing system suspend under vanilla 2.6.31-rc6.  I booted 
with no_console_suspend and init=/bin/bash, then did:

	cd /sys/power
	echo devices >pm_test
	echo mem >state

After the usual messages about freezing tasks, suspending devices, and
the 5-second debugging delay, nothing happened.  The system did not
restart.  It wasn't dead (it responded to Alt-SysRq key combinations)  
but it wasn't working.  This was on an x86-32 machine.

It doesn't appear to be a recent regression because 2.6.30 behaves the
same way.

With the gregkh-all-2.6.31-rc6 patch set, things are even worse.  After 
switching to the new VT, nothing appears on the screen -- not even the 
messages about freezing tasks.  I suspect there's something wrong with 
the new TTY changes but have not tried to track it down.

Alan Stern
