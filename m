From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 0/7] Exynos IOMMU: proper runtime PM support (use device
	dependencies)
Date: Tue, 08 Nov 2016 14:29:17 +0100
Message-ID: <1478611764-6473-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161108133014eucas1p2a5dd3306a464ee840e26532f6c405b66@eucas1p2.samsung.com>
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
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

This is another update of the patchset for adding proper runtime PM
support to Exynos IOMMU driver. This has been achieved by using recently
introduced device links, which lets SYSMMU controller's runtime PM to
follow master's device runtime PM state (the device which actually
performs DMA transaction). The main idea behind this solution is an
observation that any DMA activity from master device can be done only
when master device is active, thus when master device is suspended
SYSMMU controller device can also be suspended.

This patchset solves the problem of all power domains being always
enabled. It happened, because all SYSMMU controllers (which belongs to
the same domains) are permanently kept active, because existing driver
was simplified and kept SYSMMU device active all the time after
initialization and attaching to the master device.

This patchset is based on sixth version of Rafael's "Functional dependencies
between devices" patchset [1], which has been merged to Greg's driver-core-next
branch [2] (last patch commit id is baa8809f60971d10220dfe79248f54b2b265f003).
As Greg pointed, the branch will not be rebased and can be used as a base
for applying my patchset [3].

Joerg: I hope you can merge this version on top of Greg's driver-core-next
branch to iommu tree.

[1] https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1261311.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-next
[3] https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1264906.html

If one wants to test this patchset, I've provided a branch with all needed
patches (a small fix for Exynos4 FIMC-IS DTS is still needed, it is already
in samsung tree):
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.9-iommu-pm-v6

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v6:
- removed LATE_SYSTEM_SLEEP_PM_OPS-based workaround, because it is no longer
  needed after introducing device links (they also take care of proper system
  sleep suspend/resume sequence)
- updated some comments

v5: https://lkml.org/lkml/2016/10/20/70
- split main patch into several small changes for easier review (requested
  by Luis Rodriquez)
- fixed usage of runtime_pm_active, now it is guarded by pm_runtime_get_noresume()
  and pm_runtime_put() pair

v4: http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1241601.html
- rebased on top of v4 of device dependencies/links patchset, what resolved
  system hang on reboot

v3: http://www.spinics.net/lists/linux-samsung-soc/msg55256.html
- rebased on top of latest device dependencies/links patchset
- added proper locking between runtime pm, iommu_attach/detach and sysmmu
  enable/disable(added per iommu owner device's rpm lock)

v2: http://www.spinics.net/lists/arm-kernel/msg512082.html
- replaced PM notifiers with generic device dependencies/links developed
  by Rafael J. Wysocki

v1: http://www.spinics.net/lists/arm-kernel/msg509600.html
- initial version


Patch summary:

Marek Szyprowski (7):
  iommu/exynos: Remove excessive, useless debug
  iommu/exynos: Remove dead code
  iommu/exynos: Simplify internal enable/disable functions
  iommu/exynos: Set master device once on boot
  iommu/exynos: Rework and fix internal locking
  iommu/exynos: Add runtime pm support
  iommu/exynos: Use device dependency links to control runtime pm

 drivers/iommu/exynos-iommu.c | 230 ++++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 135 deletions(-)

-- 
1.9.1
