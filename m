Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07B439337;
	Thu,  9 Jul 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601259; cv=none; b=XCtTqVn38Fl82cjTjWb5pJuWoS6n5WNd6EJ7njMYJseAc1C6iqK5da0Y7ei3lvFyHDo8UxKzlkj2abEqVaRsNdb4HlfqV+8YWGV2jsHhQ7y7MpdyR3V+JkWtFa2XBNnONqWAopA0HvH63nZKmvBEL9fXOIGxgegDV0H1xTVc4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601259; c=relaxed/simple;
	bh=xx+6El9sbU8WOxcazpIGpQBP1XqmY2CzD6O/eaMJE4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEeC/KtgNe5saZsZL8WhX9ftlua3tXf8xaFFhDuBaP4/F8DNbJbZqvfrDMoYh1PUpjxhsMubL+3TT3w73rBI8ytGs9AP6xv1OtEebmtE1Id7L6ZPXTHntqRG+3mi86gOIyuLSJuGo43CSvIR7dX3HDSn6K8O9Jqj+BjbGIihs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFvDJJgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFvDJJgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287461F000E9;
	Thu,  9 Jul 2026 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601257;
	bh=I0SChfDGZY9q05Rl2ktZ4djGuAHJCGa8kizIbVzP9h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFvDJJgf/ceZXbnrfYvAANIyyyCgeaUa6qSFVQJmN2754wIUWNj/+tNE/51OaptN8
	 G2omiCaKjxaGzcf1QM/wBQC4FSList1yHcpMJz/ncwpno4LeVFHlCtUXKWSIB5J5/Q
	 j93ifqVj0GxOpcAFva+Rq13q4EDSYG8RvoDDj/VYioek3hS9qlKDzaEvzs+4W9hpgX
	 8F55yHoPtLf4AM1B65Y6ARqqR8gEozjVE5F8V4FV+WZ1CgaY0/RftY5jNfm/1U31EU
	 ILvdtPSKrF1hxFnbm1C5W+RIgYyHHQ3NqlYF7LLXXkM/lxaO8gJhYO3sYqxmxOpPIH
	 oELVSxcWfbgrw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 08/17] ACPI: processor: idle: Rework first-level _LPI states
 processing
Date: Thu, 09 Jul 2026 14:37:09 +0200
Message-ID: <3703077.iIbC2pHGDl@rafael.j.wysocki>
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

The first-level _LPI states need not be combined with the previous
level and the entry method for them cannot be ACPI_CSTATE_INTEGER, so
process them directly in acpi_processor_get_lpi_info() instead of doing
a special case for them in flatten_lpi_states().

Also bail out if there are no _LPI states at the first level because
that means that there are no _LPI states at all.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 47 +++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e990a43514e6..efd3e76377fa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1068,13 +1068,6 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 
 		flpi = &pr->power.lpi_states[flat_state_cnt];
 
-		if (!prev_level) { /* leaf/processor node */
-			memcpy(flpi, t, sizeof(*t));
-			stash_composite_state(curr_level, flpi);
-			flat_state_cnt++;
-			continue;
-		}
-
 		for (i = 0; i < prev_level->composite_states_size; i++) {
 			p = prev_level->composite_states[i];
 			if (t->index <= p->enable_parent_state &&
@@ -1101,9 +1094,10 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 {
 	struct acpi_lpi_states_array info[2], *prev, *curr;
 	acpi_handle handle = pr->handle;
-	unsigned int state_count;
+	unsigned int state_count = 0;
 	acpi_status status;
-	int ret, i;
+	unsigned int i;
+	int ret;
 
 	/* make sure our architecture has support */
 	ret = acpi_processor_ffh_lpi_probe(pr->id);
@@ -1117,12 +1111,45 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		return -EINVAL;
 
 	curr = &info[0];
+	curr->composite_states_size = 0;
 
 	ret = acpi_processor_evaluate_lpi(handle, curr);
 	if (ret)
 		return ret;
 
-	state_count = flatten_lpi_states(pr, 0, curr, NULL);
+	/* Copy all of the usable first-level states to power.lpi_states[]. */
+	for (i = 0; i < curr->size; i++) {
+		struct acpi_lpi_state *lpi = &curr->entries[i];
+		struct acpi_lpi_state *flpi;
+
+		/*
+		 * Skip states that are not enabled or have an inadequate entry
+		 * method for this level.
+		 */
+		if (!(lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED) ||
+		    lpi->entry_method == ACPI_CSTATE_INTEGER)
+			continue;
+
+		if (state_count >= ACPI_PROCESSOR_MAX_POWER) {
+			acpi_handle_info(handle,
+					 "No space for more _LPI states than %d\n",
+					 ACPI_PROCESSOR_MAX_POWER);
+			break;
+		}
+
+		flpi = &pr->power.lpi_states[state_count++];
+		memcpy(flpi, lpi, sizeof(*lpi));
+		stash_composite_state(curr, flpi);
+	}
+
+	kfree(curr->entries);
+
+	/*
+	 * If there are no _LPI states at the first level, there are no _LPI
+	 * states at all.
+	 */
+	if (!state_count)
+		return -ENODATA;
 
 	prev = curr;
 	curr = &info[1];
-- 
2.51.0




