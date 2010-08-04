From: Nigel Cunningham <nigel@tuxonice.net>
Subject: 2.6.35 Regression: Ages spent discarding blocks that
	weren't used!
Date: Wed, 04 Aug 2010 11:40:56 +1000
Message-ID: <4C58C528.4000606__16918.892824515$1280886190$gmane$org@tuxonice.net>
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
To: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi all.

I've just given hibernation a go under 2.6.35, and at first I thought 
there was some sort of hang in freezing processes. The computer sat 
there for aaaaaages, apparently doing nothing. Switched from TuxOnIce to 
swsusp to see if it was specific to my code but no - the problem was 
there too. I used the nifty new kdb support to get a backtrace, which was:

get_swap_page_of_type
discard_swap_cluster
blk_dev_issue_discard
wait_for_completion

Adding a printk in discard swap cluster gives the following:

[   46.758330] Discarding 256 pages from bdev 800003 beginning at page 
640377.
[   47.003363] Discarding 256 pages from bdev 800003 beginning at page 
640633.
[   47.246514] Discarding 256 pages from bdev 800003 beginning at page 
640889.

...

[  221.877465] Discarding 256 pages from bdev 800003 beginning at page 
826745.
[  222.121284] Discarding 256 pages from bdev 800003 beginning at page 
827001.
[  222.365908] Discarding 256 pages from bdev 800003 beginning at page 
827257.
[  222.610311] Discarding 256 pages from bdev 800003 beginning at page 
827513.

So allocating 4GB of swap on my SSD now takes 176 seconds instead of 
virtually no time at all. (This code is completely unchanged from 2.6.34).

I have a couple of questions:

1) As far as I can see, there haven't been any changes in mm/swapfile.c 
that would cause this slowdown, so something in the block layer has 
(from my point of view) regressed. Is this a known issue?

2) Why are we calling discard_swap_cluster anyway? The swap was unused 
and we're allocating it. I could understand calling it when freeing 
swap, but when allocating?

Regards,

Nigel
