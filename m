From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] [media] exynos-gsc: Fixup PM support
Date: Tue, 14 Oct 2014 09:15:33 +0200
Message-ID: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-media@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patchset fixup the PM support and adds some minor improvements to
potentially save some more power at runtime PM suspend.

Some background to this patchset, which are related to the generic PM domain:
http://marc.info/?l=linux-pm&m=141217452218592&w=2
http://marc.info/?t=141217462200011&r=1&w=2

The conserns from the above discussions are intended to be solved by a reworked
approach for the generic PM domain, link below.
http://marc.info/?l=linux-pm&m=141320895122707&w=2

Ulf Hansson (7):
  [media] exynos-gsc: Simplify clock management
  [media] exynos-gsc: Convert gsc_m2m_resume() from int to void
  [media] exynos-gsc: Make driver functional without CONFIG_PM_RUNTIME
  [media] exynos-gsc: Make runtime PM callbacks available for CONFIG_PM
  [media] exynos-gsc: Fixup system PM
  [media] exynos-gsc: Fixup clock management at ->remove()
  [media] exynos-gsc: Do full clock gating at runtime PM suspend

 drivers/media/platform/exynos-gsc/gsc-core.c | 127 ++++++++-------------------
 drivers/media/platform/exynos-gsc/gsc-core.h |   3 -
 2 files changed, 36 insertions(+), 94 deletions(-)

-- 
1.9.1
