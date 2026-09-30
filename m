Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689F369D5E
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736674; cv=none; b=WU4WbBPMsTBavlqlFox0EbLMxojFBIt8lkfrtPavww6oz+YrjDDHsVTb/7lYRFaJQJuFH596vpjwaYh2OiO5/cWVCB+Y+1DGCsaukzsgFzwmYFnomk9WuVTFcJNgsVbrOFr7rdVp/9TLTr9erTCccvV45J8H9ksJslGu/+Co2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736674; c=relaxed/simple;
	bh=+mRGIHfZJxdollIjL9eqHpkoapmTNqTpxnY6S5CXpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh/8MLEHTYP3+qPmQjGXNc/npKXZ7M1Ncz1X1ZlV9X0JZwOjAb8iLc+Y0cxDhAFRqS1vFEhfoeg8u5B5EcWraoP96s+6GAJZcqknhnpEXbAhhv+IowtRTqLLWEZkiys3C5ah1ajNJaMWnKhA1AhlS9z1rQzAt5WP9YwpPTJCiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fv+UDLfi; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fv+UDLfi"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342773d94a7so3003984eec.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736668; x=1791341468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUtC1CcP1+N6+FEaLlZFZA6biMp3cUxkWFaWeHswCGg=;
        b=fv+UDLfiTp08BpoqmItCnKuvsmvxkA0/gBLtdrnvzkunMlQ0aavOSjhaPuxR8HKHa+
         dTKGoW6vXGa4AenBvHSSGYUqQpHlOqLtvlaNXJOGAgbQebiVbkFPPuPfNTZCZbicVPe9
         MOCNBsxLyohZIr43kdD0E172p8estVkxWZKw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736668; x=1791341468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUtC1CcP1+N6+FEaLlZFZA6biMp3cUxkWFaWeHswCGg=;
        b=B7B34qExbj2ryrGMUjR//Mqym5dEpmtNCObUW2GCK2DqV/wqEP72vKD/CNEjRUOMeb
         sIlU7vL3UEZVPFSaUefTv+SJyercRKOJvZa7Sur3r9Fdf60DtYGDrLFa3+9Zai0IO4j3
         75wnADRnL036ze+F+JA7kHfwZdrLxS4rzVh2UOvqyjDj+qVVwEHcyj3fkpLAOeyUddhl
         oFuiq5SxJ9gcvGOe/LPPdAUry+dTKs+7MBaZA2Rubw3JQ4m8z/bwF98+sm0BainxTppn
         rnClSxsSZsME+I+Yt5I6Xgr82NgHpbR4+6nefZdkNzWLMCnBSjMDqSJxz0zq7a//cXNN
         vS0A==
X-Forwarded-Encrypted: i=1; AKwUvBxfyH9jJiZwduRC8VBbGcsWjbBjEq0xOgcq1Sa4eoxD31o3vDB56HfJbsdSx7+p/BAaFnCidyAwgw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIQJYQhjHdTg0rRxpn7lEN9H9jINnvNdCoYA9wRDRxH53f8EkCY
	3yNEIsZQtELGP4Yk5EqbsYMMEg3/AfF2iPN7Yn5VqAe4Y6AtAPAsmPdqalFB6MbEKg==
X-Gm-Gg: AYBFou0oheiFJxo3Y7cYhUcqmJwe0vDRYget8+IPjP19sZNGHrHTeE9+jasmApHH+ic
	DK+bgZhPeSN3fUug2JFPG+n857ZVGimULruB7x/NNy1iwW5cxfuVIGtISL/neu1ROFa/DiF/E6y
	q2mnkTtGMldjDzKBe6CtZ0Y6wEqfEeAjoruyQRW99imeVaWGMC3M+nWYU/Xwyf+/Js9BcqMTuUP
	uByO0y5Ty85ddW5FPGeGkO3id+jS3jrZ4ypt4oOEZrSgkwaSo28YQgzTZO1/MQ5z73LgApFN77D
	9EcW6wiG2psLlMOP4nVLeLl56MYPomVlRfzpRn2PlyeFBTCQW51BN31H/HA03gWIID9G34ttylm
	0jZ9vH6UfzBJGot5iJOOxDPZkC8FAEyvXKiZLG+KNvSCL/sFwPQE8DAvsVFJgDrIwM7lrzVlTi4
	Sc/OwrixiEBNFgVL5x1nPLwPs5BmW+1PktHuEUueeKSPC8kV9sQpL8mSE/zvHLR0gXm9kazQxGb
	fKU7QR7JBpkkeV3yS0PgTBqWvm9gXm7NpM8
X-Received: by 2002:a05:7300:c4c1:b0:34b:5ab2:e221 with SMTP id 5a478bee46e88-34cdd0aaba6mr231282eec.33.1790736668294;
        Tue, 29 Sep 2026 19:51:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34c38bf0948sm2365585eec.25.2026.09.29.19.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:07 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 3/8] PM: runtime: Misc improvements to runtime_pm.rst
