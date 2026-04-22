Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13734B682;
	Wed, 22 Apr 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872399; cv=none; b=Nx07kiQzpfMDV+WgGBfjekHx6g5o9oAfP7ayceJRLSLFvbQjTGU4biluYBEMfBLxRDq+f9Ki8MWk/RUNsZR7vYNrG176CjdarrK6HebMiNq8HT/0cuPYwR6ISFB97WRN8+E2fYa/kNUBlzh/Pzelv9pamOOB6TKKFSgXNf4RIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872399; c=relaxed/simple;
	bh=43rJuWaPQiBjOgqqdR8b7+JU2I4r4O6RN0WxtFJed9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atlYv9FyyNVH1ImdbAAKZuWoILvZFMUIkA5a83Z2AZhIjupYd8a7wZjTVUhx/bD5zIImua3T6QiBVSRuJTlg11QCjzIVzAhCHFPAA5OQ8pcqgvxcEvck0nzaT6NnG5dNdqKJg7FxkH34aV+U+JSmuU/yIx2vHQZjqszWT4f7X4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PucXFrJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PucXFrJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4860C19425;
	Wed, 22 Apr 2026 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776872398;
	bh=43rJuWaPQiBjOgqqdR8b7+JU2I4r4O6RN0WxtFJed9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PucXFrJQJKifjJRe/ENhX8+D1n5Md3Pfn/jWLMwdsG1zIcATEN+w75yhUw+LhS9NQ
	 cbSP4fJVSm60anKHoxHb4q9bhskKNUhHG+MziVHxxPXDoEJyEpA5yFUEeLWyxB6EOa
	 XIGYtqhMlqOM1+ptXBEfM9cZwCw9Xjhx6P2P93OunXMQFGXNKXZ1fUpkBrjNpY3q8e
	 5orYGLm+cCbxH3UJUz5uRFOpHj0zgWhl9L3CWAId/48G/SpZT5sWEJqBthXMONxNGT
	 2zIMuvX8AnAFsX8WFVWA4SC232pNbX93Xh6EYKYi6e3wg0r7FZPwErGTk349tPioQ2
	 xXg1Pt1gUM0bw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 2/2] thermal: core: Simplify unregistration of governors
Date: Wed, 22 Apr 2026 17:39:19 +0200
Message-ID: <9615355.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2354798.iZASKD2KPV@rafael.j.wysocki>
References: <2354798.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thermal governors are only unregistered in the thermal_init() error
path and they actually are only deleted from thermal_governor_list.

Put the entire code needed to do that to thermal_unregister_governors()
and rearrange thermal_init() to call that function also when
thermal_register_governors() returns an error.

This allows thermal_unregister_governor() to be dropped
and thermal_register_governor() that is only called by
thermal_register_governors() can be made static __init, so the
headers of these two functions can be dropped from thermal_core.h.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   50 +++++++++++------------------------------
 drivers/thermal/thermal_core.h |    2 -
 2 files changed, 14 insertions(+), 38 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -117,14 +117,12 @@ static int thermal_set_governor(struct t
 	return ret;
 }
 
-int thermal_register_governor(struct thermal_governor *governor)
+static int __init thermal_register_governor(struct thermal_governor *governor)
 {
 
 	if (!governor)
 		return -EINVAL;
 
-	guard(mutex)(&thermal_governor_lock);
-
 	if (__find_governor(governor->name))
 		return -EBUSY;
 
@@ -139,19 +137,6 @@ int thermal_register_governor(struct the
 	return 0;
 }
 
-void thermal_unregister_governor(struct thermal_governor *governor)
-{
-	if (!governor)
-		return;
-
-	guard(mutex)(&thermal_governor_lock);
-
-	if (!__find_governor(governor->name))
-		return;
-
-	list_del(&governor->governor_list);
-}
-
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 				   char *policy)
 {
@@ -187,40 +172,34 @@ int thermal_build_list_of_policies(char
 
 static void __init thermal_unregister_governors(void)
 {
-	struct thermal_governor **governor;
+	struct thermal_governor *gov, *pos;
+
+	guard(mutex)(&thermal_governor_lock);
 
-	for_each_governor_table(governor)
-		thermal_unregister_governor(*governor);
+	list_for_each_entry_safe(gov, pos, &thermal_governor_list, governor_list)
+		list_del(&gov->governor_list);
 }
 
 static int __init thermal_register_governors(void)
 {
-	int ret = 0;
 	struct thermal_governor **governor;
 
+	guard(mutex)(&thermal_governor_lock);
+
 	for_each_governor_table(governor) {
+		int ret;
+
 		ret = thermal_register_governor(*governor);
 		if (ret) {
 			pr_err("Failed to register governor: '%s'",
 			       (*governor)->name);
-			break;
+			return ret;
 		}
 
-		pr_info("Registered thermal governor '%s'",
-			(*governor)->name);
-	}
-
-	if (ret) {
-		struct thermal_governor **gov;
-
-		for_each_governor_table(gov) {
-			if (gov == governor)
-				break;
-			thermal_unregister_governor(*gov);
-		}
+		pr_info("Registered thermal governor '%s'", (*governor)->name);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int __thermal_zone_device_set_mode(struct thermal_zone_device *tz,
@@ -1872,7 +1851,7 @@ static int __init thermal_init(void)
 
 	result = thermal_register_governors();
 	if (result)
-		goto destroy_workqueue;
+		goto unregister_governors;
 
 	result = class_register(&thermal_class);
 	if (result)
@@ -1884,7 +1863,6 @@ static int __init thermal_init(void)
 
 unregister_governors:
 	thermal_unregister_governors();
-destroy_workqueue:
 	destroy_workqueue(thermal_wq);
 unregister_netlink:
 	thermal_netlink_exit();
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -258,8 +258,6 @@ struct thermal_instance {
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
 
-int thermal_register_governor(struct thermal_governor *);
-void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 void __thermal_zone_device_update(struct thermal_zone_device *tz,



