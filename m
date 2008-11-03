From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] Suspend failure on NForce4-based boards due
	to chanes in stop_machine
Date: Mon, 3 Nov 2008 01:28:20 +0100
Message-ID: <200811030128.21272.rjw__47656.2670468867$1225671977$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Current mainline (.28-rc3 at the moment) fails to suspend on at least some
machines with dual-core AMD CPUs and NForce4-based mainboards.  The affected
boxes just hang solid during suspend/hibernation, after suspending devices,
probably while the non-boot CPUs are being stopped (I'm able to reproduce this
on two different machines).

Although this is not reproducible 100% of the time, it is reproducible enough
to allow me to carry out bisection, which turned up the following commit as the
source of the problem:

commit c9583e55fa2b08a230c549bd1e3c0bde6c50d9cc
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Mon Oct 13 23:50:10 2008 +0200

    stop_machine: use workqueues instead of kernel threads

    Convert stop_machine to a workqueue based approach. Instead of using kernel
    threads for stop_machine we now use a an rt workqueue to synchronize all
    cpus.
    This has the advantage that all needed per cpu threads are already created
    when stop_machine gets called. And therefore a call to stop_machine won't
    fail anymore. This is needed for s390 which needs a mechanism to synchronize
    all cpus without allocating any memory.
    As Rusty pointed out free_module() needs a non-failing stop_machine interface
    as well.

    As a side effect the stop_machine code gets simplified.

    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

With this commit reverted, suspend/hibernation works on the affected machines
without any problems.

Thanks,
Rafael
