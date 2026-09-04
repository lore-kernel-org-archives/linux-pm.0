Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02B41F5ED
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556844; cv=none; b=OGMmYxmURy3lqcajtfrFhCMEwnz64Z2ryIJz3gM7uH7VD7Mv109/R7Gg9cB8AqNyEJbpiTHWw47749JDJciRIJ3L9VQ6ZCG4MFJmJ/3FYT6O8CHyQW86YPw0Mk0wOp60+NzHk+GD/baDc6+rCzlMsfRbaVy22s8VLMfli4KPSLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556844; c=relaxed/simple;
	bh=an4306lbd9gYljGt3gjoP2fU6r9hl/qCRg/3E2XP8aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzfmIY8I0BM40p2LjtU8lQdbnoPVX3Mokefv4/roSEeLj8psySE+gTGpTQlOqOLhLbooHF8WVBZFbYg/HpAsygpg/dP8Y44L7IPH/9gkbN5o9ErWm67DLaQtN1tMM+lYX0LEhJJOmRirrr9Ce/PLMaQKUjPrMq8WUs3rVmv6WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ULc3j4G9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULc3j4G9"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso1269062a91.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556842; x=1789161642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwLinra99aXycX9ldNYRzirNUG5NNrsETkODdowC3mE=;
        b=ULc3j4G9bKSyPD/HMpCPHNZ9pB0wLQxIAZAHO6r+WxWL1Wo1Gl9UwndodDKwTkchC0
         svuZZ++n1Lt4P08VeTpjWupGfUtFhM3sszcB0ynI5Qthz1FcJovlsYhDwJuPc7CTfwnZ
         HNTGdRF+A4ehVTPJSzd42fYauw19/2hvMPPpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556842; x=1789161642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bwLinra99aXycX9ldNYRzirNUG5NNrsETkODdowC3mE=;
        b=cxUZQBBF22kot65yySf9tfHMdEvhNrDT7+1szy616+D0iAwRTOQGZ1IOGhtPcxu8YC
         RVMqgid5eakW/7sMegh+sw+6a7oKTEMcbrq/B7IYo9aT3rhEpusWmsuPkazxmyk17rdK
         fxkOdACMvc6m77bdxHwASdqvtjbKbvEB3XiMVwwbAe8Qm/XHuMI5X8OHjVBAa3uEVOPv
         AiTIc/DOcLKGBhh/TQCNsLnGpz3xag4QeqPzZ8BgB85EI9zdMqgxFIkuiuj2P9ysj2tW
         GTQrQvgQyrFkVE2t8EMABZXzIz1eo1hz3F6orPJszBtSXiyfu57dNKPuURB5ZPo+SXMq
         7xNg==
X-Forwarded-Encrypted: i=1; AKwUvBxDOcGY0520TnCSgyV3a2C56BMCeTT2C697BiiZ6xPmq/IqN21bpoWoszmZ95aEN6dpXOCb5cIkJg==@vger.kernel.org
X-Gm-Message-State: AFuF++lrn09w5AZoYTHK9aWNQAWnuWW09XLAgsL8qlW62W1EVuDSIqHR
	y57dS26B4w9xZAvfgYlZ1BCXvZDznNRFCcVkxV1s5Tr3SxE3DlcQFVEDF0qqEKAiIA==
X-Gm-Gg: AYBFou3wMrtM2YDQuiXQIPNScJjCwf3BjdNqDMjnMWHhkZfkkKazZgya/O+hlSzmUPm
	t9bP1Wyu/FpWwzMx4JDvH5QXwR4WXPnpp8Jk1dd2rwVZO5OmQYNBRRfTvLeybnQJTVrKHsaR5kv
	CNMnK520uvM6E+jWWEbe2xe1Q5HE2lLsn3a/ZHs6KqrfJqwZwWP1ShkQVerw7Oxn5KnqUUR2oKk
	vaLViLAqcz5hNYeVAYkDpcoTw03eOZXth8LPfLEQSwVUilYt6E7IlDuCGeiloOd7xCPW3Wg0Hsb
	tgbCfsFL2OIME4jKxesNbkqkNJGWbg2cNFvsuL8IUHxZrz0IWhDlsAeIlmqVHgVf7xkzdOgre74
	zE1zFFBxaQmbw7TGciKNT7d8PD13fMkb+Cbw1mo/TIVoh6zUNT9eERKcmxVWhMUjDBrdWSNDklP
	BnWRw4thgfAUbGMC1lsxsVbA5zHhT/J2wy+cXaGTXRt7ExBhuJU6Jy2/kjgn1B1PsnTEu0YRYrv
	fFSSqktL4x2/bICyYlsFLk3IqiUmbCB6lHCyw==
