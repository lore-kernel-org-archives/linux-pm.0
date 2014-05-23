From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 02/16] sched: Introduce CONFIG_SCHED_ENERGY
Date: Fri, 23 May 2014 19:16:29 +0100
Message-ID: <1400869003-27769-3-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

The Energy-aware scheduler implementation is guarded by
CONFIG_SCHED_ENERGY.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb..bfc3a85 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1926,6 +1926,11 @@ config XEN
 =09help
 =09  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
=20
+config SCHED_ENERGY
+=09bool "Energy-aware scheduling (EXPERIMENTAL)"
+=09help
+=09  Highly experimental energy aware task scheduling.
+
 endmenu
=20
 menu "Boot options"
--=20
1.7.9.5
