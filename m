From: Nick Black <dankamongmen@gmail.com>
Subject: [PATCH] cpupower: correct spelling of interval
Date: Thu, 18 Apr 2019 15:12:52 -0400
Message-ID: <20190418191252.GA19135@schwarzgerat.orthanc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix up multiple instances of "intervall" to correct
"interval" (all save one Italian instance).

Signed-off-by: Nick Black <dankamongmen@gmail.com>
---
 tools/power/cpupower/man/cpupower-monitor.1 | 2 +-
 tools/power/cpupower/po/cs.po               | 2 +-
 tools/power/cpupower/po/de.po               | 2 +-
 tools/power/cpupower/po/fr.po               | 2 +-
 tools/power/cpupower/po/it.po               | 2 +-
 tools/power/cpupower/po/pt.po               | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 914cbb9d9cd0..70a56476f4b0 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -61,7 +61,7 @@ Only display specific monitors. Use the monitor string(s) provided by \-l option
 .PP
 \-i seconds
 .RS 4
-Measure intervall.
+Measure interval.
 .RE
 .PP
 \-c
diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index cb22c45c5069..bfc7e1702ec9 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -98,7 +98,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/de.po b/tools/power/cpupower/po/de.po
index 840c17cc450a..70887bb8ba95 100644
--- a/tools/power/cpupower/po/de.po
+++ b/tools/power/cpupower/po/de.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/fr.po b/tools/power/cpupower/po/fr.po
index b46ca2548f86..b6e505b34e4a 100644
--- a/tools/power/cpupower/po/fr.po
+++ b/tools/power/cpupower/po/fr.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/it.po b/tools/power/cpupower/po/it.po
index f80c4ddb9bda..a1deeb52c9e0 100644
--- a/tools/power/cpupower/po/it.po
+++ b/tools/power/cpupower/po/it.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/pt.po b/tools/power/cpupower/po/pt.po
index 990f5267ffe8..902186585bb9 100644
--- a/tools/power/cpupower/po/pt.po
+++ b/tools/power/cpupower/po/pt.po
@@ -93,7 +93,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
-- 
2.20.1


-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
