Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2F221275;
	Thu,  9 Jul 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601275; cv=none; b=dlUw5IyRqwnPRwaNP0QVZJZIUK3mIQz6xxh5u8OgaSQSrylWlzbXPskQqRVd7dnSEGHABaP55rFrTsdz/KeFrPZaLPsq9ZL4LOcOH1y0A5Y3Ns3pPbd/AxREHteeR3ydlPZOAzi9VzatHNHBWCReieBwBqcbXDrWkP6dBHnaCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601275; c=relaxed/simple;
	bh=J4s9A0HMclqt+nuDsHaVsI5jhaR3tgigwgiNmTSpOgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvwFl/hDBQNyEYgZU/XqLRV5QOmbdSmb/XbX+URJWkr31Q9YAJQvGbJbuEJlhGTVXKnuLUVBuE6kHs7Bn3zEAh/ZhlxEpjyzyklyPWj7l9l3mk+PzAdWAVZonZ6ZSL2plsaAs0Hj7/vHNfLAwQrElx7u4YHmhel1cKWdgG4LOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsVDEmNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsVDEmNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223511F000E9;
	Thu,  9 Jul 2026 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601273;
	bh=GK/hqPme3o1MIbAc3Xq84kbAQmmWsXDnqxrI/2ftNY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsVDEmNckYKNN8o6hXU4HiC6PfBdBgyI5+nfUemzY7QCIwprD3htDLjsD7rhdBwlp
	 zohO21a+U83BhKWIAyQ0ZXVIZZ1/wR+riSuphkmJ+vhCziRZk5c/ggHbhdnQU/tWAL
	 X4p4DwpvcetfMFjp9GdZUpD4YsQF0gbdLevnZPrH8xO5UMpnpebNVPHMZcSgMW2S+r
	 +FEfxCl3zbL2ky48ZYh6Unt2CLAgxu6fIKGbqa0JAvoFYOx38dgeceVZIkgJ7IqAgS
	 Vsv9bjhZ8kGIjBHUuxy7SVSm6nmYReVBUc1kEPdODKfpFj/Ni1T8at+2bLtfaxFuEO
	 IyjlLgTuhlq8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 03/17] ACPI: processor: idle: Unify debug in
 acpi_processor_evaluate_lpi()
Date: Thu, 09 Jul 2026 14:32:15 +0200
Message-ID: <3051550.e9J7NaK4W3@rafael.j.wysocki>
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

Use acpi_handle_debug() consistently for printing debug messages in
acpi_processor_evaluate_lpi() because that makes it somewhat easier
to identify the source of the problem in the ACPI tables.

No intentional functional impact beyond debug output.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index aa6d5d8edc79..e8682f779249 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -890,7 +890,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 	/* There must be at least 4 elements = 3 elements + 1 package */
 	if (!lpi_data || lpi_data->type != ACPI_TYPE_PACKAGE ||
 	    lpi_data->package.count < 4) {
-		pr_debug("not enough elements in _LPI\n");
+		acpi_handle_debug(handle, "Not enough elements in _LPI\n");
 		ret = -ENODATA;
 		goto end;
 	}
@@ -899,7 +899,7 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 
 	/* Validate number of power states. */
 	if (pkg_count < 1 || pkg_count != lpi_data->package.count - 3) {
-		pr_debug("count given by _LPI is not valid\n");
+		acpi_handle_debug(handle, "Invalid _LPI state count\n");
 		ret = -ENODATA;
 		goto end;
 	}
@@ -948,19 +948,24 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
 			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
 			lpi_state->address = obj->integer.value;
 		} else {
-			pr_debug("Entry method of state-%d is invalid, disable it.\n",
-				 state_idx);
+			acpi_handle_debug(handle,
+					  "Invalid entry method for _LPI state %d\n",
+					  state_idx);
 			continue;
 		}
 
 		lpi_state->index = state_idx;
 		if (obj_get_integer(pkg_elem + 0, &lpi_state->min_residency)) {
-			pr_debug("No min. residency found, assuming 10 us\n");
+			acpi_handle_debug(handle,
+					  "Assuming 10 us min. residency for _LPI state %d\n",
+					  state_idx);
 			lpi_state->min_residency = 10;
 		}
 
 		if (obj_get_integer(pkg_elem + 1, &lpi_state->wake_latency)) {
-			pr_debug("No wakeup residency found, assuming 10 us\n");
+			acpi_handle_debug(handle,
+					  "Assuming 10 us wake latency for _LPI state %d\n",
+					  state_idx);
 			lpi_state->wake_latency = 10;
 		}
 
-- 
2.51.0




