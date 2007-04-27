From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
 to -mm tree
Date: Fri, 27 Apr 2007 15:55:30 -0700
Message-ID: <20070427155530.9d589078.akpm@linux-foundation.org>
References: <200703221800.l2MI0tBW026306@shell0.pdx.osdl.net>
	<1177711880.3565.79.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177711880.3565.79.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pavel@ucw.cz, linux-pm@lists.linux-foundation.org, rmk@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

On Sat, 28 Apr 2007 00:11:20 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2007-03-22 at 10:00 -0800, akpm@linux-foundation.org wrote:
> > The patch titled
> >      rework pm_ops pm_disk_mode, kill misuse
> > has been added to the -mm tree.  Its filename is
> >      rework-pm_ops-pm_disk_mode-kill-misuse.patch
> 
> Will you be sending this patch for .22?

yup.  It's about halfway back in the -mm queue, and I usually don't start
sending the bulk of the -mm patches until halfway through the merge window
(because I have dependencies on subsystem trees, some of which are often
distressingly sluggish).

So the ETA on this one would normally be 1.5 weeks.

> I'd love to get my powermac/pmu
> suspend work merged that gets /sys/power/state working instead of using
> that pmu specific ioctl, but it depends on this patch to clean up the
> mess surrounding pm_disk_mode [1].
> 
> johannes
> 
> [1] the generic code assumes that PM_DISK_PLATFORM is a great idea in
> all cases. I'm surprised that suspend to disk is actually working for
> anybody but acpi with S4 by default.

In which case I'll move

rework-pm_ops-pm_disk_mode-kill-misuse.patch
power-management-remove-firmware-disk-mode.patch
power-management-implement-pm_opsvalid-for-everybody.patch
power-management-force-pm_opsvalid-callback-to-be.patch

to head-of-queue.

As long as it all compiles.  It often turns out that things in this area
have dependencies upon the latest gregkh rampage.  We'll see.
