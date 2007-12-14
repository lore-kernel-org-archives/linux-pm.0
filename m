From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Fri, 14 Dec 2007 02:05:59 +0100
Message-ID: <200712140205.59942.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0709211536570.5816-100000@iolanthe.rowland.org>
	<200712140108.37609.rjw@sisk.pl>
	<20071213162224.ea5aec25.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213162224.ea5aec25.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 14 of December 2007, Andrew Morton wrote:
> On Fri, 14 Dec 2007 01:08:37 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Thursday, 13 of December 2007, Rafael J. Wysocki wrote:
> > > On Thursday, 13 of December 2007, Andrew Morton wrote:
> > > > On Fri, 21 Sep 2007 15:37:40 -0400 (EDT) Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > 
> > > > > This patch (as994) reorganizes the way suspend and resume
> > > > > notifications are sent to drivers.  The major changes are that now the
> > > > > PM core acquires every device semaphore before calling the methods,
> > > > > and calls to device_add() during suspends will fail.
> > > > 
> > > > Causes my t61p to deadlock during suspend-to-RAM.  Really late - the little
> > > > moon symbol has started to flash but the LCD is still powered and the
> > > > cursor still blinks.  Only a poweroff restores control.
> > > 
> > > Most probably, one of the drivers or a CPU hotplug notifier unregisters a
> > > device during suspend (wrong).
> > > 
> > > Please boot with no_console_suspend and check if the box survives (with this
> > > patch applied):
> > > 
> > > # echo 8 > /proc/sys/kernel/printk
> > > # echo processors > /sys/power/pm_test
> > > # echo mem > /sys/power/state
> > > 
> > > If it doesn't, you can try 
> > > 
> > > # echo platform > /sys/power/pm_test
> > > # echo mem > /sys/power/state
> > > 
> > > and
> > > 
> > > # echo devices > /sys/power/pm_test
> > > # echo mem > /sys/power/state
> > 
> > Ah, that won't work, because git-acpi-build-fix.patch killed
> > /sys/power/pm_test altogether.  Sorry.
> 
> I was wondering..
> 
> What's going on with git-acpi-build-fix.patch anyway?  Is there
> something different we should do?

Yes.  I've sent a patch to you and Len, here:
http://marc.info/?l=linux-acpi&m=119758974523027&w=2
