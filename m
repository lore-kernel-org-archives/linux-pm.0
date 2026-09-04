Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA642E004
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556850; cv=none; b=E6Ji7fp7AO6HZFF6picQ7suhFr8tjQMFQI632MuGIDkvgcOn/b6WTHT2Kw3+MFWKQIWI9/E7qLoAxfBBEq3wS/O2UQa6UiOOLVb4DzdjOGJxwTjEsD9DE7/PXsA2v9BQB46tJkfjomCVMNlVRN8wgDtUuJ3FOlvgnt3llayVQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556850; c=relaxed/simple;
	bh=CTBW+rRmQcm5bB1KtVDvqWjtyepi/uHCJQSXb0G8Lyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iub2QWJ+CgAYLCHARke1PfxSSVlityg/JmGq7rWDV2KEOroTowkF8AFKsKHN8IcfYhqqRI7fg56PP67v4gVBaKakWrG1uK8lxLqG8QWKhXGLTFwv2FLH/unkkA4mZWj7X0NXTzwsWmBHWFpsClt8+/nyyRz5Twi+jxyvxTB5mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lN3yj35j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lN3yj35j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9004f39d3so17609465ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556847; x=1789161647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXxcP1aknWmW9ffXwSgdl9e8UEUswVdhRKWAevupZwU=;
        b=lN3yj35jEiObgDEPx2K4IsaFVHN1uokVRQFg9de53E7N4+PLZA6qhmfMvvJOKDHXbl
         c1lvydqIbFtNENXRjjThSmxiZ+LRMVDGopgkPadei/WnLyEc7UF/SBVePAECCAgwUkXL
         OB9D6W0nVGCCkaIeW1rK+Ic97yBBSxol1giTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556847; x=1789161647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXxcP1aknWmW9ffXwSgdl9e8UEUswVdhRKWAevupZwU=;
        b=Mlw2tQXGfmM6xBoBN4n3TYLwQYvNqOpG9TJx+iNjHq5hM5MJzG+Dr0IRDmY48Ayi5b
         nhrMoPsEGzXNacwZ9VeVdOnlku8L4aqMGcwOy+Q9SMqLR0W8vGdNrPjgN3Hfalds0LAO
         tvPWCdK8yzEpGFmNuDpt1QiJI7Q4dseoSYa1cCrzMj45qRCsYz5D3/+YInLb/rIYv8tT
         D0nkbQ4B1Jgy9Jm2yuXXY9VA/A2U/UofQyV7vLs1scX5j/5eAOJnaadjB2Fdcj+UxHU6
         E4N1EJyVYQLC0DdbgC/qxsonmhLfEyjdwIb2+u+dQ3Qs8bQEE0Lnl55qtXWMvDVEXNjS
         kVqw==
X-Forwarded-Encrypted: i=1; AKwUvBxmgYzpNyCu+/TSvJ9E2U+y8D+NVJNRzLlRwT5fcxTKFeRcIpi4cJJ8bT+3FZnochEDmJLp13qyhw==@vger.kernel.org
X-Gm-Message-State: AFuF++l8vuslzlabbHnBchA1JTeMkNSR+8e3S8OqjGYUQsquhhGkd8kj
	MNwRLIfqWzoj5BQh+zRc9pZDcwjFVBt8/5/hI5A1n05gx5yKpCsgC+s/onBDWdVzKw==
X-Gm-Gg: AYBFou3sgUSXWRiWAHgSoi4bXFE6czl3oB6uIdGkZCObBr+PzGvzH2Cael01PVBJ46o
	Idz8Le+95Y0bbCuDcPDNEYXozkQVAy0DkIzcl1iP9N70WKrscqLPpar0HQkHhDoLs4voUCLNW91
	dxM6tUWWWwYkTr+ssFGcfnj6S5RDS8iOWcQ5NmQtnVS9MveVQwBf4i2DzeLfSwEZzvzssl08wjo
	XYoXgfd7nw+fQlQfx1wUY9W/RKvk9N4Sq+GtM84yVNavqYIvQlskzvT6b4zLpj9aLVdrQCfbexF
	o2RZg6pweD6skFBa4FH1r74tyGLEWVjKmmavbBW4183UTkbT4BI94kfdBhfPTf2N/AR1F1siTXT
	X6NLD001pEhYhQYfHbNswviuE/uFEI/nO+VaVC3/J4t2xFAWuomfDtRoEqqGemSn5EBNSHJr+CZ
	5G/g527GqhxKOjsE/JPZ4BIm0aj3zp4F4TTz2kF02DvDttbL9zxjd13C4a73pFTWbsEXTGhsXM3
	IGe3GQOriBiHoKT76Iied345PQ=
