From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 0/2] Exynos IOMMU: proper runtime PM support (use device
	dependencies)
Date: Thu, 29 Sep 2016 10:12:29 +0200
Message-ID: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20160929081238eucas1p1a064e5371ce549f860d6cff4bd43b557@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

This patch series finally implements proper runtime PM support in Exynos
IOMMU driver. This has been achieved by using recently introduce device
links, which lets SYSMMU controller's runtime PM to follow master's device
runtime PM state (the device which actually performs DMA transaction).
The main idea behind this solution is an observation that any DMA activity
from master device can be done only when master device is active, thus when
master device is suspended SYSMMU controller device can also be suspended.

This patchset solves the situation that power domains are always enabled,
because all SYSMMU controllers (which belongs to those domains) are
permanently active (because existing driver was simplified and kept
SYSMMU device active all the time after initialization).

Patch requires fourth version of Rafeal's "Functional dependencies
between devices" patchset, which is available here:
https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1241473.html

If one wants to test this patchset, I've provided a branch with all needed
patches (some fixes for Exynos4 FIMC-IS driver are needed):
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.8-iommu-pm-v4

Patches are based on vanilla v4.8-rc8 kernel with Rafael's device
dependencies v4 patchset applied.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v4:
- rebased on top of v4 of device dependencies/links patchset, what resolved
  system hang on reboot

v3: http://www.spinics.net/lists/linux-samsung-soc/msg55256.html
- rebased on top of latest device dependencies/links patchset
- added proper locking between runtime pm, iommu_attach/detach and sysmmu
  enable/disable(added per iommu owner device's rpm lock)

v2: http://www.spinics.net/lists/arm-kernel/msg512082.html
- replaced PM notifiers with generic device dependencies/links developped
  by Rafael J. Wysocki

v1: http://www.spinics.net/lists/arm-kernel/msg509600.html
- initial version


Patch summary:

Marek Szyprowski (2):
  iommu/exynos: Remove excessive, useless debug
  iommu/exynos: Add proper runtime pm support

 drivers/iommu/exynos-iommu.c | 228 ++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 134 deletions(-)

-- 
1.9.1
