From: Daniel Drake <dsd@laptop.org>
Subject: Trying to understand new wakeup events architecture
Date: Tue, 14 Dec 2010 17:57:20 +0000
Message-ID: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

The OLPC XO laptop suspends a lot. It suspends with the screen on as
if it is still running. It can be woken up in a variety of ways:
keyboard, mouse, WLAN, ...

While upstreaming OLPC's power management code I'm facing the
requirement that our userspace power manager needs to know the reason
for system wakeup. For example, if it was a WLAN packet then we can go
back to sleep pretty quickly, without restoring screen brightness (the
screen gets dimmed after a few mins of inactivity on the
keyboard/mouse front). But if the system was woken up with the
keyboard we want to restore screen brightness immediately and stay
awake for a longer time before going back into suspend.

We used to do this (outside of mainline) with a /proc node storing the
"wakeup reason" but I'm now wondering what the most upstream-suitable
approach is.

I saw this patch:

commit 074037ec79bea73edf1b1ec72fef1010e83e3cc5
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Wed Sep 22 22:09:10 2010 +0200

    PM / Wakeup: Introduce wakeup source objects and event statistics

But I'm unable to find any documentation of what it's for or how to use it.

Does it solve my problem?
If so, are there any examples of drivers adapted to use this
functionality? Or documentation?

I suspect the reason I don't understand it well is because I haven't
read 17 long threads about android...And I'd rather not, if it can be
avoided :)

Thanks,
Daniel
