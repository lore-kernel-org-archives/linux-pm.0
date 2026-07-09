Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB45439337;
	Thu,  9 Jul 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601262; cv=none; b=DfLEdZ24b7ZmtWPUBUzUaQSnKQ21ecwUYh8lubfm/KJh09LF3Neu6i8A//VikqIzu03hO+pC82y6I4gAiACweyiTuJ517twqTM6M3YA8qRViQpLj4n3AY/5zdwivjst0NQ03I80+6cScaTKwKa1/ADO3/1kBG3OzR8fawXc45LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601262; c=relaxed/simple;
	bh=Ale8nTLX1erKGX+GH2R36GX7HZ249q/gnyYyJ1e7aBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAH+2992+YZbaen38Y3StgktQ1aOXipIbEKXahWGeDO6fK+aVV5WjxvTncUn/E0hrYD8URMnLaULaSr96LZsUMykT6SR88qd82CwKArCLs1OVBbc8RogxRM3Gj70xCwIyC2FFecYSUglENfhXwvFJb4OUDK0WzZpvB5sTjlhNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR1LLAAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR1LLAAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3B11F000E9;
	Thu,  9 Jul 2026 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601261;
	bh=QWklBBjtaQUFuuSSC8z3j+NBjeP7ZRFP40XauPOEDjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MR1LLAAmwwgOzfrX688RsPTl0tcFTRyY4spEvUj8Y7sqR2VxLJWFmF2DKjxYDSkxX
	 efKVF64ja3UcKDVB213EdoJk8OpYgYSVo10JD0+hUlpTHcuIdCe8sJvrxzfnQXn36z
	 wGys4CwcrCVvrqamaeVE4G8abY/rZHC1rIcjvmh8qJFYgc31XtGtqVYIkNoAW45OLw
	 hjLi5RLxZnuTgq8YTVevn5NXzRQ+Lkes8UhuzleAF2h5RAL9F+crZ/CUTICuI3FgxO
	 U2aQzv/dNTo7aGmI/AZ/N9zYomtI7v1a4lTzF/wCp592s7wdL63bafgL8NJ0Agh2zZ
	 onUvVOWZcUE9w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 07/17] ACPI: processor: idle: Rearrange
 acpi_processor_get_lpi_info()
Date: Thu, 09 Jul 2026 14:36:28 +0200
Message-ID: <7965163.EvYhyI6sBW@rafael.j.wysocki>
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

Reorder the definitions of local variables in
acpi_processor_get_lpi_info() and drop local variable
pr_ahandle that is not really necessary from it.

Additionally, move two definitions of local variables to
the loop in which they are used and rearrange the code
slightly to prepare it for subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f2ebd99a2895..e990a43514e6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1099,12 +1099,11 @@ int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
 
 static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 {
-	int ret, i;
-	acpi_status status;
-	acpi_handle handle = pr->handle, pr_ahandle;
-	struct acpi_device *d = NULL;
-	struct acpi_lpi_states_array info[2], *tmp, *prev, *curr;
+	struct acpi_lpi_states_array info[2], *prev, *curr;
+	acpi_handle handle = pr->handle;
 	unsigned int state_count;
+	acpi_status status;
+	int ret, i;
 
 	/* make sure our architecture has support */
 	ret = acpi_processor_ffh_lpi_probe(pr->id);
@@ -1117,22 +1116,26 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	if (!acpi_has_method(handle, "_LPI"))
 		return -EINVAL;
 
-	prev = &info[0];
-	curr = &info[1];
-	handle = pr->handle;
-	ret = acpi_processor_evaluate_lpi(handle, prev);
+	curr = &info[0];
+
+	ret = acpi_processor_evaluate_lpi(handle, curr);
 	if (ret)
 		return ret;
-	state_count = flatten_lpi_states(pr, 0, prev, NULL);
 
-	status = acpi_get_parent(handle, &pr_ahandle);
+	state_count = flatten_lpi_states(pr, 0, curr, NULL);
+
+	prev = curr;
+	curr = &info[1];
+
+	status = acpi_get_parent(handle, &handle);
 	while (ACPI_SUCCESS(status)) {
-		d = acpi_fetch_acpi_dev(pr_ahandle);
+		struct acpi_lpi_states_array *tmp;
+		struct acpi_device *d;
+
+		d = acpi_fetch_acpi_dev(handle);
 		if (!d)
 			break;
 
-		handle = pr_ahandle;
-
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
 			break;
 
@@ -1149,7 +1152,7 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 
 		tmp = prev, prev = curr, curr = tmp;
 
-		status = acpi_get_parent(handle, &pr_ahandle);
+		status = acpi_get_parent(handle, &handle);
 	}
 
 	/* reset the index after flattening */
-- 
2.51.0




