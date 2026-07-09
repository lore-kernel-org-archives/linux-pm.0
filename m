Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B221C9EA;
	Thu,  9 Jul 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601278; cv=none; b=affKJmQhbOihdiSWbNEuUDZKGwKcYclh/W8M424EbKhfadBuBS/JZCmwgJzSe2AuwYusiG93KGUzQCe8wsxYbTlhGEPTTDIzCTT1tYODn58s/yfMKUlr2umF15M09w7QgLd7FYlrchNt8Jap1VTqKGcyc1kthO4sC0Wn3A9Nl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601278; c=relaxed/simple;
	bh=p//xG4dF10nozG9lWw1MVV5myP4qHb65D7dsKdfkAg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT+91TecPHOktcv475OwwSNKi3xhB8EWfz/2fRw4U7lIOxw/pD5VBz/W+I+YX10eO5Gqc53aCf7b9og6zUXPYvmLsQCf31HVmI3epXc/BQCT8h9wbMUn9mWSlLdHxdIuWkjCLUgRjTBEe+GYjAZnMb1QaHE64TG2/B9wxr1fZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKiJ+lPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKiJ+lPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF3A1F000E9;
	Thu,  9 Jul 2026 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601276;
	bh=+ZkTm+LK83S0+VOfTvR+xKjCkxaP6Wn4EylKTUubACw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKiJ+lPSgzp+xYYZVovzkzs3Lp5Szuk1zpuvMMuL2+Z+UEtvT+bmnbRFrzP3HJbcg
	 FLpBi7qBx+iTVh3tCV0JdzYzSqhQQyTB+p2JtPnzjG4BwhMWwKIlpHTHeYtKx202dC
	 8IY9AH/E31o2U/PpI0rjGrs0stV8SL5AFjsJXSe83D7xPMkziiV+0QRSzKZOBb7HJS
	 4ulk8jCP7dePwMXCDcP2x0lWDnVyOm6N8EH/Y90PRO2FUriebqZfRGq9cDTglvNhg1
	 9JX+OZlj84wK5k8SbH/gdbB8J/jj2Oi/t8qXXrY6tY8Qq1OLY+4SxnpQ5hGIbc+3mg
	 XB8tpH3CqC0qg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 02/17] ACPI: processor: idle: Ignore _LPI states with SYSTEMIO
 entry method
Date: Thu, 09 Jul 2026 14:31:28 +0200
Message-ID: <2268989.irdbgypaU6@rafael.j.wysocki>
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

The only entry method for _LPI states supported by acpi_idle_lpi_enter()
is FFH and it is better to ignore _LPI states with the SYSTEMIO entry
method upfront than return an error from acpi_idle_lpi_enter() on
attempts to use them.

Update acpi_processor_evaluate_lpi() accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d573f201295a..aa6d5d8edc79 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -935,14 +935,15 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			}
 
 			reg = (struct acpi_power_register *)obj->buffer.pointer;
-			if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO &&
-			    reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)
+			if (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
+				acpi_handle_debug(handle,
+					"Unsupported entry method for _LPI state %d\n",
+					state_idx);
 				continue;
+			}
 
+			lpi_state->entry_method = ACPI_CSTATE_FFH;
 			lpi_state->address = reg->address;
-			lpi_state->entry_method =
-				reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE ?
-				ACPI_CSTATE_FFH : ACPI_CSTATE_SYSTEMIO;
 		} else if (obj->type == ACPI_TYPE_INTEGER) {
 			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 			lpi_state->address = obj->integer.value;
-- 
2.51.0




