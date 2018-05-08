From: Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] Documentation/admin-guide/pm/intel_pstate: fix Active Mode w/o HWP paragraph
Date: Tue,  8 May 2018 17:12:09 +0200
Message-ID: <20180508151209.9314-1-juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

P-state selection algorithm (powersave or performance) is selected by
echoing the desired choice to scaling_governor sysfs attribute and not
to scaling_cur_freq (as currently stated).

Fix it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
 Documentation/admin-guide/pm/intel_pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index d2b6fda3d67b..ab2fe0eda1d7 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -145,7 +145,7 @@ feature enabled.]
 
 In this mode ``intel_pstate`` registers utilization update callbacks with the
 CPU scheduler in order to run a P-state selection algorithm, either
-``powersave`` or ``performance``, depending on the ``scaling_cur_freq`` policy
+``powersave`` or ``performance``, depending on the ``scaling_governor`` policy
 setting in ``sysfs``.  The current CPU frequency information to be made
 available from the ``scaling_cur_freq`` policy attribute in ``sysfs`` is
 periodically updated by those utilization update callbacks too.
-- 
2.14.3
