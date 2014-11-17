From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 0/8] ARM: shmobile: R-Mobile: DT PM domain support
Date: Mon, 17 Nov 2014 14:30:36 +0100
Message-ID: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

	Hi Simon, Magnus, Rafael,

This patch series enables DT support for PM domains on Renesas R-Mobile SoCs.

Currently it's limited to R-Mobile A1 (r8a7740), but given the similarity of
the SYSC System-Controller on the various SH-Mobile/R-Mobile SoCs, and the
abstraction of PM domains in DT, it should be sufficiently generic to handle
other SoCs in the future (e.g. SH-Mobile AP4 (sh7372), SH-Mobile AG5 (sh73a0),
R-Mobile APE6 (r8a73a4)).

Functionality-wise, this behaves the same as the legacy (non-DT) version
(modulo missing DT support in some device drivers).

Dependencies:
  - This is based on Simon Horman's renesas-devel-20141117-v3.18-rc5, as
    v3.18-rc5 has commit c16561e8df7a6476 ("PM / Domains: Change prototype
    for the attach and detach callbacks").

Notes:
  - Rafael: I believe Simon needs your ack for "[1/8] PM / Domains: Add DT
    bindings for power-on/off latencies", or needs to know you will take it
    yourself?

  - I kept "[4/8] ARM: shmobile: R-Mobile: Enable module clocks if
    !CONFIG_PM_RUNTIME", as commit 9cdd5fd742e684ee ("PM / domains: Kconfig:
    always enable PM_RUNTIME when genpd enabled") is not yet upstream, and
    needs some rework (recursive Kconfig dependency PM_GENERIC_DOMAINS <->
    PM_RUNTIME).

Changes compared to v4:
  - Update for {at,de}tach_dev() taking a generic_pm_domain pointer
    again,

Changes compared to v3 (more detailed changelogs in the individual patches):
  - I dropped the patch to add preliminary PM domain latencies, as I want to do
    more measurements for PM domains that are currently never powered off.
    Values seem to range between 8.5 and 26 us, depending on the PM domain.
  - I dropped all patches related to QoS device latencies, as these need more
    discussion,
  - The power-{on,off}-latency properties have been changed from a single value
    to a list,
  - Device save/restore state latencies have been dropped, as they're Linux
    driver-specific, and thus don't belong in DT,
  - Use proper pm_clk_create()/pm_clk_destroy(), and update for attach_dev()
    returning an error code again,
  - New patch to enable module clocks if !CONFIG_PM_RUNTIME,
  - Always keep D4 powered, until the new Coresight code handles runtime
    PM,
  - Remove bogus power-domains properties from clock nodes, as these will not
    be instantiated as platform devices,
  - Add power-domains properties to the recently added TMU nodes,
  - Added Acked-by, Reviewed-by.

Changes compared to v2 (more detailed changelogs in the individual patches):
  - Minor changes to attach/detach callbacks,
  - Really add the A4MP and D4 PM domains, as fixes are available (see
    dependencies below),
  - Scan DT topology to identify special PM domains (CPUs and console),
  - Move PM domain power-on/off latencies to a separate patch.

Changes compared to v1 (more detailed changelogs in the individual patches):
  - Several new patches: PM QoS device latencies in DT, attach/detach
    callbacks,
  - Run-Time management of the module clocks, making the hack in
    drivers/sh/pm_runtime.c obsolete for DT platforms using genpd,
  - Addition of PM QoS device latencies, specified from DT,
  - Addition of build glue, so this builds and runs without additional
    changes, incl. s2ram.

Please apply, thanks!

Geert Uytterhoeven (8):
  PM / Domains: Add DT bindings for power-on/off latencies
  PM / Domains: Add DT bindings for the R-Mobile System Controller
  ARM: shmobile: R-Mobile: Use generic_pm_domain.attach_dev() for pm_clk
    setup
  ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME
  ARM: shmobile: R-Mobile: Store SYSC base address in rmobile_pm_domain
  ARM: shmobile: R-Mobile: Add DT support for PM domains
  ARM: shmobile: r8a7740 dtsi: Add PM domain support
  drivers: sh: Disable PM runtime for multi-platform r8a7740 with genpd

 .../devicetree/bindings/power/power_domain.txt     |  14 +-
 .../bindings/power/renesas,sysc-rmobile.txt        | 107 ++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |  99 +++++++
 arch/arm/mach-shmobile/Kconfig                     |   3 +-
 arch/arm/mach-shmobile/pm-r8a7740.c                |  14 +
 arch/arm/mach-shmobile/pm-rmobile.c                | 286 +++++++++++++++++++--
 arch/arm/mach-shmobile/pm-rmobile.h                |   3 +-
 arch/arm/mach-shmobile/pm-sh7372.c                 |  11 +
 drivers/sh/pm_runtime.c                            |   2 +
 9 files changed, 520 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
