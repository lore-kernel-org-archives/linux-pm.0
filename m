Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D78387599;
	Mon, 23 Mar 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279600; cv=none; b=eNICdPGrRBYNo0k1qxUdPwW+UKKjAd8Du88gnX/9VYiwa68RwM8V+TdjHmjxsrFhCO/5+egRFgCHiIK1eWLRmNVxdPbHeaRCNSpUuSYz741wvH99scErCjYxmchhg++ht9g5lOppMIDVC1KZclychdTYcZSU1NXyP7QQTpyr8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279600; c=relaxed/simple;
	bh=5CCLsJGYrljS+3ewrvTmrj7wEQ5+vWRBvOujOUyCBBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhVDJlrnyeutl+uAi5ucpkVh7T4GKV4mnQNNg6v1+rpyRcz9SAZLLF/Iy+fMoobeC0Jyaz56hvuCYjU5csP07WCWFLwxe4lV10wM9oTF5V6cFeTsoIOBnOpaAyzGJoadDoIbwrQp9uYwZDUMbVG1bPDMtpd/9xAXMSxg1Rp3bA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBIjBSoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBIjBSoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56053C4CEF7;
	Mon, 23 Mar 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279600;
	bh=5CCLsJGYrljS+3ewrvTmrj7wEQ5+vWRBvOujOUyCBBA=;
	h=From:To:Cc:Subject:Date:From;
	b=uBIjBSoih2ETKO1fhzHlhoLT87mHxXtJLENV0tK6JohcRE4l6yjzo3jWhlohH4DWt
	 uKyCWXRU6Q8dtlcoRLz07OqpzEfeGPSEJLrjJiTh8Ksxh3BApnRRFExXnX6JSO12Ay
	 9oBLX+62mADQqBy/XKpSoAonZgdKVkkBIHSMBXjmGAc+Wz1SzUsVpk9EtpSQ210s97
	 t1+z/6GeP2Y9T/LuDB84wmo+B+MUVca+gKFvKMhPfZ9qvPsd6HTRs+2z1RNHFlc9ti
	 s+Kg6DQIaEfWD2ItNVFDwt87b3Ybg6XdxIZiexC3sEJ0kWyxMknTnRXcq1irt3xF/7
	 uvDEnqU3Yy95w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1] ACPI: TAD: Use DC wakeup only if AC wakeup is supported
Date: Mon, 23 Mar 2026 16:26:37 +0100
Message-ID: <2833494.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to Section 9.17.2 of ACPI 6.6 [1], setting ACPI_TAD_DC_WAKE in
the capabilities without setting ACPI_TAD_AC_WAKE is invalid, so don't
support wakeup if that's the case.

Moreover, it is sufficient to check ACPI_TAD_AC_WAKE alone to determine
if wakeup is supported at all, so use this observation to simplify one
check.

Link: https://uefi.org/specs/ACPI/6.6/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#gcp-get-capability [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This change is on top of linux-next.

---
 drivers/acpi/acpi_tad.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -706,6 +706,9 @@ static int acpi_tad_probe(struct platfor
 		caps &= ~(ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE);
 	}
 
+	if (!(caps & ACPI_TAD_AC_WAKE))
+		caps &= ~ACPI_TAD_DC_WAKE;
+
 	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
 	if (!dd)
 		return -ENOMEM;
@@ -719,7 +722,7 @@ static int acpi_tad_probe(struct platfor
 	 * runtime suspend.  Everything else should be taken care of by the ACPI
 	 * PM domain callbacks.
 	 */
-	if (ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE) {
+	if (ACPI_TAD_AC_WAKE) {
 		device_init_wakeup(dev, true);
 		dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
 					     DPM_FLAG_MAY_SKIP_RESUME);