X-Received: by 2002:a17:90b:280b:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39b261cfebdmr11555869a91.14.1788556841868;
        Fri, 04 Sep 2026 14:20:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339bdf26c5sm8398706eec.27.2026.09.04.14.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:41 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 09/11] PM: runtime: Misc improvements to runtime_pm.rst
Date: Fri,  4 Sep 2026 14:12:14 -0700
Message-ID: <20260904141215.9.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
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

There are several small errors and omissions, as well as new updates
(pm_runtime_resume_and_get(), devm_pm_runtime_enable()) we should
incorporate.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 571a2f29851b..8e4e03b7dbfe 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -306,6 +306,9 @@ It is safe to execute the following helper functions from interrupt context:
 - pm_runtime_set_active()
 - pm_runtime_set_suspended()
 - pm_runtime_suspended()
+- pm_runtime_active()
+- pm_runtime_status_suspended()
+- pm_runtime_enabled()
 - pm_runtime_mark_last_busy()
 - pm_runtime_autosuspend_expiration()
 
@@ -317,6 +320,7 @@ functions may also be used in interrupt context:
 - pm_runtime_autosuspend()
 - pm_runtime_resume()
 - pm_runtime_get_sync()
+- pm_runtime_resume_and_get()
 - pm_runtime_put_sync()
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
@@ -326,7 +330,7 @@ functions may also be used in interrupt context:
 
 Initially, the runtime PM is disabled for all devices, which means that the
 majority of the runtime PM helper functions described in Section 4 will return
--EAGAIN until pm_runtime_enable() is called for the device.
+-EACCES until pm_runtime_enable() is called for the device.
 
 In addition to that, the initial runtime PM status of all devices is
 'suspended', but it need not reflect the actual physical state of the device.
@@ -355,7 +359,7 @@ enabled earlier by calling pm_runtime_enable().
 
 Note, if the device may execute pm_runtime calls during the probe (such as
 if it is registered with a subsystem that may call back in) then the
-pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
+pm_runtime_resume_and_get() call paired with a pm_runtime_put() call will be
 appropriate to ensure that the device is not put back to sleep during the
 probe. This can happen with systems such as the network device layer.
 
@@ -383,7 +387,10 @@ removal of their drivers.
 
 Drivers in ->remove() callback should undo the runtime PM changes done
 in ->probe(). Usually this means calling pm_runtime_disable(),
-pm_runtime_dont_use_autosuspend() etc.
+pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
+devm_pm_runtime_enable() during probe, which automatically takes care of
+calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
+detachment.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
@@ -494,7 +501,7 @@ out the following operations:
 
 Subsystems may wish to conserve code space by using the set of generic power
 management callbacks provided by the PM core, defined in
-driver/base/power/generic_ops.c:
+drivers/base/power/generic_ops.c:
 
 .. kernel-doc:: drivers/base/power/generic_ops.c
    :export:
@@ -509,8 +516,8 @@ subsystem-level dev_pm_ops structure.
 Device drivers that wish to use the same function as a system suspend, freeze,
 poweroff and runtime suspend callback, and similarly for system resume, thaw,
 restore, and runtime resume, can achieve similar behaviour with the help of the
-DEFINE_RUNTIME_DEV_PM_OPS() defined in include/linux/pm_runtime.h (possibly setting its
-last argument to NULL).
+DEFINE_RUNTIME_DEV_PM_OPS() macro defined in include/linux/pm_runtime.h
+(possibly setting its last argument to NULL).
 
 8. "No-Callback" Devices
 ========================
@@ -573,7 +580,7 @@ registration the length should be controlled by user space, using the
 
 In order to use autosuspend, subsystems or drivers must call
 pm_runtime_use_autosuspend() (preferably before registering the device), and
-thereafter they should use the various `*_autosuspend()` helper functions
+thereafter they should use the various \*_autosuspend() helper functions
 instead of the non-autosuspend counterparts::
 
 	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
@@ -583,7 +590,7 @@ instead of the non-autosuspend counterparts::
 
 Drivers may also continue to use the non-autosuspend helper functions; they
 will behave normally, which means sometimes taking the autosuspend delay into
-account (see pm_runtime_idle). The autosuspend variants of the functions also
+account (see pm_runtime_idle()). The autosuspend variants of the functions also
 call pm_runtime_mark_last_busy().
 
 Under some circumstances a driver or subsystem may want to prevent a device
@@ -626,7 +633,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_suspend(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 		int ret = 0;
 
 		lock(&foo->private_lock);
@@ -642,7 +649,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_resume(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 
 		lock(&foo->private_lock);
 		/* ... resume the device ... */
-- 
2.55.0.979.g7e5102b832-goog

