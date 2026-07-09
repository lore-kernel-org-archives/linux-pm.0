Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD41212D86;
	Thu,  9 Jul 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601269; cv=none; b=t2igsDW3OjSkMci5Vxi47t4QSs3I2h7l6ipoVRardp6q7ZA937BXGivcdlig7zAnkPVu64hic4Z68axsgizWoZlVkOBifSMkS55ir2dIWpTxCBgMFRvq+7gD1z7j3/h7BMC8O36U23id7lHCPtBVSr/kjWkgFORNAdzHt3YlxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601269; c=relaxed/simple;
	bh=WkXSrYGdeeuUKPxTKmj8FcKw4styrTmskte5kRSjjgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhtAlVI5MOMM3ca5GTC1xfNAgvGPTHF1vj3UFdzpb1hn85cN+ME6/9ZMFdVzQ4EnBUVob/jYvCErnGgYeswqlUxGJdA6i91JWAM1VSyPBUxMM8+Zwe9RbvIGgjOAXrAldfiHI6El1jScWM+I4wCY2OxpbhTjWpjdz48F/1ldL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqsTNzxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqsTNzxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9AB1F000E9;
	Thu,  9 Jul 2026 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601267;
	bh=msdSHA5L4lFziX4Q82D7Td1XSl+fxVXOoKnpbGtmKeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqsTNzxiC8H4JUeOVlR2Da3ggVrsabqLlLV52dha6PxK6AD04fwBd8rxDOrBCdCGp
	 WV3c2uWze4KHRMmVRSpxkTjvEvXAYI3FXA/wHUJ5IducawOaehtPPU78fQVKPHgUiL
	 eoanuh2LiBUK/PyfRKeG/gE/wXQ2mpuL0qZelVpAFGcZhVYm0pyceoTITlyoDCUEhQ
	 CMUFPBPyxim6fPMuOxS/XNkMycwbNPMs1EGPEoZBdYXPpeATE4BfQTf0702iLjJD/Q
	 zx4qGdV3kSId+MZ+S3hXyXeKn56Hq3L4vkU1CYBjwnKCtpEdh6Xk9uYCTc2YSKaDaE
	 3WSIHtq8GiFVQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 05/17] ACPI: processor: idle: Split acpi_processor_evaluate_lpi()
Date: Thu, 09 Jul 2026 14:34:36 +0200
Message-ID: <10878273.nUPlyArG6x@rafael.j.wysocki>
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

Move individual _LPI state package processing from
acpi_processor_evaluate_lpi() to a separate new function
called process_lpi_state_package().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 167 +++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index cd506e9e5a84..771a7bd6fb73 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -869,6 +869,90 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
 	return 0;
 }
 
