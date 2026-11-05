Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898299;
	b=rDkDMsaDljZLsCAHZlCZI9gfEbvizvqz4AleNzMYu/W+UfXFLD1RT6plNuJQI4NVcDFR
	 hvl/oF6kxAhnhiyGiShIq/cKtKcNiktQnFhv8NWjzOpygHF+6lRNLS9y51lvCX7xNhlL7
	 jJ8NPjTI+XqZ1OfMPJZLA2E8rdGNnupHvhPKoV213ugO5688nf0X0CGi+AxPLu0LJIQMu
	 yJdlT1yx/u8nAaE2+CNKJATwZcOZN30mxrE8UqBiI7NEzSFPh59JIUlgcAjmeYGeIE7GK
	 aluJJ6KwFf6K35t5TTRjqaltSSgGAw2AbZhW50cbr/0d0IkmDiyJRsfhw45YZoeHTYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898299;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=19A+n+tPKF3BLTOEL99mW+EyDngEAPV7MLTE18m3yzQ=;
	b=E8RH2xWG4rU5L6NySivuH/+xCCUPcZvw53IQbpKyJ8ao0XIlAenKZ5A/FPjZqkJaEbGy
	 7VCiET7BTFsODIXuAoKseiP9GxHRaeRoZbY+jy6HwMkFoODN2Oq8Q7/K1pnxbQxpuRTqm
	 OqdohQypJNiY8Aauqzc33dRkIw059BBK5QYzbdei3m2PCJuVuGjnXRopNNgaMghQSlheR
	 DRFfxHi8CS7yQSDOw1e5gvV4C39Kik2WdhbYRcknJwzpU5Db8ZrPd+kgp3lbl5OewMjMc
	 EZmXKAU9RMgxTI/XWQIr0jk4/6Dj11EE42ylWb/q1h9iGug2DYDQvpsgEfOrFSLUNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qKmPTA8I;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376C606A32D
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 17:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C376C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qKmPTA8I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793898293; bh=19A+n+tPKF3BLTOEL99mW+EyDngEAPV7MLTE18m3yzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qKmPTA8IMCx+sQxs3A49oebVGmAoHpf0D3Mumv1VqyTjIvrGbGP5BxlAnA6dYGa14
	 XuO985RhikxXuGvbw/iVxPpaZz9Hyx2JCK1dJtSBd4X83DLui0CxSwx4GeOqR8EpBI
	 po8X330j6Jcn0FV3vD+E4NCRXDm/M0Asn/u0E4sk=
