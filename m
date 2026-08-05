Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD773C8C60;
	Wed,  5 Aug 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956017; cv=none; b=dXkkiylb0WuSN/z56KlqTBaP1Emzymuy4Fga2sO0P9IEU0wGxclNmmD5lzjXWKKo0drM7jxGsDk+rytaDJYUIUFgnnqU3rU3k0UlCd2CXe3kVxAxEjccfUdYnU/16C+6uAmgSe8TdwsS0er++ZvgmCKqoUhPT3rY6zU+kowjres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956017; c=relaxed/simple;
	bh=95CoHcqvaJDUs7XKJ91At7QXbNqDueEGhmXIk9pleUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IubYJq+UNGWJP+Ec9hnEfNZloBVNXbV2pzgwe56DUNfWCd5mX+DdBvn5Q8ntIo/qJrJuz6pNqMU8EEFEJywIKJnt/nyrCgKrqAiTtiXy4QVb+m7d3HLSmP61gxOAensnV6N4gHwjrTYnve5W0zboXXHkP6SHL7yHtPwp87yZxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY9spBQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY9spBQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523D1F000E9;
	Wed,  5 Aug 2026 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785956016;
	bh=qJ+DWJ0hsoL09KLgGlF3Rq72tbFWKoEbQxPlgr0HbPs=;
	h=From:To:Cc:Subject:Date;
	b=bY9spBQpp2k26xpQfjR1WASianbJqUD1My727m6Ozl/h5Py6nmK756v6Ox+GE25Qx
	 VGgXzVV20nzKjDLCQWEzAJhmhbRDTF9gJNkhXFaWA5+GBVl+B/atLspk7CrsRq7lmd
	 fxtF2nzHWrBKA6bLI4n6zmM/UzrZQVZ5pderLIq+TsdTkNcZlRQyJO6mWHCqfmbNxy
	 yLxIxHU8GjicciltlK/T7S1uVElMtT4KRlZhDCfzD0lLyrMYH4ql+Qd2Va87VbQrdM
	 Cb5/FTQZCbdBYMIaUZUJvr/dYQNOtN+nj/olF0d3l0Qf4nB63QKNCMHZxM5T39D8Hu
	 ERmyNIIEB64nw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1] ACPI: TAD: Add locking around AML evaluations
Date: Wed, 05 Aug 2026 20:53:32 +0200
Message-ID: <12951141.O9o76ZdvQC@rafael.j.wysocki>
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

In the ACPI TAD driver, there are hidden assumptions that the ACPI
control methods used by it will not be evaluated concurrently due
to ACPICA namespace and interpreter locking.

However, that may not be the case since ACPICA may drop and re-acquire
the namespace and interpreter locks during the evaluation of a given
object in a few cases, including the one in which the AML in question
sleeps causing acpi_ex_system_do_sleep() to be called.  In that case,
the evaluation of one control method may be started while the
evaluation of another one is still in progress.

For this reason, add a global lock to the ACPI TAD driver and
acquire it every time before evaluating an ACPI control method,
except for the initial evaluation of _GCP in acpi_tad_probe().

Fixes: 95c513ec84f7 ("ACPI: Add Time and Alarm Device (TAD) driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -86,6 +87,8 @@ static bool acpi_tad_rt_is_invalid(struc
 	    rt->daylight > 3;
 }
 
+static DEFINE_MUTEX(acpi_tad_aml_lock);
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -113,6 +116,8 @@ static int acpi_tad_set_real_time(struct
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -124,30 +129,27 @@ static int acpi_tad_evaluate_grt(struct
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
-	union acpi_object *out_obj;
-	struct acpi_tad_rt *data;
 	acpi_status status;
 	int ret = -EIO;
 
-	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-	if (ACPI_FAILURE(status))
-		goto out_free;
-
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER)
-		goto out_free;
-
-	if (out_obj->buffer.length != sizeof(*rt))
-		goto out_free;
-
-	data = (struct acpi_tad_rt *)(out_obj->buffer.pointer);
-	if (!data->valid)
-		goto out_free;
+	guard(mutex)(&acpi_tad_aml_lock);
 
-	memcpy(rt, data, sizeof(*rt));
-	ret = 0;
+	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
+	if (ACPI_SUCCESS(status)) {
+		union acpi_object *out_obj;
 
-out_free:
+		out_obj = output.pointer;
+		if (out_obj->type == ACPI_TYPE_BUFFER &&
+		    out_obj->buffer.length == sizeof(*rt)) {
+			struct acpi_tad_rt *data;
+
+			data = (struct acpi_tad_rt *)(out_obj->buffer.pointer);
+			if (data->valid) {
+				memcpy(rt, data, sizeof(*rt));
+				ret = 0;
+			}
+		}
+	}
 	ACPI_FREE(output.pointer);
 	return ret;
 }
@@ -193,6 +195,8 @@ static int __acpi_tad_wake_set(struct de
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -215,6 +219,8 @@ static int __acpi_tad_wake_read(struct d
 
 	args[0].integer.value = timer_id;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, method, &arg_list, retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -416,6 +422,8 @@ static int acpi_tad_clear_status(struct
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
@@ -456,6 +464,8 @@ static ssize_t acpi_tad_status_read(stru
 	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
+	guard(mutex)(&acpi_tad_aml_lock);
+
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
 	if (ACPI_FAILURE(status))
 		return -EIO;



