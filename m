Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DC439337;
	Thu,  9 Jul 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601238; cv=none; b=m3WpPXHJgEOByFLNyFiYtptLHMPFmRucnDApclPGa6g6PoNoAO08ajITohHC8G8U9ih9Pf2KpBqgLSbdaRki8A4kKROU6haBX2lVcXeoj5KW1Yol1NojpkKKU03gMcOc+x2hRiyxYKFwNqcaQecN0GQPEGUSobNkgIW8IWdB9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601238; c=relaxed/simple;
	bh=2tJBrTjLBvM2nO4NtthbxBwVxtAAU2s8dDDn5k5I/bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsTYr0K5DptMUhVX1vm7owKGNgKyxB1Llhi/PiJHEd/S9FowrqqCOBHDdGE7xltpVws2sH7/nAzUrXPUG3m4hPXgW95FQv3PHcEK/i7NjnokSewY+AxQ65/rm8S5lSigP6aeNvxrM9jMe786Cy8Fr0WRjXfaYeV8pZYVTjAqiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8gHBfCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8gHBfCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FACB1F000E9;
	Thu,  9 Jul 2026 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601236;
	bh=hRa3RsXlryJz8g3FCZDlcIxUYj6pKYjD5YZ0UrWx4I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8gHBfCHT3DqpGYxTOSCHlEzb1lr3BzsjBfp/rIQGYrFVHqzz9D11tG9PoF78ZxTd
	 b8Doj187Ncy2GtR5bFDHNx+8UV6rhUzOSSS51BMGM65+iQTwtlLAnNcRAumKvAa1Ru
	 wLC1Bh34kmp2sbzlWWRqUrqvVMVH53i0YI4hAZYZ1kv+gbxWX1gagaKn3vp4etC/Ws
	 BF58ELyYwK2XOOQraXNC0YYPO6V6SOcoIMH7sPfKIy1+cdi3uraLMkUemsZt/ncdUg
	 iT0yRe/Mrf1viiwOFLy2fNZaY4IhQ1tgZAYuE3c7718n9nUX8K/9heI8xbNhz/s8Ay
	 tKtZg9xiQ+plg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 15/17] ACPI: processor: idle: Add switch for strict _LPI processing
Date: Thu, 09 Jul 2026 14:42:33 +0200
Message-ID: <3896986.MHq7AAxBmi@rafael.j.wysocki>
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

Add a "strict" argument to acpi_processor_extract_lpi_info() that, when
set, will cause it to ignore _LPI states without minimum residency or
wake latency instead of assuming 10 us values for these parameters.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_processor.c | 25 +++++++++++++++++++------
 drivers/acpi/processor_idle.c |  2 +-
 include/linux/acpi.h          |  6 ++++--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index cdba1aee84e9..5fbab54171b7 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -1018,7 +1018,7 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
 static void process_lpi_state_package(union acpi_object *lpi_pkg,
 				      struct acpi_lpi_state *lpi_state,
 				      acpi_handle handle,
-				      unsigned int state_idx)
+				      unsigned int state_idx, bool strict)
 {
 	union acpi_object *lpi_pkg_elem, *obj;
 
@@ -1054,11 +1054,21 @@ static void process_lpi_state_package(union acpi_object *lpi_pkg,
 	}
 
 	if (obj_get_integer(&lpi_pkg_elem[0], &lpi_state->min_residency)) {
+		if (strict) {
+			lpi_state_debug(handle, "No min. residency", state_idx);
+			return;
+		}
+
 		lpi_state_debug(handle, "Assuming 10 us min. residency", state_idx);
 		lpi_state->min_residency = 10;
 	}
 
 	if (obj_get_integer(&lpi_pkg_elem[1], &lpi_state->wake_latency)) {
+		if (strict) {
+			lpi_state_debug(handle, "No wake latency", state_idx);
+			return;
+		}
+
 		lpi_state_debug(handle, "Assuming 10 us wake latency", state_idx);
 		lpi_state->wake_latency = 10;
 	}
@@ -1090,7 +1100,8 @@ static void process_lpi_state_package(union acpi_object *lpi_pkg,
 }
 
 static int acpi_processor_evaluate_lpi(acpi_handle handle,
-				       struct acpi_lpi_states_array *info)
+				       struct acpi_lpi_states_array *info,
+				       bool strict)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *lpi_data, *lpi_pkg;
@@ -1138,7 +1149,8 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 
 	for (state_idx = 1; state_idx <= lpi_pkg_count; state_idx++) {
 		lpi_state->index = state_idx;
-		process_lpi_state_package(lpi_pkg++, lpi_state++, handle, state_idx);
+		process_lpi_state_package(lpi_pkg++, lpi_state++, handle,
+					  state_idx, strict);
 	}
 
 	acpi_handle_debug(handle, "Found %u power states\n", lpi_pkg_count);
@@ -1245,7 +1257,8 @@ static unsigned int flatten_lpi_states(acpi_handle handle,
 }
 
 int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
-				    struct acpi_processor_power *pr_power)
+				    struct acpi_processor_power *pr_power,
+				    bool strict)
 {
 	struct acpi_lpi_states_array info[2], *prev, *curr;
 	acpi_handle handle = pr_handle;
@@ -1259,7 +1272,7 @@ int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
 	curr = &info[0];
 	curr->composite_states_size = 0;
 
-	ret = acpi_processor_evaluate_lpi(handle, curr);
+	ret = acpi_processor_evaluate_lpi(handle, curr, strict);
 	if (ret)
 		return ret;
 
@@ -1312,7 +1325,7 @@ int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
 
 		curr->composite_states_size = 0;
 
-		ret = acpi_processor_evaluate_lpi(handle, curr);
+		ret = acpi_processor_evaluate_lpi(handle, curr, strict);
 		if (ret)
 			break;
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 44a52148bc25..e113bcbbb882 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -867,7 +867,7 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	if (ret == -EOPNOTSUPP)
 		return ret;
 
-	ret = acpi_processor_extract_lpi_info(pr->handle, &pr->power);
+	ret = acpi_processor_extract_lpi_info(pr->handle, &pr->power, false);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1d3ea92a2344..9e418b23373c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -317,10 +317,12 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
 int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
-				    struct acpi_processor_power *pr_power);
+				    struct acpi_processor_power *pr_power,
+				    bool strict);
 #else
 static inline int acpi_processor_extract_lpi_info(acpi_handle pr_handle,
-				    struct acpi_processor_power *pr_power)
+				    struct acpi_processor_power *pr_power,
+				    bool strict)
 {
 	return -ENODEV;
 }
-- 
2.51.0




