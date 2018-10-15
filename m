From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/3] Documentation: intel_pstate: Add base_frequency information
Date: Mon, 15 Oct 2018 10:37:21 -0700
Message-ID: <20181015173721.66147-4-srinivas.pandruvada@linux.intel.com>
References: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, robert.moore@intel.com, erik.schmauss@intel.com
Cc: juri.lelli@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, pprakash@codeaurora.org, george.cherian@cavium.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Updated documentation to explain base_frequency attribute.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 8f1d3de449b5..ac6f5c597a56 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -465,6 +465,13 @@ Next, the following policy attributes have special meaning if
 	policy for the time interval between the last two invocations of the
 	driver's utilization update callback by the CPU scheduler for that CPU.
 
+One more policy attribute is present if the `HWP feature is enabled in the
+processor <Active Mode With HWP_>`_:
+
+``base_frequency``
+	Shows the base frequency of the CPU. Any frequency above this will be
+	in the turbo frequency range.
+
 The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
 same as for other scaling drivers.
 
-- 
2.17.1
