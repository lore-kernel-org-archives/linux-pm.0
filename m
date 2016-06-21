From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/5] PM / devfreq: remove modular references from non-modules
Date: Tue, 21 Jun 2016 01:14:56 -0400
Message-ID: <20160621051501.18396-1-paul.gortmaker@windriver.com>
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

We have already merged over 100 of these for mainline to date, so there
is really nothing new to see here, in terms of the type of change.

That said, devfreq changes seen here cover the following categories:

  -just replacement of modular macros with their non-modular
   equivalents that CPP would have inserted anyway

  -the removal of including module.h ; replaced with init.h
   and/or export.h as required based on whether the file used it.

  -the removal of any/all unused/orphaned __exit functions that
   would never be called.

  -the removal of any ".remove" functions that were hooked into
   the driver struct.   This ".remove" function would of
   course not be called from the __exit function since that was
   never run.  However in theory, someone could have triggered it
   via sysfs unbind, even though there isn't a sensible use case
   for doing so.  So to cover that possibility, we've also disabled
   sysfs unbind in the driver.

There are no initcall level changes here; everything stays at the level
of initcall it was previously - either by not using modular versions to
begin with, or by using the builtin level equivalents.

Build tested for arm and arm64 allmodconfig (for which all the drivers
touched here get coverage) on the linux-next tree from today to ensure
no silly typos crept in.

If there is a desire for any of these to be modular, we can definitely
consider that, but by default the changes here keep the code consistent
with existing behaviour.  Thus I do not expand functionality into the
modular realm that I can't run time test, or even know if the modular
instance has a sensible modular use case.

Paul.
---

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
  PM / devfreq: make exynos-bus explicitly non-modular
  PM / devfreq: make event/exynos-nocp explicitly non-modular
  PM / devfreq: make event/exynos-ppmu explicitly non-modular

 drivers/devfreq/devfreq-event.c     | 12 +-----------
 drivers/devfreq/devfreq.c           | 13 +------------
 drivers/devfreq/event/exynos-nocp.c | 19 +++----------------
 drivers/devfreq/event/exynos-ppmu.c |  8 ++------
 drivers/devfreq/exynos-bus.c        |  9 ++-------
 5 files changed, 9 insertions(+), 52 deletions(-)

-- 
2.8.4
