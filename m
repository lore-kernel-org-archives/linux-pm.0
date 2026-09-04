Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DB52ED27
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556836; cv=none; b=S3w4uArupFP5jsC6S/+Fyi8PTvbSxEmpVSsj2YC729zooqyjjqOK6s0icDHP6ETR4VL7M5x/9lKT1a80GwbzF6/vJEvLcsXXB1Araq652i5NF6n+HNuxRswvQOdeoCCfjFceoNiA39+/g4qhCPDj66heRtV7GESv9pN83z7gLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556836; c=relaxed/simple;
	bh=k1NUZekdNvDVAxHEPDyOpNgDCTC3QF+OU9gpLFLNa1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7327DYaFNZCW2IvqdPYBrYi5TaqnzsaLvJI0t1ThEMoA/vYMGxbUHLwRy00RDDKflF0B7gRZ48HkrKaHp8V4OapatqlG6ErmLQM9JZb4HJxRwJL9DSo5tJpQ1kIN6SbXeQHxUtVfl4vVJxbYt2cqliKg3jeGoOAef8PYjruFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=odGIsZib; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odGIsZib"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d9004f39d3so17607055ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556834; x=1789161634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pyu7EKLYDGgyMZngozm5HGHi5hOMpAogxMMPdrlXlPo=;
        b=odGIsZibm3cGX29uVOKV8mrRU42cRL0GnASI6Tl74YOoHa1sjo/wQlw4ZvQc0twMmF
         lXocr59sRAWRyEYHrG/3q9aAPnN2FbWhjKJncog8/jpR0NwhNwjs6x82iekDwI7ZNJFO
         QFtzV3ej/KLxlmnO+1hT8557eZVYt9OwzXWwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556834; x=1789161634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pyu7EKLYDGgyMZngozm5HGHi5hOMpAogxMMPdrlXlPo=;
        b=aU9hBS8nX0vQUfK7xrmfulSARNtMLACfN8Dj/S0CR3+uTmj/ahIvMbivj4vmkjC23p
         vcqq27+m7y7ZMdvfzUZ+CQeVeL1JxTP1ZzPZ4hXk5L/pXivamJNAaj8t4DxwVfhvgfpc
         NMRUxSk0tSV55r7uiUuGeY3XuFVCFZC6OaTRDtmrobI9z9HOoMkxZMtX+7scOLPmYqtZ
         I4kKndQM3gmEHr6O2hnudPpg5OTHNj1x9L50oNBmsvX8ZsYOOdGZ9hGo1Wmzh6AC+aLG
         XSIjbpzbEDn6oWpwXOtjUv7ljb3zFBo8+JahrNSYF1eJkW8hY2uY6+87waygTRJ5hiyR
         CIMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDTsRjvWX1SK6ZLbcQ/MWQwM+RtyUydvRMHg6N5nZ0FLiusWtGgoCz5BvWY+K4P+ISWF249UdR2g==@vger.kernel.org
X-Gm-Message-State: AFuF++ktwgmmCCPns3zYJPS3/QnbQJFglax0X3FbKFhpeLqRholkFG6D
	8ha2CbrdY6cxreytr0+sZF+nLFjTBehB9BVr+eoIcDvfsXZLtr+8Wwl1I6IbM/mxXDjSg87clWQ
	2o1M=
X-Gm-Gg: AYBFou0aSlf83TBN8DLVuCfKDXIWWTTeU2VX573WuzYVHy24nrppbKFYaDcP5IN8MhQ
	xTj5DaAUBADn6pMFDMqCpuHnbNutAETjvf9m9kWxNgHkNM4MYOnxY44qMl6hGrfjdtcgzRqqlAs
	2SubrP7njVdOBKZmIjsq1RLYU5yDKmUzZlEqadGW3JcuktaFoM4Zh3wYuZntcO4zWY2XrC1OaNW
	bx7J3I0QF7XkXhE684JVdJ4jf4f9vtoKs8herUXmYdTn8smsRT23piHsiZBLc21C/ZKXTQiz4l2
	Ci9tKxmelc+SFrcQMYmpt++HB2TJbypTFE9TADbN3F9BtMePMSun5rAH/TVa0ZROgwDf4A442d7
	A66ripHhi6HZysIfcdW+nN3vdTWAuE/Mhn3jgVBjHWwCmdGwc7+lzNr6DfmLl+YSp4yUgdUx3VA
	DfBIEy9rOe+30HPiO0mAe25zFuaCOu4Zd+AWmQ+gwVHzwPDIvRIKeQmtw7tDaATOAf0VSJ47SLB
	huV1yot0ledzud7YBch4wRSbKs=
