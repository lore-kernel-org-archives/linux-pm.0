Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA1421251
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185678; cv=none; b=tKbeLHfFk6H76eMD2vSOJ8AZKrLwevJtpFPfWJ5jtFD4CK6mJQBtajAjL6K5UrWlyfPtI9L0PKkZuA+ejAY8WJpOCHuOz9ViuPc8wSnl9nLx3S3Cv9z0dwEVnDlfaoqfzRlHFVZtrr/guWd3sRNdZaBWvpQwIS6oEz4SPo3svks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185678; c=relaxed/simple;
	bh=ccdYWN4uO+fXp6GWBAaFVGwPrdESUwDVjL7T/+movy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxUAWuHQufkOHIYpkAQ1vaYtBq/zZnn3cO9LTXcS2dqskqypUzbadWeFzhHnEcZqJKMrvp2tQKgatKaAEJN2BbivpT2cQ6wgiuzCO8fdNGNlK1a1CfRrCkKJY9+s52AuwtlI72/RhqtKxDCWAsjtOzSO4vUSPJTqZ5mAng2G4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G6yUe4AJ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6yUe4AJ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a147688bso946743a91.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185675; x=1790790475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LcVXpdi1RtlLWtUvQyxzQWA8IBu8z+++v+33eMLlNCI=;
        b=G6yUe4AJWPgHHRcUvA5J6svDHAVjUGYfx9gl037ZKs+zo8VcH91ZgAbBYsBS42QZQD
         Qx4j87uYZXmUM+MugEsLszafaxYZCRKNSDDyQr0yd/j5L9vqd0GAKJvgxyY0eSRs2cou
         M7n4YpXQ+4MJkWUzyFzpJX7a6Gz6fnW7qbU+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185675; x=1790790475;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcVXpdi1RtlLWtUvQyxzQWA8IBu8z+++v+33eMLlNCI=;
        b=vWTNBs6C1AYaT/UaEP24dsUhZ1UTjIkYGI2yCbKovGZ13aDQ5ukmuEm5MjSdDX8LL9
         mMP9f69/lVE7AMBmB1CjMKzzglzVlOD4N5a8YNDQ9LnG0+Ex8dmdLeEDBh4lTuZWGJEr
         vaYZcyRmrAWjwtTju8Lh/352KBcoTVfj+Bl9VkRLKl1B1kHJlax4id70CP5x2QiLf8SF
         D18eQ3Ff/OJd7h0UwcrbxO7T3ISwFKJTgbXI5jln3DM96LV0qt4jc9inw9LAS7VEqxUC
         582qm9vHN5CE4qCD8AetHBiy/T1/qlN9pr2ROm/zDMZhVM8LAakMzRHHBcpvV+/kM1Vt
         r2+Q==
X-Forwarded-Encrypted: i=1; AKwUvBz2wH739iUt1gapeXI/UIINqLE3MLoVZ4ebuTTaDGF28i/qWnDK3bqiASENKNPGKhakoK+7yjuHbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mbhPiLeDCpfpBeCO18nVBZbQXXrrZIEj0gr//vH6LDqCJzxv78
	rBbwPCrCKkxFYW7fDq+5HC5yiueU7QrEdZzFdUd+wkQgSRs27wlETCvL1jpmOc+E0Q==
X-Gm-Gg: AYBFou0oVuKHxQgCzM2DVokLKfqzNVT37zGjj5JbflnRP3/e93R5sKzO58HFKTkvW5A
	kYpHv+b9uTF8m3BHqaowBZ3w8h9566xtPbNAEHrcrJKLHI+91rpMngDAUJS6GIKtSsVQkidHOQZ
	Wan4xPm5rlYWOdLwZ7cZZCksamV5e3HvjaUyqWKHcRGANmRci4V6LoMQvexZ5ideZXhBiawaXSN
	BWg0AGm6Hwgy4mLNiUEJF9p9ppZzSnbaTeHEBLyBUsJMXJTiEj7lAjdUthd9EF2VWT+NbmpzPPW
	wrn70pra0KgEM95lGaOMRWtHJb/p1Cv8y/A6BaCQ9Hl8sCVyTdnWil8/Ll5+c8gCiDqzWob/DXi
	ifd0Fbf+MsKrndphbD9mmLbh0SFhGVcMI1Dxm64UinuNX/maasTz5IVCTxmPjNdKTckb9/EVrTt
	10TD28kiQ1ot8XWjtul6U/aGY53602UBwRhoMmmQXvN8SDx25Mx0lQ2hWjgR8LnjLd30GsUK8T7
	VBt4Snxowlyuq4lrXpREhgqLiDwynnERUTtMw==