+static void process_lpi_state_package(union acpi_object *lpi_pkg,
+				      struct acpi_lpi_state *lpi_state,
+				      acpi_handle handle,
+				      unsigned int state_idx)
+{
+	union acpi_object *lpi_pkg_elem, *obj;
+
+	if (lpi_pkg->type != ACPI_TYPE_PACKAGE || lpi_pkg->package.count < 7)
+		return;
+
+	lpi_pkg_elem = lpi_pkg->package.elements;
+
+	/* Get the entry method first and skip the state if that fails. */
+	obj = &lpi_pkg_elem[6];
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		struct acpi_power_register *reg;
+
+		if (obj->buffer.length < sizeof(*reg)) {
+			acpi_handle_debug(handle,
+				"Invalid register data for _LPI state %u\n",
+				state_idx);
+			return;
+		}
+
+		reg = (struct acpi_power_register *)obj->buffer.pointer;
+		if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
+			acpi_handle_debug(handle,
+				"Unsupported entry method for _LPI state %u\n",
+				state_idx);
+			return;
+		}
+
+		lpi_state->entry_method = ACPI_CSTATE_FFH;
+		lpi_state->address = reg->address;
+	} else if (obj->type == ACPI_TYPE_INTEGER) {
+		lpi_state->entry_method = ACPI_CSTATE_INTEGER;
+		lpi_state->address = obj->integer.value;
+	} else {
+		acpi_handle_debug(handle,
+				  "Invalid entry method for _LPI state %u\n",
+				  state_idx);
+		return;
+	}
+
+	if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
+		acpi_handle_debug(handle,
+				  "Assuming 10 us min. residency for _LPI state %u\n",
+				  state_idx);
+		lpi_state->min_residency = 10;
+	}
+
+	if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
+		acpi_handle_debug(handle,
+				  "Assuming 10 us wake latency for _LPI state %u\n",
+				  state_idx);
+		lpi_state->wake_latency = 10;
+	}
+
+	if (obj_get_integer(&lpi_pkg_elem[2], &lpi_state->flags))
+		lpi_state->flags = 0;
+
+	if (obj_get_integer(&lpi_pkg_elem[3], &lpi_state->arch_flags))
+		lpi_state->arch_flags = 0;
+
+	if (obj_get_integer(&lpi_pkg_elem[4], &lpi_state->res_cnt_freq))
+		lpi_state->res_cnt_freq = 1;
+
+	if (obj_get_integer(&lpi_pkg_elem[5], &lpi_state->enable_parent_state))
+		lpi_state->enable_parent_state = 0;
+
+	/* Skip elements [7-8] i.e. Residency/Usage counters. */
+
+	/*
+	 * Avoid out-of-bounds access if the size of the package is less than
+	 * expected.
+	 */
+	if (lpi_pkg->package.count < 10)
+		return;
+
+	obj = &lpi_pkg_elem[9];
+	if (obj->type == ACPI_TYPE_STRING)
+		strscpy(lpi_state->desc, obj->string.pointer, ACPI_CX_DESC_LEN);
+}
+
 static int acpi_processor_evaluate_lpi(acpi_handle handle,
 				       struct acpi_lpi_states_array *info)
 {
@@ -916,88 +1000,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 	/* _LPI State packages start at index 3. */
 	lpi_pkg = &lpi_data->package.elements[3];
 
-	for (state_idx = 1; state_idx <= lpi_pkg_count;
-	     state_idx++, lpi_state++, lpi_pkg++) {
-		union acpi_object *lpi_pkg_elem, *obj;
-
+	for (state_idx = 1; state_idx <= lpi_pkg_count; state_idx++) {
 		lpi_state->index = state_idx;
-
-		if (lpi_pkg->type != ACPI_TYPE_PACKAGE || lpi_pkg->package.count < 7)
-			continue;
-
-		lpi_pkg_elem = lpi_pkg->package.elements;
-
-		/* Get the entry method first and skip the state if that fails. */
-		obj = &lpi_pkg_elem[6];
-		if (obj->type == ACPI_TYPE_BUFFER) {
-			struct acpi_power_register *reg;
-
-			if (obj->buffer.length < sizeof(*reg)) {
-				acpi_handle_debug(handle,
-					"Invalid register data for _LPI state %u\n",
-					state_idx);
-				continue;
-			}
-
-			reg = (struct acpi_power_register *)obj->buffer.pointer;
-			if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
-				acpi_handle_debug(handle,
-					"Unsupported entry method for _LPI state %u\n",
-					state_idx);
-				continue;
-			}
-
-			lpi_state->entry_method = ACPI_CSTATE_FFH;
-			lpi_state->address = reg->address;
-		} else if (obj->type == ACPI_TYPE_INTEGER) {
-			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
-			lpi_state->address = obj->integer.value;
-		} else {
-			acpi_handle_debug(handle,
-					  "Invalid entry method for _LPI state %u\n",
-					  state_idx);
-			continue;
-		}
-
-		if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
-			acpi_handle_debug(handle,
-					  "Assuming 10 us min. residency for _LPI state %u\n",
-					  state_idx);
-			lpi_state->min_residency = 10;
-		}
-
-		if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
-			acpi_handle_debug(handle,
-					  "Assuming 10 us wake latency for _LPI state %u\n",
-					  state_idx);
-			lpi_state->wake_latency = 10;
-		}
-
-		if (obj_get_integer(&lpi_pkg_elem[2], &lpi_state->flags))
-			lpi_state->flags = 0;
-
-		if (obj_get_integer(&lpi_pkg_elem[3], &lpi_state->arch_flags))
-			lpi_state->arch_flags = 0;
-
-		if (obj_get_integer(&lpi_pkg_elem[4], &lpi_state->res_cnt_freq))
-			lpi_state->res_cnt_freq = 1;
-
-		if (obj_get_integer(&lpi_pkg_elem[5], &lpi_state->enable_parent_state))
-			lpi_state->enable_parent_state = 0;
-
-		/* Skip elements [7-8] i.e. Residency/Usage counters. */
-
-		/*
-		 * Avoid out-of-bounds access if the size of the package is less
-		 * than expected.
-		 */
-		if (lpi_pkg->package.count < 10)
-			continue;
-
-		obj = &lpi_pkg_elem[9];
-		if (obj->type == ACPI_TYPE_STRING)
-			strscpy(lpi_state->desc, obj->string.pointer,
-				ACPI_CX_DESC_LEN);
+		process_lpi_state_package(lpi_pkg++, lpi_state++, handle, state_idx);
 	}
 
 	acpi_handle_debug(handle, "Found %u power states\n", lpi_pkg_count);
-- 
2.51.0