Received: from localhost.localdomain ([180.164.23.12])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 133170FE; Fri, 06 Nov 2026 01:04:51 +0800
X-QQ-mid: xmsmtpt1793898291txuxm0f2b
Message-ID: <tencent_E6852D1967C70433E84FE0F8C893BC8CFB0A@qq.com>
X-QQ-XMAILINFO: NMOcRb7Tb1o3o4a9i8OKNvHa6Oc53gvuHUC5ukE06ZDohYu/uW9/mg+vyvgrfB
	 +rftpnd76oK+FMvhfGZCkisqe47BKHPVk+Y5jrplRNomGSpgRuYwooTTF4tO9y+Q0QxiY8Zj3P7z
	 BNGF4C1Qd27hMJacSJaamnrV72K1qi8eE9R4iDdKJOIv2VJh7HaB5KnKa0HBUMYk+FJAWCgrAHVh
	 NgGRzsMDXfxoWnt5uVO/7oc/4JSSau0lSYHX1bPBwhgYIL60XZKJVQ9SezJgPiytrTD1GGkQ6VFb
	 QbcbB5egI/lWaOS9jFVRIcztjJURJXF0ZQ8GCBkLLVPAbKeuEO8KwOdXN/vBeHkObkp6VOj0lYmv
	 qG+Dv5DBT8yQdfnYV/sYTd6rM4MUaba4wqOV9Q2mRRjzbSXRKeZEfYz15/NGz2duLDukNELg+dpP
	 JmJtp8Xt3pvSfAWjIvW+XSExemAhqN/MUnG/GjIDkoGlu0t6SZIkD3gYmi3ARFtBwz+hLPM6LpWj
	 LOa/5ToaLECzaNv36YpQ9LZ6yZpXVISsNv17XxDDvLVe5rRh5/vQnkOKJM8gvSigfU3nIkT0ner3
	 4UQrXikaRd7AEd59rhGVFkoBb8GWAEm1/opmeDae4BueD+aJHtIw1QjDvZwUSIQ/3Pa4YWHN+yJQ
	 l7yvA5z3KI5Hp2TdglPj003x34xwdHRmY+hJq/7BrlPv5cH5KulajV9EzeEbYP5l7UaO121eG7TY
	 mNmUF/Il3tCagKYwD6lydva5R1k12ZZ20kjRGvDnV+1jV0NS2A8RTt2riJpGOZVVwW45TWUy9iD3
	 f+rj81rWYCN+tl8IODIWhEaKyn9y0mIJb3ttKCbpIdb7WCEyibFhnYrskncwd59FHMazITk3gmv/
	 7N6xXzJ0D3RL7OFLcFTBXGyscjfqixXnkD/806WNSDswQjAXWFfc44D3ZZg9yQHKqS/DjdQsZERV
	 Q74HweYktIt78Ry3smp9Yi8pDUJVDL0OBJb+U1PZy41IhfY3yn/BqaVaiYLJVIFSn8pQQ4y+fvod
	 9jozdKdqmzX3ouWOAEvi5k/6XmR2SVdPb6kkfLxiPMUmiGcgBD+LXJDhZ0njU/Dt600hGXXXsRhe
	 q6dyLBhOKqlwQ6VJEgT1JtWUmYA350oToW6GjiNURA6jv4atpDKwa/S37CCsM+YeKrKH18
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Kaiqian Zhu <362918296@qq.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com,
	linux-pm@vger.kernel.org,
	Kaiqian Zhu <zhukaiqian@xiaomi.com>
Subject: [PATCH] cpuidle: psci: Fix CPU PM domain state after failed runtime PM resume
Date: Fri,  6 Nov 2026 01:04:38 +0800
X-OQ-MSGID: <20261105170438.1559-1-362918296@qq.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20261105-logical-ruby-scorpion-29ba7b@sudeepholla>
References: <20261105-logical-ruby-scorpion-29ba7b@sudeepholla>
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

In PSCI OSI mode with the hierarchical CPU topology, a CPU can come=0D
out of idle after dpm_suspend_late() has already disabled runtime PM=0D
for its device. The idle exit then restores the cluster PM domain through=0D
the runtime PM path, however, since the runtime PM is disabled, it=0D
becomes a no-op and the domain stays powered off in software while=0D
the CPU is running. The CPU then silently stops requesting the cluster/=0D
system power level in CPU_SUSPEND.=0D
=0D
The Race:=0D
dpm_suspend_late() wakes all idle CPUs first and only then walks the=0D
device list, disabling runtime PM per device as it goes:=0D
=0D
  dpm_suspend_late()=0D
    wake_up_all_idle_cpus()               <-- asynchronous cpu wakeup=0D
      device_suspend_late(dev, ...)=0D
        __pm_runtime_disable(dev,false)    <-- disable_depth++=0D
=0D
wake_up_all_idle_cpus() only requests that the idle CPUs leave idle; it=0D
does not wait for them. A CPU parked in a deep PSCI state can take a long=0D
time to come back that its idle exit lands after the runtime disable:=0D
=0D
  CPU0: dpm_suspend_late()             CPUx: parked in idle=0D
  ------------------------------       ----------------------------=0D
  wake_up_all_idle_cpus()=0D
                                       powering ON=0D
  device_suspend_late(pd_dev)=0D
    __pm_runtime_disable(pd_dev)=0D
      disable_depth++=0D
                                       powered ON=0D
                                       __psci_enter_domain_idle_state()=0D
                                       pm_runtime_get_sync(pd_dev)=0D
                                       no-op: disable_depth > 0=0D