X-Received: by 2002:a17:90a:d60c:b0:39e:6c69:9b8d with SMTP id 98e67ed59e1d1-3a07e690cecmr3110112a91.50.1790185675217;
        Wed, 23 Sep 2026 10:47:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a09733f49asm205130a91.9.2026.09.23.10.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:52 -0700 (PDT)
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
Subject: [PATCH v2 7/8] PM: runtime: Expand introduction with core concepts and structure
Date: Wed, 23 Sep 2026 10:40:31 -0700
Message-ID: <20260923104031.v2.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923174711.1283986-1-briannorris@chromium.org>
References: <20260923174711.1283986-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I commonly see people have difficulty learning how runtime PM works
because of the following key points [*]:

 1) there are several boolean concepts in runtime PM, with somewhat
    similar meanings:

     enabled / disabled
     active / suspended
     allowed / forbidden

 2) if these concepts are documented at all, they're scattered across
    the kerneldoc or Documentation/

 3) the runtime_pm.rst docs don't make any attempt to ease a reader into
    understanding the concepts, and instead jump straight into how it's
    implemented (queues, 'struct device' fields, helpers).

Let's try to remedy this a bit by discussing the core concepts and
highlights at the top of the introduction, and introduce a few
sub-headings, so it's easier to navigate different aspects of the
introduction.

While shuffling the intro around, I also see that the existing text
largely mirrors the layout of the following sections (2, 3, and 4), but
does so out of order. Reorder those, and point to section numbers.

[*] In addition to API complexity. I count 61 pm_*() helpers, 7 of which
    are variations of put() and 8 of which are variations of get().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
Address review feedback around descriptions of "enabled" and "active". I
know not every point of discussion was settled, but I hope this updated
version resolves many of them and provides a better basis for further
improvement.
 * Avoid calling enabled and active "orthogonal"
 * Describe more of their inter-relationship
 * Prioritize talking about "enabled" first, since that's the first
   concept a reader should know about
 * Brief mentions of parent/child and supplier/consumer, and dependency
   handling
 * Other tweaks

 Documentation/power/runtime_pm.rst | 103 +++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 19 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index e0c20132dabd..7bb64d793cdd 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -13,31 +13,96 @@ Runtime Power Management Framework for I/O Devices
 1. Introduction
 ===============
 
