Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF8218821;
	Thu,  9 Jul 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601281; cv=none; b=ny/cNskZgNMXHPZMWghA4P0AZErwMs1aplKqcgKqLnabD6F2FcOVRrsgS0/Mxsq/42SgAPs50ZnXCeuMCHrtbV48RpoamO72B0dk7N8wOkI1xp7XFzl5c13AOG84jYGvmE2nQzDvflmz4NiL4YLSHn/VHWZJEYQnvytS2NnAka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601281; c=relaxed/simple;
	bh=yLvn8u3+Pho6lC/wA66btLbm+3NlFsn7HNFa2DmVAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/1cac1IyF7LEauIkLDuBQ9gLKFhKhD65Byzdn+T/Irq9k0eeRLvJCMZvzEXlWihlXZ+wsPNMbJbE32hTLZhG/cQZvD+o0V2cVkcrrUozL1F2HjNoLzoG2BgBBm4blERamMq7JphyxHyQpdy7qMyCV2SYuHdzlXkEdQq5gBNiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF0dML1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF0dML1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0F61F000E9;
	Thu,  9 Jul 2026 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601279;
	bh=FaQIvuYUdzDwZm2nKydrpQRgnD2KtKQYpxGTBXkPaD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XF0dML1O3vWQ/ERcOIm/3w/1NQjvIP9Iw/5iZBs9UVbSPw9WAEvv7+3BKgtcUVkDX
	 lP/3UXTMj6h+/dBlBHv/84VhyXFg9hOGr6j6egwrk8TLOJQEFEjf1AX6mw3yaSl7GR
	 SXiUkm9dmroRWIEYkLvBamjnuSd4BmCLwHOy+u7dEptBuFbGcJxmmH/QEMe1zPm2gA
	 C2uKLrALGZMyRDe++JgEZB571+xyOkmzQ3p5AUxD6CqZiSHW5K8e38qkDi3JTCqrRT
	 +Ax6dwW2/jweD+nbGXMChy7fFfBUqbdeMKoeFKJkaHxqdkrtznw5cLxl4XqnKMPqGn
	 iFcVpzSihgidg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 01/17] ACPI: processor: idle: Expand _LPI package sanity checks
Date: Thu, 09 Jul 2026 14:30:35 +0200
Message-ID: <5084143.GXAFRqVoOG@rafael.j.wysocki>
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

The _LPI package sanity checks in acpi_processor_evaluate_lpi() miss
a couple of things, so expand them by adding a buffer size check
before retrieving a struct acpi_power_register from it (and skip the
given state if the buffer is not large enough to hold a register
structure) and making the function avoid copying the state description
from the ACPI table if there are too few elements in the package
supposed to hold it.

While at it, relocate and rephrase a comment about skipping _LPI state
package elements [7-8].

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4482cf28f56a..d573f201295a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -927,6 +927,13 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 		if (obj->type == ACPI_TYPE_BUFFER) {
 			struct acpi_power_register *reg;
 
+			if (obj->buffer.length < sizeof(*reg)) {
+				acpi_handle_debug(handle,
+					"Invalid register data for _LPI state %d\n",
+					state_idx);
+				continue;
+			}
+
 			reg = (struct acpi_power_register *)obj->buffer.pointer;
 			if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO &&
 			    reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)
@@ -945,13 +952,6 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			continue;
 		}
 
-		/* elements[7,8] skipped for now i.e. Residency/Usage counter*/
-
-		obj = pkg_elem + 9;
-		if (obj->type == ACPI_TYPE_STRING)
-			strscpy(lpi_state->desc, obj->string.pointer,
-				ACPI_CX_DESC_LEN);
-
 		lpi_state->index = state_idx;
 		if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residency)) {
 			pr_debug("No min. residency found, assuming 10 us\n");
@@ -974,6 +974,20 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 
 		if (obj_get_integer(pkg_elem + 5, &lpi_state->enable_parent_state))
 			lpi_state->enable_parent_state = 0;
+
+		/* Skip elements [7-8] i.e. Residency/Usage counters. */
+
+		/*
+		 * Avoid out-of-bounds access if the size of the package is less
+		 * than expected.
+		 */
+		if (element->package.count < 10)
+			continue;
+
+		obj = pkg_elem + 9;
+		if (obj->type == ACPI_TYPE_STRING)
+			strscpy(lpi_state->desc, obj->string.pointer,
+				ACPI_CX_DESC_LEN);
 	}
 
 	acpi_handle_debug(handle, "Found %d power states\n", state_idx);
-- 
2.51.0




