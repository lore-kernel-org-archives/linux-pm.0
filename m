Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7138E5FF;
	Mon,  9 Mar 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094842; cv=none; b=VOOYLRB7dM/7Wbbnd6LQ40y94c19cGudqohovM3hjsKGzFcbBxRa4Dt+ozpc2ZVL136k6z75BxKAHGGoFbesUAo69J2mlT797oDix5jHdh80VVjicQ+2Ad6yepMCmyY8TB9gB5C7YkZ7Q+3nljAseyQ3jUs78NJJHkWtWm1Edc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094842; c=relaxed/simple;
	bh=xkX6/r3jlEdr7Ws/dG9NtH+OFdxbALWEmLOIVpaykP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9C76Imf/9yQu8m7et1RxV1imm4pWzpNL1OMbZbI4LzfS4b0MA64k8mlSJwNEx7WBxUA/qEUilKwpx9nwOdkJkWGU3SYbPBsX/i5jAPo7vSqJt/PyDNikDnPwv+Ryo2gBfbLCwh0yPPJI8lUvzJ9LJgqpyNQsAcMyQD/yWnPRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxoMBlcp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxoMBlcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773094841; x=1804630841;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xkX6/r3jlEdr7Ws/dG9NtH+OFdxbALWEmLOIVpaykP4=;
  b=FxoMBlcp1nhIrR8iBB9lyOcU+Om2h9p2MIeiQCHbbEhxhC7gDdEqHhJ8
   U1foLiksrqrxLY+rw6pq5720Bf+XhQ3nS1jFJ+neYQafqyOL7vjVQxPKm
   W4fKs51wKuRrRB1Dc8FbcQeX/XOsnusrYbRpRNiaNG01P7EOPSBCfWb2R
   qByJFw9YNGSOvfsSSIoEBaRGP1D0/Ma7OS9AwL1/h+XA2l7tKnNYTfWOE
   NoqDwgFfg0r50q4Z8aSygM0W0T0r6vw1Uol/ej2tMFn+pqNi5Hi9Owl2V
   bEI1IPaKQeQss7ydonRRXBd/caVIKKiY/c10KgLMB8PuIEVmLhDHmIz6S
   g==;
X-CSE-ConnectionGUID: vwYfCHd5TQOEp0unBV/dcA==
X-CSE-MsgGUID: kQupOvCHRS68AorsrPIG2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74050658"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74050658"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:38 -0700
X-CSE-ConnectionGUID: IgDh7SA2RI+mIDra/ZyvVQ==
X-CSE-MsgGUID: aje8LJsSRlWiPiJpaqstlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224004293"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 Mar 2026 15:19:26 -0700
Subject: [PATCH 3/4] thermal: intel: Add syscore callbacks for suspend and
 resume
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-rneri-directed-therm-intr-v1-3-2956e3000950@linux.intel.com>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
In-Reply-To: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773094783; l=2660;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=xkX6/r3jlEdr7Ws/dG9NtH+OFdxbALWEmLOIVpaykP4=;
 b=RCifaQc3sZs2aCjV+CM02cR5JeAxqgY+1wc6eaOA1skx8ikMnTUrf7IdLzgFHY/5IN4mKhitT
 iMljg24LwDXAx6eggCAFZ/Oin4GtYHEmmR8WiCVUsSPhRACTihajNiO
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Directed package-level thermal interrupts are serviced by a single CPU per
package. These handler CPUs are selected at boot through the CPU hotplug
infrastructure. This mechanism is sufficient to restore the directed
interrupt configuration when resuming from suspend.

For the boot package, CPU0 is chosen during boot because its CPU hotplug
online callback runs first. However, this callback is not invoked on
resume. The directed package-level interrupt configuration for the boot
package is not restored automatically. Add a syscore .resume callback to
re-enable directed package-level interrupts for this package.

Disabling directed interrupts during suspend is not strictly required, but
doing so keeps the handler-tracking array in a consistent state. It allows
the correct configuration to be restored on resume.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/therm_throt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 456f2ac10e0c..c89485a8cda0 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -14,6 +14,7 @@
  * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
  *          Inspired by Ross Biro's and Al Borchers' counter code.
  */
+#include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/jiffies.h>
@@ -730,6 +731,32 @@ static int thermal_throttle_offline(unsigned int cpu)
 	return 0;
 }
 
+static void directed_pkg_intr_syscore_resume(void *data)
+{
+	/* We resume from the suspend on CPU0. */
+	enable_directed_thermal_pkg_intr(0);
+}
+
+static int directed_pkg_intr_syscore_suspend(void *data)
+{
+	/*
+	 * We suspend from CPU0. The interrupt will not be redirected since all
+	 * CPUs in the package are offline at this point.
+	 */
+	disable_directed_thermal_pkg_intr(0);
+
+	return 0;
+}
+
+static struct syscore_ops directed_pkg_intr_pm_ops = {
+	.resume = directed_pkg_intr_syscore_resume,
+	.suspend = directed_pkg_intr_syscore_suspend,
+};
+
+static struct syscore directed_pkg_intr_pm = {
+	.ops = &directed_pkg_intr_pm_ops,
+};
+
 static __init void init_directed_pkg_intr(void)
 {
 	int i;
@@ -745,6 +772,8 @@ static __init void init_directed_pkg_intr(void)
 
 	for (i = 0; i < topology_max_packages(); i++)
 		directed_intr_handler_cpus[i] = nr_cpu_ids;
+
+	register_syscore(&directed_pkg_intr_pm);
 }
 
 static __init int thermal_throttle_init_device(void)

-- 
2.43.0

