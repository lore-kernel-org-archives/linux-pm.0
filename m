From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/06][RFC] sh: Runtime PM Prototype for SuperH
	Mobile
Date: Fri, 10 Jul 2009 00:19:26 +0900
Message-ID: <20090709151926.8385.92800.sendpatchset__9403.85724320567$1247153067$gmane$org@rx1.opensource.se>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

sh: Runtime PM Prototype for SuperH Mobile

[PATCH 01/06] Driver Core: Runtime PM callbacks for the Platform Bus
[PATCH 02/06] sh: Add support for multiple hwblk counters
[PATCH 03/06] sh: Runtime PM for SuperH Mobile
[PATCH 04/06] sh: Runtime PM for sh7722 and Migo-R
[PATCH 05/06] i2c: Runtime PM for i2c-sh_mobile.c
[PATCH 06/06] video: Runtime PM for sh_mobile_lcdcfb.c

This is the first complete Runtime PM prototype for SuperH Mobile.
The patches above should be applied on top of the sh-2.6 git tree
and the following ones:
"PM: Introduce core framework for run-time PM of I/O devices (rev. 9)"
"Driver Core: Add platform device arch data V3"

Looking forward to hear what you think. Before, during or after the
PM Summit!

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c        |    9 +
 arch/sh/include/asm/device.h             |   16 ++
 arch/sh/include/asm/hwblk.h              |   17 ++
 arch/sh/kernel/cpu/hwblk.c               |   69 ++++++----
 arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c   |   14 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c   |   31 ++++
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |  206 ++++++++++++++++++++++++++++++
 drivers/base/platform.c                  |   31 ++++
 drivers/i2c/busses/i2c-sh_mobile.c       |   21 +++
 drivers/video/sh_mobile_lcdcfb.c         |   31 +---
 11 files changed, 398 insertions(+), 48 deletions(-)
