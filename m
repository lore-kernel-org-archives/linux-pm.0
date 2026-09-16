Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F49A3D6;
	Wed, 16 Sep 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587796; cv=none; b=D6OtzztA5PlG9KZsR12eTkh5f+vgU7ynalCqkIDKx2lg5RWnVW2LqmWLeRtS4fU36t+n+hsCECd0vLol/p5GImSL7Pd3usaMg+r5nbuaNWmnYQFwDtfkO7LOUETKMmEdTMuuM6UdGu86N8Z9h82XmAzAdjXp00mVBHVQU053FO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587796; c=relaxed/simple;
	bh=Ft9BS3kW++D232pIP3ML+6ilnOrWbdzA1OUA42XDh1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSGiOkn/sYiyb1c+voknB/XfZQ6+r2OvgnvYVnCHI5FjYw7VLUWLyY1i+Oqy1hGQ0VbdIbMVOmvwrTpe7YA/6BAPcmmWXxibzl0aszGo5Vmorlb3Rm+5EZcLsHyQLA4HPDdoM6I86TbuKh1p04IgRP3GM1gWSzsuRwGryAXM530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M02+kOlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M02+kOlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A21F000FF;
	Wed, 16 Sep 2026 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587777;
	bh=/UNh8tCi96JXByL1XoKefV6unJDt7ze/TrpH88Glt7c=;
	h=From:To:Cc:Subject:Date;
	b=M02+kOlIDM3VCtgBZcC4LVrF79XkK+/hkvHDfsVCiUASa9bzpfCG747G/0toM9qmR
	 qqXp+X4Bl1WwfXg8VwAdmfzaN7vNyg8R5juFrX+OGSJ/Xb6oo72QyR2CG0sKr97Loo
	 ZbJZfU2/QVAI+/dKm75bhUHraL7YdFaejMP9dx1ch9XTk4D523rK9reuFca+p17mcz
	 K3gXcPQ8InLlDINpsQhWNgswMzD4KWxcPmvNTeIR5rX/kfMrrCb175imiBTPChRbpW
	 oc1o81AsPl30uE2TBs25vacHlHsmiG6UqFdmLjH+kOWxBaaIOn10CrwDyVyUNwVhJs
	 LKh8VUuH163Vg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Armin Wolf <w_armin@gmx.de>, Linux PM <linux-pm@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1][linux-next] ACPI: fan: Use __free() to simplify AML error handling
Date: Wed, 16 Sep 2026 21:42:54 +0200
Message-ID: <6029013.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Introduce acpi_object_free for freeing union acpi_object objects
allocated by AML and use it for simplifying AML error handling in
the ACPI fan driver.

While at it, update the driver to use consistent error values across
all function using the union acpi_object data type.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of

https://lore.kernel.org/linux-acpi/1965933.tdWV9SEqCh@rafael.j.wysocki/

which is in linux-next now.

---
 drivers/acpi/fan_core.c |   80 ++++++++++++++++++------------------------------
 include/linux/acpi.h    |    2 +
 2 files changed, 32 insertions(+), 50 deletions(-)

--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -71,37 +71,29 @@ static int fan_get_max_state(struct ther
 int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 	acpi_status status;
-	int ret = 0;
 
 	status = acpi_evaluate_object(handle, "_FST", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return -EIO;
+		return -ENXIO;
 
-	obj = buffer.pointer;
+	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj)
 		return -ENODATA;
 
-	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
-		ret = -EPROTO;
-		goto err;
-	}
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
+		return -EPROTO;
 
 	if (obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
 	    obj->package.elements[1].type != ACPI_TYPE_INTEGER ||
-	    obj->package.elements[2].type != ACPI_TYPE_INTEGER) {
-		ret = -EPROTO;
-		goto err;
-	}
+	    obj->package.elements[2].type != ACPI_TYPE_INTEGER)
+		return -EPROTO;
 
 	fst->revision = obj->package.elements[0].integer.value;
 	fst->control = obj->package.elements[1].integer.value;
 	fst->speed = obj->package.elements[2].integer.value;
 
-err:
-	kfree(obj);
-	return ret;
+	return 0;
 }
 
 static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *state)
