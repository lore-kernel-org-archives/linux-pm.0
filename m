From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] Documentation/power/basic-pm-debugging: Fix spelling mistake
Date: Mon, 16 Jan 2012 09:15:51 +0530
Message-ID: <95dd281f84c943a1ae2eabd88ec143566a433be7.1326685381.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: len.brown@intel.com, rdunlap@xenotime.net, linux-pm@lists.linux-foundation.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/power/basic-pm-debugging.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
index 40a4c65..262acf5 100644
--- a/Documentation/power/basic-pm-debugging.txt
+++ b/Documentation/power/basic-pm-debugging.txt
@@ -15,7 +15,7 @@ test at least a couple of times in a row for confidence.  [This is necessary,
 because some problems only show up on a second attempt at suspending and
 resuming the system.]  Moreover, hibernating in the "reboot" and "shutdown"
 modes causes the PM core to skip some platform-related callbacks which on ACPI
-systems might be necessary to make hibernation work.  Thus, if you machine fails
+systems might be necessary to make hibernation work.  Thus, if your machine fails
 to hibernate or resume in the "reboot" mode, you should try the "platform" mode:
 
 # echo platform > /sys/power/disk
-- 
1.7.8.110.g4cb5d

