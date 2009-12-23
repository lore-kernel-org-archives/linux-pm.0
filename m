From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression,
	2.6.32->33-rc1] Commit 9f15226e755 breaks resume on Toshiba Portege
	R500
Date: Wed, 23 Dec 2009 01:58:42 +0100
Message-ID: <200912230158.42161.rjw__28054.1022694253$1261529976$gmane$org@sisk.pl>
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
To: Andreas Herrmann <andreas.herrmann3@amd.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Andreas,

Unfortunately your commit 9f15226e75583547aaf542c6be4bdac1060dd425
(x86, ucode-amd: Ensure ucode update on suspend/resume after CPU off/online
cycle) breaks resume from suspend to RAM on my Toshiba Portege R500 (an attempt
to resume causes a hard hang with 100% CPU load, reproducible 100% of the
time).  This has been found by bisection and confirmed by reverting this commit
on top of 2.6.33-rc1.

Strangely enough, the box doesn't even have an AMD CPU, there's an Intel Core2
Duo in it, so I suspect some missing check somewhere.

If I have the time, I'll look deeper into this tomorrow.

[BTW, I can't recall seeing this patch before.  That very well may be my fault,
but please make sure that CCs of suspend-related patches are sent to me in
future.]

Rafael
