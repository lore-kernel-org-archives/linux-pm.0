Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4493DE429;
	Thu,  9 Jul 2026 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635235; cv=none; b=pxAP38aMbd8UN6bGcFs9AVZLuDeoIn5pgaJzmv0NVKygn3ELB+cr52S5ohOm9TQX0zSg6uXvBBg2VFJrQRA1qlg+Cn0MmhIZeSl5hGraNnvE/yPSbgvcHhF7EvKgP5s6kR4w51e4ee4W/q+ny7d8Xk+9zF4oQfayCKSI7PpRjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635235; c=relaxed/simple;
	bh=4GcVwhhih1UZiLewMoHfgZQA0OnyjT8cEx6F+hGyRf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUCzrQQy9wH/WNEHSLStZ0SamIiTDN2//Zd9dFSMTFMuzAs3rZAb0FeYFlrrX6jYbIBid0SVa5koLI8m0ltwl1aSs6i/ffl1KHjy51on+sZXbHUwoeeoWqwxLElMR9Pex1FJHqCAc7KnmnaVyjGd7JW9K72w3FSQoNiVABu1LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QSmTkY7s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QSmTkY7s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F311477;
	Thu,  9 Jul 2026 15:13:47 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024B63F66F;
	Thu,  9 Jul 2026 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783635232; bh=4GcVwhhih1UZiLewMoHfgZQA0OnyjT8cEx6F+hGyRf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSmTkY7shkKn1sZalNMTuGLIk9j0ofBUJ1YHb+YryFOaCYfGttsVEOf6yy1ftfZDd
	 WCz9ttdBePXaUFdwI07h0m/PMptcC4M0KUyrvw6yEeamo/zWTt3gCNMUwwlTJiEgZg
	 SPWDedqqwSSHbTC0uyFVfX1MylRgSvd22GDL+2vk=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	kaushlendra.kumar@intel.com,
	sashal@kernel.org,
	fj5851bi@fujitsu.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/3] cpupower: Add generic CPPC performance display
Date: Thu,  9 Jul 2026 17:13:42 -0500
Message-ID: <20260709221344.1919794-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709221344.1919794-1-jeremy.linton@arm.com>
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm64 machines, and possibly others, use the standard ACPI defined CPPC
infrastructure. cpupower has CPPC support, but it's largely written
around the intricacies of AMD processors, using platform MSRs to avoid
shortcomings in the specification.

Add a generic CPPC display that depends only on standardized fields. The
computed frequency values are best effort and rely on the FW providing
optional values that can be used to derive a meaningful frequency at a
given unique performance level.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 tools/power/cpupower/utils/helpers/cppc.c | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tools/power/cpupower/utils/helpers/cppc.c

diff --git a/tools/power/cpupower/utils/helpers/cppc.c b/tools/power/cpupower/utils/helpers/cppc.c
new file mode 100644
index 000000000000..3493ce8551ea
--- /dev/null
+++ b/tools/power/cpupower/utils/helpers/cppc.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <math.h>
+
+#include "helpers/helpers.h"
+#include "cpufreq.h"
+#include "acpi_cppc.h"
+
+#define cppc_to_frequency(perf) (roundf(slope * (perf) + intercept))
+
+void cppc_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	int64_t nominal = acpi_cppc_get_data(cpu, NOMINAL_PERF);
+	int64_t nominal_freq = acpi_cppc_get_data(cpu, NOMINAL_FREQ) * 1000;
+	int64_t lowest = acpi_cppc_get_data(cpu, LOWEST_PERF);
+	int64_t lowest_freq = acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000;
+	unsigned long non_linear = acpi_cppc_get_data(cpu, LOWEST_NONLINEAR_PERF);
+	unsigned long highest = acpi_cppc_get_data(cpu, HIGHEST_PERF);
+	float slope, intercept;
+
+	/* do the optional freq fields look invalid? */
+	if (!nominal_freq || !lowest_freq || nominal == lowest)
+		return;
+
+	slope = (float)(nominal_freq - lowest_freq) / (nominal - lowest);
+	intercept = lowest_freq - slope * lowest;
+
+	printf(_("  CPPC limits:\n"));
+	printf(_("    Highest Performance: %lu. Maximum Frequency: "),
+	       highest);
+	/*
+	 * If boost isn't active, the cpuinfo_max doesn't indicate real max
+	 * frequency.
+	 */
+	print_speed(cppc_to_frequency(highest), no_rounding);
+	printf(".\n");
+
+	printf(_("    Nominal Performance: %lu. Nominal Frequency: "),
+	       acpi_cppc_get_data(cpu, NOMINAL_PERF));
+	print_speed(nominal_freq,  no_rounding);
+	printf(".\n");
+
+	printf(_("    Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	       non_linear);
+	print_speed(cppc_to_frequency(non_linear), no_rounding);
+	printf(".\n");
+
+	printf(_("    Lowest Performance: %lu. Lowest Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_PERF));
+	print_speed(lowest_freq, no_rounding);
+	printf(".\n");
+}
-- 
2.54.0

