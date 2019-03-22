From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] ACPI / CPPC: Fix processing for guaranteed performance
Date: Fri, 22 Mar 2019 15:45:19 -0700
Message-ID: <20190322224520.6740-2-srinivas.pandruvada@linux.intel.com>
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pprakash@codeaurora.org, wangxiongfeng2@huawei.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "4 . 20+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

As per ACPI specification "Guaranteed Performance Register" is a "Buffer"
field. It can't be "Integer" field. So treat "Integer" type as invalid and
ignore "Guaranteed Performance Register".
Also save one cpc_read() call, when "Guaranteed Performance Register" is
not present, which means register defined as:
"Register(SystemMemory, 0, 0, 0, 0)".

Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
---
 drivers/acpi/cppc_acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1b207fca1420..3f6c290e06af 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1150,8 +1150,14 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
-	cpc_read(cpunum, guaranteed_reg, &guaranteed);
-	perf_caps->guaranteed_perf = guaranteed;
+	if (guaranteed_reg->type == ACPI_TYPE_INTEGER  ||
+	    (guaranteed_reg->type == ACPI_TYPE_BUFFER &&
+	     IS_NULL_REG(&guaranteed_reg->cpc_entry.reg))) {
+		perf_caps->guaranteed_perf = 0;
+	} else {
+		cpc_read(cpunum, guaranteed_reg, &guaranteed);
+		perf_caps->guaranteed_perf = guaranteed;
+	}
 
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
-- 
2.17.2