=0D
genpd_runtime_resume() never runs and the domain stays OFF. The next=0D
idle entry skips the genpd suspend as the state is already OFF.=0D
=0D
Fix this by using the genpd interface when the runtime PM is disabled.=0D
If the runtime resume failed to restore the domain, force it on by=0D
calling the genpd suspend/resume pair directly.=0D
=0D
Signed-off-by: Kaiqian Zhu <zhukaiqian@xiaomi.com>=0D
---=0D
Resend note: No code changes. Resent only to remove the automatic=0D
corporate email disclaimer footer from previous send.=0D
Link: https://lore.kernel.org/r/20261021031709.42644-1-zhukaiqian@xiaomi.co=
m=0D
Link: https://lore.kernel.org/all/20261105-logical-ruby-scorpion-29ba7b@sud=
eepholla/=0D
=0D
 drivers/cpuidle/cpuidle-psci.c | 28 +++++++++++++++++++++++++---=0D
 1 file changed, 25 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.=
c=0D
index b250d0dde760..5b56f279cc7e 100644=0D
--- a/drivers/cpuidle/cpuidle-psci.c=0D
+++ b/drivers/cpuidle/cpuidle-psci.c=0D
@@ -70,14 +70,23 @@ static __cpuidle int __psci_enter_domain_idle_state(str=
uct cpuidle_device *dev,=0D
        struct device *pd_dev =3D data->dev;=0D
        struct psci_cpuidle_domain_state *ds;=0D
        u32 state =3D states[idx];=0D
+       bool use_genpd;=0D
        int ret;=0D
=0D
        ret =3D cpu_pm_enter();=0D
        if (ret)=0D
                return -1;=0D
=0D
+       /*=0D
+        * The PM core disables runtime PM during a system-wide suspend, wh=
ich=0D
+        * makes the pm_runtime_*() calls below no-ops.  The resume can the=
n=0D
+        * no longer set the PM domains back ON, while the CPU is running.=
=0D
+        * Use the genpd interface directly whenever runtime PM is unavaila=
ble.=0D
+        */=0D
+       use_genpd =3D s2idle || !pm_runtime_enabled(pd_dev);=0D
+=0D
        /* Do runtime PM to manage a hierarchical CPU toplogy. */=0D
-       if (s2idle)=0D
+       if (use_genpd)=0D
                dev_pm_genpd_suspend(pd_dev);=0D
        else=0D
                pm_runtime_put_sync_suspend(pd_dev);=0D
@@ -90,11 +99,24 @@ static __cpuidle int __psci_enter_domain_idle_state(str=
uct cpuidle_device *dev,=0D
        ret =3D psci_cpu_suspend_enter(state) ? -1 : idx;=0D
        trace_psci_domain_idle_exit(dev->cpu, state, s2idle);=0D
=0D
-       if (s2idle)=0D
+       if (use_genpd) {=0D
                dev_pm_genpd_resume(pd_dev);=0D
-       else=0D
+       } else {=0D
                pm_runtime_get_sync(pd_dev);=0D
=0D
+               /*=0D
+                * Whenever runtime PM is disabled while a CPU was idle (in=
=0D
+                * the system-wide suspend progress), the resume above beca=
me=0D
+                * a no-op and the domain is still OFF.=0D
+                * Force the genpd to update power state to ON, so that the=
 next=0D
+                * suspend can see the correct state.=0D
+                */=0D
+               if (!dev_pm_genpd_is_on(pd_dev)) {=0D
+                       dev_pm_genpd_suspend(pd_dev);=0D
+                       dev_pm_genpd_resume(pd_dev);=0D
+               }=0D
+       }=0D
+=0D
        cpu_pm_exit();=0D
=0D
        /* Correct domain-idlestate statistics if we failed to enter. */=0D
--=0D
2.53.0=

