Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AB1D63F3;
	Thu,  9 Jul 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601244; cv=none; b=XTys5y9Od2swMpaI/xVwWBsZ35PDcYDhunHOussDvuy+ToQNRTFj6UINADr7vw2TAj2BW116IijMcxalAEwaJAbGPFkEHZAIGpKyIxnJHhmKeTgAnVVBNN810gnVoIlei13b9Ce+NF1FNLr9L+HIs4gD3R4b1zMf4Uy32Y0Y1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601244; c=relaxed/simple;
	bh=R9aRLgRUt4Ogow1zw4JCucTkGGr76dKgYlFL7uhdpOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK7gmoxbyg3gbxNir94ecy97W7+PuIiUQOS4TIYFtAw259JKAzUOpUFYygeXylKGDP6jCuJo58yP84AAO5ISJGT29YFDJ0YitqHdRqiiCkFtEwJq+HkdQKrRPI+sDeGsfzq1HsECT1Ra1DISiERemNSzVEOR1BECZ4HB8Ya1MXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5+/71sw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5+/71sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAFA1F000E9;
	Thu,  9 Jul 2026 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601242;
	bh=vKpJgDuEIJ59UH5t5IP++T0dEoLRPg8iTTbxbu2vxqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5+/71swyos7CTqIk7nZWeyyFx1Cg73jVCwtwWhOoL1JYP412xMUF2L4dVYIhdWj/
	 0xrCIqTJdSTgi3cJVu4TJLIpVja6tVT3UZb3fbATgZzEzh3GAJjSG7XqbV0OOWiqhA
	 Wvtzd/XiTMK32LynnCEvm9ODDsYhxQZDOXpZEPQL5REdBhfrX+BnDDFFgwKdgZ5oDa
	 d2sAJC4klLNE65dAxky96qUwVsz6Lz0l4+0A6X4I+rMw2YcSTgJu7PlJiZg8T+GbwB
	 W9X7CLUA2TW+kBhD9E8JbyDC94Rg2gYqBgjiKcVZ3No++uGhkvKkNb24Gu3KTnlZ1k
	 hCZS2xVA6l/Pg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 13/17] ACPI: processor: idle: Introduce
 acpi_processor_extract_lpi_info()
Date: Thu, 09 Jul 2026 14:40:35 +0200
Message-ID: <2709187.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4746278.LvFx2qVVIh@rafael.j.wysocki>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In preparation for adding ACPI _LPI support to the intel_idle driver,
move the majority of the acpi_processor_get_lpi_info() function body
to a new function called acpi_processor_extract_lpi_info() that will
be exported to external code subsequently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 44 +++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index c7f206c094fb..2c6c9a7365fb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1054,7 +1054,8 @@ static bool too_many_states(acpi_handle handle, unsigned int state_count)
 	return true;
 }
 
-static unsigned int flatten_lpi_states(struct acpi_processor *pr,
+static unsigned int flatten_lpi_states(acpi_handle handle,
+				       struct acpi_lpi_state *lpi_states,
 				       unsigned int state_count,
 				       struct acpi_lpi_states_array *curr,
 				       struct acpi_lpi_states_array *prev)
@@ -1074,10 +1075,10 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 		if (!(parent_lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
 			continue;
 
-		if (too_many_states(pr->handle, state_count))
+		if (too_many_states(handle, state_count))
 			break;
 
-		flpi = &pr->power.lpi_states[state_count];
+		flpi = &lpi_states[state_count];
 
 		for (i = 0; i < prev->composite_states_size; i++) {
 			struct acpi_lpi_state *local_lpi = prev->composite_states[i];
@@ -1105,19 +1106,15 @@ int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
 	return -EOPNOTSUPP;
 }
 
-static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
+static int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
+					   struct acpi_processor_power *pr_power)
 {
 	struct acpi_lpi_states_array info[2], *prev, *curr;
-	acpi_handle handle = pr->handle;
+	acpi_handle handle = pr_handle;
 	unsigned int state_count = 0;
 	unsigned int i;
 	int ret;
 
-	/* make sure our architecture has support */
-	ret = acpi_processor_ffh_lpi_probe(pr->id);
-	if (ret == -EOPNOTSUPP)
-		return ret;
-
 	if (!osc_pc_lpi_support_confirmed)
 		return -EOPNOTSUPP;
 
@@ -1141,10 +1138,10 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		    lpi->entry_method == ACPI_CSTATE_INTEGER)
 			continue;
 
-		if (too_many_states(pr->handle, state_count))
+		if (too_many_states(pr_handle, state_count))
 			break;
 
-		flpi = &pr->power.lpi_states[state_count++];
+		flpi = &pr_power->lpi_states[state_count++];
 		memcpy(flpi, lpi, sizeof(*lpi));
 		stash_composite_state(curr, flpi);
 	}
@@ -1182,7 +1179,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 			break;
 
 		/* flatten all the LPI states in this level of hierarchy */
-		state_count = flatten_lpi_states(pr, state_count, curr, prev);
+		state_count = flatten_lpi_states(pr_handle, pr_power->lpi_states,
+						 state_count, curr, prev);
 
 		kfree(curr->entries);
 
@@ -1191,9 +1189,25 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 
 	/* reset the index after flattening */
 	for (i = 0; i < state_count; i++)
-		pr->power.lpi_states[i].index = i;
+		pr_power->lpi_states[i].index = i;
 
-	pr->power.count = state_count;
+	pr_power->count = state_count;
+
+	return 0;
+}
+
+static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
+{
+	int ret;
+
+	/* make sure our architecture has support */
+	ret = acpi_processor_ffh_lpi_probe(pr->id);
+	if (ret == -EOPNOTSUPP)
+		return ret;
+
+	ret = acpi_processor_extract_lpi_info(pr->handle, &pr->power);
+	if (ret)
+		return ret;
 
 	/* Tell driver that _LPI is supported. */
 	pr->flags.has_lpi = 1;
-- 
2.51.0




