From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Trying to understand new wakeup events architecture
Date: Wed, 15 Dec 2010 23:33:43 +0100
Message-ID: <201012152333.43644.rjw@sisk.pl>
References: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 14, 2010, Daniel Drake wrote:
> Hi,
> 
> The OLPC XO laptop suspends a lot. It suspends with the screen on as
> if it is still running. It can be woken up in a variety of ways:
> keyboard, mouse, WLAN, ...
> 
> While upstreaming OLPC's power management code I'm facing the
> requirement that our userspace power manager needs to know the reason
> for system wakeup. For example, if it was a WLAN packet then we can go
> back to sleep pretty quickly, without restoring screen brightness (the
> screen gets dimmed after a few mins of inactivity on the
> keyboard/mouse front). But if the system was woken up with the
> keyboard we want to restore screen brightness immediately and stay
> awake for a longer time before going back into suspend.
> 
> We used to do this (outside of mainline) with a /proc node storing the
> "wakeup reason" but I'm now wondering what the most upstream-suitable
> approach is.
> 
> I saw this patch:
> 
> commit 074037ec79bea73edf1b1ec72fef1010e83e3cc5
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Wed Sep 22 22:09:10 2010 +0200
> 
>     PM / Wakeup: Introduce wakeup source objects and event statistics
> 
> But I'm unable to find any documentation of what it's for or how to use it.
> 
> Does it solve my problem?
> If so, are there any examples of drivers adapted to use this
> functionality? Or documentation?
> 
> I suspect the reason I don't understand it well is because I haven't
> read 17 long threads about android...And I'd rather not, if it can be
> avoided :)

I guess it's sufficient to read the article at http://lwn.net/Articles/416690/
(or the PDF linked from there is that's not enough :-)).

I don't really think it solves your problem right now, because it's only a
high-level framework and it's missing some mechanics for this purpose.

In principle you could compare device wakeup counters before suspend
and after resume and figure out what devices reported wakeup in the
meantime from that.  For devices, the counters may be read from sysfs.
For "raw" wakeup sources it's necessary to read the wakeup_sources file in
debugfs.

Still, you need your subsystems to call pm_wakeup_event() or pm_stay_awake()
during resume to actually report the events. 

Thanks,
Rafael
