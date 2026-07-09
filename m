Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1E1D7E5C;
	Thu,  9 Jul 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601247; cv=none; b=Z43HWGSO/KZ4r7p8RCB/PbH8UhsGcnWIXBnqB59RGBmQQjbnrtx2Q+GcM0FV/mAewHozqjfalAQ2Av+fE7GE2PRDaYNUZKarXwi8dszqIz8Axo6HICVkI0yeEluzRZxcaRnlz0OkaXGtpUUhhBnwyLtk+Op/dIKJt5Gx5RuVeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601247; c=relaxed/simple;
	bh=VmHsVFjJrODjXNQL9HHxTuSU7TMa/TIfPLEN4yLLwmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vas5xbM9qDhoTP1cR8PKzvv4aG347mj8KEaDniawBFohEmeB71/gJDgRg1MMVdrtHvEzemeHZGu6k++m5hHXz6Md+SZaSNqd/aBBdyaAWciRbdGECxwpKxsHiOOSEecNdCbgx23CBFtutL6ixWluc2BNbaXUmqIz+wEVS7VGsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e++WpRKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e++WpRKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67CB1F000E9;
	Thu,  9 Jul 2026 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601245;
	bh=fO3r8FbwiC5cIKsm9fUYiNV7b7Yd7Wok2c04psPuBV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e++WpRKBkRPmwoQx2c9iqCEDDGI2qIuwaBTSDcTm7aHfLQ8ioDgN970L9mhjMAQBC
	 cW0mztlkurKDpahfd6B7ivR7G8yMivp4xJ1xFfBHn+Y8w/7dP9wgPHzsLO0kYBt7zO
	 K5WXiP50uFmY5K4S2n5zKSgMmqrPS6FxkLfVNDMO646UUJ+M2lGeQZjbFQWcz3LBBE
	 Ob54wvg5LLsTd4FIT+4oSYWBtZK3UIDgCc555KnED3hIjvx49qCjJb5aMf16Zg69/2
	 wnkD7ab90aBwSuOPi3PeHyk5Rtdj1VwqSU5ngd27U/KJBFSWwAyXWkGhBkNQy1d43P
	 Qk63nEcLZCtxg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 12/17] ACPI: processor: idle: Introduce too_many_states() for _LPI
Date: Thu, 09 Jul 2026 14:39:49 +0200
Message-ID: <1964818.CQOukoFCf9@rafael.j.wysocki>
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

To reduce code duplication, introduce a function called too_many_states()
that will check if the total number of _LPI states for a given CPU is
too large and print a message in that case.

Use that function in flatten_lpi_states() and acpi_processor_get_lpi_info().

No functional impact beyond reducing dynamic debug flexibility.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index edc9b5d88b79..c7f206c094fb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1044,6 +1044,16 @@ static void stash_composite_state(struct acpi_lpi_states_array *curr_level,
 	curr_level->composite_states[curr_level->composite_states_size++] = t;
 }
 
+static bool too_many_states(acpi_handle handle, unsigned int state_count)
+{
+	if (state_count < ACPI_PROCESSOR_MAX_POWER)
+		return false;
+
+	acpi_handle_info(handle, "No space for more _LPI states than %d\n",
+			 ACPI_PROCESSOR_MAX_POWER);
+	return true;
+}
+
 static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 				       unsigned int state_count,
 				       struct acpi_lpi_states_array *curr,
@@ -1064,12 +1074,8 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 		if (!(parent_lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
 			continue;
 
-		if (state_count >= ACPI_PROCESSOR_MAX_POWER) {
-			acpi_handle_info(pr->handle,
-					 "No space for more _LPI states than %d\n",
-					 ACPI_PROCESSOR_MAX_POWER);
+		if (too_many_states(pr->handle, state_count))
 			break;
-		}
 
 		flpi = &pr->power.lpi_states[state_count];
 
@@ -1135,12 +1141,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		    lpi->entry_method == ACPI_CSTATE_INTEGER)
 			continue;
 
-		if (state_count >= ACPI_PROCESSOR_MAX_POWER) {
-			acpi_handle_info(handle,
-					 "No space for more _LPI states than %d\n",
-					 ACPI_PROCESSOR_MAX_POWER);
+		if (too_many_states(pr->handle, state_count))
 			break;
-		}
 
 		flpi = &pr->power.lpi_states[state_count++];
 		memcpy(flpi, lpi, sizeof(*lpi));
-- 
2.51.0




