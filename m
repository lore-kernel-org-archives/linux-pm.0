From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2 0/5] PM / devfreq: make module code usage consistent.
Date: Sat, 25 Jun 2016 14:43:46 -0400
Message-ID: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For anyone new to the underlying goal of this cleanup, we are trying to
not use module support for code that can never be built as a module since:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

We have already merged lots of these for mainline to date, so there
is really nothing new to see here, in terms of the type of change.

That said, devfreq changes seen here cover the following categories:

  -just replacement of modular macros with their non-modular
   equivalents that CPP would have inserted anyway

  -the removal of including module.h ; replaced with init.h
   and export.h as required based on whether the file used it.

  -the removal of the unused __exit functions that would never
   be called.

  -the conversion of 3 bool Kconfig to tristate to reflect the
   module author's intended or re-evaluated choice. (new in v2).

There are no initcall level changes here; everything stays at the level
of initcall it was previously; simply by the fact that it was not
using modular versions to begin with.

Build tested for arm and arm64 allmodconfig (for which all the drivers
touched here get coverage) on the linux-next tree from Fri. to ensure
no silly typos crept in.

The three drivers converted from bool to trisate are done as per
Chanwoo's request.  I have confirmed they build and modpost to a
.ko file but I don't have the hardware to test module loading
and/or any other runtime behaviour.

Paul.
---

[v2: convert patch #3,4,5 from demodule cleanup to one line conversion
     from bool to tristate; confirm =m after "allmodconfig"; retest.]

[v1: https://lkml.kernel.org/r/20160621051501.18396-1-paul.gortmaker@windriver.com ]

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org

Paul Gortmaker (5):
  PM / devfreq: make devfreq explicitly non-modular
  PM / devfreq: make devfreq-event explicitly non-modular
  PM / devfreq: make exynos-bus ARM_EXYNOS_BUS_DEVFREQ tristate
  PM / devfreq: make event/exynos-nocp DEVFREQ_EVENT_EXYNOS_NOCP
    tristate
  PM / devfreq: make event/exynos-ppmu DEVFREQ_EVENT_EXYNOS_PPMU
    tristate

 drivers/devfreq/Kconfig         |  2 +-
 drivers/devfreq/devfreq-event.c | 12 +-----------
 drivers/devfreq/devfreq.c       | 13 +------------
 drivers/devfreq/event/Kconfig   |  4 ++--
 4 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.8.4
