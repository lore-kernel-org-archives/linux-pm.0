From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/04] PM: SuperH Runtime PM prototype V2
Date: Fri, 31 Jul 2009 23:01:58 +0900
Message-ID: <20090731140158.11351.26021.sendpatchset__32425.6293163218$1249049248$gmane$org@rx1.opensource.se>
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

PM: SuperH Runtime PM prototype V2

[PATCH 01/04] sh: SuperH platform bus code for Runtime PM v11
[PATCH 02/04] i2c: Runtime PM changes for SuperH I2C driver 
[PATCH 03/04] uio: Runtime PM changes for UIO driver
[PATCH 04/04] video: Runtime PM hack for SuperH LCDC driver

This series is the Runtime PM prototype for SuperH V2. Included
is a architecture specific Runtime PM implementation prototype
for the platform bus together with a few driver changes.

The patches are meant to be applied on top of the following: 
"PM: Introduce core framework for run-time PM of I/O devices (rev. 11)"
"PM: Runtime PM v11 - add dev_pm_ops helpers"
"PM: Runtime PM v11 - let bus-less devices succeed"
"PM: Runtime PM v11 - add debug printouts"
"PM: Runtime PM v11 - CONFIG_PM_SLEEP=n support"
"Driver Core: Runtime PM callbacks for the Platform Bus V2"

For the SuperH side of things you also need latest sh-2.6 git and:
"Driver Core: Add platform device arch data V3"
"sh: Runtime PM pdev hwblk changes"

Patch 01 + 04 need more attention
Patch 02 + 03 should be all that is needed for Runtime PM driver support.

Rafael, please have a look at the Runtime PM v11 issue in patch 04.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h             |    8 
 arch/sh/include/asm/hwblk.h              |    4 
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |  244 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c       |   39 ++++
 drivers/uio/uio_pdrv_genirq.c            |   54 ++++++
 drivers/video/sh_mobile_lcdcfb.c         |   47 +++--
 7 files changed, 376 insertions(+), 21 deletions(-)
