Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BC3803D1;
	Mon, 24 Aug 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594007; cv=none; b=Z6xATO1TkbgjJkIn+yJpZeMXCtrtwT/D7Myeb59exZBT7kUiK7O4JPnHh3arEYOR9rfNue4qXc+VrGubBPI4ai12Ghd/kphsETavKSpoAid3fxVxMpI5fzPj3ZUzd9aCJGcymJ9kjLzvW/iYqNxBTwSsBJVKIM1ZJtDW1udIfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594007; c=relaxed/simple;
	bh=EAAcUDziU2IhgcVXol7bnTBFuLmuyEAdu/T35tktoIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6Qh3NNGLQ9ke2gvDYBu1nvovioQfSAQjH4W6Pd0ImJRAM/tqZLtVgc14fhOWUFm0i1yXV8OxLNlEAA/EGzKCr7nMLcZTkH/daelijPxCAzvb3JAQCyJZP3A2yxhqPQG8nFA3cMTsUops7Otr5mtgt+OyWtbobVL7N/UO9j+zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jirlP3li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jirlP3li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4EE1F000E9;
	Mon, 24 Aug 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594006;
	bh=BseSwSDAr6YqFXRd4qEgNfXLZzwO9RSWOqvoRf/byXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jirlP3liih/wMQs8uqaXkGDbl5h1/66yHDqkMgDgUHacWW6D6lmfrTJ4L3ZKhjdcx
	 xONWaIEAzKv8pTjuQxS3e1qH2erDxAz9IvgGX8DJOUcBJkdcNwROz0dSuxFSthVjQs
	 lOIO6+L8GV8KmOVI+b1lJZ4OgU7htFfBAylr1z45+sj6odA6m6CPQwaXoLNi/EOrRL
	 k9wx8/7HYnH04UKhRzJfgIHCVehdvyjHYpmPL2HRyw+izqANO9TEwiGGyI+NRRHvQy
	 geinUBfucuEqvVOz0KEzpieHt8a7jlLVHF5I+DmY43AtodXn17JBf13+7zQ5vM8FJk
	 3kqGe5gxozNRQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1 1/2] Revert "thermal/core: Use the thermal class pointer as init
 guard"
Date: Mon, 24 Aug 2026 19:52:08 +0200
Message-ID: <6301222.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12960456.O9o76ZdvQC@rafael.j.wysocki>
References: <12960456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This reverts commit 499274d078d0 ("thermal/core: Use the thermal class
pointer as init guard") because it depends on another commit that needs
to be reverted.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 28a20d4b475c..2d9d8740491f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -890,6 +890,7 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 }
 
 static struct class *thermal_class __ro_after_init;
+static bool thermal_class_unavailable __ro_after_init = true;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -973,7 +974,7 @@ thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_devi
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1447,7 +1448,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1745,7 +1746,7 @@ static void __thermal_pm_prepare(void)
 
 void thermal_pm_prepare(void)
 {
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return;
 
 	__thermal_pm_prepare();
@@ -1776,7 +1777,7 @@ void thermal_pm_complete(void)
 {
 	struct thermal_zone_device *tz;
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return;
 
 	guard(mutex)(&thermal_list_lock);
@@ -1815,6 +1816,8 @@ static int __init thermal_init(void)
 	}
 
 	thermal_class = tc;
+	thermal_class_unavailable = false;
+
 	return 0;
 
 unregister_governors:
-- 
2.51.0




