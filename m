Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70601439337;
	Thu,  9 Jul 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601265; cv=none; b=pGBsZX+S4vmeb46ki5lyOriK3VZ48BU1B2balw2p+laHMGUzN1eAeIeh3I0cbao43ri1MRJTqpJDwu8Ka97CM6Ym9Xp4oOHVEWenb2SrQAVQ4TK1B5VgDyklXpuntuKMvgjpvh+BXjMgTXRaCTjlfgt7mTbFz6/V8mBDhS6KPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601265; c=relaxed/simple;
	bh=4kCn4ruPZtRd5OHhWbINqTVDDGnY760WENs5SUPlfxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUHfgldtMwBz3K4tMtRRCNiQnDudEvhL1u4JE/wIE9amSe1VOHXpJ1t8eX+QYA56Z+BfWd3/dXpZShO7pYrfXd2KPzmgmROjD6uuxm4XW+bFZ2uknk9ErA3VsmRKlCUc9rUTlLLKZn0/3MJmWR4MwfEHYTb1tr34GbXIgxewOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGDNpm8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGDNpm8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DD01F000E9;
	Thu,  9 Jul 2026 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601264;
	bh=VxRofvxpVCgZxWMRX34G1/bWPDVZNzOrPcPLU9+ALZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGDNpm8hzxnWKVTj5MZ7xMpUTlxk3Nluz3V8Stdr6uyyYnjIkHDESsOSpxwxEes5z
	 knWpGLXDUb2ESqh8xvwrfhPwwO9fPhBW2uyw8O4g4G5SDhX0ADgGMd2kwTg1XTRgxF
	 vdM5UHZGmjgiDNUh52WdWN2uDmwyzfAC1Yeb7Fq0YW7uF/BfesPj7bmFCZAIJLyBIM
	 XZ1Ml7VzwinH0XQBY3GjeUdPPwIGD94m8Rtn6dcL+RYrqIcBV/OQnqRoyCmcDS/+ZS
	 hyYHWVEhs/C6TBbn6QGVdAJRnRBFjRFv8eJvXE8zYG7OcskH1rleJzuNR0X8Za2BCW
	 wiZiI7ajx+DKg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [PATCH v1 06/17] ACPI: processor: idle: Introduce lpi_state_debug()
Date: Thu, 09 Jul 2026 14:35:14 +0200
Message-ID: <2043393.PYKUYFuaPT@rafael.j.wysocki>
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

Add a helper macro called lpi_state_debug() for printing debug messages
regarding _LPI states and use it in acpi_processor_evaluate_lpi().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 771a7bd6fb73..f2ebd99a2895 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -869,6 +869,9 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
 	return 0;
 }
 
+#define lpi_state_debug(handle, message, state_idx)	\
+	acpi_handle_debug(handle, message " for _LPI state %u\n", state_idx)
+
 static void process_lpi_state_package(union acpi_object *lpi_pkg,
 				      struct acpi_lpi_state *lpi_state,
 				      acpi_handle handle,
@@ -887,17 +890,13 @@ static void process_lpi_state_package(union acpi_object *lpi_pkg,
 		struct acpi_power_register *reg;
 
 		if (obj->buffer.length < sizeof(*reg)) {
-			acpi_handle_debug(handle,
-				"Invalid register data for _LPI state %u\n",
-				state_idx);
+			lpi_state_debug(handle, "Invalid register data", state_idx);
 			return;
 		}
 
 		reg = (struct acpi_power_register *)obj->buffer.pointer;
 		if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
-			acpi_handle_debug(handle,
-				"Unsupported entry method for _LPI state %u\n",
-				state_idx);
+			lpi_state_debug(handle, "Unsupported entry method", state_idx);
 			return;
 		}
 
@@ -907,23 +906,17 @@ static void process_lpi_state_package(union acpi_object *lpi_pkg,
 		lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 		lpi_state->address = obj->integer.value;
 	} else {
-		acpi_handle_debug(handle,
-				  "Invalid entry method for _LPI state %u\n",
-				  state_idx);
+		lpi_state_debug(handle, "Invalid entry method", state_idx);
 		return;
 	}
 
 	if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
-		acpi_handle_debug(handle,
-				  "Assuming 10 us min. residency for _LPI state %u\n",
-				  state_idx);
+		lpi_state_debug(handle, "Assuming 10 us min. residency", state_idx);
 		lpi_state->min_residency = 10;
 	}
 
 	if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
-		acpi_handle_debug(handle,
-				  "Assuming 10 us wake latency for _LPI state %u\n",
-				  state_idx);
+		lpi_state_debug(handle, "Assuming 10 us wake latency", state_idx);
 		lpi_state->wake_latency = 10;
 	}
 
-- 
2.51.0




