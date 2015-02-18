From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 8/8] tools/thermal: tmon: silence 'set but not used' warnings
Date: Tue, 17 Feb 2015 18:18:36 -0800
Message-ID: <1424225916-13488-9-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34032 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbbBRCTi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 21:19:38 -0500
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

gcc complains about the 'cols' variable being unused. This is
unavoidable, given the ncurses getmaxyx() macro-based API, which wants
to assign to a variable directly, even when we're not going to use it.

Warning:

    gcc -O1 -Wall -Wshadow -W -Wformat -Wimplicit-function-declaration =
-Wimplicit-int -fstack-protector -D VERSION=3D\"1.0\"   -c -o tui.o tui=
=2Ec
    tui.c: In function =E2=80=98show_dialogue=E2=80=99:
    tui.c:288:12: warning: variable =E2=80=98cols=E2=80=99 set but not =
used [-Wunused-but-set-variable]
      int rows, cols;
                ^

So, add a hack to get rid of that warning.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
This patch is ugly and of little value IMO, but it does squash the warn=
ing.
Take it or leave it.

 tools/thermal/tmon/tui.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 36e1f86c8452..b5d1c6b22dd3 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -293,6 +293,9 @@ void show_dialogue(void)
=20
 	getmaxyx(w, rows, cols);
=20
+	/* Silence compiler 'unused' warnings */
+	(void)cols;
+
 	werase(w);
 	box(w, 0, 0);
 	mvwprintw(w, 0, maxx/4, DIAG_TITLE);
--=20
1.9.1

