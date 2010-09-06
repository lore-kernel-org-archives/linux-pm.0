From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: T.O.I for the boot-up time reduction
Date: Mon, 06 Sep 2010 12:59:32 +0300 (EEST)
Message-ID: <20100906.125932.52163247.Hiroshi.DOYU__8276.68264178119$1283767378$gmane$org@nokia.com>
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
To: tuxonice-devel@tuxonice.net
Cc: linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com
List-Id: linux-pm@vger.kernel.org

Hi,

I tried T.O.I for the ARM based reference platform, TI OMAP3, with the
ARM hibernation patch(*1). It works quite reliably as below:

...
[    7.282806] Post atomic.
[    7.285369] Reading caches...
[    8.328247] ...20%...40%...60%...80%
[    8.862762] Waited for i/o due to throughput_throttle 35 times.
[    8.869934] Cleaning up...
[    8.876373] Restarting all filesystems ...
[    8.919616] Restarting tasks ... Restarting tasks ... done.
[    9.096862] TuxOnIce debugging info:
[    9.096893] - TuxOnIce core  : 3.1.1.1
[    9.096893] - Compiler vers. : 4.3
[    9.096893] - Attempt number : 1
[    9.096893] - Parameters     : 0 667648 0 0 -2 0
[    9.096923] - Overall expected compression percentage: 0.
[    9.096923] - Compressor is 'lzo'.
[    9.096923]   Compressed 180785152 bytes into 56154335 (68 percent compression).
[    9.096923] - Block I/O active.
[    9.096923]   Used 13840 pages from swap on /dev/...
[    9.096923] - Max outstanding reads 752. Max writes 221.
[    9.096954]   Memory_needed: 1024 x (4096 + 200 + 72) = 4472832 bytes.
[    9.096954]   Free mem throttle point reached 0.
[    9.096954] - Swap Allocator enabled.
[    9.096954]   Swap available for image: 105984 pages.
[    9.096954] - I/O speed: Write 27 MB/s, Read 26 MB/s.
[    9.096984] - Extra pages    : 0 used/2000.
[    9.096984] - Result         : Succeeded.
...

Now it boots at ~9 [sec] and I am trying to reduce the resuming time
as much as possible, and I set the following:

(a) echo 100 > /proc/sys/vm/swappiness
(b) echo -2 > /sys/power/tuxonice/image_size_limit
(c) Apply the followin patch to call shrink_all_memory(ULONG_MAX)
--- a/kernel/power/tuxonice_prepare_image.c
+++ b/kernel/power/tuxonice_prepare_image.c
@@ -982,7 +982,7 @@ static void eat_memory(void)

	if (amount_wanted > 0 && !test_result_state(TOI_ABORTED) &&
			image_size_limit != -1) {
-               unsigned long request = amount_wanted + 50;
+               unsigned long request = ULONG_MAX;

		toi_prepare_status(CLEAR_BAR,
				"Seeking to free %ldMB of memory.",

I think that most of resuming time is spent on extracting image from
disk and I am sure that reducing the image size could make the boot-up
time/resuming time much shorter. I understand that smaller page cache
makes application less responsive, but from total user experience POV,
still shorter boot-up time may have some advantage over such
responsiveness. The ealier UI shows up the better experience. So I
would like ask experts here about the following questions:

1, Any other (T.O.I) parameters to make the image size smaller?
   Now I do "drop_pagecache()", "shrink_all_memory(ULONG_MAX)" and compression.
2, Any other (T.O.I) parameters to make I/O speed faster?
3, Does "swappiness = 100" make the resume faster?
4, Could multiple swap partitions on different storage make I/O speed
   faster?

I'm looking for any possibility to reduce the boot-up/resuming time
with T.O.I. Any comment/idea would be appreciated.

  Hiroshi DOYU

*1: http://www.spinics.net/lists/linux-omap/msg32850.html
