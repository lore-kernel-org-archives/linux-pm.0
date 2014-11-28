From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V3 0/3] PM / Domains: Add initial PM clock support to genpd
Date: Fri, 28 Nov 2014 09:30:00 +0100
Message-ID: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Changes in v3:
	-Fixed comments from Rafael for patch 1.
	-Change name of define, affects all patches.

Changes in v2:
	-Small fixes in patch 1.


It's quite common for PM domains to use PM clocks. Typically from SOC specific
code, the per device PM clock list is created and pm_clk_suspend|resume() are
invoked to handle clock gating/ungating.

A step towards consolidation is to integrate PM clock support into genpd, which
is what this patchset does.

In this initial step, the calls to the pm_clk_suspend|resume() are handled
within genpd, but the per device PM clock list still needs to be created from
SOC specific code. It seems reasonable to have gendp to handle that as well, but
that left to future patchsets to address.

It's not every users of genpd that are keen on using PM clocks thus we need
to provide this a configuration option for genpd.

In patch 2 and patch 3, we convert some of the SH-MOBILE SOCs to start using the
new PM clock support in genpd.


Ulf Hansson (3):
  PM / Domains: Initial PM clock support for genpd
  ARM: shmobile: Convert to genpd flags for PM clocks for r8a7779
  ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile

 arch/arm/mach-shmobile/pm-r8a7779.c | 3 +--
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 drivers/base/power/domain.c         | 7 +++++++
 include/linux/pm_domain.h           | 4 ++++
 4 files changed, 13 insertions(+), 4 deletions(-)

-- 
1.9.1
