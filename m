From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Wed, 12 May 2010 10:50:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005121048420.1962-100000__20596.9697483399$1273675937$gmane$org@iolanthe.rowland.org>
References: <AANLkTikH7DvizJ9340SiksoIWU5KU2n-OCqWc4f_-z9v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikH7DvizJ9340SiksoIWU5KU2n-OCqWc4f_-z9v@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Reimer <mattjreimer@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 11 May 2010, Matt Reimer wrote:

> >> or has a consensus about how to fix this been
> >> achieved? I'm hitting the same problem and have some time to work on a
> >> fix.
> >
> > Generally, it looks like del_gendisk should thaw writeback threads, but not
> > during suspend, only during resume.
> 
> Thawing the writeback thread only during resume does fix the case
> Maxim originally presented:
> 
> 0. build kernel with CONFIG_MMC_UNSAFE_RESUME
> 1. insert SD card
> 2. suspend
> 3. remove SD card while suspended
> 4. resume from suspend hangs
> 
> But if CONFIG_MMC_UNSAFE_RESUME is not set, the kernel oopses during
> suspend because the MMC device suspend times out:
> 
> mmc0: card e624 removed
> **** DPM device timeout: pxa2xx-mci.0 (pxa2xx-mci)
> kernel BUG at /home/mreimer/sdg/android/android-2.1/kernel/drivers/base/power/main.c:453!
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 817 [#1] PREEMPT
> 
> If I thaw the writeback thread unconditionally in del_gendisk() then
> suspend and resume work as expected for both CONFIG_MMC_UNSAFE_RESUME
> set/not set, even when the card is removed while suspended.
> 
> So what is the proper fix?

I don't see any reason not to let del_gendisk thaw the writeback thread
during suspend.  Since the device is going away anyhow, letting the
thread run shouldn't cause any problems.

Alan Stern
