From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Mon, 13 Oct 2014 16:02:01 +0200
Message-ID: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes in v3:
	-Rework the entire intermediate step which was suggested in v2.
	 That means solving the race condition, but also cope with PM domains
	 that are initialized in powered off state.

Changes in v2:
	-Added some acks.
	-Updated commit messages.
	-Included a wider audience of the patchset. V1 was lacking SoC
	 maintainers.

Here are link to the first patchset, were some discussion started.
http://marc.info/?l=linux-pm&m=141208104729597&w=2

There may be more than one device in a PM domain which then will be
probed at different points in time.

Depending on timing and runtime PM support, in for the device related
driver/subsystem, a PM domain may be advised to power off after a
successful probe sequence.

A general requirement for a device within a PM domain, is that the
PM domain must stay powered during the probe sequence. To cope with
such requirement, let's add two new APIs, dev_pm_domain_get|put().

These APIs are intended to be invoked from subsystem-level code and the
calls between get/put needs to be balanced.

dev_pm_domain_get(), tells the PM domain that it needs to increase a
usage count and to keep supplying power. dev_pm_domain_put(), does the
opposite.


Ulf Hansson (9):
  PM / Domains: Add dev_pm_domain_get|put() APIs
  PM / Domains: Enable genpd to support ->get|put() callbacks
  amba: Keep PM domain powered during ->probe()
  drivercore / platform: Keep PM domain powered during ->probe()
  i2c: core: Keep PM domain powered during ->probe()
  spi: core: Keep PM domain powered during ->probe()
  mmc: core: Attach PM domain prior probing of SDIO func driver
  mmmc: core: Keep PM domain powered during ->probe() of SDIO func
    driver
  PM / Domains: Remove pm_genpd_dev_need_restore() API

 drivers/amba/bus.c          |  8 ++++++++
 drivers/base/platform.c     |  7 +++++++
 drivers/base/power/common.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c | 46 ++++++++++++++++++++++++---------------------
 drivers/i2c/i2c-core.c      |  7 +++++++
 drivers/mmc/core/sdio_bus.c | 21 +++++++++++++++++----
 drivers/spi/spi.c           |  7 +++++++
 include/linux/pm.h          |  2 ++
 include/linux/pm_domain.h   |  7 +++++--
 9 files changed, 118 insertions(+), 27 deletions(-)

-- 
1.9.1
