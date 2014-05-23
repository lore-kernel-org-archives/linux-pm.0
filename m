From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 01/16] sched: Documentation for scheduler energy cost model
Date: Fri, 23 May 2014 19:16:28 +0100
Message-ID: <1400869003-27769-2-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35914 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaEWSQu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:50 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

This documentation patch provide a brief overview of the experimental
scheduler energy costing model and associated data structures.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 Documentation/scheduler/sched-energy.txt |   66 ++++++++++++++++++++++++++=
++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/scheduler/sched-energy.txt

diff --git a/Documentation/scheduler/sched-energy.txt b/Documentation/sched=
uler/sched-energy.txt
new file mode 100644
index 0000000..c6896c0
--- /dev/null
+++ b/Documentation/scheduler/sched-energy.txt
@@ -0,0 +1,66 @@
+Energy cost model for energy-aware scheduling (EXPERIMENTAL)
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The basic energy model uses platform energy data stored in sched_energy da=
ta
+structures attached to the sched_groups in the sched_domain hierarchy. The
+energy cost model offers two function that can be used to guide scheduling
+decisions:
+
+1.=09energy_diff_util(cpu, util, wakeups)=20
+2.=09energy_diff_task(cpu, task)
+
+Both return the energy cost delta caused by adding/removing utilization or=
 a
+task to/from a specific cpu.
+
+CONFIG_SCHED_ENERGY needs to be defined in Kconfig to enable the energy co=
st
+model and associated data structures.
+
+The basic algorithm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The basic idea is to determine the energy cost at each level in sched_doma=
in
+hierarchy based on utilization:
+
+=09for_each_domain(cpu, sd) {
+=09=09sg =3D sched_group_of(cpu)
+=09=09energy_before =3D curr_util(sg) * busy_power(sg)
+                =09        + 1-curr_util(sg) * idle_power(sg)
+=09=09energy_after =3D new_util(sg) * busy_power(sg)
+                =09        + 1-new_util(sg) * idle_power(sg)
+                        =09+ new_util(sg) * task_wakeups
+=09=09=09=09=09=09=09* wakeup_energy(sg)
+=09=09energy_diff +=3D energy_before - energy_after
+=09}
+
+=09return energy_diff
+
+Platform energy data
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+struct sched_energy has the following members:
+
+cap_states:
+=09List of struct capacity_state representing the supported capacity state=
s=20
+=09(P-states). struct capacity_state has two members: cap and power, which=
=20
+=09represents the compute capacity and the busy power of the state. The=20
+=09list must ordered by capacity low->high.
+
+nr_cap_states:
+=09Number of capacity states in cap_states.
+
+max_capacity:
+=09The highest capacity supported by any of the capacity states in=20
+=09cap_states.
+
+idle_power:
+=09Idle power consumption. Will be extended to support multiple C-states=
=20
+=09later.
+
+wakeup_energy:
+=09Energy cost of wakeup/power-down cycle for the sched_group which this i=
s=20
+=09attached to. Will be extended to support different costs for different=
=20
+=09C-states later.
+
+There are no unit requirements for the energy cost data. Data can be norma=
lized=20
+with any reference, however, the normalization must be consistent across a=
ll=20
+energy cost data. That is, one bogo-joule/watt must be same quantity for d=
ata,=20
+but we don't care what it is.
--=20
1.7.9.5


