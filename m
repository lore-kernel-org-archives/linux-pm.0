Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141155;
	b=EhlkXYDthzl5hdc6XVbn2yY8uYZMPDvQDojugB4FyShkYRigPBQASt1FEvAEbxXvsX4k
	 6jWpsHuX8NR453afQsBgF5dQP7wrUOKdx0Y8j3qrPxJXTTSmYxICyF4BZZ8MmV+9u+M46
	 PzVFKYbcYk+b0J3MmrvKrgjZiZj4UkKMx+qhGvcgDtl1/zfPWZxyP/N/1TQP7lThyWYNK
	 Gr6YKLQM7aEcqOF24rFvxmvXpZozu4lEoTSOWHVA5SbL7gSmREzA5Te1cMGPjlibhMX6p
	 ZlifA698v5UBMTi7edOGPEYI66ivngMAZpZb4cwC4i/Oc4W1OnAnx7kgK4kzJklPUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2S9p2IwZ6XavDmdrTQ9R1nXJLgNp+n1leUdQhEa1gUo=;
	b=pk70R8lzT3yGLz75OQ97V5G95l8QxbNfmBMWIXXOltAcrLgu5ynAMjb3/4ICOyqYatzf
	 aNG8wqavQK6wNmvkBJq7jBBpDxcf6nJ2NWHLqbR64kFQ8UnWDH8Gyj0Z7Uz2trpHaDa6C
	 DthCLPFQ+su72fsHggGypexffDD2YEGOp5g3xS8rTnnFgzIf2bC13Hn+I1DjnR3Kens9P
	 yPeQRKQACzg9+7xE2nTZDz87zM+1SHzs01hHu0ZbAvZGa+fciEHJvLsXnd+WknFrg9Zau
	 E4/UVP66dRNZhxTFfrInXa/WLl4qabfedDwENmUz3tXxsEbtcvxSveVpaQReiC4DbeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EFo6qYAY;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFB606A31D
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 22:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EFB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EFo6qYAY
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so505200eec.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793141153; x=1793745953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2S9p2IwZ6XavDmdrTQ9R1nXJLgNp+n1leUdQhEa1gUo=;
        b=EFo6qYAYjbmpuM9lDFFuyKpsKYtmQ5wsMpQtehnjIS5Jv/x98Rru1Joq4rx1el7Ftm
         asqYeYkYfIyo+ihd4ZNzAx7BO3Vi6L7MH0pvZjw/2DvFLxdclGBHFlP5GOuEkHdAgGTu
         Yn7JwC1pc03UIyF3TZaPH3u2V/w+BxAW/52jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141153; x=1793745953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2S9p2IwZ6XavDmdrTQ9R1nXJLgNp+n1leUdQhEa1gUo=;
        b=mF2vvWF+PAoIfMtB6Fbcv+pYpER4yUMi60+qByewWqzJD1dLBYXPVnQx3G6H43z3gf
         FI5tUZxIsAuGk6n0Ei9iqk2d4g3I/ZKUNsnHlE1Mm7gtNPsJnjY9waF2ATvKLfZ4eZuU
         MeqsCXkx48Aax+4mUWkdr1G2aeuzoPI1Dgmxfzmiwl77j8OqJ5huSIX6e2H6DQI/oAbX
         dKAGPHhAU9FsLvvAoUSq82t01znBfmZQ6TIQuAf4AHsndDGkQdavf4G5DMb/+4GWZPxS
         9pVJetrdcvCvsF149R/u6XmnHTnn1uRAKiyekyR/+Kep1NMZtzGgXi+6cSi/X3lY3csF
         orNw==
X-Forwarded-Encrypted: i=1; AKwUvBx6axjyDd18LP3FBAjY6ZR1yoB6XPMezryI5EEyKoPfMfJYNgsUS0f68Ne9J0FCy6/6HSAbHR1FCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgQCKcILJxn8WxxDFiDxhYkSMNb829I33mWrsQBIgWb49EpB7C
	u5JWPnj/l/Twk2Db+YJFUdV/U4cqD/xfhY21WUP/pvbjSwN2g0jfE1K+yBwi9aN0iA==