X-Received: by 2002:a17:903:32cb:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2db1248c3f4mr108329295ad.7.1788556834000;
        Fri, 04 Sep 2026 14:20:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3346ea43377sm5484633eec.3.2026.09.04.14.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:33 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 06/11] PM: runtime: Expand introduction with core concepts and structure
Date: Fri,  4 Sep 2026 14:12:11 -0700
Message-ID: <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
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

 Documentation/power/runtime_pm.rst | 87 +++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 39fdeeda7a1e..620b6988deca 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -11,31 +11,80 @@ Runtime Power Management Framework for I/O Devices
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
+complementary states that operate orthogonally: **active** / **suspended**,
+**enabled** / **disabled**, and **allowed** / **forbidden**.
+
+* **Active**: The PM core tracks a device's runtime status as either **active**
+  (the device is operational, having completed its resume callback) or
+  **suspended** (the device is idle or in a low-power state, having
+  completed its suspend callback), along with transitional **suspending**
+  and **resuming** phases. State transitions are primarily driven by
+  reference counting: drivers call pm_runtime_get() (or related variants)
+  when the hardware is needed (ensuring the device is active) and
+  pm_runtime_put() when work completes, allowing the PM core to initiate
+  suspension (immediately or after an autosuspend delay) once the usage
+  counter and any active child dependencies reach zero.
+
+* **Enabled**: Orthogonal to whether a device is currently active or suspended
+  is whether runtime PM is **enabled** or **disabled**. This is governed by an
+  internal disable counter (``disable_depth``). All devices are initialized
+  with runtime PM disabled (``disable_depth == 1``) and can also be disabled
+  during system sleep transitions or explicitly via pm_runtime_disable(). In
+  the disabled state, the PM core ignores idle and suspend requests and will
+  not execute runtime PM callbacks (->runtime_suspend(), ->runtime_resume(),
+  ->runtime_idle()). A driver activates runtime PM processing during
+  initialization or probe by calling pm_runtime_enable(), decrementing
+  ``disable_depth`` to zero.
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
+described in more detail in Section 9.
+
+Implementation Structure
+------------------------
+
+Support for runtime power management is provided at the power management core
+(PM core) level by means of:
 
 * Three device runtime PM callbacks in 'struct dev_pm_ops' (defined in
-  include/linux/pm.h).
+  include/linux/pm.h). See Section 2.
+
+* A number of runtime PM fields in the 'power' member of 'struct device' that
+  can be used for synchronizing runtime PM operations with one another. These
+  are covered in Section 3.
 
 * A set of helper functions defined in drivers/base/power/runtime.c that can be
   used for carrying out runtime PM operations in such a way that the
-  synchronization between them is taken care of by the PM core.  Bus types and
-  device drivers are encouraged to use these functions.
+  synchronization between them is taken care of by the PM core. Bus types and
+  device drivers are encouraged to use these functions. They are covered in
+  Section 4.
 
-The runtime PM callbacks present in 'struct dev_pm_ops', the device runtime PM
-fields of 'struct dev_pm_info' and the core helper functions provided for
-runtime PM are described below.
+* The power management workqueue pm_wq in which bus types and device drivers can
+  put their PM-related work items. It is strongly recommended that pm_wq be
+  used for queuing all work items related to runtime PM, because this allows
+  them to be synchronized with system-wide power transitions (suspend to RAM,
+  hibernation and resume from system sleep states). pm_wq is declared in
+  include/linux/pm_runtime.h and defined in kernel/power/main.c.
 
 2. Device Runtime PM Callbacks
 ==============================
-- 
2.55.0.979.g7e5102b832-goog

