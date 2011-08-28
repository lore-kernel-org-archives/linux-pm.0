From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fixes for 3.1
Date: Sun, 28 Aug 2011 14:58:56 +0200
Message-ID: <201108281458.57057.rjw__40746.2503215813$1314538335$gmane$org@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-fixes

They include:

* Fixes related to the sh-sci driver which uses runtime PM helpers in
  such a way that they may be run with interrupts off, but it doesn't
  tell the core about that (so the core happily enables interrupts when
  they should be off), and which also causes pm_clk_suspend() and
  pm_clk_resume() to be run with interrupts off (so they shouldn't use
  a mutex).

* shi7372 LCDC suspend fix from Magnus Damm.

* OMAP suspend callbacks fix from Kevin Hilman.

* Runtime PM documentation correction.

Thanks!


 Documentation/power/runtime_pm.txt      |    3 +-
 arch/arm/mach-shmobile/board-ap4evb.c   |    1 +
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 arch/arm/mach-shmobile/clock-sh7372.c   |    2 +
 arch/arm/plat-omap/omap_device.c        |    3 +-
 drivers/base/power/clock_ops.c          |   40 +++++++++++++++++--------------
 drivers/tty/serial/sh-sci.c             |    1 +
 7 files changed, 30 insertions(+), 21 deletions(-)

---------------

Kevin Hilman (1):
      OMAP: omap_device: only override _noirq methods, not normal suspend/resume

Magnus Damm (2):
      ARM: mach-shmobile: sh7372 LCDC1 suspend fix
      ARM: mach-shmobile: sh7372 LCDC1 suspend fix V2 (incremental)

Rafael J. Wysocki (3):
      PM: Use spinlock instead of mutex in clock management functions
      sh-sci / PM: Use power.irq_safe
      PM / Runtime: Correct documentation of pm_runtime_irq_safe()