Date: Tue, 29 Sep 2026 19:49:51 -0700
Message-ID: <20260929194956.v3.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
References: <20260930025044.104824-1-briannorris@chromium.org>
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
devm_pm_runtime_enable() can be a tricky API to use correctly. I mention
it here for completeness, but see the Example updates in patch 8, which
help describe its pitfalls.

Changes in v3:
 * add pm_runtime_get_if_active(), pm_runtime_get_if_in_use() to
   interrupt-safe list

 Documentation/power/runtime_pm.rst | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 39fdeeda7a1e..59b634fd6829 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -229,6 +229,8 @@ It is safe to execute the following helper functions from interrupt context:
 - pm_request_resume()
 - pm_runtime_get_noresume()
 - pm_runtime_get()
+- pm_runtime_get_if_active()
+- pm_runtime_get_if_in_use()
 - pm_runtime_put_noidle()
 - pm_runtime_put()
 - pm_runtime_put_autosuspend()
@@ -238,6 +240,9 @@ It is safe to execute the following helper functions from interrupt context:
 - pm_runtime_set_active()
 - pm_runtime_set_suspended()
 - pm_runtime_suspended()
+- pm_runtime_active()
+- pm_runtime_status_suspended()
+- pm_runtime_enabled()
 - pm_runtime_mark_last_busy()
 - pm_runtime_autosuspend_expiration()
 
@@ -249,6 +254,7 @@ functions may also be used in interrupt context:
 - pm_runtime_autosuspend()
 - pm_runtime_resume()
 - pm_runtime_get_sync()
+- pm_runtime_resume_and_get()
 - pm_runtime_put_sync()
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
@@ -258,7 +264,7 @@ functions may also be used in interrupt context:
 
 Initially, the runtime PM is disabled for all devices, which means that the
 majority of the runtime PM helper functions described in Section 4 will return
--EAGAIN until pm_runtime_enable() is called for the device.
+-EACCES until pm_runtime_enable() is called for the device.
 
 In addition to that, the initial runtime PM status of all devices is
 'suspended', but it need not reflect the actual physical state of the device.
@@ -287,7 +293,7 @@ enabled earlier by calling pm_runtime_enable().
 
 Note, if the device may execute pm_runtime calls during the probe (such as
 if it is registered with a subsystem that may call back in) then the
-pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
+pm_runtime_resume_and_get() call paired with a pm_runtime_put() call will be
 appropriate to ensure that the device is not put back to sleep during the
 probe. This can happen with systems such as the network device layer.
 
@@ -315,7 +321,10 @@ removal of their drivers.
 
 Drivers in ->remove() callback should undo the runtime PM changes done
 in ->probe(). Usually this means calling pm_runtime_disable(),
-pm_runtime_dont_use_autosuspend() etc.
+pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
+devm_pm_runtime_enable() during probe, which automatically takes care of
+calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
+detachment.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
@@ -426,7 +435,7 @@ out the following operations:
 
 Subsystems may wish to conserve code space by using the set of generic power
 management callbacks provided by the PM core, defined in
-driver/base/power/generic_ops.c:
+drivers/base/power/generic_ops.c:
 
 .. kernel-doc:: drivers/base/power/generic_ops.c
    :export:
@@ -441,8 +450,8 @@ subsystem-level dev_pm_ops structure.
 Device drivers that wish to use the same function as a system suspend, freeze,
 poweroff and runtime suspend callback, and similarly for system resume, thaw,
 restore, and runtime resume, can achieve similar behaviour with the help of the
-DEFINE_RUNTIME_DEV_PM_OPS() defined in include/linux/pm_runtime.h (possibly setting its
-last argument to NULL).
+DEFINE_RUNTIME_DEV_PM_OPS() macro defined in include/linux/pm_runtime.h
+(possibly setting its last argument to NULL).
 
 8. "No-Callback" Devices
 ========================
@@ -505,7 +514,7 @@ registration the length should be controlled by user space, using the
 
 In order to use autosuspend, subsystems or drivers must call
 pm_runtime_use_autosuspend() (preferably before registering the device), and
-thereafter they should use the various `*_autosuspend()` helper functions
+thereafter they should use the various \*_autosuspend() helper functions
 instead of the non-autosuspend counterparts::
 
 	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
@@ -515,7 +524,7 @@ instead of the non-autosuspend counterparts::
 
 Drivers may also continue to use the non-autosuspend helper functions; they
 will behave normally, which means sometimes taking the autosuspend delay into
-account (see pm_runtime_idle). The autosuspend variants of the functions also
+account (see pm_runtime_idle()). The autosuspend variants of the functions also
 call pm_runtime_mark_last_busy().
 
 Under some circumstances a driver or subsystem may want to prevent a device
@@ -558,7 +567,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_suspend(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 		int ret = 0;
 
 		lock(&foo->private_lock);
@@ -574,7 +583,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_resume(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 
 		lock(&foo->private_lock);
 		/* ... resume the device ... */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

