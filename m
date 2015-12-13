From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] cpuidle: avoid module usage in non-modular code
Date: Sun, 13 Dec 2015 18:57:09 -0500
Message-ID: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series of commits is a part of a larger project to ensure
people don't reference modular support functions in non-modular
code.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, ... and we continue to work on other areas.

There are several reasons to not use module support for code that
can never be built as a module, but the big ones are:

 (1) it is easy to accidentally code up unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
      modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else.

Fortunately for cpuidle, the changes are largely trivial and change
zero runtime.  All the changes here just remap the modular functions
onto the non-modular ones that they would be remapped onto anyway.

Changes are against linux-next and compile tested on ARM allmodconfig.
I've Cc'd ARM list because all of these are used on ARM, but I'm
thinking these probably can go in via the PM tree.

Paul.
---

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org

Paul Gortmaker (3):
  drivers/cpuidle: make cpuidle-clps711x.c explicitly non-modular
  drivers/cpuidle: make cpuidle-ux500.c explicitly non-modular
  drivers/cpuidle: make cpuidle-exynos.c explicitly non-modular

 drivers/cpuidle/cpuidle-clps711x.c | 8 ++------
 drivers/cpuidle/cpuidle-exynos.c   | 5 ++---
 drivers/cpuidle/cpuidle-ux500.c    | 5 ++---
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.6.1