X-Received: by 2002:a17:902:c40f:b0:2d7:107c:917b with SMTP id d9443c01a7336-2db1212ee51mr113486185ad.0.1788556847215;
        Fri, 04 Sep 2026 14:20:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339b8f44d7sm8949830eec.22.2026.09.04.14.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:46 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 11/11] PM: runtime: Add Example Driver Patterns section
Date: Fri,  4 Sep 2026 14:12:16 -0700
Message-ID: <20260904141215.11.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904212000.4167880-1-briannorris@chromium.org>
References: <20260904212000.4167880-1-briannorris@chromium.org>
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

 Documentation/power/runtime_pm.rst | 349 ++++++++++++++++++++++++++++-
 1 file changed, 348 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index d34f846ec822..74df4e822fb3 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -625,7 +625,9 @@ The implementation is well suited for asynchronous use in interrupt contexts.
 However such use inevitably involves races, because the PM core can't
 synchronize ->runtime_suspend() callbacks with the arrival of I/O requests.
 This synchronization must be handled by the driver, using its private lock.
-Here is a schematic pseudo-code example::
+Here is a schematic pseudo-code example:
+
+.. code-block:: c
 
 	foo_read_or_write(struct foo_priv *foo, void *data)
 	{
@@ -691,3 +693,348 @@ pm_runtime_autosuspend_expiration() from within the ->runtime_suspend()
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
+can initialize runtime PM using device-managed helpers:
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
+		/* Power on and initialize hardware registers... */
+
+		/*
+		 * The code above left hardware powered on and operational, so
+		 * tell the PM core that the device is active before enabling
+		 * runtime PM.
+		 */
+		pm_runtime_set_active(dev);
+
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+
+		/*
+		 * Alternatively, the above two calls can be combined into:
+		 * ret = devm_pm_runtime_set_active_enabled(dev);
+		 * if (ret)
+		 *     return ret;
+		 */
+
+		/*
+		 * Upon successful return from ->probe(), the driver core
+		 * automatically executes pm_request_idle(dev), allowing the
+		 * device to suspend asynchronously if its usage counter is zero.
+		 */
+		return 0;
+	}
+
+Probe with Hardware Powered Off
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Many drivers prefer to keep hardware powered off or in low power until
+actually needed, avoiding duplicate power sequencing logic between ->probe()
+and ->runtime_resume(). Because the initial runtime PM state of a device is
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
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+
+		/*
+		 * Power on the device via ->runtime_resume() to verify device
+		 * ID or perform initial hardware configuration.
+		 */
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			return ret;
+
+		ret = foo_verify_hardware_id(priv);
+		if (ret) {
+			pm_runtime_put(dev);
+			return ret;
+		}
+
+		/*
+		 * Drop the usage counter, allowing ->runtime_suspend() to
+		 * power off the device until an I/O request arrives.
+		 */
+		pm_runtime_put(dev);
+
+		return 0;
+	}
+
+Note that this pattern requires ``CONFIG_PM``. When ``CONFIG_PM`` is
+disabled, pm_runtime_resume_and_get() returns 0 without calling
+->runtime_resume(), leaving hardware unpowered. Drivers using this pattern
+should typically depend on ``CONFIG_PM``.
+
+Autosuspend Probe
+~~~~~~~~~~~~~~~~~
+
+If the driver uses autosuspend, it configures the autosuspend delay and enables
+autosuspend before enabling runtime PM:
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
+		/* Power on and initialize hardware registers... */
+
+		/* Set autosuspend delay (e.g. 2000 ms) and enable autosuspend */
+		pm_runtime_set_autosuspend_delay(dev, 2000);
+		pm_runtime_use_autosuspend(dev);
+
+		pm_runtime_set_active(dev);
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
+		/*
+		 * Update last busy timestamp so the driver core's post-probe
+		 * pm_request_idle() respects the autosuspend delay.
+		 */
+		pm_runtime_mark_last_busy(dev);
+
+		return 0;
+	}
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
2.55.0.979.g7e5102b832-goog

