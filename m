Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9788423EA4
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185665; cv=none; b=Z2ZUqB31yHQsqMw6+fxeUqojdffoew6UoBPkD43nqtUdy6pIfEK07sOipVhro5I2ukmxpm6u53WxhuzV1Isur7ODpGh9PBxgcNd7Xj/+4XWcrH2eLoVdgqAhHabH9zVb3owsNHFHR4XYRSlbFARdOaMWIMz+1Hdx/vseqjQgAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185665; c=relaxed/simple;
	bh=2BonED8RnAqLes9QDCALEvgg2CW7qcUbWR78q6mNvsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai1HquJ8AZtUpCDeqp6x0GlIpf15BuoTj6PL30YbGihp2G+YXNS9mSQw6kMh8BZMu6elLjSuM8B8KmiOuRDbaXjSqU39VJFkctur/eFNXRWtNmsABZutNB10LeE3dLrllVQ/3VZzJ2O/GvsFRInl6/HYodZaD/SG8RpFih+MoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PaN2aWOi; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaN2aWOi"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so730575b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185663; x=1790790463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9iFgQ0s/mszVKUPGKbaxhv7W2jRsjbdiTzglblCdQc=;
        b=PaN2aWOimi3oPnarGVs15gLb/h73S1FSxCn8IWNVVzlqMNb99z/37L4FNukD7v84Ri
         tJ6Dd+3bLv6F+AfChI2ht02Eu5MXO6fgqwZe1rNlM3pcd7wcynNb1hsaTgax5PRgXZu2
         s9yHgr56d7BB8cYOsqFvrb+108nyYJuiMxWqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185663; x=1790790463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9iFgQ0s/mszVKUPGKbaxhv7W2jRsjbdiTzglblCdQc=;
        b=PYKA2HzymwwRlJ4a8egVX2Z+pnmRl8gEp+RE+ejvLlwez12Xd5UMpxQ1VkHYZ2r/pn
         JxKFGAR4zY/KB7cukHIfnzihixCOxIZaFImyr3UY9mK4r8hPnDrIq5PZSR5XZTxReNI1
         /WAXp5UY0t+G7CdW6jFLTAeIB5dDu++MaDdHnkpXnsEPW3m5xyyU5xcCyh4hRaNQC+up
         Sn1loXUmozW9h5rqmcGRi4WOu7wYNnRYNbzcB4pMLsrg5utKEeYAy92QkfTuVUuNhI9J
         r0QaEJ9r4JuO4exnkPZftpwZOPx+BQWfOYKHKYgi8ZtYH2kX3Qz6YQAw0rQKO7oqGONr
         ynpQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+o6ldtiUhIzc8wbSvXg2aS9VNPY1D6n1X+iPANpkzb4yXKQMm0nDEpRa5EkG1ObDn98r+SGgaOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lYp0uBefQJ6rTTh+InYLyHpCmQzOlCTd4PvGd3BejtGPfbH+Hb
	0DM0eavsPz7xykOiQ8JKeqAfhejCNnUHz+mnxCtMqbgTb12uJDa3AZOnjZu9wy6lcw==
X-Gm-Gg: AYBFou0yMu3XrTsgkXBYhjmilUDiBLxNp9ODQZIQNy2QG8R9V+hDBvzCx5VRRo5ThOk
	Oh77D0ngxOYivbdMU9ffwpCKDM4cctOpTaNJkTjQlRdr6hqR3LZ1L9NySUSIQznE22714aKoKMp
	z/5ib6FGpa3Db4pDiVFygTUYi7aIsdqGvEyVf2iV+ITCvDBTOi6QUYsgrotMqh7A/T66qLiE3sM
	P4xSjj9fUMLxXjjfyvVMKlKlQXyGr+rXKNNbRjKcrUTGcfaUX57C9lj8v+OsdpeWCZM8GRPrSwD
	dXmTm++Li/djp5+zj0cIxU36HD+83zKX3vt4UUPb2l27agxCT1EFYBaZVeJK9yYGlmMgSSOo6H9
	C/RR946aFfdP+y1aOiOWAbsBbjG+5i7pwD9SGRMFYrHWi9rPTWmnacxtmQsLzBgV41t5IKf4K/O
	f0UYZUV8coHWhlxC4XPeZ47VOhA+VBmUE51BBLPDn0i85cs5KYedUv54zW8rdYs1/cS8MwFmoQ8
	4i8u+jfQnv01NrKNrDCj9aTAOoB4KHkWCqdQCA2y4YbcmO3Hw==
X-Received: by 2002:a05:6a20:734b:b0:3dd:a197:cf36 with SMTP id adf61e73a8af0-3ddf82e3484mr3304445637.90.1790185662903;
        Wed, 23 Sep 2026 10:47:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cc75f21f530sm1499260a12.2.2026.09.23.10.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:40 -0700 (PDT)
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
Subject: [PATCH v2 4/8] PM: runtime: Add "Section" hyperlinks
Date: Wed, 23 Sep 2026 10:40:28 -0700
Message-ID: <20260923104031.v2.4.I7666a5802ea59359afce4ff7d0b1af668e5f5292@changeid>
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

Add reStructuredText targets for each section, and use them throughout
to make the generated HTML more navigable.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Rebase to put this earlier in the series

 Documentation/power/runtime_pm.rst | 48 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 352cdaf0650d..114c4a872cb1 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -8,6 +8,8 @@ Runtime Power Management Framework for I/O Devices
 
 (C) 2014 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
+.. _Section 1:
+
 1. Introduction
 ===============
 
@@ -37,6 +39,8 @@ The runtime PM callbacks present in 'struct dev_pm_ops', the device runtime PM
 fields of 'struct dev_pm_info' and the core helper functions provided for
 runtime PM are described below.
 
