Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48372420486
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185661; cv=none; b=KfplcADdnn+oeYLPNh88aU1JTVo8V5rNmP+QoYk5eylm/+6yHFWJUP8cGyCBcOhQ0IdYNsigq8Dlt2GpwgxzDytldQ16Ipi3VrZFudHhXbyGICt4tcnnFz1uVNksC8DIxp18mam9uZmhqMivyWi8Cf3QhmwSWoU/H89kvxh0D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185661; c=relaxed/simple;
	bh=HNhAwhGiJI8XpQjGibl8SR8njJRmYfryO09H5BYfZ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyu+azwUKkBWC+6gIA97lcrntM+OxU+5mGLSkjI14cpBMOocIAH5QLgi6+tR22svoberxkIqiPzdh8WUZdOR20D+Ew7edoCpYO9xfUjVWcOBO54cRtRaK5vPa6AuEdXAlh/+4PBctbkHrPrljN8v3P+1x5MwvkoicLKxiR1slOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0wM+/QW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0wM+/QW"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d93ff61046so7366135ad.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185658; x=1790790458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0FUTmKiKSraH2afuGbds8iMVikboWrVQOvL7iyG9Nc=;
        b=P0wM+/QWSeSzVyi+YQHCnDGANsNcwPJJsHTgEi4hdmql28QdXn9Kjr4zBZMvTkX8BE
         u28GTzBIkB9DHaRss7CGqt7LiKctj4yRuSdIiwaFMnKd4+Uis4AxvembmsniVYNlfJvm
         lOUPV676Yv/+nRPthUxAObnMIMjhTqfnk3qpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185658; x=1790790458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0FUTmKiKSraH2afuGbds8iMVikboWrVQOvL7iyG9Nc=;
        b=Y9UAY7xxUKVI9PI+4J5cPAGmhq6gbMjE7oQklRY3ZSGQjsLjYZF/IihKbHg5+2aU+z
         dHGmilMeOsWjDKRZfseTlzZP1q/x1o3NnBYV+Dp+mMknLd/8koKmUY2nJwIRJOpuhElP
         ksWvLTK4yTqzZUjmBzq8VnGjK3IB0fzw7PILhQrDR1IfXK7Tutj8GVsMdr5u95v4lzVe
         zZSG8wt90vBRMnxgdaJ796gyL6R7+68UO3wvxKP51h19pEA6FIfIrYvv4+tg/WGwLADM
         M/AwnRe89yiTufdRaklm5pX3NeGKfw+Hd5z9DS4+R/SLIFxiHm/Enx1foXd0BgD1qgjM
         2Nsg==
X-Forwarded-Encrypted: i=1; AKwUvBzqDBFknrBzUCUEZ07El+mhEyRoIn+TUHSS2PcsTEtNG0eGxW4arXW3WogTDA4CJQNJ8JdfIffyrA==@vger.kernel.org
X-Gm-Message-State: AFuF++lEkOEor8p29yh/jot7+Ibkihqp/9Vuq54WqmkVIV21ho9X0PLB
	QVD18mgSeGrI+M1dVgG87K1cBEfBN1mCu2Fe/4iISmE0KSOLk5LHLij9iA04GhWf8w==
X-Gm-Gg: AYBFou1lg8Oq226I7+K+d/pCi5N3KIl9zrZwJcjKEporqALfI3Pz8PhT1Q52AzXtC2c
	+qRAHYGuH/DBNAiPCYTwvk/sYdXW0VcaCQ6rvs4w43nhphuKYnFOzr+RAD/k8FLET3hVBEnib7B
	oyyENP6ON0L19BK+16u4m72HooheNQ2f+iGhXXjXJQOgjf48RpV7xgXqbyULGcRD5Rs2g8Z7SNB
	hEzT7aC1j40mCLpwRwCQb6sT79XfGh4YhZvKy6GOqnBwzS3TBBLWVqYtddAwsD/sLgFfeoNqoTG
	EpTr3h5xJtnC431nWVIOGZCbMbFxZBj6qT9RyQULNkYg0Xsz2XYruhvUpO4G0nGq4FUXdgKGhRE
	PgB5cXnqZWjv6J47Tz/53shsohHOaElcjjWNAXZzANj/aZrZQ4Jq03vQUDSYSbrzGvEFaaRgcye
	NN9r+tXOxX8SoVqGXoPhS1QYFW8EByC+SdSauKLXoWOvdTSt5JVKpNUGrsy+fk3SPPlRbbwQQE/
	CIz88f6XMVhCUxyjB69+XrgT9tN+AzqNeQDnmvmzBuAcSDQ
X-Received: by 2002:a17:902:ec81:b0:2dd:c100:3140 with SMTP id d9443c01a7336-2df69e015c9mr32107685ad.60.1790185658348;
        Wed, 23 Sep 2026 10:47:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2df6a60cc52sm15320815ad.83.2026.09.23.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:37 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/8] PM: runtime: Misc improvements to runtime_pm.rst
