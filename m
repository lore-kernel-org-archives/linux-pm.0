Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDEE3E00B5
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869914; cv=none; b=Ps7S3BWJl2YUd7IvjmpvOXMjn4DBeDJ3o++XDeMKzNR+qqZXnQ/oFv9xV2jrWU8hlHhCBlowUz2fNSXv6P43lvxDbAo5fKNQi35xhiRGYs3X1qALWLNjY9Snh+Zkfo40+K4fL7pKgf5JHzYt3SFG43xcXdCahLnyuKH3rKAyyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869914; c=relaxed/simple;
	bh=SVDCHWsYPmsgSYVuKj8b1x5lC29irn5V1jfNngUFnMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxdigVrOlIwJHKdLVlnI+7i2hbzkZ918Q/q47WwGg/ME9M6H98hZ3HbXgU9ACATQIoYHp6n28PJtdnPnqYbU4qlkB15PMC7dF4aMmGivz17RNZfRRtiYG3cdWCEleVK3B+sbSnUxGutvWF0L2ewXk682V9igH2jMrj9FpvW7jA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m21DyZ3/; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m21DyZ3/"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so4123265c88.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790869910; x=1791474710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zt9JyDXmTGDDbq3TOFvk6pJbQMamUp+44tse3lGeGOo=;
        b=m21DyZ3/QLdmgW/143S8R1gkqpgNkVvfN8ZYAjMpIHlygVuYewAInPqfi1URcRRiBa
         ttp3GQLcKtolSDZ9bee+ZyZAkMoV7MifnQ3tH4CiCyRcobsSCvJWbd9n/16BCtwJG0rZ
         1pzofbF7skPPmvMefWMWruYgvzKRP8j9kl63Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869910; x=1791474710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zt9JyDXmTGDDbq3TOFvk6pJbQMamUp+44tse3lGeGOo=;
        b=geVLO1UZkHSQsnnKAjV52rQUp7SGpkgHoDvQ6dRzDitkEic4neyLIz6TGtVY5yXcCO
         kbG6fBZL7fb8jtJHSb3NlIUC542w6zgFv4tJCYznAfKfeFa6jecD7rxIliRV6EaxNrBN
         fB6dwqj0iJfVMtjcBKgJJVqNgy6nc9Vb7i/sNcNtsI0A0sC9KdCKoKFFzVte68Aws+qB
         7jZryicf9An9sLM/7PLZ/bsJLrGuyVqKBZxmaeGEzEJ/zAzHHs6Vij2wQfeDdldfChsD
         NjCyImmpGP6RRWfXRWlasGNR2Ng6KxjEAj6pKTQ8fDMhD/iEP9TlRjcBJ5aC/pKnuGfQ
         UmGA==
X-Forwarded-Encrypted: i=1; AKwUvBwJxYhWPthDWfkvaZZ/5ZZnxnwmLID3FBvUFYmBxGs3kCGDzM0zT+GFQJqxzmfXz2IwCQJLhak+zg==@vger.kernel.org
X-Gm-Message-State: AFuF++lvcTuCZpkgKI5wjlUWb43LP/ccqJzF4FdtkIy8sgjU3gZiWuPU
	I/dzKXVo2YHAHpOxnzkepD1cQI+CPwN+Uxn/IhtFZFZ5QsH/huKtXIX5hDdBilBIkw==
