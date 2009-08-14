From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/05] PM: Runtime PM v16 for SuperH Mobile V3
Date: Fri, 14 Aug 2009 19:48:08 +0900
Message-ID: <20090814104808.32396.50021.sendpatchset__43108.1997849562$1250247220$gmane$org@rx1.opensource.se>
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

PM: Runtime PM v16 for SuperH Mobile V3

[PATCH 01/05] sh: Runtime PM for SuperH Mobile platform bus devices
[PATCH 02/05] i2c: Runtime PM for SuperH Mobile I2C
[PATCH 03/05] video: Runtime PM for SuperH Mobile LCDC
[PATCH 04/05] v4l2: Runtime PM for SuperH Mobile CEU
[PATCH 05/05] uio: Runtime PM for UIO devices

This is the SuperH Mobile platform bus Runtime PM implementation V3.
Included is a SuperH Mobile specific Runtime PM implementation and
some driver changes. The code has been tested with "Software Standby"
mode on sh7722 and a multimedia playback workload exercising drivers
for fbdev, uio, v4l2 and i2c.

Apply on top of Rafael's linux-next patches and
"PM: Introduce core framework for run-time PM of I/O devices (rev. 16)"
"PM: Runtime PM v15 - Platform Device Bus Support"

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h               |    9 
 arch/sh/include/asm/hwblk.h                |    4 
 arch/sh/kernel/cpu/shmobile/Makefile       |    1 
 arch/sh/kernel/cpu/shmobile/pm_runtime.c   |  304 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c         |   39 +++
 drivers/media/video/sh_mobile_ceu_camera.c |   41 ++-
 drivers/uio/uio_pdrv_genirq.c              |   54 ++++
 drivers/video/sh_mobile_lcdcfb.c           |  154 ++++++++++----
 8 files changed, 542 insertions(+), 64 deletions(-)
