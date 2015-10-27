From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 0/7] Managing cluser-level idle-states with generic power domains
Date: Tue, 27 Oct 2015 18:40:49 +0100
Message-ID: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
References: <20151019205825.GA82426@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019205825.GA82426@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Lina,

this is the rebased version of my patches to handle cluster sleep with genpd.
I rebased over your current patches in the linaro git, and Axels v10, and
finally linux-next.

The arm64/Juno stuff is mainly for testing, it may not be 100% up-to-date with
the CPU-pd discussion outcomes, and I've left the patch for dynamic states
registration by devices in this series for now (will do things differently
using the CPU devices as suggested by Kevin).

Changes in v3 (based on comments from you and Kevin)
 - removed the "power-states" binding. Instead, look for a ppty called
   cpu-idle-states in each PD node. this is a list of idle-states that will be
   mapped as domain states.
 - quit referring to c-states, but refer to idle-states instead.


Jon Medhurst (1):
  arm64: dts: Add idle-states for Juno

Marc Titinger (6):
  PM / Domains: prepare for devices that might register a power state
  PM / Domains: support idle-states as genpd multiple-state.
  arm64: Juno: declare generic power domains for both clusters.
  drivers: cpu-pd: allow calling of_cpu_pd_init from platform code.
  arm64: PM /Domains: Initialize CPU-domains from DT.
  arm64: Juno: declare idle-state cluster-sleep-0 as genpd state

 .../devicetree/bindings/power/power_domain.txt     |  29 +++
 arch/arm64/boot/dts/arm/juno.dts                   |  50 ++++
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/cpu_domain.c                     |  19 ++
 drivers/base/power/cpu-pd.c                        |  31 +--
 drivers/base/power/domain.c                        | 278 ++++++++++++++-------
 include/linux/cpu-pd.h                             |   2 +
 include/linux/pm_domain.h                          |  13 +-
 8 files changed, 308 insertions(+), 115 deletions(-)
 create mode 100644 arch/arm64/kernel/cpu_domain.c

-- 
1.9.1
