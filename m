From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue,  9 Sep 2014 09:46:39 +0530
Message-ID: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46747 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaIIEQz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 00:16:55 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so3892310pab.32
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 21:16:55 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robert.schoene@tu-dresden.de, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

This commit was earlier commited in kernel as:
19c7630 cpufreq: serialize calls to __cpufreq_governor()

and was later reverted by Srivatsa:
56d07db cpufreq: Remove temporary fix for race between CPU hotplug and =
sysfs-writes

When this commit was first introduced it was written for races during h=
otplug
and because we got some other solution to take care of the races with h=
otplug we
reverted it.

But (as I also said in the revert patch: https://lkml.org/lkml/2013/9/1=
0/61)
there are more cases where this is required.

Recently Robert shown an instance where changing governors with multipl=
e threads
leads to following warnings:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2458 at drivers/cpufreq/cpufreq_governor.c:261 cpu=
freq_governor_dbs+0x6d2/0x740()
CPU: 1 PID: 2458 Comm: tee Tainted: G           OE 3.16.0-rc6+ #1
Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for=
 D3061-A1x 07/04/2011
 0000000000000009 ffff8800ae403b78 ffffffff8173b0bf 0000000000000000
 ffff8800ae403bb0 ffffffff8106c82d 0000000000000000 ffff88022fa27000
 0000000000000005 0000000000000002 ffffffff81cd5d00 ffff8800ae403bc0
Call Trace:
 [<ffffffff8173b0bf>] dump_stack+0x45/0x56
 [<ffffffff8106c82d>] warn_slowpath_common+0x7d/0xa0
 [<ffffffff8106c90a>] warn_slowpath_null+0x1a/0x20
 [<ffffffff815e4a12>] cpufreq_governor_dbs+0x6d2/0x740
 [<ffffffff810941fc>] ? notifier_call_chain+0x4c/0x70
 [<ffffffff815e2757>] od_cpufreq_governor_dbs+0x17/0x20
 [<ffffffff815dea50>] __cpufreq_governor+0xb0/0x2a0
 [<ffffffff815ded8c>] cpufreq_set_policy+0x14c/0x2f0
 [<ffffffff815df796>] store_scaling_governor+0x96/0xf0
 [<ffffffff815df100>] ? cpufreq_update_policy+0x1d0/0x1d0
 [<ffffffff815de3c9>] store+0x79/0xc0
 [<ffffffff81245bed>] sysfs_kf_write+0x3d/0x50
 [<ffffffff81245120>] kernfs_fop_write+0xe0/0x160
 [<ffffffff811d00d7>] vfs_write+0xb7/0x1f0
 [<ffffffff811d0c76>] SyS_write+0x46/0xb0
 [<ffffffff817439ff>] tracesys+0xe1/0xe6
---[ end trace a2dad7e42b22c796 ]---
BUG: unable to handle kernel NULL pointer dereference at           (nul=
l)
IP: [<ffffffff815e4395>] cpufreq_governor_dbs+0x55/0x740
PGD 36a05067 PUD b47df067 PMD 0
Oops: 0000 [#1] SMP

Robert also provided a small script to reproduce it:
crash_governor.sh:
for I in `seq 1000`
do
        echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/s=
caling_governor
        echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/=
scaling_governor
done

runme.sh:
for I in `seq 8`
do
        ./crash_governor.sh &
done

Just run runme.sh to crash your system :)

Introduce an additional variable which would guarantee serialization of
__cpufreq_governor() routine.

Reported-and-tested-by: Robert Sch=C3=B6ne <robert.schoene@tu-dresden.d=
e>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

These fixes the issues reported by Robert. There is slight change after=
 Robert
tested my initial patch, 'bool' is replaced by 'int' for 'governor_stat=
e'.

Regardingn stable trees, I am not too sure. The first patch of this ser=
ies was
earlier applied on 3.12 and then was reverted quickly in the same relea=
se.

So, the best we can do is 3.12+.

 drivers/cpufreq/cpufreq.c | 7 ++++++-
 include/linux/cpufreq.h   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9fdedd..a7ceae3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2012,13 +2012,15 @@ static int __cpufreq_governor(struct cpufreq_po=
licy *policy,
 		 policy->cpu, event);
=20
 	mutex_lock(&cpufreq_governor_lock);
-	if ((policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
+	if (policy->governor_busy
+	    || (policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
 	    || (!policy->governor_enabled
 	    && (event =3D=3D CPUFREQ_GOV_LIMITS || event =3D=3D CPUFREQ_GOV_S=
TOP))) {
 		mutex_unlock(&cpufreq_governor_lock);
 		return -EBUSY;
 	}
=20
+	policy->governor_busy =3D true;
 	if (event =3D=3D CPUFREQ_GOV_STOP)
 		policy->governor_enabled =3D false;
 	else if (event =3D=3D CPUFREQ_GOV_START)
@@ -2047,6 +2049,9 @@ static int __cpufreq_governor(struct cpufreq_poli=
cy *policy,
 			((event =3D=3D CPUFREQ_GOV_POLICY_EXIT) && !ret))
 		module_put(policy->governor->owner);
=20
+	mutex_lock(&cpufreq_governor_lock);
+	policy->governor_busy =3D false;
+	mutex_unlock(&cpufreq_governor_lock);
 	return ret;
 }
=20
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7d1955a..c7aa96b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -82,6 +82,7 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	bool			governor_enabled; /* governor start/stop flag */
+	bool			governor_busy;
=20
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
--=20
2.0.3.693.g996b0fd

