From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 15/46] kernel: Include appropriate header file in
 kernel/power/wakelock.c
Date: Thu, 27 Feb 2014 17:15:54 +0530
Message-ID: <e0a51dd52207bdb03257413e9b4d18a4b6a65812.1393493277.git.rashika.kheria@gmail.com>
References: <7b4a60c74ced00e0d65c38488f20dc4bd69f0dd2.1393493276.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38115 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaB0LqD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 06:46:03 -0500
Content-Disposition: inline
In-Reply-To: <7b4a60c74ced00e0d65c38488f20dc4bd69f0dd2.1393493276.git.rashika.kheria@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, josh@joshtriplett.org

Include appropriate header file kernel/power/power.h in
kernel/power/wakelock.c because it has prototype declaration of functio=
n
defined in kernel/power/wakelock.c.

This eliminates the following warning in kernel/power/wakelock.c:
kernel/power/wakelock.c:34:9: warning: no previous prototype for =E2=80=
=98pm_show_wakelocks=E2=80=99 [-Wmissing-prototypes]
kernel/power/wakelock.c:184:5: warning: no previous prototype for =E2=80=
=98pm_wake_lock=E2=80=99 [-Wmissing-prototypes]
kernel/power/wakelock.c:232:5: warning: no previous prototype for =E2=80=
=98pm_wake_unlock=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 kernel/power/wakelock.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 8f50de3..019069c 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -18,6 +18,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
=20
+#include "power.h"
+
 static DEFINE_MUTEX(wakelocks_lock);
=20
 struct wakelock {
--=20
1.7.9.5

