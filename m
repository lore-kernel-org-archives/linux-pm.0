From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Date: Wed, 27 Mar 2019 13:21:05 +0000
Message-ID: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

This work is a workaround I'm looking into (more as a background task)
in order to add support for cpuidle on i.MX8MQ based platforms.

The main idea here is getting around the missing GIC wake_request signal
(due to integration design issue) by waking up a each individual core throu=
gh
some dedicated SW power-up bits inside the power controller (GPC) right bef=
ore
every IPI is requested for that each individual core.

This work is basically composed of four parts (in kernel):

 - the cpuidle core poking mechanism along with the related sched/irq_work =
calls
 - the cpuidle-arm ops addition in order to support poking, along with the
   'local-wakeup-poke' DT idle state knob
 - the psci and cpu_ops cpu_poke addition
 - the i.MX8MQ specific idle states in dts

There is also a change needed in TF-A which is available here:

  https://lists.trustedfirmware.org/pipermail/tf-a/2019-March/000009.html

Abel Vesa (7):
  sched: idle: Add sched get idle state helper
  cpuidle: Add cpu poke support
  smp: Poke the cores before requesting IPI
  psci: Add cpu_poke ops to support core poking
  cpuidle-arm: Add ops to support poke alonside enter
  cpuidle-arm: Add arm64 wake helper for cpu_poke op
  arm64: dts: imx8mq: Add cpu-sleep state with poke wake-up enabled

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 ++++++++++++++++++
 arch/arm64/include/asm/cpu_ops.h          |  1 +
 arch/arm64/include/asm/cpuidle.h          |  6 ++++++
 arch/arm64/kernel/cpuidle.c               |  8 ++++++++
 arch/arm64/kernel/psci.c                  |  1 +
 drivers/cpuidle/cpuidle-arm.c             | 13 +++++++++++-
 drivers/cpuidle/cpuidle.c                 | 34 +++++++++++++++++++++++++++=
++++
 drivers/cpuidle/dt_idle_states.c          | 15 +++++++++-----
 drivers/cpuidle/dt_idle_states.h          | 10 +++++++++
 drivers/firmware/psci.c                   |  6 ++++++
 include/linux/cpuidle.h                   |  7 +++++++
 include/linux/psci.h                      |  1 +
 include/uapi/linux/psci.h                 |  2 ++
 kernel/irq_work.c                         | 19 ++++++++++++++---
 kernel/sched/core.c                       | 16 ++++++++++-----
 kernel/sched/idle.c                       | 11 ++++++++++
 kernel/smp.c                              | 10 ++++++++-
 kernel/time/tick-broadcast.c              |  4 ++++
 18 files changed, 169 insertions(+), 15 deletions(-)

--=20
2.7.4
