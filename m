Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535467;
	b=tiQPw2salA84pL+vgAG+bxYhkmfYYoshDtQs6bDxr/UAsho9d4CaU7mf6jZZGjZfo0Df
	 wyCcgVgtt9wIYkJEUquTWlL3I0e2n50T5TowCehj3rXHkYRIBGm4ZIfTanvnYvAwZ99dT
	 hLyvSHznMUROCzeaC/UmraFYQ0xlfo23MT/HdERg4zE/ZkKWAZwE9jIZa54bMfQSkKtgH
	 JIjiX82+P6wYQ1a4EI42Jv5ZaJ5N7cNP6FdYORlO5y4HYmfANJ94/Jkfba/gWmSRiyhef
	 b8TfZU3gYF15qZ23gyaE4B3tsfFI3SeEwc6ZB1PXZEaP1lbXlPg//o7EqaGAQBCtqxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=6XyseT8gOCSjo4j2a4OVVIQSHT4J6/+td0phlbgSqNg=;
	b=MVK4BIs3j+kjZV7yUq30CuJRRPzFaGwcM9IHT1qYuUxuYmk1ngjL+UddhA0MewRiWMuc
	 +Y76LsPBRX5DJOzsM+r0QnyF+LxqTpME0lXhqR+W4fIBsaaHsoZVIw0/ojRVNY0UHPlWs
	 nxr8lsPkSg3zn+fYCI/tRZeO7eyfLDxZ/TvnTrVQh1QMD2jERNfJw0wQXcwV8toi4v3hG
	 bad2NUQPkTLX6yfnfEQ58NgbwUHIaYncxTIpcZY0NWXJ8EpsxC71AO0MRLL2ZzXZcd243
	 to6Rl6HzTTEFV9a0upoLtHGIXipFIARyqDzU/hcfU4JDuQI8WkMbWaWn59RozzWYJlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kR/VZXlg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A146606A31E;
	Tue, 24 Nov 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kR/VZXlg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1611F000C4;
	Tue, 24 Nov 2026 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535466;
	bh=6XyseT8gOCSjo4j2a4OVVIQSHT4J6/+td0phlbgSqNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kR/VZXlg0F2M7R3oMW+f0R1u0ab2EO3KJTa6lwRzwFflg200PXO+PMRCNReSJpCVP
	 DgDmnFf6bxrM0l+i6FqprWJ/nR1w+yR0CNtxZKj3ECwGyzoFT4KRhpAye2PctMTDcv
	 PGqmI8u6VKYd4GBfyBhQFASndAw4G8XsI4VWDngPcwntypGVA1JihMdzNhZnFX7GGk
	 XvoZdHWqp7VXSyqvONWHq3fDZgNZpExeGtsAKFAtLWEBMxAnVoseSZvJp54blF2pmG
	 UN4IB79y6QbPLHlxxS/E4gxCftuGTwV+wF8byWxrp1OC+Y3/kHtW4WRDh/S1r7bTzx
	 B9d81zCuM2e8Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 5/5] ACPI: fan: Use acpi_handle_debug/err() for diagnostic messages
Date: Tue, 24 Nov 2026 16:50:54 +0100
Message-ID: <24600912.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3985766.kQq0lBPeGt@rafael.j.wysocki>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
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

Use acpi_handle_debug() or acpi_handle_err() for printing all of the
remaining diagnostic messages in the ACPI fan driver core code that
are still printed relative to the fan ACPI device object.

It is better to print them relative the device object's path in the
ACPI namespace because that's where the problems are actually present.

While at it, add FW_BUG to error messages printed on errors that cause
probe to fail.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 4b37f6ea2aa6..f724f1aa2c2c 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -109,7 +109,8 @@ static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *state)
 	if (fan->fif.fine_grain_ctrl) {
 		/* This control should be same what we set using _FSL by spec */
 		if (fst.control > 100) {
-			dev_dbg(&device->dev, "Invalid control value returned\n");
+			acpi_handle_debug(device->handle,
+					  "Invalid control value returned\n");
 			goto match_fps;
 		}
 
@@ -123,7 +124,7 @@ static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *state)
 			break;
 	}
 	if (i == fan->fps_count) {
-		dev_dbg(&device->dev, "No matching fps control value\n");
+		acpi_handle_debug(device->handle, "No matching fps control value\n");
 		return -EINVAL;
 	}
 
@@ -193,7 +194,7 @@ static int fan_set_state_acpi4(struct acpi_fan *fan, unsigned long state)
 
 	status = acpi_execute_simple_method(device->handle, "_FSL", value);
 	if (ACPI_FAILURE(status)) {
-		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
+		acpi_handle_debug(device->handle, "Failed to set state by _FSL\n");
 		return -ENODEV;
 	}
 
@@ -236,13 +237,13 @@ static int acpi_fan_get_fif(struct acpi_device *device, struct acpi_fan *fan)
 
 	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
-		dev_err(&device->dev, "Invalid _FIF data\n");
+		acpi_handle_err(device->handle, FW_BUG "Invalid _FIF data\n");
 		return -ENODATA;
 	}
 
 	status = acpi_extract_package(obj, &format, &fif);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&device->dev, "Invalid _FIF element\n");
+		acpi_handle_err(device->handle, FW_BUG "Invalid _FIF element\n");
 		return -ENODATA;
 	}
 
@@ -281,7 +282,7 @@ static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device,
 
 	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
-		dev_err(&device->dev, "Invalid _FPS data\n");
+		acpi_handle_err(device->handle, FW_BUG "Invalid _FPS data\n");
 		return -ENODATA;
 	}
 
@@ -297,7 +298,8 @@ static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device,
 		status = acpi_extract_package(&obj->package.elements[i + 1],
 					      &format, &fps);
 		if (ACPI_FAILURE(status)) {
-			dev_err(&device->dev, "Invalid _FPS element\n");
+			acpi_handle_err(device->handle,
+					FW_BUG "Invalid _FPS element\n");
 			return -ENODATA;
 		}
 	}
-- 
2.51.0




