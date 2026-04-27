Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680E3644C3;
	Mon, 27 Apr 2026 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262131; cv=none; b=n7zmMh4q0YVdLBmB1Rlk8UzHm/l/tOIm00UVFC8c2F63lscfqpck078WqrH/gGfkhXd9xncUa+eB/gIXAf1mLSY8Ypg4cQB7/p3GvOdZkyYdQ4mYXtgvasi7/oL9Kr0YdEEqE9PsK02S35wlPNX5Yiabn45DDkGhDLfNpBt5kcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262131; c=relaxed/simple;
	bh=4YMMBXWmIwJmYIH24b1eS5YbU5mq7WwaS0/4ExDHXj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH953d3uytai5q3iKlYNrvnZSawHaUrF4DYJ/Y7eYf74+oNlXN9HPbJGnV4qXyYxSaQ/RGRPoY38IXUMWYoT9w19kXwCkUr+1SznC01mF4IuPKmlFrgF5jgnBWBkQm3zdB57ar9YnbDZnDghFi7xh609dtWtHL9i9pnmRHaH8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCr6p/I5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCr6p/I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0EBC2BCC4;
	Mon, 27 Apr 2026 03:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262131;
	bh=4YMMBXWmIwJmYIH24b1eS5YbU5mq7WwaS0/4ExDHXj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCr6p/I5C00mbsECYQNGTJC1uR9jqYw5ZVU1AxJEkioOtKUi5nDwv8rbRgMnO95UJ
	 cvt/q1MyGgrNF1VkH28VMoL0yUE6G3dqUyTywyefe6Pif8idO3t6XBEOM9xwufBbO7
	 mDItLXSMle1r3iPo4n8WtqkZrMkHnUN16ap5R4LmBgx4hEPx+EK/sCU/CpS0uP36Sk
	 j4wioYn15fRAuWYIdjTHHSDAod4ezU20wZ2vqnRUhjd0dX4SGhlR6S2pzQrrTpecBR
	 m7Y2fg4PhhmTmLd6EEvnjca/w18a+ZSFW5wzhM5nYCRa6GIsdZBUj+eBaNocTB8IF6
	 gqK2j8qvL7zcA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 2/6] ACPI: Add CPPC v4 definitions
Date: Sun, 26 Apr 2026 22:55:16 -0500
Message-ID: <20260427035520.1427080-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035520.1427080-1-superm1@kernel.org>
References: <20260427035520.1427080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 introduced new optional package values for
`OSPMNominalPerformanceRegister` and
`ResourcePriorityRegisters`.

Add these into the defines.  As they're not used right now they are not
wired up to anything at this time.

Link: https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.html#cpc-continuous-performance-control
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 16 ++++++++++++----
 include/acpi/cppc_acpi.h | 13 +++++++++----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2e91c5a977611..cbfebc50b6eab 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -755,14 +755,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	 */
 	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
 	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
-	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
+	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
+	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
 		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
 			 num_ent, pr->id);
 		goto out_free;
 	}
-	if (cpc_rev > CPPC_V3_REV) {
-		num_ent = CPPC_V3_NUM_ENT;
-		cpc_rev = CPPC_V3_REV;
+	if (cpc_rev > CPPC_V4_REV) {
+		num_ent = CPPC_V4_NUM_ENT;
+		cpc_rev = CPPC_V4_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -845,6 +846,13 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
 			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
+		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
+			/*
+			 * CPPC v4 ResourcePriorityRegisters is a Package.
+			 * Store NULL for now as it's not wired up to anything.
+			 */
+			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.pkg_data = NULL;
 		} else {
 			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
 				 i, pr->id);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d1f02ceec4f98..38bf9013c6e2e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -17,16 +17,18 @@
 #include <acpi/pcc.h>
 #include <acpi/processor.h>
 
-/* CPPCv2 and CPPCv3 support */
+/* CPPC support */
 #define CPPC_V2_REV	2
 #define CPPC_V3_REV	3
+#define CPPC_V4_REV	4
 #define CPPC_V2_NUM_ENT	21
 #define CPPC_V3_NUM_ENT	23
+#define CPPC_V4_NUM_ENT	25
 
 #define PCC_CMD_COMPLETE_MASK	(1 << 0)
 #define PCC_ERROR_MASK		(1 << 2)
 
-#define MAX_CPC_REG_ENT 21
+#define MAX_CPC_REG_ENT 23
 
 /* CPPC specific PCC commands. */
 #define	CMD_READ 0
@@ -60,8 +62,8 @@ struct cpc_reg {
 
 /*
  * Each entry in the CPC table is either
- * of type ACPI_TYPE_BUFFER or
- * ACPI_TYPE_INTEGER.
+ * of type ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER,
+ * or ACPI_TYPE_PACKAGE (for CPPC v4 ResourcePriorityRegisters).
  */
 struct cpc_register_resource {
 	acpi_object_type type;
@@ -69,6 +71,7 @@ struct cpc_register_resource {
 	union {
 		struct cpc_reg reg;
 		u64 int_value;
+		void *pkg_data;
 	} cpc_entry;
 };
 
@@ -109,6 +112,8 @@ enum cppc_regs {
 	REFERENCE_PERF,
 	LOWEST_FREQ,
 	NOMINAL_FREQ,
+	OSPM_NOMINAL_PERF,
+	RESOURCE_PRIO,
 };
 
 /*
-- 
2.43.0

