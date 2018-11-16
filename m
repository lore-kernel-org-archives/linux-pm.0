From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] Documentation: intel_pstate: Clarify coordination of P-State limits
Date: Fri, 16 Nov 2018 14:24:20 -0800
Message-ID: <20181116222420.24260-2-srinivas.pandruvada@linux.intel.com>
References: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, yu.c.chen@intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Explain influence of per-core P-states and hyper threading on the
effective performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index ac6f5c597a56..ec0f7c111f65 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -495,7 +495,15 @@ on the following rules, regardless of the current operation mode of the driver:
 
  2. Each individual CPU is affected by its own per-policy limits (that is, it
     cannot be requested to run faster than its own per-policy maximum and it
-    cannot be requested to run slower than its own per-policy minimum).
+    cannot be requested to run slower than its own per-policy minimum). The
+    effective performance depends on whether the platform supports per core
+    P-states, hyper-threading is enabled and on current performance requests
+    from other CPUs. When platform doesn't support per core P-states, the
+    effective performance can be more than the policy limits set on a CPU, if
+    other CPUs are requesting higher performance at that moment. Even with per
+    core P-states support, when hyper-threading is enabled, if the sibling CPU
+    is requesting higher performance, the other siblings will get higher
+    performance than their policy limits.
 
  3. The global and per-policy limits can be set independently.
 
-- 
2.17.1
