Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118308;
	b=Wd0kfSJBZVKRfut/GANPDt0x3MqFkFEFJ+NCrfsr71OWKC+Ow/eJhN0Z45fDh2iZoxwI
	 tMV1Vr4/726eaghoKMcwi+vJ/JipU3WmYKBCX1rcxmFCNUNyVfWyUltjvS58BAmWL0QFi
	 PTiakHJOkmWH4wSItSDyON2FARTkmmybtWNw9GlAqEPD47QkyLt/vGU+T/Cu1K9OjEbER
	 vuOnzT7WhH+R47wbbpuD4d+yCgjeP9IThswKQTPtmalno1njSa+9u+E0KOOgziz9Uo3SJ
	 nuugjbEvrZzzZ9X7PX4sXCCePKCMKLWI21mJCnFCiMFj6/MIZY5nUtypO9rDVQZ5YVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118308;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=IEg+CKmOlkZndpwphnetx0KbTsayP3KWj3U59fB9YnA=;
	b=l7yzJdXbS3GVMxH2KMcuib09uJQV3QDYe+ohTQvnBLTWTzspoBfefTyzOy69hGhbgNtx
	 Gq82AvIrlNSdVO+52kwRq9zvzUd2adTlgQOe/segsdDH/kQY8kkrLidYUbYk3+8Mic2V8
	 1wXg5yCAo0MvFPgAABnfCVWi6kMTSFPjg71xYvEc0mbykbdl+dDpShvuqj5+Ecv+iA2xT
	 pq3RwFYcFxSiGtUzPTzSpaTSRzFjmwL6JNqwPO9g39Jyiyt8JFlMLgxY70HCTeuwki6a6
	 kGpRMFi0UN8pc4BosUDk6Lrdx/POnVHBuGulwfPRVfbZz3yzhyf4wZGZhLyftyxK7Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BKPLi5/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77633606A320;
	Thu, 19 Nov 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKPLi5/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B591F000C5;
	Thu, 19 Nov 2026 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118308;
	bh=IEg+CKmOlkZndpwphnetx0KbTsayP3KWj3U59fB9YnA=;
	h=From:To:Cc:Subject:Date;
	b=BKPLi5/lGPpGufB85JB28WuLDktgF+yUSjQQ2xgsVooMVLU1te/oWchz5AIkFj7EW
	 jokQdeBKCpow98VPuIzqCNA3pGcHf/20ZRDKwK+Vwvs6FY2OWUzj6aJ9cSY+h+vaxu
	 7y21YWmQ0gOvPDaz/I2LWyIIOfeWXdAOLlo1QTDXnD+Uxkgg0sV/GlgOT+QZUA5Hk3
	 V9+j48ezjnsG2KCV2jmbfe+B06yanmqctjVq4Ft/y9a8PucYvCeOmImsAoady9ymGp
	 SSP6Hr0HrPN2ksAgI+u7PwwudMZkig+4+q1S6X0BloMU1xlXjnk+XEPe9rlCLiqnjy
	 SdLXwLjr/UcRA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Brian Norris <briannorris@chromium.org>
Subject:
 [PATCH v1] ACPI: TAD: Improve runtime PM handling during driver removal
Date: Thu, 19 Nov 2026 20:58:26 +0100
Message-ID: <6052490.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In acpi_tad_remove(), instead of attempting a runtime suspend of the
device which may be blocked by user space via "power/control", change
the device's runtime PM status to "suspended" after disabling runtime
PM for it to potentially unblock the runtime suspend of its parent and
suppliers (if any).

Since pm_runtime_suspend() is not called in acpi_tad_remove() any more,
the latter need not drop the runtime PM reference to the device held by
it, so make it use guard()() instead of scoped_guard() for acquiring
that reference and reduce the indentation level.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -850,19 +850,21 @@ static void acpi_tad_remove(void *data)
 
 	device_init_wakeup(dev, false);
 
-	scoped_guard(pm_runtime_noresume, dev) {
-		if (dd->capabilities & ACPI_TAD_AC_WAKE) {
-			acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
-			acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
-		}
-		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
-			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
-			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
-		}
+	guard(pm_runtime_noresume)(dev);
+
+	if (dd->capabilities & ACPI_TAD_AC_WAKE) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+	}
+	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
 	}
 
-	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
+	/* Allow the parent and suppliers (if any) to suspend. */
+	pm_runtime_set_suspended(dev);
+	/* No need to power down, the PM domain detach will take care of it. */
 }
 
 static int acpi_tad_probe(struct platform_device *pdev)



