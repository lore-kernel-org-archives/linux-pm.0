From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] cpupower update for 4.15-rc1
Date: Thu, 9 Nov 2017 13:10:27 -0700
Message-ID: <d34df2fe-3f33-2716-6a29-8f66656edf8a@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8665E14027308EA778F16E93"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:60344 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbdKIUKg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Nov 2017 15:10:36 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, Prarit Bhargava <prarit@redhat.com>

This is a multi-part message in MIME format.
--------------8665E14027308EA778F16E93
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please pull the cpupower update for 4.15-rc1

This update consists of fixes to the MHz frequency output and
adding 64-bit library detection.

Diff is attached.

These patches have been in linux-next for a few days. I had to fix
commit lines longer than 75 chars in one of the commits and fixed
this morning.

Please let me know if you would like any changes in the work-flow
and the pull request.

thanks,
-- Shuah

--------------------------------------------------------------
The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-4.15-rc1

for you to fetch changes up to 69b6f8a9b7961efd7dcc11ab9b1d5be55ed8a15e:

  tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore (2017-11-09 10:52:22 -0700)

----------------------------------------------------------------
linux-cpupower-4.15-rc1

This cpupower update consists of fixes to the MHz frequency output and
adding 64-bit library detection.

----------------------------------------------------------------
Prarit Bhargava (3):
      cpupower: Fix no-rounding MHz frequency output
      tools/power/cpupower: Add 64 bit library detection
      tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore

 tools/power/cpupower/.gitignore           | 3 +--
 tools/power/cpupower/Makefile             | 6 ++++++
 tools/power/cpupower/utils/cpufreq-info.c | 2 --
 3 files changed, 7 insertions(+), 4 deletions(-)
--------------------------------------------------------------

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com

--------------8665E14027308EA778F16E93
Content-Type: text/x-patch;
 name="linux-cpupower-4.15-rc1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-cpupower-4.15-rc1.diff"

diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.giti=
gnore
index d42073f12609..1f9977cc609c 100644
--- a/tools/power/cpupower/.gitignore
+++ b/tools/power/cpupower/.gitignore
@@ -1,7 +1,6 @@
 .libs
 libcpupower.so
-libcpupower.so.0
-libcpupower.so.0.0.0
+libcpupower.so.*
 build/ccdv
 cpufreq-info
 cpufreq-set
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefil=
e
index d6e1c02ddcfe..da205d1fa03c 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -30,6 +30,8 @@ OUTDIR :=3D $(shell cd $(OUTPUT) && /bin/pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
=20
+include ../../scripts/Makefile.arch
+
 # --- CONFIGURATION BEGIN ---
=20
 # Set the following to `true' to make a unstripped, unoptimized
@@ -79,7 +81,11 @@ bindir ?=3D	/usr/bin
 sbindir ?=3D	/usr/sbin
 mandir ?=3D	/usr/man
 includedir ?=3D	/usr/include
+ifeq ($(IS_64_BIT), 1)
+libdir ?=3D	/usr/lib64
+else
 libdir ?=3D	/usr/lib
+endif
 localedir ?=3D	/usr/share/locale
 docdir ?=3D       /usr/share/doc/packages/cpupower
 confdir ?=3D      /etc/
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpup=
ower/utils/cpufreq-info.c
index 3e701f0e9c14..df43cd45d810 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -93,8 +93,6 @@ static void print_speed(unsigned long speed)
 		if (speed > 1000000)
 			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
 				((unsigned int) speed%1000000));
-		else if (speed > 100000)
-			printf("%u MHz", (unsigned int) speed);
 		else if (speed > 1000)
 			printf("%u.%03u MHz", ((unsigned int) speed/1000),
 				(unsigned int) (speed%1000));

--------------8665E14027308EA778F16E93--