+.. _Section 2:
+
 2. Device Runtime PM Callbacks
 ==============================
 
@@ -80,8 +84,8 @@ the PM core that it is safe to run the ->runtime_suspend(), ->runtime_resume()
 and ->runtime_idle() callbacks for the given device in atomic context with
 interrupts disabled.  This implies that the callback routines in question must
 not block or sleep, but it also means that the synchronous helper functions
-listed at the end of Section 4 may be used for that device within an interrupt
-handler or generally in an atomic context.
+listed at the end of `Section 4`_ may be used for that device within an
+interrupt handler or generally in an atomic context.
 
 The subsystem-level suspend callback, if present, is _entirely_ _responsible_
 for handling the suspend of the device as appropriate, which may, but need not
@@ -105,9 +109,9 @@ knows what to do to handle the device).
 
   * If the suspend callback returns an error code different from -EBUSY and
     -EAGAIN, the PM core regards this as a fatal error and will refuse to run
-    the helper functions described in Section 4 for the device until its status
-    is directly set to  either 'active', or 'suspended' (the PM core provides
-    special helper functions for this purpose).
+    the helper functions described in `Section 4`_ for the device until its
+    status is directly set to  either 'active', or 'suspended' (the PM core
+    provides special helper functions for this purpose).
 
 In particular, if the driver requires remote wakeup capability (i.e. hardware
 mechanism allowing the device to request a change of its power state, such as
@@ -132,10 +136,10 @@ what to do to handle the device).
     'active'.
 
   * If the resume callback returns an error code, the PM core regards this as a
-    fatal error and will refuse to run the helper functions described in Section
-    4 for the device, until its status is directly set to either 'active', or
-    'suspended' (by means of special helper functions provided by the PM core
-    for this purpose).
+    fatal error and will refuse to run the helper functions described in
+    `Section 4`_ for the device, until its status is directly set to either
+    'active', or 'suspended' (by means of special helper functions provided by
+    the PM core for this purpose).
 
 The idle callback (a subsystem-level one, if present, or the driver one) is
 executed by the PM core whenever the device appears to be idle, which is
@@ -158,9 +162,9 @@ call to pm_runtime_autosuspend(). To prevent this (for example, if the callback
 routine has started a delayed suspend), the routine must return a non-zero
 value.  Negative error return codes are ignored by the PM core.
 
-The helper functions provided by the PM core, described in Section 4, guarantee
-that the following constraints are met with respect to runtime PM callbacks for
-one device:
+The helper functions provided by the PM core, described in `Section 4`_,
+guarantee that the following constraints are met with respect to runtime PM
+callbacks for one device:
 
 (1) The callbacks are mutually exclusive (e.g. it is forbidden to execute
     ->runtime_suspend() in parallel with ->runtime_resume() or with another
@@ -200,6 +204,8 @@ rules:
     scheduled requests to execute the other callbacks for the same device,
     except for scheduled autosuspends.
 
+.. _Section 3:
+
 3. Runtime PM Device Fields
 ===========================
 
@@ -210,6 +216,8 @@ state.
 .. kernel-doc:: include/linux/pm.h
    :identifiers: dev_pm_info
 
+.. _Section 4:
+
 4. Runtime PM Device Helper Functions
 =====================================
 
@@ -257,12 +265,14 @@ functions may also be used in interrupt context:
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
 
+.. _Section 5:
+
 5. Runtime PM Initialization, Device Probing and Removal
 ========================================================
 
 Initially, the runtime PM is disabled for all devices, which means that the
-majority of the runtime PM helper functions described in Section 4 will return
--EACCES until pm_runtime_enable() is called for the device.
+majority of the runtime PM helper functions described in `Section 4`_ will
+return -EACCES until pm_runtime_enable() is called for the device.
 
 In addition to that, the initial runtime PM status of all devices is
 'suspended', but it need not reflect the actual physical state of the device.
@@ -285,7 +295,7 @@ pm_runtime_set_suspended().
 If the default initial runtime PM status of the device (i.e. 'suspended')
 reflects the actual state of the device, its bus type's or its driver's
 ->probe() callback will likely need to wake it up using one of the PM core's
-helper functions described in Section 4.  In that case, pm_runtime_resume()
+helper functions described in `Section 4`_.  In that case, pm_runtime_resume()
 should be used.  Of course, for this purpose the device's runtime PM has to be
 enabled earlier by calling pm_runtime_enable().
 
@@ -336,6 +346,8 @@ value of /sys/devices/.../power/control to "auto" to allow the driver to power
 manage the device at run time, the driver may confuse it by using
 pm_runtime_forbid() this way.
 
+.. _Section 6:
+
 6. Runtime PM and System Sleep
 ==============================
 
@@ -428,6 +440,8 @@ out the following operations:
     callback and right after executing the subsystem-level .complete() callback
     for it, respectively.
 
+.. _Section 7:
+
 7. Generic subsystem callbacks
 ==============================
 
@@ -451,6 +465,8 @@ restore, and runtime resume, can achieve similar behaviour with the help of the
 DEFINE_RUNTIME_DEV_PM_OPS() macro defined in include/linux/pm_runtime.h
 (possibly setting its last argument to NULL).
 
+.. _Section 8:
+
 8. "No-Callback" Devices
 ========================
 
@@ -487,6 +503,8 @@ in subsystems/drivers, the PM core allows runtime PM callbacks to be
 unassigned. More precisely, if a callback pointer is NULL, the PM core will act
 as though there was a callback and it returned 0.
 
+.. _Section 9:
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.56.0.rc1.310.g51773c2048-goog

