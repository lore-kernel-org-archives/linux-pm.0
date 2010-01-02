From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk hang update
Date: Sat, 2 Jan 2010 21:38:42 +0100
Message-ID: <201001022138.42575.rjw__16543.0772504353$1262464791$gmane$org@sisk.pl>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 January 2010, Alan Jenkins wrote:
> Hi,

Hi,

> I've been suffering from s2disk hangs again.  This time, the hangs
> were always before the hibernation image was written out.
> 
> They're still frustratingly random.  I just started trying to work out
> whether doubling PAGES_FOR_IO makes them go away, but they went away
> on their own again.
> 
> I did manage to capture a backtrace with debug info though.  Here it
> is for 2.6.33-rc2.  (It has also happened on rc1).  I was able to get
> the line numbers (using gdb, e.g.  "info line
> *stop_machine_create+0x27"), having built the kernel with debug info.
> 
> [top of trace lost due to screen height]
> ? sync_page	(filemap.c:183)
> ? wait_on_page_bit	(filemap.c:506)
> ? wake_bit_function	(wait.c:174)
> ? shrink_page_list	(vmscan.c:696)
> ? __delayacct_blkio_end	(delayacct.c:94)
> ? finish_wait	(list.h:142)
> ? congestion_wait	(backing-dev.c:761)
> ? shrink_inactive_list	(vmscan.c:1193)
> ? scsi_request_fn	(spinlock.h:306)
> ? blk_run_queue	(blk-core.c:434)
> ? shrink_zone	(vmscan.c:1484)
> ? do_try_to_free_pages	(vmscan.c:1684)
> ? try_to_free_pages	(vmscan.c:1848)
> ? isolate_pages_global	(vmscan.c:980)
> ? __alloc_pages_nodemask	(page_alloc.c:1702)
> ? __get_free_pages	(page_alloc.c:1990)
> ? copy_process	(fork.c:237)
> ? do_fork	(fork.c:1443)
> ? rb_erase
> ? __switch_to
> ? kthread
> ? kernel_thread
> ? kthread
> ? kernel_thread_helper
> ? kthreadd
> ? kthreadd
> ? kernel_thread_helper
> 
> INFO: task s2disk:2174 blocked for more than 120 seconds

This looks like we have run out of memory while creating a new kernel thread
and we have blocked on I/O while trying to free some space (quite obviously,
because the I/O doesn't work at this point).

I think it should help if you increase PAGES_FOR_IO, then.

Rafael
