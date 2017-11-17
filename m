From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] cpupower update for 4.15-rc2
Date: Fri, 17 Nov 2017 11:20:13 -0700
Message-ID: <e7b8b542-2fc9-0b6f-da97-a0dd50a7d55d@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CBA082BD6824C835664007B3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:58584 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752501AbdKQSUQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Nov 2017 13:20:16 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>

This is a multi-part message in MIME format.
--------------CBA082BD6824C835664007B3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please pull the cpupower update for 4.15-rc2

This update consists of fixes to tool's handling of offline cpus.
The first patch fixes the tool to find information on the cpu it
is running on, instead of always looking for cpu0 and failing if
cpu0 happens to be offline.

The second patch fixes the incorrect check for offline cpu status.

Diff is attached.

thanks,
-- Shuah

------------------------------------------------------------------------------------------

The following changes since commit 69b6f8a9b7961efd7dcc11ab9b1d5be55ed8a15e:

  tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore (2017-11-09 10:52:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.15-rc2

for you to fetch changes up to dbdc468f35ee827cab2753caa1c660bdb832243a:

  cpupower : Fix cpupower working when cpu0 is offline (2017-11-15 08:37:42 -0700)

----------------------------------------------------------------
linux-cpupower-4.15-rc2

This update consists of fixes to tool's handling of offline cpus.
The first patch fixes the tool to find information on the cpu it
is running on, instead of always looking for cpu0 and failing if
cpu0 happens to be offline.

The second patch fixes the incorrect check for offline cpu status.

----------------------------------------------------------------
Abhishek Goel (2):
      cpupowerutils: bench - Fix cpu online check
      cpupower : Fix cpupower working when cpu0 is offline

 tools/power/cpupower/bench/system.c                     | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

------------------------------------------------------------------------------------------


--------------CBA082BD6824C835664007B3
Content-Type: text/x-patch;
 name="linux-cpupower-4.15-rc2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-cpupower-4.15-rc2.diff"

diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/b=
ench/system.c
index c25a74ae51ba..2bb3eef7d5c1 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int c=
pu)
=20
 	dprintf("set %s as cpufreq governor\n", governor);
=20
-	if (cpupower_is_cpu_online(cpu) !=3D 0) {
+	if (cpupower_is_cpu_online(cpu) !=3D 1) {
 		perror("cpufreq_cpu_exists");
 		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
 		return -1;
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/to=
ols/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 1b5da0066ebf..5b3205f16217 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -130,15 +130,18 @@ static struct cpuidle_monitor *cpuidle_register(voi=
d)
 {
 	int num;
 	char *tmp;
+	int this_cpu;
+
+	this_cpu =3D sched_getcpu();
=20
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num =3D cpuidle_state_count(0);
+	cpuidle_sysfs_monitor.hw_states_num =3D cpuidle_state_count(this_cpu);
=20
 	if (cpuidle_sysfs_monitor.hw_states_num <=3D 0)
 		return NULL;
=20
 	for (num =3D 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp =3D cpuidle_state_name(0, num);
+		tmp =3D cpuidle_state_name(this_cpu, num);
 		if (tmp =3D=3D NULL)
 			continue;
=20
@@ -146,7 +149,7 @@ static struct cpuidle_monitor *cpuidle_register(void)=

 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
=20
-		tmp =3D cpuidle_state_desc(0, num);
+		tmp =3D cpuidle_state_desc(this_cpu, num);
 		if (tmp =3D=3D NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);

--------------CBA082BD6824C835664007B3--
