From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] Documentation: power: swsusp: Fix script for unswapping
Date: Tue,  6 May 2014 13:01:56 +0200
Message-ID: <1399374116-12400-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-pm@vger.kernel.org

System can have mmaped also character devices (e.g dri devices by X) or=
 deleted
files. Running cat on character devices is really bad idea (system can =
hang) so
run cat only on regular files. Also mmaped files can have spaces in fil=
enames.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 Documentation/power/swsusp.txt |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsus=
p.txt
index 079160e..f732a83 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -220,7 +220,10 @@ Q: After resuming, system is paging heavily, leadi=
ng to very bad interactivity.
=20
 A: Try running
=20
-cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /de=
v/null
+cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u | while rea=
d file
+do
+  test -f "$file" && cat "$file" > /dev/null
+done
=20
 after resume. swapoff -a; swapon -a may also be useful.
=20
--=20
1.7.9.5