X-Gm-Gg: AYBFou2HLWCKb8W50Eag8e1UPR5qlYRmYvMzvlDGne8QHc+SCIoPuJCHYJH0uMzOCtt
	FmPhUI27ys6rNlgZJpwPpOzcK0tCdxGipwavr+0OJ5c5j+bsIGueSdDiiVtbhHNj7ymwpr11DEk
	WEd374GjYiPqgfEdd26tEN2R1SM/owDImVLUoomNPn8CInLlozmgMfIjf++eODY/BQY5GfC6xBw
	yO7Wkl0O4fwLuXgUm4ZWPpv3mfu6VQlT1Qz/8xXqX9rrG0czaI7bkgrESVdjZ4WxfpprvzXGtYL
	s1hYV9sXug+KJivRfFyKKpwRYHBwkPZEiSe9Ap2bt0uHtJY+Pqqcny24ZYJexi5scQ4jj7y8pm1
	1XS0ALG4vbL3V+K1IuVT8ZNhbAC9h0H/7EMbgNnxpm6lYpV0SVGU7h+DLHI9vKekxbABoDaB4bz
	UgwP4DHLOl4zIKSCmjpY5TQLxqMi7kctEokwpCRUUeIYb80KgnqAnc8DPI5vXvpTTAVo1kEhJ8Y
	Wjfs43RzhjgcS+Nu4uYC+Beom1umhuklAk1nN4=
X-Received: by 2002:a05:701b:4191:10b0:143:761a:863e with SMTP id a92af1059eb24-14d33a63c54mr4988582c88.44.1790869910141;
        Thu, 01 Oct 2026 08:51:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:7cf1:ee59:f140:7be9])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14f246d398asm291129c88.2.2026.10.01.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:51:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
Date: Thu,  1 Oct 2026 08:50:09 -0700
Message-ID: <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261001155118.1750028-1-briannorris@chromium.org>
References: <20261001155118.1750028-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM API surface is pretty large, but there are a few common
patterns that many drivers should follow. Add some illustrative
examples, to help guide the most common audience for runtime PM docs --
driver writers.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

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

 Documentation/power/runtime_pm.rst | 475 ++++++++++++++++++++++++++++-
 1 file changed, 473 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index e4407b687f8b..cb25e0bb4ca7 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -429,7 +429,8 @@ in ->probe(). Usually this means calling pm_runtime_disable(),
 pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
 devm_pm_runtime_enable() during probe, which automatically takes care of
 calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
