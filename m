Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEE45C6E0;
	Fri, 11 Sep 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132114; cv=none; b=hZfnK7RbRT13mKILvOGmyjwFNpp3MmP9dFyoBkomRriaM9TsmuWZR9gEkHYvIqjapMRqKp336fxNNQTCCZjR2eVtxTGdlYX0/qROaV6y/UOm97pzwVmOzXJhquHx2nH9LWKJH3rO+MSAxdY6kF7DFBGijT4rbBbuxnLcBe1FxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132114; c=relaxed/simple;
	bh=arnalO1JsMUcaRJ1qcWXlV2mrN6mnoqbD1E8eqN67Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+7AuWhbCQqgQD4GQ21JVaq8yuRqYrcjy+LP+NZIXpukCBYZSpFrrOtEoicwnyJFVMYGU3UDUWrILHY6lfFmOr/NVkU7Lj0GXtS29knWHR9rJ3kMr6C7QhBdzxcWUXVRY4MelFpysTx6sWLCHn423zxDIS88ziECzEvudgr+T1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEXdH78R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEXdH78R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1B1F000FF;
	Fri, 11 Sep 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132112;
	bh=Lfm3vyAeQJjgi9jyKCyI89nedtCr+8z8FOD9jtOySGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CEXdH78R1o9cvqqvYhukKloisfM8U9UWEK/LhxHLjLKOPfHPWVT7VwjL34IIDJfXi
	 fwv/Z3x3WXvAZtsXncCFIiwRw/hQByDLMw9IXvGYOyKwr2f5hCBQr+gKICl+aC9yji
	 D4Wxto9iIgOmhjagO+mpwX5Nl9qIHGpL/L2nr44BRgGqXFHgtMp/ruKig6jk54Mde1
	 cYudbEN/iyxq9kWIh0TDVUotwmntmw9Sym5A+2NMtsokoIw+3t5XgcqJD8A8m0YHVj
	 pChpsnHC7OZYO33AE5wUTno99HQNwAEgAYyS41SE+d+Wma+UY6I2kAqfU6WPnNH18v
	 amUeyn1Oju3BQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 10/10] ACPI: fan: Use more suitable cooling device data
Date: Fri, 11 Sep 2026 15:07:07 +0200
Message-ID: <3631084.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of passing an ACPI device object pointer as devdata to
thermal_cooling_device_create(), make acpi_fan_probe() pass a pointer
to struct acpi_fan to it, which allows the callback functions in
fan_cooling_ops to be simplified.

Also avoid using acpi_driver_data() in two functions invoked by the
cooling device callbacks by passing struct acpi_fan pointers instead
of struct acpi_device pointers to them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 8b20b8a55c13..5ad65975fbb4 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -54,8 +54,7 @@ MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan *fan = cdev->devdata;
 
 	if (fan->acpi4) {
 		if (fan->fif.fine_grain_ctrl)
@@ -105,9 +104,9 @@ int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst)
 	return ret;
 }
 
-static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *state)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_device *device = fan->adev;
 	struct acpi_fan_fst fst;
 	int status, i;
 
@@ -159,13 +158,12 @@ static int fan_get_state(struct acpi_device *device, unsigned long *state)
 static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan *fan = cdev->devdata;
 
 	if (fan->acpi4)
-		return fan_get_state_acpi4(device, state);
+		return fan_get_state_acpi4(fan, state);
 	else
-		return fan_get_state(device, state);
+		return fan_get_state(fan->adev, state);
 }
 
 static int fan_set_state(struct acpi_device *device, unsigned long state)
@@ -177,9 +175,9 @@ static int fan_set_state(struct acpi_device *device, unsigned long state)
 				     state ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD);
 }
 
-static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
+static int fan_set_state_acpi4(struct acpi_fan *fan, unsigned long state)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_device *device = fan->adev;
 	acpi_status status;
 	u64 value = state;
 	int max_state;
@@ -213,13 +211,12 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 static int
 fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan *fan = cdev->devdata;
 
 	if (fan->acpi4)
-		return fan_set_state_acpi4(device, state);
+		return fan_set_state_acpi4(fan, state);
 	else
-		return fan_set_state(device, state);
+		return fan_set_state(fan->adev, state);
 }
 
 static const struct thermal_cooling_device_ops fan_cooling_ops = {
@@ -565,7 +562,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	else
 		name = acpi_device_bid(device);
 
-	cdev = thermal_cooling_device_create(&pdev->dev, name, device, &fan_cooling_ops);
+	cdev = thermal_cooling_device_create(&pdev->dev, name, fan, &fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		result = PTR_ERR(cdev);
 		goto err_end;
-- 
2.51.0




