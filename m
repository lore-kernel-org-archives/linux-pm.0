Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FF439337;
	Thu,  9 Jul 2026 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601250; cv=none; b=qgldKuSki8WOVOMMHHOh2C2FoSSpUhqLDC6Zud1LVqVESNBoZgvSXVigjBVZGq5NYIH7peEJkjAEn6+BfH2eJRIL3aApXh93N1qYweKwXF+mWUpJ5Ru32ypECIh5WNvDCeaPtoTlSHl8NyrZYjUln2Tp/zirT5L8gdgBHpg8NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601250; c=relaxed/simple;
	bh=ikQR0A6tVwTb6uimoOyivBFSDknBdQX0LjZk4WtcrvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXr7BQ6H/xhYpc+8Mh6lntr+bjAbim00pPayio6g5JKy3r2wPYz6/mr9d9Tg3Wr8jn5atmY2TKfu0s7VtBuLHUhMVB1mL+F20K3L4LjSvGd125ytc0mQLbbwLuiVbkD+cp4qeLZ/uf3DseqFtt+G2fDiBwYijxTXVjF75BQSRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRNqH8ya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRNqH8ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED661F000E9;
	Thu,  9 Jul 2026 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601248;
	bh=ypeneKON+UASlBGKcE9KY2TNCPgyE9mzWzCaPGJi6Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRNqH8ya78KlqAH7kD3uCE5qq9O+quQegEKVubSuqIDwKS6RzD8MABfX40dtKPgLl
	 EaiAW/cougLoDBKaeOtj1JMcf7kbo6vMi5gjOvpyxwdwNtyxbxiLQyjv7+cnZUKMfD
	 7bcrC/AuEsIOQlmHA003Ae1/xiBzVJhzydQnIXnbDpxm0uQEj5Lc6TGJFzZSgOL5ht
	 jLAF/1KOYNnxj1/iALMPRrhfnWi1sRy6nJZf2NLPJZ7n/DDGHW9mwcxNDSWKGI+BpX
	 z4SZFGJgH6++vO99i5KroyKgpsFE1HWTKoYLxXiWDC5NA7KkZ4oxCsyVfxAHFBB5qI
	 1KrnUdDJ2Xeng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [PATCH v1 11/17] ACPI: processor: idle: Rework flatten_lpi_states()
Date: Thu, 09 Jul 2026 14:39:06 +0200
Message-ID: <2064627.usQuhbGJ8B@rafael.j.wysocki>
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

Rewrite flatten_lpi_states() to make it easier to follow:

 * Rename its flat_state_cnt, curr_level and prev_level parameters to
   state_count, curr, and prev, respectively, so their names match the
   names of analogous variables in acpi_processor_get_lpi_info().

 * Eliminate a redundant local variable state_count.

 * Move definitions of local variables to the code blocks in which
   they are used.

 * Reduce the indentation level in the inner loop.

 * Use more meaningful names for local variables.

 * Move two statements that belong in acpi_processor_get_lpi_info()
   from flatten_lpi_states() to that function.

 * Use acpi_handle_info() for printing a message when the count of
   flattened states gets too large and drop the message requesting
   ACPI_PROCESSOR_MAX_POWER to be adjusted which is pointless.

 * Add a comment explaining what happens in that function.

No intentional functional impact beyond the message printed when
the count of flattened states is too large.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 65 +++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 57a0a8aaa42f..edc9b5d88b79 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1045,44 +1045,53 @@ static void stash_composite_state(struct acpi_lpi_states_array *curr_level,
 }
 
 static unsigned int flatten_lpi_states(struct acpi_processor *pr,
-				       unsigned int flat_state_cnt,
-				       struct acpi_lpi_states_array *curr_level,
-				       struct acpi_lpi_states_array *prev_level)
+				       unsigned int state_count,
+				       struct acpi_lpi_states_array *curr,
+				       struct acpi_lpi_states_array *prev)
 {
-	int i, j, state_count = curr_level->size;
-	struct acpi_lpi_state *p, *t = curr_level->entries;
+	struct acpi_lpi_state *parent_lpi = curr->entries;
+	unsigned int j;
 
-	curr_level->composite_states_size = 0;
-	for (j = 0; j < state_count; j++, t++) {
+	/*
+	 * Combine each of the "raw" _LPI states from the current (processor
+	 * container) level with all of the composite _LPI states from the
+	 * previous (processor or processor container) level.
+	 */
+	for (j = 0; j < curr->size; j++, parent_lpi++) {
 		struct acpi_lpi_state *flpi;
+		int i;
 
-		if (!(t->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
+		if (!(parent_lpi->flags & ACPI_LPI_STATE_FLAGS_ENABLED))
 			continue;
 
-		if (flat_state_cnt >= ACPI_PROCESSOR_MAX_POWER) {
-			pr_warn("Limiting number of LPI states to max (%d)\n",
-				ACPI_PROCESSOR_MAX_POWER);
-			pr_warn("Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
+		if (state_count >= ACPI_PROCESSOR_MAX_POWER) {
+			acpi_handle_info(pr->handle,
+					 "No space for more _LPI states than %d\n",
+					 ACPI_PROCESSOR_MAX_POWER);
 			break;
 		}
 
-		flpi = &pr->power.lpi_states[flat_state_cnt];
-
-		for (i = 0; i < prev_level->composite_states_size; i++) {
-			p = prev_level->composite_states[i];
-			if (t->index <= p->enable_parent_state &&
-			    combine_lpi_states(p, t, flpi)) {
-				stash_composite_state(curr_level, flpi);
-				flat_state_cnt++;
-				flpi++;
-				if (flat_state_cnt >= ACPI_PROCESSOR_MAX_POWER)
-					break;
-			}
+		flpi = &pr->power.lpi_states[state_count];
+
+		for (i = 0; i < prev->composite_states_size; i++) {
+			struct acpi_lpi_state *local_lpi = prev->composite_states[i];
+
+			if (parent_lpi->index > local_lpi->enable_parent_state)
+				continue;
+
+			if (!combine_lpi_states(local_lpi, parent_lpi, flpi))
+				continue;
+
+			stash_composite_state(curr, flpi);
+			state_count++;
+			flpi++;
+
+			if (state_count >= ACPI_PROCESSOR_MAX_POWER)
+				break;
 		}
 	}
 
-	kfree(curr_level->entries);
-	return flat_state_cnt;
+	return state_count;
 }
 
 int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
@@ -1164,6 +1173,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
 			break;
 
+		curr->composite_states_size = 0;
+
 		ret = acpi_processor_evaluate_lpi(handle, curr);
 		if (ret)
 			break;
@@ -1171,6 +1182,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		/* flatten all the LPI states in this level of hierarchy */
 		state_count = flatten_lpi_states(pr, state_count, curr, prev);
 
+		kfree(curr->entries);
+
 		tmp = prev, prev = curr, curr = tmp;
 	}
 
-- 
2.51.0




