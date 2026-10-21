Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.226.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552696;
	b=sEncPAxYr9IxLOxkYerfLsaAbI9MKP44vQQBeWnDYRvl6g8SqvDmXRQrtDQtOnHCsnHx
	 oiG0WMf4f0rTc4FQiukxbuPuPj1V7yCF2/Pc1wbKErIgc91jK4hLue6vEbnkyZpXIe+Ex
	 wgBehRzUXFHzr5KpN31uwwToABJupSCeg72+kiM8+LlWBtSiujhBpgJ56b+ysa6ae0ZyH
	 Ylxv9HqQSzc5f4jrzYJ4luuFAzDqVaFNjKt8LqTjagAVBuPonzewP/vRaUD+hcwe1BzEW
	 NHGHmNRbe11UUNI2+bHUPG4fBaVPUIG4JCG76n4YtQd2bvqqMIJwVR5oZAmL/n8Z0Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552696;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=E6SRRIHdR3MeVbzYonVYeC0jQ3Pln5amYMSI+TSF0oA=;
	b=3bALQYqe0dCbyPjPKF/ukVL5wja7WuFBQ5Oc868xNZaBfKj3V7uTa3TFYF9c1hx4NS99
	 UputDDvzrnNizTygwd2Zdp0zQo3vP9y4M2V+R+7HeC5W9yG2nhqMyUO/p5+EhPDbmMSaI
	 jDVpsF+9czShv0lzeetoXsrJw88lIIuMBP0patl6bW17AF4yopPCfRu6/rQ9n2jE0ph4k
	 Pz6ja8Zi2Dsg2cLyVsd0NLgavPIo5OKrdI5qx8wmuvfZiTbud0I0LTNrkz/wabFNWLazU
	 52O8WqbWGDrNH/XzYIBxIU37MAuTdrfbvLJOwKIlrJwOhH5rwXuDcpBVDElwrCUhncg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xiaomi.com;
	spf=pass smtp.mailfrom=xiaomi.com;
	arc=none smtp.remote-ip=207.226.244.123
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE412607B108;
	Wed, 21 Oct 2026 03:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE412607B108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: GaW/xH2SQkKAlUYhY3iXfg==
X-CSE-MsgGUID: FP2NoZ6qRMS2c2VW3EmU4A==
X-IronPort-AV: E=Sophos;i="6.27,169,1786982400"; 
   d="scan'208";a="192574023"
From: Kaiqian Zhu <zhukaiqian@xiaomi.com>
To: <ulfh@kernel.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kaiqian Zhu <zhukaiqian@xiaomi.com>
Subject: [PATCH] cpuidle: psci: Fix CPU PM domain state after failed runtime PM resume
Date: Wed, 21 Oct 2026 11:17:08 +0800
Message-ID: <20261021031709.42644-1-zhukaiqian@xiaomi.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX07.mioffice.cn (10.237.8.127) To YZ-MBX03.mioffice.cn
 (10.237.88.123)

In PSCI OSI mode with the hierarchical CPU topology, a CPU can come
out of idle after dpm_suspend_late() has already disabled runtime PM
for its device. The idle exit then restores the cluster PM domain through
the runtime PM path, however, since the runtime PM is disabled, it
becomes a no-op and the domain stays powered off in software while
the CPU is running. The CPU then silently stops requesting the cluster/
system power level in CPU_SUSPEND.

The Race:
dpm_suspend_late() wakes all idle CPUs first and only then walks the
device list, disabling runtime PM per device as it goes:

  dpm_suspend_late()
    wake_up_all_idle_cpus()               <-- asynchronous cpu wakeup
      device_suspend_late(dev, ...)
        __pm_runtime_disable(dev,false)    <-- disable_depth++

wake_up_all_idle_cpus() only requests that the idle CPUs leave idle; it
does not wait for them. A CPU parked in a deep PSCI state can take a long
time to come back that its idle exit lands after the runtime disable:

  CPU0: dpm_suspend_late()             CPUx: parked in idle
  ------------------------------       ----------------------------
  wake_up_all_idle_cpus()
                                       powering ON
  device_suspend_late(pd_dev)
    __pm_runtime_disable(pd_dev)
      disable_depth++
                                       powered ON
                                       __psci_enter_domain_idle_state()
                                       pm_runtime_get_sync(pd_dev)
                                       no-op: disable_depth > 0

genpd_runtime_resume() never runs and the domain stays OFF. The next
idle entry skips the genpd suspend as the state is already OFF.

Fix this by using the genpd interface when the runtime PM is disabled.
If the runtime resume failed to restore the domain, force it on by
calling the genpd suspend/resume pair directly.

Signed-off-by: Kaiqian Zhu <zhukaiqian@xiaomi.com>
---
 drivers/cpuidle/cpuidle-psci.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.=
c
index b250d0dde760..5b56f279cc7e 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -70,14 +70,23 @@ static __cpuidle int __psci_enter_domain_idle_state(str=
uct cpuidle_device *dev,
        struct device *pd_dev =3D data->dev;
        struct psci_cpuidle_domain_state *ds;
        u32 state =3D states[idx];
+       bool use_genpd;
        int ret;

        ret =3D cpu_pm_enter();
        if (ret)
                return -1;

+       /*
+        * The PM core disables runtime PM during a system-wide suspend, wh=
ich
+        * makes the pm_runtime_*() calls below no-ops.  The resume can the=
n
+        * no longer set the PM domains back ON, while the CPU is running.
+        * Use the genpd interface directly whenever runtime PM is unavaila=
ble.
+        */
+       use_genpd =3D s2idle || !pm_runtime_enabled(pd_dev);
+
        /* Do runtime PM to manage a hierarchical CPU toplogy. */
-       if (s2idle)
+       if (use_genpd)
                dev_pm_genpd_suspend(pd_dev);
        else
                pm_runtime_put_sync_suspend(pd_dev);
@@ -90,11 +99,24 @@ static __cpuidle int __psci_enter_domain_idle_state(str=
uct cpuidle_device *dev,
        ret =3D psci_cpu_suspend_enter(state) ? -1 : idx;
        trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

-       if (s2idle)
+       if (use_genpd) {
                dev_pm_genpd_resume(pd_dev);
-       else
+       } else {
                pm_runtime_get_sync(pd_dev);

+               /*
+                * Whenever runtime PM is disabled while a CPU was idle (in
+                * the system-wide suspend progress), the resume above beca=
me
+                * a no-op and the domain is still OFF.
+                * Force the genpd to update power state to ON, so that the=
 next
+                * suspend can see the correct state.
+                */
+               if (!dev_pm_genpd_is_on(pd_dev)) {
+                       dev_pm_genpd_suspend(pd_dev);
+                       dev_pm_genpd_resume(pd_dev);
+               }
+       }
+
        cpu_pm_exit();

        /* Correct domain-idlestate statistics if we failed to enter. */
--
2.53.0

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
