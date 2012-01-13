From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] Documentation/power/freezing-of-tasks: Fix minor issue
Date: Fri, 13 Jan 2012 10:09:17 +0530
Message-ID: <1e6f2ab3f62123a550ca52ce68d9d7e0573c5084.1326372545.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: pavel@ucw.cz, len.brown@intel.com, rdunlap@xenotime.net, linux-pm@lists.linux-foundation.org, linux-doc@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com
List-Id: linux-pm@vger.kernel.org

In a paragraph, "kernel thread" is mistakenly written as "kernel". Fix this by
adding thread after word "kernel".

Changes are shown in multiple lines, as they are realigned to 80 col width.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/power/freezing-of-tasks.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/freezing-of-tasks.txt b/Documentation/power/freezing-of-tasks.txt
index 6ccb68f..ebd7490 100644
--- a/Documentation/power/freezing-of-tasks.txt
+++ b/Documentation/power/freezing-of-tasks.txt
@@ -120,10 +120,10 @@ So in practice, the 'at all' may become a 'why freeze kernel threads?' and
 freezing user threads I don't find really objectionable."
 
 Still, there are kernel threads that may want to be freezable.  For example, if
-a kernel that belongs to a device driver accesses the device directly, it in
-principle needs to know when the device is suspended, so that it doesn't try to
-access it at that time.  However, if the kernel thread is freezable, it will be
-frozen before the driver's .suspend() callback is executed and it will be
+a kernel thread that belongs to a device driver accesses the device directly, it
+in principle needs to know when the device is suspended, so that it doesn't try
+to access it at that time.  However, if the kernel thread is freezable, it will
+be frozen before the driver's .suspend() callback is executed and it will be
 thawed after the driver's .resume() callback has run, so it won't be accessing
 the device while it's suspended.
 
-- 
1.7.8.110.g4cb5d

