Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A924886A;
	Thu, 27 Aug 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839178; cv=none; b=FJfOsArSha4bJY/5N985kAybxwXc7+0wITc53260qkQz4VxmhSe4Yl5qflneKLcevs+9l8BN7XYGz4YjhACftsU0H9uqtUhCGzP6lBp7ayOO9HVJpf7OVylCNOc7JwxuYoUfjlw+QmgVYCblsCdfxXdF67G11PEGM5nDrSqKPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839178; c=relaxed/simple;
	bh=6QtYceN08ctRHiGOKb2Te5ZRLhVJhxy9KZZsmpog0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhm9mI5KGiuAWA/iBcQ5Fxu7q/lyT7f2iUVo6SdfxWVQQrBYfQhhr4ABFrKGdtt7L0UFo1pdQJbTUbzr7AM4SHLP7ql/ODz9aSTSMdZbQnpeHVitWPqxZRNLFO7WUSS3JegPSZhibjDm0QFTjb9RCCjAlQ6qXq5LFtYRwzbVtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUOcZg2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUOcZg2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FBA1F000E9;
	Thu, 27 Aug 2026 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839176;
	bh=YlYAmxTedcW+z4fH3/ZePc5utWgTFiPplYAQ6byAKJM=;
	h=From:To:Cc:Subject:Date;
	b=PUOcZg2OqkXJX8Sv/h7shs4Dy0sYV1xhlnOcbKILk4ut9aYpIGH/4Y8Vx7V+ID9Lk
	 szZ0EGxiF18tx1SgGPB6fT5/INHoQzUCqq3JwjFCzmPnX7QGiJ/v4lyvPMJYC8N1Cb
	 jko48HE/kS+Vh6aMVJMZHGZvVPITY4ylpxDC/uDHF+zqyLFDuC6BHaOnaAyr6a2N5h
	 QN0ka7p/Rzm3KrKVDwOXJ5Kc8hPaTLKcZcJlTlYDmq9EqkDEvmKyfXje3g+IoU0FB6
	 O3v0gMB8bKJHDjORaBbUjDZRpCrAXMjmfYMKFt1zb7IKDn/zpxASzatsIsxInqrAfF
	 niv8RUIqYWXxA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Peixin Xie <peixin.xie@linux.spacemit.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v1] Revert "ACPI: scan: Defer device power initialization"
Date: Thu, 27 Aug 2026 15:59:32 +0200
Message-ID: <6029658.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit dc948f8b384a ("ACPI: scan: Defer device power
initialization") that is incomplete and may cause ACPI power
management of devices to fail.

The problem is that PCI devices are associated with the
corresponding ACPI device objects before acpi_bus_attach()
runs for them, so after commit dc948f8b384a, ACPI power
management will not be initialized for them before making
that association.  Consequently, the reference counting of
ACPI power resources may not work as expected going forward
and power management issues may appear.  If they appear, they
may be elusive and hard to diagnose.

While this is fixable, I am not sure if fixing it on top of
commit dc948f8b384a is the best way to go, so it is better to
revert that commit for now and revisit the whole thing in the
next cycle.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

@Xie: Sorry for catching this late.  The change is quite subtle
and I should probably take care of doing it myself.

---
 drivers/acpi/power.c | 1 -
 drivers/acpi/scan.c  | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 922ba9803a93..23a4e207a01e 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -954,7 +954,6 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
 	device->power.state = ACPI_STATE_UNKNOWN;
-	device->flags.initialized = true;
 
 	/* Evaluate the object to get the system level and resource order. */
 	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7dcf784199fa..f48715ed827c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1144,6 +1144,9 @@ static void acpi_bus_get_power_flags(struct acpi_device *device)
 		if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
 			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
 	}
+
+	if (acpi_bus_init_power(device))
+		device->flags.power_manageable = 0;
 }
 
 static void acpi_bus_get_flags(struct acpi_device *device)
@@ -1825,6 +1828,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_set_pnp_ids(handle, &device->pnp, type);
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
+	device->flags.initialized = true;
 	device->flags.enumeration_by_parent =
 		acpi_device_enumeration_by_parent(device);
 	acpi_device_clear_enumerated(device);
-- 
2.51.0




