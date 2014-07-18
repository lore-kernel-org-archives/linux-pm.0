From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 0/2] Convert exynos PPMU driver to be built as module
Date: Fri, 18 Jul 2014 15:09:52 +0100
Message-ID: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: orjan.eide@arm.com, Punit Agrawal <punit.agrawal@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

There's no reason why the exynos PPMU can't be built as a module
except you need -

- The first patch exports the functions that are needed to build
devfreq drivers as modules.

- The second patch then converts the exynos PPMU devfreq driver to be
  built as a module.

Compile tested only.

Thanks

Punit Agrawal (1):
  PM / devfreq: exynos: Enable building exynos PPMU as module

=C3=98rjan Eide (1):
  PM / devfreq: Export helper functions for drivers

 drivers/devfreq/Kconfig              |    2 +-
 drivers/devfreq/devfreq.c            |    3 +++
 drivers/devfreq/exynos/exynos_ppmu.c |    3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

--=20
1.7.10.4
