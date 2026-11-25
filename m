Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615877;
	b=5oVBSMSkrhq8HCm/coBy6XmWn7kWjAhx1FcYUHH7fAOYpVDhdia/OxLe/FXHR1uiXD/0
	 1eamTDvHU3sLs66v336XyfL0PhYVSAGOjo/uTkY4I6lXF5dfRfPpVj8AYAFh7VDFkVLTt
	 AD9Lasz6L3XIFFI9RWzKTbfp6Do5gxXq3he9wDtTtBscfeBTF/iVWyc4fY7j7hRjjp4Oi
	 leM/wGbaIQi7TO5qi+yjWw7w6qfWOWQSDCoW63Bu4HeRRaFAKV9KR3uLsjykMaSE2CCkb
	 4i/JyjDVGA+PafVzAkPjQ7Qo0FvRDJ9x/ZqikiL8IuZAs2fIc4FU2qbog5GyYhGcJmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=xc+SxOQTlfKFAM349sghgpZ6wY60OspBA3OTKlqR+F8=;
	b=nJCLsDfy6/Buhbxfg6DK3LG4Fg3etvHztwKHoFOpkJmBeldxDGcIX0P4/g+6A6SXXuqq
	 Z2U43dB5Xbu/b6yRBbZwizyE7YeaPzcMvayhjfvfi2JCUHlQfAH+4gMxNZQhfuncnsccn
	 G7boSPZfatiM7Rt7wnXt9XI96g5VBcZMTzjoGYsn0Uk3FmZkBq4cZt8UWvzAOfjsKBAph
	 C0qqIzMUqBCWTc8iRtWhRF7iMTJ3zRv1guY8nUPWO9aeSgRO/2pI4jAnVMHnOr8a2wlUE
	 DWkgI9YgahgVEJltaW2UrdHylBscgF9gKKUWO6fFiFwX8wtdR88aIUjxGyj6W8bCe/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4dXay1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE01606A32A;
	Wed, 25 Nov 2026 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4dXay1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973BF1F000C4;
	Wed, 25 Nov 2026 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615876;
	bh=xc+SxOQTlfKFAM349sghgpZ6wY60OspBA3OTKlqR+F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4dXay1BCqEHHo4qiLiWmKZp1zSQrvCZ+L4RYd6g2ZvYVu5UKHOdSlwqK9S+tEYGY
	 zwIJMqc1wUIYQ+783fzP7oo+MGgYm8W/ezSbiq8bbiZ2gGxCrs6eJwJffPGALdpl3N
	 ZPW0aAkiwh/PMWQV2bz7oJvNC8Q8OtRO2UKScXlGdr7F1xl09UyhjTnDzrPlVryAJV
	 cBUA8b2hsEGcqYS2hFKyxY6e5vG+JShsPK2jnb3dOXC4qwck9BT9Hk5XAOwFAFildX
	 ZevRadRMWick7225j9j8th++KAy8+3kVSYwW8Ot5pgMta9hGbh7RaLgP5qzHN+uJ/+
	 RkKheybmfPszQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v2 5/5] ACPI: fan: Use acpi_handle_debug/err() for diagnostic messages
Date: Wed, 25 Nov 2026 15:10:29 +0100
Message-ID: <2374022.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <2859850.mvXUDI8C0e@rafael.j.wysocki>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
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
ACPI namespace because that's where the problems actually happen.

Also, add FW_BUG to error messages printed on errors that cause probe
to fail.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---

v1 -> v2:
   * Add R-by from Armin (thanks!)

---
 drivers/acpi/fan_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index f1efa0db9958..95ffacfa22c9 100644
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
 
@@ -236,13 +237,13 @@ static int acpi_fan_get_fif(struct acpi_fan *fan, struct acpi_device *device)
 
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
 
@@ -281,7 +282,7 @@ static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
 
 	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
-		dev_err(&device->dev, "Invalid _FPS data\n");
+		acpi_handle_err(device->handle, FW_BUG "Invalid _FPS data\n");
 		return -ENODATA;
 	}
 
@@ -297,7 +298,8 @@ static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
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




