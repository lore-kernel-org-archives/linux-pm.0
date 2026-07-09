Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0316439337;
	Thu,  9 Jul 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601272; cv=none; b=X4JUyKjil6Xygnidp/j6DoRc6A97Pt8QX3g3QYXYw3wy+ydZAUHBulfDSJofh0Z5WL/CW9qbK9RsHPvymJ5ZAh4NFJKQE/t1i3v8p4Tc3Nz9+U2z8qfCRkJPfn3ivsUeGBfaTHh3qNw3hrRFnhSt2XK3spt78oKIVbZhs/1TCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601272; c=relaxed/simple;
	bh=oGFZSDzfT8inmFJ2z03dxCAa4YK4yHbZnQRFMeNIiDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAYVeDnoVlZu9HT/PZfMj7dKVVhkOdQem14eO1a3jHP31TK4VNGI8z2dOwDKYTVBQiGto55VazxyVWl0t7sz0izgp6M5cKMxYEfmkK3xcfWSwtAv1M37jjyYch9Y+SyvcBxE1d9nAcOAyQ5BC9G1Z9H8A2cb7rCAxnKybTP3AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUDpIf3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUDpIf3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8541F00AC4;
	Thu,  9 Jul 2026 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601270;
	bh=Bvu1pVARNrRdquNNzMQzZTMsYi1sl740x7KIfOlZMPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HUDpIf3qCXq3WSEtooxlezUa9eLVN2OpDT01n+fXcBENyBczngHIaOrch3bkt3OXi
	 ViOvnSWudvA+bY1wIz5UbQ+PLi6iKYqqznpts3Gk79IrtvrETQSNuxzCuANIvu8Bg/
	 iO1HSABhD2f8QLqO0E6guaqQ6lQCoRFbsaH2fkDf6U0dYB44G1aVXPPntnXiN6pSI7
	 2rc0Lpi4l8+cxTirMcPzAKetVZq1xfSIwrHIWsBV/DYQEhLjsdbzuTUDSGHMTa6wkr
	 TYzsVFHAtqAbT2pxC5As02f1s5XHaHPoeibXhAQFISD8f8RoJoYV2khdZS3yeCLlzf
	 cwrZxoCCw7MtA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 04/17] ACPI: processor: idle: Rearrange
 acpi_processor_evaluate_lpi()
Date: Thu, 09 Jul 2026 14:33:41 +0200
Message-ID: <3426078.44csPzL39Z@rafael.j.wysocki>
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

Rearrange acpi_processor_evaluate_lpi() to make it somewhat easier to
follow and diagnose (if need be).  In particular:

 * Rename some local variables and reorder their definitions.

 * Change the type of local variables used for storing firmware-provided
   values to unsigned int (they cannot be negative).

 * Eliminate local variable "loop" that is redundant.

 * Avoid explicit pointer arithmetic.

 * Print the correct number of _LPI state packages in the final debug
   message.

No intentional functional impact beyond debug output.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 64 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e8682f779249..cd506e9e5a84 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -872,12 +872,12 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
 static int acpi_processor_evaluate_lpi(acpi_handle handle,
 				       struct acpi_lpi_states_array *info)
 {
-	acpi_status status;
-	int ret = 0;
-	int pkg_count, state_idx = 1, loop;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *lpi_data;
+	union acpi_object *lpi_data, *lpi_pkg;
+	unsigned int lpi_pkg_count, state_idx;
 	struct acpi_lpi_state *lpi_state;
+	acpi_status status;
+	int ret = 0;
 
 	status = acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -895,41 +895,46 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 		goto end;
 	}
 
-	pkg_count = lpi_data->package.elements[2].integer.value;
+	lpi_pkg_count = lpi_data->package.elements[2].integer.value;
 
 	/* Validate number of power states. */
-	if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
+	if (!lpi_pkg_count || lpi_pkg_count != lpi_data->package.count - 3) {
 		acpi_handle_debug(handle, "Invalid _LPI state count\n");
 		ret = -ENODATA;
 		goto end;
 	}
 
-	lpi_state = kzalloc_objs(*lpi_state, pkg_count);
+	lpi_state = kzalloc_objs(*lpi_state, lpi_pkg_count);
 	if (!lpi_state) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
-	info->size = pkg_count;
+	info->size = lpi_pkg_count;
 	info->entries = lpi_state;
 
