From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/4] OMAP: PM: omap_device: update PM domain
	support for v3.1
Date: Mon, 11 Jul 2011 16:29:25 -0700
Message-ID: <1310426969-30306-1-git-send-email-khilman__45801.6852885068$1310427033$gmane$org@ti.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

For v3.1, the PM core has some changes that impact various assumptions
made (by me) during the design and implementation of the PM domain
support in the omap_device layer.

This series is needed to update our PM domain layer to behave properly
under the new rules of the PM core code which are planned to be merged
for v3.1 (see recent linux-pm discussions for the gory details.)

This series is based on the pm-domains branch of Rafael Wysocki's
suspend-2.6 tree, and also depends on the patch which adds
pm_runtime_status_suspended() helper function[1].

Rafael, because of the dependencies on your pm-domains branch (due to
the pwr_domain -> pm_domain rename), it might be easiest to merge
these via your tree.   Let me know if that's OK with you.

I've tested this series with all of the PM core changes planned for
v3.1 (Rafael's linux-next branch[2]) and have done various
suspend/resume testing (including off-mode) with individual devices
disabled via /sys/devices/.../power/control.

Kevin

[1] https://patchwork.kernel.org/patch/966732/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git

Kevin Hilman (4):
  OMAP: PM: omap_device: conditionally use PM domain runtime helpers
  OMAP: PM: omap_device: add system PM methods for PM domain handling
  OMAP: PM: omap_device: add API to disable idle on suspend
  OMAP: PM: disable idle on suspend for GPIO and UART

 arch/arm/mach-omap2/Kconfig                   |    4 +-
 arch/arm/mach-omap2/gpio.c                    |    2 +
 arch/arm/mach-omap2/serial.c                  |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    9 +++++
 arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++++++++--
 5 files changed, 60 insertions(+), 5 deletions(-)

-- 
1.7.6