X-Gm-Gg: AYBFou3SUGG60r/qjyb9k4ZjfRjqtm1b7UvPjXKi1JvYy07+LXoYCIfQuF8u2Qit80L
	FjWL4G6GEZW6MDIUUaUTzKwYZGUNwyQ/11PZms1UpwRSN7y1GIaYTMhRmYCqUFnNmdcn4gEYTNI
	9U6bJP3vMyosXXbM9ktad8LLVc9d+f33tlqRXxvIHa1FopNmnNVytr2OKxI2/dfMyNGIHOz2R97
	R5hBuSYUyhnGZo596F/axlQE08Z3cN8B7sZZeSQD0GzlmOIuwfkp3DTvFItBV9AUI8AdcD6Zq4C
	g1dxpgN0e4DFs8P+hRkBRyhNHTjlEzpNPSN6Bgd8cTyp4DFoJlMy0OQe4LrczZnM5XxEk0vl6w1
	sVNL5O9qsOui5kBSVfj3naGy+nepBn4C7T4rACzNm/pOk/pNczJiWr1tECCpB2cMe+tcm/FUv9v
	TGB8vZXrJPlXerYHl/2+OYQVh5h75/voN2flLE5CwQZqEcGE57QPrEqdSALsLQJWxZlaWsi8SAk
	DONUglKrmixzF6ea1T2hrWA9dr7zJ2kXyReKbtPIUp4fOHCI5cBaWUajJqqbactmQrOwwwt7irX
	BvGaQ7yChEFRRoXKIHqL
X-Received: by 2002:a05:7300:3082:b0:36a:1452:8dad with SMTP id 5a478bee46e88-36a203d0982mr1578378eec.20.1793141152909;
        Tue, 27 Oct 2026 15:45:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:2d45:5fa2:f626:22dd])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a005c0188sm24402852eec.9.2026.10.27.15.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:45:52 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5] PM: runtime: Add Example Driver Patterns section
Date: Tue, 27 Oct 2026 15:45:20 -0700
Message-ID: <20261027154519.v5.1.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM API surface is pretty large, but there are a few common
patterns that many drivers should follow. Add some illustrative
examples, to help guide the most common audience for runtime PM docs --
driver writers.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This was previously part of a series:
   "PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs"
The rest of the series has been applied, so this is now just 1 patch.

v1 is here:
https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium.org/

v2 is here:
https://lore.kernel.org/all/20260923174711.1283986-1-briannorris@chromium.org/

v3 is here:
https://lore.kernel.org/all/20260930025044.104824-1-briannorris@chromium.org/

v4 is here:
https://lore.kernel.org/all/20261001155118.1750028-1-briannorris@chromium.org/

I've tried to account for all the feedback from prior revisions, but
runtime PM is complicated, and it's hard to make a one-size-fits-all
(or, 3 to 6 sizes fit all?) example solution that covers all the most
relevant topics, without leaving too many unexplained/unaccounted corner
cases. I hope I struck the right balance.

Changes in v5:
 * Account for differing assumptions about initial device state,
   especially with ACPI and with PM domains.
 * Try to more precisely talk about "operational" and "non-operational"
   states, in case "powered on/off" has a different or confusing meaning
   (especially when considering PM domains).
 * Expand some of the pseudocode/comments to be more realistic and clear
   about what the code (foo_runtime_suspend(), foo_initialize(), etc.)
   is doing.
 * Be more verbose about what each step is doing, and what the entry and
   exit conditions look like.

Changes in v4:
 * "state" to "status", to be consistent with Introduction terminology

