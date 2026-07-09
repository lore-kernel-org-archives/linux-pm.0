Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D979439337;
	Thu,  9 Jul 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601256; cv=none; b=X/zzkkuSYm0KrhLzMWh72pS42BR9TxGlZ+aMqJnz3vKngSlA6y8yhtxuOm3jSqFqJbR/XHQ72zalYGQ2zSsxVHSzt+HAKJZBJEGCADPf7FpNatNWh2+2aom9whwfriay9JlHgNeU+rGhNHWfpxxUeGGL4LRlHVrx/2wd+XyRe+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601256; c=relaxed/simple;
	bh=84vKwTrxsNZ97k7f/hC48FGW5hYCLcrsbhaWi58CX68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGRJDBbOtjnolYKOPSZG4mxQZcrinXu+i68wgH6/Axaw7omdzpONGiNVBQusAcQGPbKh0rHaRilbOyN03ZA4gaDucpgdXkwCjg9drlZs5cVWLDrauTg5XXzNbP3aERDcDB1naRW/zH9AfBskAM5KE2KJIauKisEPnyty+oB9wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng/8IBpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng/8IBpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170F41F000E9;
	Thu,  9 Jul 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601254;
	bh=tIll783jCthqFI1/QAGckGAOIaGYl2VI5/i68ovDfdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ng/8IBpIJcJGh0nvAFaP0iAny+Lw5v41xdTa5eVBGWLd3Q6WnpmVZfjl6QNHM8g9g
	 VrgXx053lHlmGq/+NKsixxMFVkCJdWTx193aMZR6BX5dbf5883yWmuZtwD1T5yNdb1
	 IpOh58VPN+RI4wTdSk8sLKYSFBIWr3eTsGgx2veAnHham0K7bwPgTaNXCJ9xSxdFBh
	 mqiebEBY53IzMSmFBR2/S8kCVTbAzfB2HLBwSGUQDWd0HLYWz/kLzN/CyHxBWFDaj1
	 JCnYTLXBw7VYlBJS/63keClBYxYdXD6V49RV2NcasR5JLM+Wd7Miv6jZ2qTPYhsG7N
	 3/vVmpiclUYqA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 09/17] ACPI: processor: idle: Drop redundant _LPI presence checks
Date: Thu, 09 Jul 2026 14:37:49 +0200
Message-ID: <3349003.5fSG56mABF@rafael.j.wysocki>
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

The acpi_has_method() checks for _LPI in acpi_processor_get_lpi_info()
are redundant because acpi_processor_evaluate_lpi() returns an error
when _LPI is not present, so drop them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index efd3e76377fa..274abe3da7a4 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1107,9 +1107,6 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	if (!osc_pc_lpi_support_confirmed)
 		return -EOPNOTSUPP;
 
-	if (!acpi_has_method(handle, "_LPI"))
-		return -EINVAL;
-
 	curr = &info[0];
 	curr->composite_states_size = 0;
 
@@ -1166,10 +1163,6 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
 			break;
 
-		/* can be optional ? */
-		if (!acpi_has_method(handle, "_LPI"))
-			break;
-
 		ret = acpi_processor_evaluate_lpi(handle, curr);
 		if (ret)
 			break;
-- 
2.51.0




