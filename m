From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Fri, 05 Sep 2014 15:51:23 +0200
Message-ID: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds support for AFTR idle mode on boards with
secure firmware enabled and allows EXYNOS cpuidle driver usage on
Exynos4x12 SoCs.

It has been tested on Trats2 board (using Exynos4412 SoC with secure
firmware enabled) on which AFTR mode reduces power consumption by ~12%
when EXYNOS cpuidle driver is enabled (in both cases the default
exynos_defconfig config is used and CPU1-3 are offlined).

Currently Exynos4412 SoC support is limited to Trats2 board.

Depends on:
- next-20140904 branch of linux-next kernel tree
- "irqchip: Properly fetch the per cpu offset" patch
  (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg716674.html)
- [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
  (https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg35921.html)

Changes since v5:
- rebased on top of next-20140904 +
  "irqchip: Properly fetch the per cpu offset" patch
  (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg716674.html)
  [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
  (https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg35921.html)
- limit Exynos4412 SoC support to Trats2 board for now

Changes since v4:
- rebased on top of next-20140804 +
  [PATCH v5][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg35262.html)
  [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34282.html)
- call exynos_save_cp15() only on A9 type core (this is needed for the future
  Exynos3250 SoC support)

Changes since v3:
- rebased on top of next-20140804 +
  [PATCH v4][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg35192.html)
  [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34282.html)
- (re-)added patch fixing S5P_CENTRAL_SEQ_OPTION register setup

Changes since v2:
- rebased on top of next-20140708 +
  [PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg32809.html)
  [with rejects fixed]
  [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on Exynos4210 and 5250
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg32808.html)
  [PATCH 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg32991.html)
  [with rejects fixed in patch #2]
- addressed review comments from Tomasz Figa and Daniel Lezcano

Changes since v1:
- synced against next-20140602
- added missing Acked-by-s

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
  ARM: EXYNOS: add AFTR mode support to firmware do_idle method
  ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
  ARM: EXYNOS: PM: fix register setup for AFTR mode code
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs

 arch/arm/include/asm/firmware.h |  2 +-
 arch/arm/mach-exynos/common.h   |  5 ++++
 arch/arm/mach-exynos/exynos.c   |  5 +++-
 arch/arm/mach-exynos/firmware.c | 34 ++++++++++++++++-------
 arch/arm/mach-exynos/pm.c       | 60 ++++++++++++++++++++++++-----------------
 5 files changed, 71 insertions(+), 35 deletions(-)

-- 
1.8.2.3