Changes in v3:
 * Rewrite Examples to avoid devm_* at first, to highlight correct
   approaches
 * Include error-handling and remove() in any probe() Examples
 * Advise more caution when using devm_*, as ordering issues are subtle

Changes in v2:
 * Add appropriate teardown to "Probe with Hardware Powered Off"
   Example, as the remove() + power-off behavior is subtle here, and
   easy to get wrong

 Documentation/power/runtime_pm.rst | 567 ++++++++++++++++++++++++++++-
 1 file changed, 565 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 40a5c23d5259..ef9e02ba893f 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_disable() etc.
 Alternatively, drivers can use devm_pm_runtime_enable() during probe, which
 automatically takes care of calling pm_runtime_disable() upon driver detachment.
 Any pm_runtime_use_autosuspend() calls in a driver will be automatically undone
-on driver exit.
+on driver exit. See also the Examples in `Section 10`_ for some effective
+strategies for driver teardown.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
@@ -654,7 +655,9 @@ The implementation is well suited for asynchronous use in interrupt contexts.
 However such use inevitably involves races, because the PM core can't
 synchronize ->runtime_suspend() callbacks with the arrival of I/O requests.
 This synchronization must be handled by the driver, using its private lock.
-Here is a schematic pseudo-code example::
+Here is a schematic pseudo-code example:
+
+.. code-block:: c
 
 	foo_read_or_write(struct foo_priv *foo, void *data)
 	{
@@ -720,3 +723,563 @@ pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
 callback while holding its private lock.  If the function returns a nonzero
 value then the delay has not yet expired and the callback should return
 -EAGAIN.
+
+.. _Section 10:
+
+10. Example Driver Patterns
+===========================
+
+The runtime PM API is large and complex, but most device drivers follow a small
+set of canonical patterns when interacting with runtime PM. This section
+illustrates standard patterns for device probing, performing I/O, and handling
+interrupts.
+
+Probe and Initialization
+------------------------
+
+There are at least two general strategies regarding how to initialize a device
+in a driver that wants to use runtime PM: one in which the driver fully brings
+the device to an operational state before enabling runtime PM, and one in which
+the driver does not. We explore example driver patterns for those two approaches
+in the following two examples, and then explore an example with devres-based
+resource teardown and with autosuspend.
+
+Enabling a Fully Operational Device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In this approach, a driver expects to find its device initially in a
+non-operational state, and it intends to bring the device into an operational
+state before enabling runtime PM. Such a device may initially be powered on to
+some extent (e.g., by a PM domain, which is powered on by the PM core), but it
+may still require device-specific initialization (e.g., clocks, regulators,
+device-specific programming) to become fully operational. Such a driver's
+probe() routine should perform any device-specific initialization, mark the
+device **active**, and then enable runtime PM. On probe() errors and in
+remove(), the driver should perform all these steps in reverse.
+
+.. code-block:: c
+
+	static int foo_initialize(struct platform_device *pdev)
+	{
+		/*
+		 * Perform device-specific initialization, to bring the device
+		 * into an operational state. For example, enable clocks, bring
+		 * device out of reset, etc.
+		 *
+		 * In some cases, one may choose to share this code with the
+		 * driver's .runtime_resume() implementation.
+		 */
+
+		[...]
+
+		return 0;
+	}
+
+	static int foo_teardown(struct platform_device *pdev)
+	{
+		/*
+		 * Perform device-specific teardown/power-down.
+		 *
+		 * In some cases, one may choose to share this code with the
+		 * driver's .runtime_suspend() implementation.
+		 */
+
+		[...]
+
+		return 0;
+	}
+
+	static int foo_probe(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+		struct foo_priv *priv;
+		int ret;
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		platform_set_drvdata(pdev, priv);
+
+		/* Acquire regulators, clocks, GPIOs, and register map... */
+		[...]
+
+		ret = foo_initialize(pdev);
+		if (ret)
+			return ret;
+
+		/*
+		 * The code above left hardware powered on and operational, so
+		 * tell the PM core that the device is active before enabling
+		 * runtime PM.
+		 */
+		pm_runtime_set_active(dev);
+
+		/* After this point, the device may suspend. */
+		pm_runtime_enable(dev);
+
+		/*
+		 * Perform remaining driver setup (e.g. register interrupts,
+		 * device nodes). If any step fails after enabling runtime PM,
+		 * we must unwind the PM initialization process.
+		 */
+		ret = foo_register_device(priv);
+		if (ret)
+			goto err_pm_disable;
+
+		/*
+		 * Upon successful return from ->probe(), the driver core
+		 * automatically executes pm_request_idle(dev), allowing the
+		 * device to suspend asynchronously if its usage counter is zero.
+		 */
+		return 0;
+
+	err_pm_disable:
+		/*
+		 * Ensure the device is active, so we tear it down from a
+		 * consistent state.
+		 */
+		pm_runtime_get_sync(dev);
+
+		/* Tear down in reverse order of initialization. */
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		foo_teardown(pdev);
+
+		/* Drop the reference we acquired a few lines above. */
+		pm_runtime_put_noidle(dev);
+
+		return ret;
+	}
+
+	static void foo_remove(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+		struct foo_priv *priv = platform_get_drvdata(pdev);
+
+		foo_unregister_device(priv);
+
+		/*
+		 * Ensure the device is active, so we tear it down from a
+		 * consistent state.
+		 */
+		pm_runtime_get_sync(dev);
+
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		foo_teardown(pdev);
+
+		/* Drop the reference we acquired a few lines above. */
+		pm_runtime_put_noidle(dev);
+	}
+
+Drivers using this pattern should ensure that hardware is left back at its
+initial state upon driver remove() or probe() error. This generally means
+unwinding any resource acquisition and undoing any programming sequences in
+reverse of the order performed in probe(). However, runtime PM has additional
+state to consider -- the device may potentially be either **active** or
+**suspended** during teardown, even if the device is otherwise currently unused.
+Consider, for example, if user space configured
+``/sys/devices/.../power/control`` to ``on``, or if the device has not yet
+idled.
+
+Thus, ``foo_remove()`` and ``err_pm_disable`` first ensure the device is active,
+and then disable runtime PM and tear down the device to its initial probe()
+state.
+
+Note that for some devices (e.g., devices with an ACPI PM domain),
+foo_initialize() and foo_teardown() may be minimal or even empty, as the PM
+domain performed the power-on work. Such drivers may still follow this general
+pattern, but also may be even simpler in some cases.
+
+Also note that device-managed helpers such as devm_pm_runtime_enable() and
+devm_pm_runtime_set_active_enabled() exist, but they only call
+pm_runtime_disable() upon driver unbind; they do not take care of device quiesce
+and power-off. See the `Autosuspend and Device-Managed Probe`_ section below for
+how to encapsulate complete teardown in a custom devm action.
+
+Enabling a Device in a Non-Operational State
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As an alternative approach, some drivers prefer to keep hardware powered off or
+in a low power non-operational state until actually needed, avoiding duplicate
+power sequencing logic between ->probe() and ->runtime_resume(), and potentially
+even avoiding unneeded power transitions during probe(). Because the initial
+runtime PM status of a device is suspended by default, the driver can enable
+runtime PM directly and rely on pm_runtime_resume_and_get() to trigger the
+->runtime_resume() callback when the driver needs to access hardware:
+
+.. code-block:: c
+
+	static int foo_runtime_suspend(struct device *dev)
+	{
+		struct foo_priv *priv = dev_get_drvdata(dev);
+
+		clk_disable_unprepare(priv->clk);
+		regulator_disable(priv->supply);
+
+		return 0;
+	}
+
+	static int foo_runtime_resume(struct device *dev)
+	{
+		struct foo_priv *priv = dev_get_drvdata(dev);
+		int ret;
+
+		ret = regulator_enable(priv->supply);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(priv->clk);
+		if (ret) {
+			regulator_disable(priv->supply);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	static int foo_probe(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+		struct foo_priv *priv;
+		int ret;
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		platform_set_drvdata(pdev, priv);
+
+		/* Acquire regulators, clocks, GPIOs, and register map... */
+		[...]
+
+		/*
+		 * Hardware starts in a non-operational state. The default
+		 * status is RPM_SUSPENDED, so no need for:
+		 * pm_runtime_set_suspended(dev);
+		 */
+
+		pm_runtime_enable(dev);
+
+		/*
+		 * Optional: power on the device via ->runtime_resume() to
+		 * verify device ID or perform initial hardware configuration.
+		 */
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto err_pm_disable;
+
+		ret = foo_verify_hardware_id(priv);
+		if (ret) {
+			pm_runtime_put_sync(dev);
+			goto err_pm_disable;
+		}
+
+		/*
+		 * Drop the usage counter, allowing ->runtime_suspend() to
+		 * power off the device until an I/O request arrives.
+		 */
+		pm_runtime_put(dev);
+
+		return 0;
+
+	err_pm_disable:
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev)) {
+			foo_runtime_suspend(dev);
+			pm_runtime_set_suspended(dev);
+		}
+		return ret;
+	}
+
+	static void foo_remove(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev)) {
+			foo_runtime_suspend(dev);
+			pm_runtime_set_suspended(dev);
+		}
+	}
+
+Similar to the previous example, drivers using this pattern also must exercise
+care when handling probe() errors or performing unbind/remove(), to ensure they
+clean up resources that they manage with runtime suspend/resume, and generally
+leave the device in the same state it was when the driver first probed. And
+again, one must consider that the device can be either **active** or
+**suspended** while unwinding. Typically, this may mean explicitly suspending
+the device if not already suspended.
+
+Note that this pattern requires ``CONFIG_PM``. When ``CONFIG_PM`` is disabled,
+pm_runtime_resume_and_get() returns 0 without calling ->runtime_resume(),
+leaving hardware unpowered. Drivers using this pattern should typically depend
+on ``CONFIG_PM``.
+
+Autosuspend and Device-Managed Probe
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the driver wants to use autosuspend, it should first configure the
+autosuspend delay and enable autosuspend before enabling runtime PM.
+
+Additionally, drivers can use device-managed (``devm_*``) helpers to clean up
+resources on probe failure or driver unbind. This provides an alternative to
+writing complicated ``goto``-based error paths, with similar teardown code in
+remove(). Note that drivers must still exercise care to avoid assuming a
+particular runtime PM status in these cases; a device may be either **active**
+or **suspended**, and so ``devm``-based teardown code must be written
+accordingly.
+
+.. code-block:: c
+
+	static int foo_runtime_suspend(struct device *dev)
+	{
+		return foo_teardown(to_platform_device(dev));
+	}
+
+	static int foo_runtime_resume(struct device *dev)
+	{
+		return foo_initialize(to_platform_device(dev));
+	}
+
+	/* Tear-down action, for error handling or driver unbind. */
+	static void foo_poweroff_action(void *data)
+	{
+		struct device *dev = data;
+
+		/* Runtime PM is already disabled by this point. */
+
+		if (!pm_runtime_status_suspended(dev)) {
+			/*
+			 * Power device back off, in case device was left active.
+			 * e.g., leverage .runtime_suspend() routine:
+			 */
+			foo_runtime_suspend(dev);
+
+			pm_runtime_set_suspended(dev);
+		}
+	}
+
+	static int foo_probe(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+		struct foo_priv *priv;
+		int ret;
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		platform_set_drvdata(pdev, priv);
+
+		/* Acquire regulators, clocks, GPIOs, and register map... */
+		[...]
+
+		/* Power on and initialize hardware registers... */
+		ret = foo_initialize(pdev);
+		if (ret)
+			return ret;
+
+		pm_runtime_set_active(dev);
+
+		/*
+		 * Guarantee hardware is powered off upon unbind or probe error.
+		 * Register this action before devm_pm_runtime_enable() to
+		 * ensure runtime PM status is frozen by the time we tear down
+		 * here.
+		 */
+		ret = devm_add_action_or_reset(dev, foo_poweroff_action, dev);
+		if (ret)
+			return ret;
+
+		/* Set autosuspend delay (e.g., 2000 ms) and enable autosuspend. */
+		pm_runtime_set_autosuspend_delay(dev, 2000);
+		pm_runtime_use_autosuspend(dev);
+
+		/*
+		 * Update last busy timestamp so the driver core's post-probe
+		 * pm_request_idle() respects the autosuspend delay.
+		 */
+		pm_runtime_mark_last_busy(dev);
+
+		/*
+		 * devm_pm_runtime_enable() ensures that pm_runtime_disable()
+		 * and pm_runtime_dont_use_autosuspend() are called upon driver
+		 * unbind.
+		 */
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+
+		return 0;
+	}
+
+Key points:
+
+* **Guaranteed Power-off on Detach**: Again similar to the previous examples, we
+  must exercise care in case the device was still active during probe failure or
+  driver unbind. In this case, we encapsulate the teardown using device-managed
+  actions.
+* **LIFO Teardown Ordering**: Because ``devm`` releases resources in reverse
+  order of registration (LIFO), registering foo_poweroff_action() before
+  devm_pm_runtime_enable() ensures that runtime PM is disabled first, and the
+  device is suspended *before* devm disables any clocks or regulators acquired
+  earlier in ->probe().
+* **Omission of ->remove()**: If all other resources in the driver are managed
+  with ``devm`` helpers, this eliminates both manual ``goto``-based unwinding in
+  ->probe() and the need for an explicit ->remove() callback.
+* **Initialization vs suspend/resume symmetry**: This example exploits the fact
+  that device-state initialization/teardown is often similar or identical to
+  runtime_resume()/runtime_suspend(), making it easier to perform appropriate
+  teardown in ``devm_`` teardown. If this is not the case, this becomes more
+  complicated, and ``devm_`` may not be the right approach to use.
+
+Performing I/O Operations
+-------------------------
+
+Before accessing hardware registers or initiating I/O transfers, drivers must
+ensure the device is active by calling pm_runtime_resume_and_get() or similar.
+
+Basic I/O
+~~~~~~~~~
+
+For devices without autosuspend, work completion is signaled with
+pm_runtime_put(), which drops the usage counter and queues an asynchronous idle
+check once the counter reaches zero:
+
+.. code-block:: c
+
+	int foo_do_transfer(struct foo_priv *priv, void *buf, size_t count)
+	{
+		int ret;
+
+		ret = pm_runtime_resume_and_get(priv->dev);
+		if (ret < 0)
+			return ret;
+
+		/* Access hardware registers or perform data transfer... */
+		ret = foo_hardware_transfer(priv, buf, count);
+
+		/*
+		 * Drop usage counter and request asynchronous idle check (and
+		 * suspend, if possible).
+		 */
+		pm_runtime_put(priv->dev);
+
+		return ret;
+	}
+
+Autosuspend I/O
+~~~~~~~~~~~~~~~
+
+For devices using autosuspend, work completion is signaled with
+pm_runtime_put_autosuspend(), which drops the usage counter and defers
+suspension until the autosuspend delay expires:
+
+.. code-block:: c
+
+	int foo_do_transfer(struct foo_priv *priv, void *buf, size_t count)
+	{
+		int ret;
+
+		ret = pm_runtime_resume_and_get(priv->dev);
+		if (ret < 0)
+			return ret;
+
+		/* Access hardware registers or perform data transfer... */
+		ret = foo_hardware_transfer(priv, buf, count);
+
+		/*
+		 * Drop the usage counter and schedule an autosuspend once
+		 * the delay expires. Note that pm_runtime_put_autosuspend()
+		 * updates the last-access timestamp automatically.
+		 */
+		pm_runtime_put_autosuspend(priv->dev);
+
+		return ret;
+	}
+
+Synchronous Completion
+~~~~~~~~~~~~~~~~~~~~~~
+
+When immediate suspension is desired -- such as before unregistering a device or
+during shutdown -- synchronous put helpers can be used instead of their
+asynchronous counterparts. Which helper to use depends on whether autosuspend is
+configured:
+
+* For non-autosuspend devices, use pm_runtime_put_sync().
+* For devices that use autosuspend, use pm_runtime_put_sync_suspend(), which
+  ignores any configured autosuspend delay and forces immediate suspension.
+
+However, note several important caveats when relying on synchronous runtime
+PM helpers for power-down:
+
+* **Parents and Suppliers**: While the target device itself is suspended
+  synchronously, the PM core handles idle notifications for parents and
+  device link suppliers asynchronously. As a result, parent devices or
+  power domain suppliers are not guaranteed to be powered off when the
+  function returns.
+* **User Policy ("Forbidden")**: Runtime PM helpers respect system policy.
+  If user space has set ``/sys/devices/.../power/control`` to ``on``
+  (pm_runtime_forbid()), the PM core holds an extra reference on the
+  device, meaning dropping the driver's usage counter will not trigger a
+  suspend.
+
+Because of these constraints, synchronous put helpers may not be suitable when a
+driver functionally requires hardware to be powered off synchronously (for
+example, to perform a hardware reset or power cycle). Such requirements may
+necessitate other methods, such as disabling runtime PM with
+pm_runtime_disable() and explicitly executing the hardware power-down sequence.
+
+Interrupt Handling with Conditional Get
+---------------------------------------
+
+Interrupt handlers (especially in atomic or hardirq context) cannot typically
+invoke pm_runtime_resume_and_get(), because runtime-resume may sleep. Moreover,
+if an interrupt arrives while the device is suspended or transitioning to low
+power (e.g., on a shared interrupt line or spurious wakeups), attempting to read
+hardware registers could trigger a bus fault or system hang.
+
+To handle this safely, drivers can conditionally acquire a runtime PM reference
+using pm_runtime_get_if_in_use() or pm_runtime_get_if_active():
+
+.. code-block:: c
+
+	static irqreturn_t foo_irq_handler(int irq, void *dev_id)
+	{
+		struct foo_priv *priv = dev_id;
+		irqreturn_t ret = IRQ_NONE;
+
+		/*
+		 * Check if the device is active before reading hardware
+		 * registers. If the device is suspended, this interrupt
+		 * cannot belong to us (or was already serviced).
+		 *
+		 * Note that this also will drop interrupts while runtime PM is
+		 * disabled.
+		 */
+		if (pm_runtime_get_if_active(priv->dev) <= 0)
+			return IRQ_NONE;
+
+		/* Hardware is active and usage count is incremented */
+		if (foo_has_pending_irq(priv)) {
+			foo_service_irq(priv);
+			ret = IRQ_HANDLED;
+		}
+
+		/*
+		 * Release the reference acquired by pm_runtime_get_if_active().
+		 * For autosuspend devices, use pm_runtime_put_autosuspend();
+		 * for non-autosuspend devices, use pm_runtime_put().
+		 */
+		pm_runtime_put_autosuspend(priv->dev);
+
+		return ret;
+	}
+
+Both pm_runtime_get_if_in_use() and pm_runtime_get_if_active() are safe to use
+from an interrupt routine. One example where a device might be active but not
+"in use" is if autosuspend is used. A device will stay active for a while with
+no users. If interrupts should still be serviced for a device in this state,
+pm_runtime_get_if_active() should be used.
-- 
2.56.0.307.g5fe7bd680c-goog

