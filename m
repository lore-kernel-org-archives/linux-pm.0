From: Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Sat, 29 Sep 2007 19:04:54 +0800
Message-ID: <20070929110454.GA29861__5852.5409586311$1191251264$gmane$org@mail.ustc.edu.cn>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Message-ID: <20070929110454.GA29861@mail.ustc.edu.cn>
Content-Disposition: inline
In-Reply-To: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Chakri n <chakriin5@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, linux-pm <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Krzysztof Oledzki <olel@ans.pl>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2007 at 11:32:36PM -0700, Chakri n wrote:
> Hi,
> 
> In my testing, a unresponsive file system can hang all I/O in the system.
> This is not seen in 2.4.
> 
> I started 20 threads doing I/O on a NFS share. They are just doing 4K
> writes in a loop.
> 
> Now I stop NFS server hosting the NFS share and start a
> "dd" process to write a file on local EXT3 file system.
> 
> # dd if=/dev/zero of=/tmp/x count=1000
> 
> This process never progresses.

Peter, do you think this patch will help?

===
writeback: avoid possible balance_dirty_pages() lockup on light-load bdi

On a busy-writing system, a writer could be hold up infinitely on a
light-load device. It will be trying to sync more than enough dirty data.

The problem case:

0. sda/nr_dirty >= dirty_limit;
   sdb/nr_dirty == 0
1. dd writes 32 pages on sdb
2. balance_dirty_pages() blocks dd, and tries to write 6MB.
3. it never gets there: there's only 128KB dirty data.
4. dd may be blocked for a loooong time as long as sda is overloaded

Fix it by returning on 'zero dirty inodes' in the current bdi.
(In fact there are slight differences between 'dirty inodes' and 'dirty pages'.
But there is no available counters for 'dirty pages'.)

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---
 mm/page-writeback.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.22.orig/mm/page-writeback.c
+++ linux-2.6.22/mm/page-writeback.c
@@ -227,6 +227,9 @@ static void balance_dirty_pages(struct a
 		if (nr_reclaimable + global_page_state(NR_WRITEBACK) <=
 			dirty_thresh)
 				break;
+		if (list_empty(&mapping->host->i_sb->s_dirty) &&
+		    list_empty(&mapping->host->i_sb->s_io))
+			break;
 
 		if (!dirty_exceeded)
 			dirty_exceeded = 1;
