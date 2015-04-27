From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 0/7] PM / Domains: DT power-on/off and QoS device latencies
Date: Mon, 27 Apr 2015 14:43:35 +0200
Message-ID: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

	Hi all,

This patch series is an RFC to add (1) PM Domain power-on/off latencies
and (2) QoS device latencies to DT.

To provide a good quality of service, the PM subsystem suspends PM
Domains and devices only if this doesn't break QoS constraints.  While
the PM subsystem performs measurements of the various latencies
involved, and adapts automatically according to these measurements, it's
still beneficial to provide initial values for these latencies.
Currently these initial values, which are properties of the hardware,
can only be specified from C code. This RFC adds DT support for
specifying them.

All of these patches have been sent before (change logs are available in
the individual patches). I'm resending them upon request from Kevin
Hilman, and synced them all to the same version number (v6).

  - Patch 1 adds DT bindings for PM Domain power-on/off latencies,
  - Patches 2 and 3 update the DT bindings and support code for the
    Renesas R-Mobile system controller, providing a sample
    implementation,
  - Patch 4 adds DT bindings for QoS device latencies,
  - Patches 5 and 6 implement retrieving the QoS device latencies in the
    genpd code,
  - Patch 7 updates the DT bindings for the Renesas R-Mobile system
    controller, adding an example.

Compared to previous submissions, I've left out the (preliminary)
patches adding the actual latency values to the .dtsi files, as they
just used a single default value taken from the legacy code[*].

In the mean time, support for PM Domains with multiple states has been
proposed, cfr. "[RFC v5 0/8]  genpd multiple states v5"
(http://marc.info/?l=linux-pm&m=142989694214237&w=2).
If this is accepted, I think we have to rethink how to specify PM Domain
latencies (and be happy we didn't have the DT part cast in stone yet
;-), as they won't be limited to power-on/off latencies anymore.

Perhaps we should switch to a mechanism similar to what's used for idle
states (cfr. Documentation/devicetree/bindings/arm/idle-states.txt)?
I.e. a single "idle-states" node, with subnodes for each state, being
pointed to by phandles in the actual PM domain provider nodes.

What do you think?  Thanks for your comments!

Geert Uytterhoeven (7):
  [RFC] PM / Domains: Add DT bindings for power-on/off latencies
  [RFC] PM / Domains: R-Mobile SYSC: Add PM domain power-on/off
    latencies
  [RFC] ARM: shmobile: R-Mobile: Add support for PM domain power-on/off
    latencies
  [RFC] PM / Domains: Add DT bindings for PM QoS device latencies
  [RFC] PM / Domains: Add helper variable np = dev->of_node
  [RFC] PM / Domains: Retrieve PM QoS device latencies from DT
  [RFC] PM / Domains: R-Mobile SYSC: Add PM QoS device latencies

 .../devicetree/bindings/power/power_domain.txt     | 18 ++++++++++++++++--
 .../bindings/power/renesas,sysc-rmobile.txt        | 13 ++++++++++++-
 arch/arm/mach-shmobile/pm-rmobile.c                |  5 +++++
 drivers/base/power/domain.c                        | 22 +++++++++++++++-------
 4 files changed, 48 insertions(+), 10 deletions(-)

[*] I did perform some real latency measurements a while ago, which was
    complicated by two things:
      1. The ktime_get() based timing were not sufficiently accurate, so
	 I hacked up measurement code using the ARM cycle timer,
      2. The latency values fluctuate a lot, and are impacted by other
	 system activity.
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
