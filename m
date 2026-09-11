Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656147206E;
	Fri, 11 Sep 2026 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132127; cv=none; b=IB9kW4u+NycsHUZg7MoE4RMidPmWvrz6j7UFFj56Myc1hyGHGEr04niQ5EGDt4jgYc8mCeki892O5uELVj9VyScxWYh4TYhIn3vt29RWqTZMczDPR7xYcdS+wPKN35cXyhsNDnNcxkpfj/yM/6zoMyMXaRJmB7ZpqKtsqDTx/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132127; c=relaxed/simple;
	bh=dJr1RL7oUCJfTVozFYphNU7PJ2WUfEj4pYlTRt2xqcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgeFxXR06I9bE2VniaNxkUbTIBib40VV2NlSAhda2GAWAluIVIvhBb5Cl6+uN/Hd9KQpZ3CIMF8TZV/JVVUkcLklh4uhE4IyhgkIPO4cDiJiuDZjNTe1Y33MUBTtw5TrgjdMS5tHWyvFRBcKihp+Wzq9EuypEzWhFXxdWxqNgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyqZmQkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyqZmQkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8811F000FF;
	Fri, 11 Sep 2026 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132125;
	bh=przzX8XQ0Pwraq22n34EHyVoNki1kvlkkZzz/xXROKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TyqZmQkgCI+04z6+cX4swkXsmNjdPmQCob7unQQFNUrjQCi2kTbYZQqqtAFHxkc56
	 TH0G+gVlCfcMwKIvz4lX4OPOcD/LREa3T8xtuIfWEf7tFYo5WxqfVpnGuqMjRjawO8
	 fXq84TredrOE280hjF803AAuHWVs2neZQdikJF7LXKon9zt3LgsP6uc2j0EWQ2t0ls
	 1rugveHFpRlf957JDzZ+1Lj47jDE7q4lfC0kiMtMFTdhP/AerG+w3SRGXW+mSbNRW4
	 NBO3Ld0Omk7gdHL9TlvSx5EH5mwLMX2iKD1vb2kyFFR1uw7iONCb806p1T0DY2qJX8
	 ttC5Ia7mYS3sQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 07/10] ACPI: thermal: Use cooling device parent for thermal zone
 binding
Date: Fri, 11 Sep 2026 15:05:07 +0200
Message-ID: <9672996.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI thermal zone .should_bind() callback function,
acpi_thermal_should_bind_cdev(), expects the given cooling device's
devdata to point to an ACPI device object whose ACPI handle should be
compared with ACPI handles in a list associated with the given trip
point.  That is not particularly straightforward and it effectively
requires the drivers of ACPI cooling devices to populate the devdata
with addresses of the ACPI companions of the devices they bind to.
Consequently, the devdata cannot be used by the driver for its own
needs which is its intended purpose.

That can be overcome with the help of the observation that the
ACPI device objects to be matched against the lists of ACPI handles
associated with trip points are in fact the ACPI companions of the
parents of cooling devices.  Thus instead of using the given cooling
device's devdata, it is sufficient to obtain the ACPI handle of its
parent and compare that ACPI handle with the ones in the list
associated with the given trip point.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index dd7666c176a0..dea28d674407 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -564,17 +564,18 @@ static bool acpi_thermal_should_bind_cdev(struct thermal_zone_device *thermal,
 					  struct cooling_spec *c)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
-	struct acpi_device *cdev_adev = cdev->devdata;
+	struct device *parent = cdev->device.parent;
+	acpi_handle parent_handle;
 	int i;
 
-	/* Skip critical and hot trips. */
-	if (!acpi_trip)
+	/* Skip critical and hot trips and parentless cooling devices. */
+	if (!acpi_trip || !parent)
 		return false;
 
-	for (i = 0; i < acpi_trip->devices.count; i++) {
-		acpi_handle handle = acpi_trip->devices.handles[i];
+	parent_handle = ACPI_HANDLE(parent);
 
-		if (acpi_fetch_acpi_dev(handle) == cdev_adev)
+	for (i = 0; i < acpi_trip->devices.count; i++) {
+		if (acpi_trip->devices.handles[i] == parent_handle)
 			return true;
 	}
 
-- 
2.51.0




