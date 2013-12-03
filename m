From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Tue,  3 Dec 2013 12:14:32 +0100
Message-ID: <1386069272-9250-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:60678 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab3LCLPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Dec 2013 06:15:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>

This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Perform
light-weight init/teardown during suspend/resume"), which enabled
suspend/resume optimizations leaving the sysfs files in place.

Errors during suspend/resume are not handled properly, leaving
dead sysfs attributes in case of failures.  There are are number of
functions with special code for the "frozen" case, and all these
need to also have special error handling.

The problem is easy to demonstrate by making cpufreq_driver->init()
or cpufreq_driver->get() fail during resume.

The code is too complex for a simple fix, with split code paths
in multiple blocks within a number of functions.  It is therefore
best to revert the patch enabling this code until the error handling
is in place.

Examples of problems resulting from resume errors:

Dec  2 09:54:38 nemi kernel: [  930.162476] ------------[ cut here ]---=
---------
Dec  2 09:54:38 nemi kernel: [  930.162489] WARNING: CPU: 0 PID: 6055 a=
t fs/sysfs/file.c:343 sysfs_open_file+0x77/0x212()
Dec  2 09:54:38 nemi kernel: [  930.162493] missing sysfs attribute ope=
rations for kobject: (null)
Dec  2 09:54:38 nemi kernel: [  930.162495] Modules linked in: [strippe=
d as irrelevant]
Dec  2 09:54:38 nemi kernel: [  930.162662] CPU: 0 PID: 6055 Comm: grep=
 Tainted: G      D      3.13.0-rc2 #153
Dec  2 09:54:38 nemi kernel: [  930.162665] Hardware name: LENOVO 2776L=
EG/2776LEG, BIOS 6EET55WW (3.15 ) 12/19/2011
Dec  2 09:54:38 nemi kernel: [  930.162668]  0000000000000009 ffff88023=
27ebb78 ffffffff81380b0e 0000000000000006
Dec  2 09:54:38 nemi kernel: [  930.162676]  ffff8802327ebbc8 ffff88023=
27ebbb8 ffffffff81038635 0000000000000000
Dec  2 09:54:38 nemi kernel: [  930.162682]  ffffffff811823c7 ffff88021=
a19e688 ffff88021a19e688 ffff8802302f9310
Dec  2 09:54:38 nemi kernel: [  930.162690] Call Trace:
Dec  2 09:54:38 nemi kernel: [  930.162698]  [<ffffffff81380b0e>] dump_=
stack+0x55/0x76
Dec  2 09:54:38 nemi kernel: [  930.162705]  [<ffffffff81038635>] warn_=
slowpath_common+0x7c/0x96
Dec  2 09:54:38 nemi kernel: [  930.162710]  [<ffffffff811823c7>] ? sys=
fs_open_file+0x77/0x212
Dec  2 09:54:38 nemi kernel: [  930.162715]  [<ffffffff810386e3>] warn_=
slowpath_fmt+0x41/0x43
Dec  2 09:54:38 nemi kernel: [  930.162720]  [<ffffffff81182dec>] ? sys=
fs_get_active+0x6b/0x82
Dec  2 09:54:38 nemi kernel: [  930.162725]  [<ffffffff81182382>] ? sys=
fs_open_file+0x32/0x212
Dec  2 09:54:38 nemi kernel: [  930.162730]  [<ffffffff811823c7>] sysfs=
_open_file+0x77/0x212
Dec  2 09:54:38 nemi kernel: [  930.162736]  [<ffffffff81182350>] ? sys=
fs_schedule_callback+0x1ac/0x1ac
Dec  2 09:54:38 nemi kernel: [  930.162742]  [<ffffffff81122562>] do_de=
ntry_open+0x17c/0x257
Dec  2 09:54:38 nemi kernel: [  930.162748]  [<ffffffff8112267e>] finis=
h_open+0x41/0x4f
Dec  2 09:54:38 nemi kernel: [  930.162754]  [<ffffffff81130225>] do_la=
st+0x80c/0x9ba
Dec  2 09:54:38 nemi kernel: [  930.162759]  [<ffffffff8112dbbd>] ? ino=
de_permission+0x40/0x42
Dec  2 09:54:38 nemi kernel: [  930.162764]  [<ffffffff81130606>] path_=
openat+0x233/0x4a1
Dec  2 09:54:38 nemi kernel: [  930.162770]  [<ffffffff81130b7e>] do_fi=
lp_open+0x35/0x85
Dec  2 09:54:38 nemi kernel: [  930.162776]  [<ffffffff8113b787>] ? __a=
lloc_fd+0x172/0x184
Dec  2 09:54:38 nemi kernel: [  930.162782]  [<ffffffff811232ea>] do_sy=
s_open+0x6b/0xfa
Dec  2 09:54:38 nemi kernel: [  930.162787]  [<ffffffff811233a7>] SyS_o=
penat+0xf/0x11
Dec  2 09:54:38 nemi kernel: [  930.162794]  [<ffffffff8138c812>] syste=
m_call_fastpath+0x16/0x1b
Dec  2 09:54:38 nemi kernel: [  930.162798] ---[ end trace 48ce7fe74a95=
d4be ]---

The failure to restore cpufreq devices on cancelled hibernation is
not a new bug. It is caused by the ACPI _PPC call failing unless the
hibernate is completed. This makes the acpi_cpufreq driver fail its
init.

Previously, the cpufreq device could be restored by offlining the
cpu temporarily.  And as a complete hibernation cycle would do this,
it would be automatically restored most of the time.  But after
commit 5302c3fb2e62 the leftover sysfs attributes will block any
device add action.  Therefore offlining and onlining CPU 1 will no
longer restore the cpufreq object, and a complete suspend/resume
cycle will replace it with garbage.

=46ixes: 5302c3fb2e62 ("cpufreq: Perform light-weight init/teardown dur=
ing suspend/resume")
Cc: <stable@vger.kernel.org> # v3.12
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/cpufreq/cpufreq.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534da22dd..b7c3b877da44 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2076,9 +2076,6 @@ static int cpufreq_cpu_callback(struct notifier_b=
lock *nfb,
 	dev =3D get_cpu_device(cpu);
 	if (dev) {
=20
-		if (action & CPU_TASKS_FROZEN)
-			frozen =3D true;
-
 		switch (action & ~CPU_TASKS_FROZEN) {
 		case CPU_ONLINE:
 			__cpufreq_add_dev(dev, NULL, frozen);
--=20
1.7.10.4