@@ -237,25 +229,22 @@ static int acpi_fan_get_fif(struct acpi_
 	struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
 	u64 fields[4];
 	struct acpi_buffer fif = { sizeof(fields), fields };
-	union acpi_object *obj;
 	acpi_status status;
 
 	status = acpi_evaluate_object(device->handle, "_FIF", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return status;
+		return -ENXIO;
 
-	obj = buffer.pointer;
+	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
 		dev_err(&device->dev, "Invalid _FIF data\n");
-		status = -EINVAL;
-		goto err;
+		return -ENODATA;
 	}
 
 	status = acpi_extract_package(obj, &format, &fif);
 	if (ACPI_FAILURE(status)) {
 		dev_err(&device->dev, "Invalid _FIF element\n");
-		status = -EINVAL;
-		goto err;
+		return -ENODATA;
 	}
 
 	fan->fif.revision = fields[0];
@@ -269,9 +258,8 @@ static int acpi_fan_get_fif(struct acpi_
 	/* If step size > 9, change to 9 (by spec valid values 1-9) */
 	else if (fan->fif.step_size > 9)
 		fan->fif.step_size = 9;
-err:
-	kfree(obj);
-	return status;
+
+	return 0;
 }
 
 static int acpi_fan_speed_cmp(const void *a, const void *b)
@@ -285,27 +273,24 @@ static int acpi_fan_get_fps(struct devic
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 	acpi_status status;
 	int i;
 
 	status = acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return status;
+		return -ENXIO;
 
-	obj = buffer.pointer;
+	union acpi_object *obj __free(acpi_object_free) = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
 		dev_err(&device->dev, "Invalid _FPS data\n");
-		status = -EINVAL;
-		goto err;
+		return -ENODATA;
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
 	fan->fps = devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps), GFP_KERNEL);
-	if (!fan->fps) {
-		status = -ENOMEM;
-		goto err;
-	}
+	if (!fan->fps)
+		return -ENOMEM;
+
 	for (i = 0; i < fan->fps_count; i++) {
 		struct acpi_buffer format = { sizeof("NNNNN"), "NNNNN" };
 		struct acpi_buffer fps = { offsetof(struct acpi_fan_fps, name),
@@ -314,7 +299,7 @@ static int acpi_fan_get_fps(struct devic
 					      &format, &fps);
 		if (ACPI_FAILURE(status)) {
 			dev_err(&device->dev, "Invalid _FPS element\n");
-			goto err;
+			return -ENODATA;
 		}
 	}
 
@@ -322,9 +307,7 @@ static int acpi_fan_get_fps(struct devic
 	sort(fan->fps, fan->fps_count, sizeof(*fan->fps),
 	     acpi_fan_speed_cmp, NULL);
 
-err:
-	kfree(obj);
-	return status;
+	return 0;
 }
 
 static int acpi_fan_dsm_init(struct device *dev)
@@ -338,8 +321,6 @@ static int acpi_fan_dsm_init(struct devi
 	};
 	struct acpi_fan *fan = dev_get_drvdata(dev);
 	acpi_handle fan_handle = fan->adev->handle;
-	union acpi_object *obj;
-	int ret = 0;
 
 	if (!acpi_check_dsm(fan_handle, &acpi_fan_microsoft_guid, 0,
 			    BIT(ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY) |
@@ -348,20 +329,19 @@ static int acpi_fan_dsm_init(struct devi
 
 	dev_info(dev, "Using Microsoft fan extensions\n");
 
-	obj = acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, 0,
-				      ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy,
-				      ACPI_TYPE_INTEGER);
+	union acpi_object *obj __free(acpi_object_free) =
+		acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, 0,
+					ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY,
+					&dummy, ACPI_TYPE_INTEGER);
 	if (!obj)
-		return -EIO;
+		return -ENXIO;
 
 	if (obj->integer.value > U32_MAX)
-		ret = -EOVERFLOW;
-	else
-		fan->fan_trip_granularity = obj->integer.value;
+		return -EOVERFLOW;
 
-	kfree(obj);
+	fan->fan_trip_granularity = obj->integer.value;
 
-	return ret;
+	return 0;
 }
 
 static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u64 lower)
@@ -392,7 +372,7 @@ static int acpi_fan_dsm_set_trip_points(
 
 	obj = acpi_evaluate_dsm(fan->adev->handle, &acpi_fan_microsoft_guid,
 				0, ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
-	kfree(obj);
+	ACPI_FREE(obj);
 
 	return 0;
 }
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -27,6 +27,8 @@ struct irq_domain_ops;
 #include <acpi/acpi.h>
 #include <acpi/acpi_numa.h>
 
+DEFINE_FREE(acpi_object_free, union acpi_object *, if (_T) ACPI_FREE(_T));
+
 #ifdef	CONFIG_ACPI
 
 #include <linux/list.h>