Date: Wed, 23 Sep 2026 10:40:27 -0700
Message-ID: <20260923104031.v2.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923174711.1283986-1-briannorris@chromium.org>
References: <20260923174711.1283986-1-briannorris@chromium.org>
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

(no changes since v1)

 Documentation/power/runtime_pm.rst | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 39fdeeda7a1e..352cdaf0650d 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -238,6 +238,9 @@ It is safe to execute the following helper functions from interrupt context:
 - pm_runtime_set_active()
 - pm_runtime_set_suspended()
 - pm_runtime_suspended()
+- pm_runtime_active()
+- pm_runtime_status_suspended()
+- pm_runtime_enabled()
 - pm_runtime_mark_last_busy()
 - pm_runtime_autosuspend_expiration()
 
@@ -249,6 +252,7 @@ functions may also be used in interrupt context:
 - pm_runtime_autosuspend()
 - pm_runtime_resume()
 - pm_runtime_get_sync()
+- pm_runtime_resume_and_get()
 - pm_runtime_put_sync()
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
@@ -258,7 +262,7 @@ functions may also be used in interrupt context:
 
 Initially, the runtime PM is disabled for all devices, which means that the
 majority of the runtime PM helper functions described in Section 4 will return
--EAGAIN until pm_runtime_enable() is called for the device.
+-EACCES until pm_runtime_enable() is called for the device.
 
 In addition to that, the initial runtime PM status of all devices is
 'suspended', but it need not reflect the actual physical state of the device.
@@ -287,7 +291,7 @@ enabled earlier by calling pm_runtime_enable().
 
 Note, if the device may execute pm_runtime calls during the probe (such as
 if it is registered with a subsystem that may call back in) then the
-pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
+pm_runtime_resume_and_get() call paired with a pm_runtime_put() call will be
 appropriate to ensure that the device is not put back to sleep during the
 probe. This can happen with systems such as the network device layer.
 
@@ -315,7 +319,10 @@ removal of their drivers.
 
 Drivers in ->remove() callback should undo the runtime PM changes done
 in ->probe(). Usually this means calling pm_runtime_disable(),
-pm_runtime_dont_use_autosuspend() etc.
+pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
+devm_pm_runtime_enable() during probe, which automatically takes care of
+calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
+detachment.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
@@ -426,7 +433,7 @@ out the following operations:
 
 Subsystems may wish to conserve code space by using the set of generic power
 management callbacks provided by the PM core, defined in
-driver/base/power/generic_ops.c:
+drivers/base/power/generic_ops.c:
 
 .. kernel-doc:: drivers/base/power/generic_ops.c
    :export:
@@ -441,8 +448,8 @@ subsystem-level dev_pm_ops structure.
 Device drivers that wish to use the same function as a system suspend, freeze,
 poweroff and runtime suspend callback, and similarly for system resume, thaw,
 restore, and runtime resume, can achieve similar behaviour with the help of the
-DEFINE_RUNTIME_DEV_PM_OPS() defined in include/linux/pm_runtime.h (possibly setting its
-last argument to NULL).
+DEFINE_RUNTIME_DEV_PM_OPS() macro defined in include/linux/pm_runtime.h
+(possibly setting its last argument to NULL).
 
 8. "No-Callback" Devices
 ========================
@@ -505,7 +512,7 @@ registration the length should be controlled by user space, using the
 
 In order to use autosuspend, subsystems or drivers must call
 pm_runtime_use_autosuspend() (preferably before registering the device), and
-thereafter they should use the various `*_autosuspend()` helper functions
+thereafter they should use the various \*_autosuspend() helper functions
 instead of the non-autosuspend counterparts::
 
 	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
@@ -515,7 +522,7 @@ instead of the non-autosuspend counterparts::
 
 Drivers may also continue to use the non-autosuspend helper functions; they
 will behave normally, which means sometimes taking the autosuspend delay into
-account (see pm_runtime_idle). The autosuspend variants of the functions also
+account (see pm_runtime_idle()). The autosuspend variants of the functions also
 call pm_runtime_mark_last_busy().
 
 Under some circumstances a driver or subsystem may want to prevent a device
@@ -558,7 +565,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_suspend(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 		int ret = 0;
 
 		lock(&foo->private_lock);
@@ -574,7 +581,7 @@ Here is a schematic pseudo-code example::
 
 	int foo_runtime_resume(struct device *dev)
 	{
-		struct foo_priv foo = container_of(dev, ...);
+		struct foo_priv *foo = container_of(dev, ...);
 
 		lock(&foo->private_lock);
 		/* ... resume the device ... */
-- 
2.56.0.rc1.310.g51773c2048-goog

