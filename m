From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/4] PM / Domains: Fix race conditions during boot
Date: Wed,  1 Oct 2014 16:41:30 +0200
Message-ID: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes in v2:
	-Added some acks.
	-Updated commit messages.
	-Included a wider audience of the patchset. V1 was lacking SoC
	 maintainers.

Here are link to the first patchset, were some discussion started.
http://marc.info/?l=linux-pm&m=141208104729597&w=2


When there are more than one device in a PM domain these will obviously
be probed at different times. Depending on timing and the implemented
support for runtime PM in a driver/subsystem, genpd may be advised to
power off a PM domain after a successful probe sequence.

Ideally we should have relied on the driver/subsystem, through runtime
PM, to bring their device's PM domain into powered state prior doing
probing if such requirement exist.

Since this is not a common practice by drivers/subsystems, enforcing
such a change doesn't seem viable.

Instead, let's improve the situation, by preventing genpd from powering
off any of the PM domains until late_init. At that point genpd already
tries to power off unused PM domains, so it seems like a decent match.

Cases which can't be covered within the window of until late_init needs
to be adressed separately and likely through a more common long term
solution.


Ulf Hansson (4):
  PM / Domains: Remove pm_genpd_dev_need_restore() API
  ARM: exynos: Ensure PM domains are powered at initialization
  PM / Domains: Expect PM domains being powered at initialization
  PM / Domains: Enforce PM domains to stay powered during boot

 arch/arm/mach-exynos/pm_domains.c   |  7 ++++---
 arch/arm/mach-s3c64xx/pm.c          |  4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c |  2 +-
 arch/arm/mach-shmobile/pm-rmobile.c |  2 +-
 drivers/base/power/domain.c         | 42 ++++++++++++++++---------------------
 include/linux/pm_domain.h           |  7 +++----
 6 files changed, 29 insertions(+), 35 deletions(-)

-- 
1.9.1