-	/* LPI States start at index 3 */
-	for (loop = 3; state_idx <= pkg_count; loop++, state_idx++, lpi_state++) {
-		union acpi_object *element, *pkg_elem, *obj;
+	/* _LPI State packages start at index 3. */
+	lpi_pkg = &lpi_data->package.elements[3];
 
-		element = &lpi_data->package.elements[loop];
-		if (element->type != ACPI_TYPE_PACKAGE || element->package.count < 7)
+	for (state_idx = 1; state_idx <= lpi_pkg_count;
+	     state_idx++, lpi_state++, lpi_pkg++) {
+		union acpi_object *lpi_pkg_elem, *obj;
+
+		lpi_state->index = state_idx;
+
+		if (lpi_pkg->type != ACPI_TYPE_PACKAGE || lpi_pkg->package.count < 7)
 			continue;
 
-		pkg_elem = element->package.elements;
+		lpi_pkg_elem = lpi_pkg->package.elements;
 
-		obj = pkg_elem + 6;
+		/* Get the entry method first and skip the state if that fails. */
+		obj = &lpi_pkg_elem[6];
 		if (obj->type == ACPI_TYPE_BUFFER) {
 			struct acpi_power_register *reg;
 
 			if (obj->buffer.length < sizeof(*reg)) {
 				acpi_handle_debug(handle,
-					"Invalid register data for _LPI state %d\n",
+					"Invalid register data for _LPI state %u\n",
 					state_idx);
 				continue;
 			}
@@ -937,7 +942,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			reg = (struct acpi_power_register *)obj->buffer.pointer;
 			if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
 				acpi_handle_debug(handle,
-					"Unsupported entry method for _LPI state %d\n",
+					"Unsupported entry method for _LPI state %u\n",
 					state_idx);
 				continue;
 			}
@@ -949,36 +954,35 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			lpi_state->address = obj->integer.value;
 		} else {
 			acpi_handle_debug(handle,
-					  "Invalid entry method for _LPI state %d\n",
+					  "Invalid entry method for _LPI state %u\n",
 					  state_idx);
 			continue;
 		}
 
-		lpi_state->index = state_idx;
-		if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residency)) {
+		if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
 			acpi_handle_debug(handle,
-					  "Assuming 10 us min. residency for _LPI state %d\n",
+					  "Assuming 10 us min. residency for _LPI state %u\n",
 					  state_idx);
 			lpi_state->min_residency = 10;
 		}
 
-		if (obj_get_integer(pkg_elem + 1, &lpi_state->wake_latency)) {
+		if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
 			acpi_handle_debug(handle,
-					  "Assuming 10 us wake latency for _LPI state %d\n",
+					  "Assuming 10 us wake latency for _LPI state %u\n",
 					  state_idx);
 			lpi_state->wake_latency = 10;
 		}
 
-		if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
+		if (obj_get_integer(&lpi_pkg_elem[2], &lpi_state->flags))
 			lpi_state->flags = 0;
 
-		if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags))
+		if (obj_get_integer(&lpi_pkg_elem[3], &lpi_state->arch_flags))
 			lpi_state->arch_flags = 0;
 
-		if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_freq))
+		if (obj_get_integer(&lpi_pkg_elem[4], &lpi_state->res_cnt_freq))
 			lpi_state->res_cnt_freq = 1;
 
-		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
+		if (obj_get_integer(&lpi_pkg_elem[5], &lpi_state->enable_parent_state))
 			lpi_state->enable_parent_state = 0;
 
 		/* Skip elements [7-8] i.e. Residency/Usage counters. */
@@ -987,16 +991,16 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 		 * Avoid out-of-bounds access if the size of the package is less
 		 * than expected.
 		 */
-		if (element->package.count < 10)
+		if (lpi_pkg->package.count < 10)
 			continue;
 
-		obj = pkg_elem + 9;
+		obj = &lpi_pkg_elem[9];
 		if (obj->type == ACPI_TYPE_STRING)
 			strscpy(lpi_state->desc, obj->string.pointer,
 				ACPI_CX_DESC_LEN);
 	}
 
-	acpi_handle_debug(handle, "Found %d power states\n", state_idx);
+	acpi_handle_debug(handle, "Found %u power states\n", lpi_pkg_count);
 end:
 	kfree(buffer.pointer);
 	return ret;
-- 
2.51.0