-Support for runtime power management (runtime PM) of I/O devices is provided
-at the power management core (PM core) level by means of:
-
-* The power management workqueue pm_wq in which bus types and device drivers can
-  put their PM-related work items.  It is strongly recommended that pm_wq be
-  used for queuing all work items related to runtime PM, because this allows
-  them to be synchronized with system-wide power transitions (suspend to RAM,
-  hibernation and resume from system sleep states).  pm_wq is declared in
-  include/linux/pm_runtime.h and defined in kernel/power/main.c.
-
-* A number of runtime PM fields in the 'power' member of 'struct device' (which
-  is of the type 'struct dev_pm_info', defined in include/linux/pm.h) that can
-  be used for synchronizing runtime PM operations with one another.
+Runtime power management (or runtime PM, sometimes shortened to RPM) allows
+individual I/O devices to transition between high and low-power states
+dynamically while the system is running, conserving power without waiting for a
+system-wide sleep state.
+
+Core Concepts
+-------------
+
+Understanding runtime PM requires distinguishing between several pairs of
+related but distinct concepts that apply to each device: **enabled** /
+**disabled**, **active** / **suspended**, and **allowed** / **forbidden**.
+
+* **Enabled**: To use runtime PM to manage a device's power states, it must
+  first be **enabled**. If RPM is never enabled for a device, it generally
+  stays inactive from an RPM perspective, and the PM core will ignore it.
+  If it is enabled, the PM core can manage the device status (see **Active**
+  below) according to its understanding of whether the device is in use, and
+  perform state transitions via the appropriate PM callbacks
+  (->runtime_suspend(), ->runtime_resume()).
+
+  Each device has an internal disable counter (``disable_depth``) which
+  determines whether runtime PM is currently enabled. Devices are initially
+  registered with runtime PM disabled (``disable_depth == 1``), though some bus
+  types (such as PCI) may enable it before driver probe.
+
+  To opt into runtime PM, a driver first ensures that the device's recorded
+  status matches its actual physical state (for example, by calling
+  pm_runtime_set_active() if the device was powered on at probe) and then calls
+  pm_runtime_enable(), decrementing ``disable_depth`` to zero (i.e.,
+  **enabled**). Runtime PM may be disabled again explicitly via
+  pm_runtime_disable() or temporarily during system sleep transitions.
+
+* **Active**: The PM core tracks a device's runtime status as either **active**
+  (the device is operational, having completed its resume callback or otherwise
+  marked active) or **suspended** (the device is idle or in a low-power state,
+  having completed its suspend callback or otherwise marked suspended), along
+  with transitional **suspending** and **resuming** phases. When runtime PM is
+  **enabled**, state transitions are primarily driven by reference counting:
+  drivers call pm_runtime_resume_and_get() (or related variants) before using
+  the hardware, to ensure the device is active; and pm_runtime_put() (or
+  related variants) once work completes. When a device's usage counter drops to
+  zero and its dependencies (children or consumers) are suspended, the PM core
+  can suspend the device immediately or after an autosuspend delay.
+
+  Besides driving the state of the device in question, a device's runtime
+  status also affects those of its dependencies — its parent (if the parent's
+  ``power.ignore_children`` is false) and its linked supplier device(s) (for
+  links with the ``DL_FLAG_PM_RUNTIME`` flag). An **active** device holds
+  reference counts on its dependencies, preventing them from suspending.
+
+* **Allowed**: System policy and user space govern whether dynamic suspension
+  is permitted through the concepts of **allowed** and **forbidden**,
+  manipulated in-kernel via pm_runtime_allow() and pm_runtime_forbid() and
+  exposed to user space through the ``/sys/devices/.../power/control``
+  attribute. When runtime PM is forbidden (``control`` set to ``on``), the PM
+  core increments the device's usage counter, forcing the device to remain
+  active regardless of whether the driver is idle. When runtime PM is allowed
+  (``control`` set to ``auto``), this reference is dropped, permitting the PM
+  core to automatically suspend the device whenever its driver and child
+  devices are no longer using it.
+
+Notably, runtime PM also has a feature called "autosuspend." This is different
+than the ``control`` notion of "auto" (i.e., "allowed"). Autosuspend is
+described in more detail in `Section 9`_.
+
+Implementation Structure
+------------------------
+
+Support for runtime power management is provided at the power management core
+(PM core) level by means of:
 
 * Three device runtime PM callbacks in 'struct dev_pm_ops' (defined in
-  include/linux/pm.h).
+  include/linux/pm.h). See `Section 2`_.
+
+* A number of runtime PM fields in the 'power' member of 'struct device' that
+  can be used for synchronizing runtime PM operations with one another. These
+  are covered in `Section 3`_.
 
 * A set of helper functions defined in drivers/base/power/runtime.c that can be
   used for carrying out runtime PM operations in such a way that the
-  synchronization between them is taken care of by the PM core.  Bus types and
-  device drivers are encouraged to use these functions.
+  synchronization between them is taken care of by the PM core. Bus types and
+  device drivers are encouraged to use these functions. They are covered in
+  `Section 4`_.
 
-The runtime PM callbacks present in 'struct dev_pm_ops', the device runtime PM
-fields of 'struct dev_pm_info' and the core helper functions provided for
-runtime PM are described below.
+* The power management workqueue pm_wq in which bus types and device drivers can
+  put their PM-related work items. It is strongly recommended that pm_wq be
+  used for queuing all work items related to runtime PM, because this allows
+  them to be synchronized with system-wide power transitions (suspend to RAM,
+  hibernation and resume from system sleep states). pm_wq is declared in
+  include/linux/pm_runtime.h and defined in kernel/power/main.c.
 
 .. _Section 2:
 
-- 
2.56.0.rc1.310.g51773c2048-goog

