Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E23D3488;
	Tue,  5 May 2026 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981642; cv=none; b=B12X7xK9bB4w3ji/VLZd2JXpGEmZEXQ1LgJX8SnicpiA5Vtbi1CeeLdlFYkszLSh33tOvDrgwdzaxtU+UvDnGEOVULiqAPRPAdZ4+b7G13IL7Tf9F2OIZvaU85zB/GzpoJ9Sk989WvlRC++0GqsID6U9FWQo4c49Ki3E+tWHUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981642; c=relaxed/simple;
	bh=MtTqs1dk3T88zbcKKBwjwHIblIEKq4Hzm1x9Up3cZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlfN+GJn7qP/+B2g42QxXvTZR86iBKHkWOOrCNMfmsY6O853CgTqOmr2R2MUpnVKpOIfZ8TN6uyEFnzwDj7yOd+qMwO0lI/yzrcVbf3vn31WtTlrBqcSlOdRzcn6MG3vd1W3qOW1YS6Lcl0Rl7vwlCL/EpwD0fIQeQLglq1zOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcKJGcxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcKJGcxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88E5C2BCB4;
	Tue,  5 May 2026 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981642;
	bh=MtTqs1dk3T88zbcKKBwjwHIblIEKq4Hzm1x9Up3cZVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcKJGcxWahg/1VueSnb+8RKyBi5ILFZfKr2FQxvo1tjvDR0pHSgDr0yFopzyA3QEp
	 wIg3wAwu5b7kUpiIitAb9YNgqzFDKNABu8HMGggQ2CWYqa78SuwIBwMCNHnme6UweH
	 DGrrfP6U9p+KG6pOMjxSd/YIuEGWZYpeFb0SAurwZDgOS/VFk9WYbZKFdxjSHF9jf5
	 LMxPrzkhXcMSQ80gSdDoLqX9gwBaOJ/5EjXFbg8/XXHwOSoSEbgCNWEZz7oxs9DyYf
	 f9ojR6O1lCa+JC5gltIyhzuIWS7rKIxiRs1vFq8XXIakoSqQ9RCQJlMJEVabxcwq3I
	 Y9ekc9Zr6+6WA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>, linux-hwmon@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject:
 [PATCH v2 1/3] thermal: hwmon: Fix critical temperature attribute removal
Date: Tue, 05 May 2026 13:36:56 +0200
Message-ID: <2437056.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6017595.DvuYhMxLoT@rafael.j.wysocki>
References: <6017595.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the return value of thermal_zone_crit_temp_valid() depends on
the behavior of the thermal zone .get_crit_temp() callback which
may change over time in theory, thermal_remove_hwmon_sysfs() may
attempt to remove a critical temperature attribute that has not
been created, passing a pointer to an uninitialized attribute
structure to device_remove_file().

To avoid that, set a flag in struct thermal_hwmon_temp after creating
a critical temperature attribute and use the value of that flag to
decide whether or not the attribute needs to be removed.

Fixes: e8db5d6736a7 ("thermal: hwmon: Make the check for critical temp valid consistent")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch (due to sashiko.dev feedback)

---
 drivers/thermal/thermal_hwmon.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -40,6 +40,7 @@ struct thermal_hwmon_temp {
 	struct thermal_zone_device *tz;
 	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
 	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
+	bool temp_crit_present;
 };
 
 static LIST_HEAD(thermal_hwmon_list);
@@ -191,6 +192,8 @@ int thermal_add_hwmon_sysfs(struct therm
 					    &temp->temp_crit.attr);
 		if (result)
 			goto unregister_input;
+
+		temp->temp_crit_present = true;
 	}
 
 	mutex_lock(&thermal_hwmon_list_lock);
@@ -235,7 +238,7 @@ void thermal_remove_hwmon_sysfs(struct t
 	}
 
 	device_remove_file(hwmon->device, &temp->temp_input.attr);
-	if (thermal_zone_crit_temp_valid(tz))
+	if (temp->temp_crit_present)
 		device_remove_file(hwmon->device, &temp->temp_crit.attr);
 
 	mutex_lock(&thermal_hwmon_list_lock);