-detachment.
+detachment. See also the Examples in `Section 10`_ for some effective
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
@@ -720,3 +723,471 @@ pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
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
+Basic Probe
+~~~~~~~~~~~
+
+A driver that powers on its hardware during probe and does not use autosuspend
+can initialize runtime PM using standard helpers:
+
+.. code-block:: c
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
+		/* Power on and initialize hardware registers... */
+
+		/*
+		 * The code above left hardware powered on and operational, so
+		 * tell the PM core that the device is active before enabling
+		 * runtime PM.
+		 */
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+
+		/*
+		 * Perform remaining driver setup (e.g. register interrupts, device nodes).
+		 * If any step fails after enabling runtime PM:
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
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev)) {
+			/*
+			 * Power back off, in case device did not suspend yet.
+			 * For example, leverage your .runtime_suspend()
+			 * implementation:
+			 */
+			foo_runtime_suspend(dev);
+			pm_runtime_set_suspended(dev);
+		}
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
+		pm_runtime_disable(dev);
+		/*
+		 * The runtime PM status is not guaranteed at this point. We
+		 * could be either suspended or active, so we need to handle
+		 * both.
+		 */
+		if (!pm_runtime_status_suspended(dev)) {
+			/* Power back off, in case device did not suspend yet. */
+			foo_runtime_suspend(dev);
+			pm_runtime_set_suspended(dev);
+		}
+	}
+
+Drivers using this pattern should ensure that hardware is powered off cleanly
+upon driver unbind or probe error. If the device was still active when detached
+(for example, if user space configured ``/sys/devices/.../power/control`` to
+``on``, or if the device has not yet idled), ``foo_remove()`` and
+``err_pm_disable`` disable runtime PM, check whether the device is not yet
+suspended using pm_runtime_status_suspended(), and manually power the device
+back off.
+
+Note that device-managed helpers such as devm_pm_runtime_enable() and
+devm_pm_runtime_set_active_enabled() exist, but they only call
+pm_runtime_disable() upon driver unbind; they do not take care of device
+quiesce and power-off. See the `Autosuspend and Device-Managed Probe`_ section
+below for how to encapsulate complete teardown in a custom devm action.
+
+Probe with Hardware Powered Off
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Many drivers prefer to keep hardware powered off or in low power until
+actually needed, avoiding duplicate power sequencing logic between ->probe()
+and ->runtime_resume(). Because the initial runtime PM status of a device is
+suspended by default, the driver can enable runtime PM directly and rely on
+pm_runtime_resume_and_get() to trigger the ->runtime_resume() callback when
+probe needs to access hardware:
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
+
+		/*
+		 * Hardware starts powered off. The default state is
+		 * RPM_SUSPENDED, so no need for:
+		 * pm_runtime_set_suspended(dev);
+		 */
+
+		pm_runtime_enable(dev);
+
+		/*
+		 * Power on the device via ->runtime_resume() to verify device
+		 * ID or perform initial hardware configuration.
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
+Note that this pattern requires ``CONFIG_PM``. When ``CONFIG_PM`` is
+disabled, pm_runtime_resume_and_get() returns 0 without calling
+->runtime_resume(), leaving hardware unpowered. Drivers using this pattern
+should typically depend on ``CONFIG_PM``.
+
+Similar to the Basic Probe example, drivers using this pattern also must
+exercise care when handling probe() errors or performing unbind/remove(), to
+ensure they power off and clean up resources that they manage with runtime
+suspend/resume. Typically, this may mean explicitly powering off if not already
+suspended.
+
+Autosuspend and Device-Managed Probe
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the driver uses autosuspend, it configures the autosuspend delay and enables
+autosuspend before enabling runtime PM.
+
+Additionally, drivers can use device-managed (``devm_*``) helpers to clean up
+resources on probe failure or driver unbind. This provides an alternative to
+writing complicated ``goto``-based error paths, with similar teardown code in
+remove(). Note that drivers must still exercise care to avoid assuming a
+particular runtime PM status in these cases; a device typically may be either
+**active** or **suspended**, and so ``devm``-based teardown code must be
+written accordingly.
+
+.. code-block:: c
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
+		/* Power on and initialize hardware registers... */
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
+* **Guaranteed Power-off on Detach**: Again similar to the Basic Probe example,
+  we must exercise care in case the device was still active during probe
+  failure or driver unbind. In this case, we encapsulate the teardown using
+  device-managed actions.
+* **LIFO Teardown Ordering**: Because devm releases resources in reverse
+  order of registration (LIFO), registering foo_poweroff_action() before
+  devm_pm_runtime_enable() ensures that runtime PM is disabled first, and the
+  device is suspended *before* devm disables any clocks or regulators
+  acquired earlier in ->probe().
+* **Omission of ->remove()**: If all other resources in the driver are managed
+  with ``devm`` helpers, this eliminates both manual ``goto``-based unwinding
+  in ->probe() and the need for an explicit ->remove() callback.
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
+When immediate suspension is desired -- such as before unregistering a
+device or during shutdown -- synchronous put helpers can be used instead of
+their asynchronous counterparts. Which helper to use depends on whether
+autosuspend is configured:
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
+Because of these constraints, synchronous put helpers may not be suitable
+when a driver functionally requires hardware to be powered off
+synchronously (for example, to perform a hardware reset or power cycle).
+Such requirements may necessitate other methods, such as disabling runtime
+PM with pm_runtime_disable() and explicitly executing the hardware
+power-down sequence.
+
+Interrupt Handling with Conditional Get
+---------------------------------------
+
+Interrupt handlers (especially in atomic or hardirq context) cannot typically
+invoke pm_runtime_resume_and_get(), because runtime-resume may sleep. Moreover,
+if an interrupt arrives while the device is suspended or transitioning to low
+power (e.g., on a shared interrupt line or spurious wakeups), attempting to
+read hardware registers could trigger a bus fault or system hang.
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
2.56.0.rc1.315.gc6ed9934b7-goog

