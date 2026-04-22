Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30533F591;
	Wed, 22 Apr 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872402; cv=none; b=VZLevzJleiHr4bq4j+MJDCiSGWVWglx3zxKclrkHCsrsQcavfUOLlRXH1hv12BlSX5XV+tMFcWGxkxFmhKjWszpnywHx2YCuo1WaXq/k3/qPEgTAkOuolYZ2JkLbl2o1gWTc4Pw0lhSMMGKvZ754G/skp3g4BsnXG1J2fbYlICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872402; c=relaxed/simple;
	bh=B/HVfZVMeyhleXR4W1gDTZ7DRrRBMrbGdCzfO2XmG5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryttb0NUFql3LJquz8o+yH+y5XMHhRKNypKA/pw8sNgs44vbQt4XiVWNn7ZiELwerPB16KEpnFzzMtSmSYrYQ1NJaa5Tia/3A/FkenljGcwCDR96ozgpv8gbeKACRcNEOAptv7UY8h11TiHBgFKHeCgWGLWqokw4b5vN8QgnDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDAPT39d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDAPT39d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E3C2BCB2;
	Wed, 22 Apr 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776872401;
	bh=B/HVfZVMeyhleXR4W1gDTZ7DRrRBMrbGdCzfO2XmG5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDAPT39d6iw11bFjdZn0QeiQcMCPCWQgIU98TdV86wtgqPbco6UioM8ytiyBICedD
	 wz05Mv0XoCf9Cg/uh7EunPR8NoQ3hTHifhXism2x1x4Pu/uwPdNpJ6SP5EpvkTY+NN
	 gqhvek0rE6FcrR21EXEzLDOwTgDBN3izmriV4eis/1RK0Of0Z1yCHFQ73KCa/yCz/I
	 jUaOC1laEBBz8V59uXn6LIcseD2pAOaUgVajaP//LjypW57lkUctPBN4hOyiBvwKRW
	 gprH9MNsoEIjnPrd6dFipJMgWNlNrkIbLPyKOA6j8NFQPbPVISlD6feAU5t6LmPJQs
	 tYzzlZKffQRrg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 1/2] thermal: core: Remove dead code from two functions
Date: Wed, 22 Apr 2026 17:37:14 +0200
Message-ID: <3950489.kQq0lBPeGt@rafael.j.wysocki>
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

Since thermal_register_governor() is only called by
thermal_register_governors() which runs before clearing
thermal_class_unavailable, thermal_tz_list is guaranteed to be
empty when it runs, so the code walking that list in it is
effectively dead.

The same observation applies to the code walking thermal_tz_list
in thermal_unregister_governor() which is also called only if
thermal_class_unavailable hasn't been cleared.

Remove the dead code from both functions mentioned above and rearrange
thermal_register_governor() to reduce indentation level.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   61 +++++++----------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -119,59 +119,28 @@ static int thermal_set_governor(struct t
 
 int thermal_register_governor(struct thermal_governor *governor)
 {
-	int err;
-	const char *name;
-	struct thermal_zone_device *pos;
 
 	if (!governor)
 		return -EINVAL;
 
 	guard(mutex)(&thermal_governor_lock);
 
-	err = -EBUSY;
-	if (!__find_governor(governor->name)) {
-		bool match_default;
-
-		err = 0;
-		list_add(&governor->governor_list, &thermal_governor_list);
-		match_default = !strncmp(governor->name,
-					 DEFAULT_THERMAL_GOVERNOR,
-					 THERMAL_NAME_LENGTH);
-
-		if (!def_governor && match_default)
-			def_governor = governor;
-	}
-
-	guard(mutex)(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		/*
-		 * only thermal zones with specified tz->tzp->governor_name
-		 * may run with tz->govenor unset
-		 */
-		if (pos->governor)
-			continue;
-
-		name = pos->tzp->governor_name;
-
-		if (!strncasecmp(name, governor->name, THERMAL_NAME_LENGTH)) {
-			int ret;
-
-			ret = thermal_set_governor(pos, governor);
-			if (ret)
-				dev_err(&pos->device,
-					"Failed to set governor %s for thermal zone %s: %d\n",
-					governor->name, pos->type, ret);
-		}
-	}
+	if (__find_governor(governor->name))
+		return -EBUSY;
 
-	return err;
+	list_add(&governor->governor_list, &thermal_governor_list);
+
+	if (strncmp(governor->name, DEFAULT_THERMAL_GOVERNOR, THERMAL_NAME_LENGTH))
+		return 0;
+
+	if (!def_governor)
+		def_governor = governor;
+
+	return 0;
 }
 
 void thermal_unregister_governor(struct thermal_governor *governor)
 {
-	struct thermal_zone_device *pos;
-
 	if (!governor)
 		return;
 
@@ -181,14 +150,6 @@ void thermal_unregister_governor(struct
 		return;
 
 	list_del(&governor->governor_list);
-
-	guard(mutex)(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!strncasecmp(pos->governor->name, governor->name,
-				 THERMAL_NAME_LENGTH))
-			thermal_set_governor(pos, NULL);
-	}
 }
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,



