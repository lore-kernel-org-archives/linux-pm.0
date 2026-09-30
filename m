Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADD371889
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736684; cv=none; b=TiM62Y1kKJmgpoftK62X7ZBSYNQAUXU2pWg+bDfqF3nG5hqQWcdLHDs1bruyz0zWESy3Yw+Q5Kd2G9FuKEzqZDg1ZOQ/h8yhyFzdhHGf/cpzXnIpuNDb7oftHkZ7MuaWWLpgOgfKESW9VMx8cGHYgoRgjvfsAsQ6cBAMP8fFkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736684; c=relaxed/simple;
	bh=3RCQiiGiOcS89Sc7XimbHotJkA/dulcxRVmBe0BF3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0FyxkPsYn5bivZeUhq9oxOIwSYz/U53KOHRMbJfqDH5iwTdLEg+jxPfhiSpCLeoovzHya4z5VXFwbrz2WVdC5YF80eiVeT6ZEn27HpkNllECNB3nDLsvF9PCaARDMddnfEig+vVhErRk//xDhw/OVAolfEon7oT9Az3k6MQJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mr8bdhGB; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mr8bdhGB"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so5262390c88.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736678; x=1791341478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udxMl2iGuUO1ZRkCUqUYDdpK0NWx0fsMJs0kN/8DGsY=;
        b=mr8bdhGBXTbi5l3DVDL3vRbb7YkLQZ7dvdNLkDSsyioMGlMIJsgIQdYRb4UiEtixIn
         NBpWx4Wf1PRWqitY5IYGc059PqQARtANLoQv3c0Epiz/CgUL0NtwEyHQIU6UWmajyi0t
         6H8g5Rh1T26aeXigGEmwzHUqTrPmFwy4q5QXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736678; x=1791341478;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udxMl2iGuUO1ZRkCUqUYDdpK0NWx0fsMJs0kN/8DGsY=;
        b=vOEE5raDXysLskjgMVNUKwRzsZdIgZ9xXtNkoPEjkh1QIh4F7c/ShyGGAj0zvAgUAs
         iCvQkrCA6sl0s1Pp4bBaXlLJA2rcsW9FszwVh6YNDWrMuJcQUix6xv5WlG12qkSlYfU0
         XpCMusk8EeHQuPuwIEirTYU/OnrCZPmgfQpC5KxyPCFvAgNmo+ia+ZoKOmaZz+1WzNzZ
         +cJb1cFuUY7j2sAntkkCx8AiL5bRditbKqeTQtlktEozdXuUlidiB5T68SPCyoodu0NK
         IZSpnFaI7tCMNEq/BNWknZQyy/TmgXEHOqXBP6NJaViAT0No2tre72EwuVaINkJ0fhJd
         P3Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwNb33JMNcAJzYJMGKJH0dFIAzu3cPRpLKH/VEDkStMwv3Jk0eATd1bJKuP2BXXrL3aZ/8FN1fzCA==@vger.kernel.org
X-Gm-Message-State: AFuF++l1heVjz8OI2pgqM7SJqfBQOhl5RI44S4mCQORkDXOj9GOoJaTv
	3ACAQl40QmqIDrWaZ07JrkpYpR5/lJlSmXJuMC02VYjueTuLYvByufFDUserPiGKtQ==
X-Gm-Gg: AYBFou01Z/8IQoIPOizQh0/akrOUr1d48nle7TnGZk2ZLvCIsEdCRs2TxsHsn3yEbr9
	GbXjWVtiYrLLAlXd3OzVQYg9rqkJo+0nhcQrHqe0IyeRwnj5G4VUF9rGNLtSNKcpjlfCkQwlFQQ
	Gc8sKVsexv8hOt3QwYZrxteYrFWutT/jYk80exebJHGxKqgcl0lpXgjw1NGYORoLVHZ3NHV1QhW
	sz0vZvyeeHn6xe6ANn64AjqloAEiFHyWqiyl9NhsZjP+ecUhrKfbK72jLcNDfQ1b0mmoU0YGAlR
	9bXtqI3p6Bz6WuRqSmPEAoMhc7e1OHBr+dUrpbUf1kHbV2uCJVk2UG5L4R3OIYBg5ltlj5CFbSq
	PQvbbCJ/SCPe3IhPioOwwYcwtdcJyHd2IYPgRZHC2xu3DVMeN1ovPnnMG08ok+817PvQcd4Ktqg
	JD5iTzZyyM2Ql5/CIpNd5XKjtjnJ/wTkvOcUsByAjrMyFq4ndGnm9SfOBxRsRhARWo3NryJ3HNX
	GAZh/u2L9abzvE6tqcWx7HewaWjzh0twuNcCEhEKfQxVwk=
X-Received: by 2002:a05:701b:230c:b0:144:fd7c:84f4 with SMTP id a92af1059eb24-14c9c65f884mr1852704c88.5.1790736677848;
        Tue, 29 Sep 2026 19:51:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14d083fe728sm229720c88.6.2026.09.29.19.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:17 -0700 (PDT)
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
Subject: [PATCH v3 7/8] PM: runtime: Expand introduction with core concepts and structure
Date: Tue, 29 Sep 2026 19:49:55 -0700
Message-ID: <20260929194956.v3.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
References: <20260930025044.104824-1-briannorris@chromium.org>
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

(no changes since v2)

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
index 68903d93a3e7..c63fbf0ff862 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

