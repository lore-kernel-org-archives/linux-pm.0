Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F445C6E0;
	Fri, 11 Sep 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132118; cv=none; b=nLHMU/dD6XYGzJBxwH6mt6REuW7w67QzI5el5x/L33oIlMQRJrk/nIcSjXAjOOxtSnlLj+4kYMcOD8V2yMt+x331uL/XuGMdb7HhO1iEZlK84uWCRVz7Xs1bKIn34/PATJNayXMdL/hEhRH2ebFS2LPM7rzAlfPa3DdvJV1iNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132118; c=relaxed/simple;
	bh=ciYQaFJkKIqfim4YlrDq13atK7eh0xRvlug06He5h+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsDHue6ewajjeZS+WXoXszgJamPdeXdtDmmngSQ6zw99WcYvZEPSl4BBeZgd1DkEdR2Yy/b/tOwToqBsMvjZRcr2J0W5gPM2ezm9rjKGkWPzi5MU8LjsEWCyafpldXN/UgoGu7lUNMWK4dFzy4grEMqvTFGj2KzjJB16Ds5nTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0Gkf+lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0Gkf+lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BF71F000FF;
	Fri, 11 Sep 2026 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132116;
	bh=DEGwy+7VeZYSfKpqOQJDCqOPesHrPeWKIcsZdgC1V1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0Gkf+lby3elx/LaIzqmFJU0pB7HT0AmulhxZGJ+D8dS/k3C8d9Ptq9ILlYM9f90s
	 gfCX78a8FjH9Admz2WUKnXcqk64sc0gKEdD0wvwl6gi8o0WUuVUXrClms7M4ndutSy
	 /8r59BeYK9K1XrqrYeOg/EbGDQHHKfMQnZflj8uEQ5CPfsHTo4F/aLwJ9v45gpoZzg
	 jCJ1geTd0piYH5n0vsx9wRvoFqnpEssfzPqtvEezsGaDKECVqL63TlQa7vumScIaRJ
	 FeHW2sVEpoWhgIuqDNrBWna3d7WeaQHUDF/6DQHv6wHAU+wyhF267Sz9ZeqjAHgmvA
	 NOzRxe+wvQCYg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 09/10] ACPI: fan: Store ACPI device pointer in struct acpi_fan
Date: Fri, 11 Sep 2026 15:06:27 +0200
Message-ID: <8772267.NyiUUSuA9g@rafael.j.wysocki>
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

In preparation for subsequent changes, instead of storing a fan ACPI
handle in struct acpi_fan, store a pointer to the corresponding struct
acpi_device in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan.h       |  2 +-
 drivers/acpi/fan_core.c  | 11 ++++++-----
 drivers/acpi/fan_hwmon.c |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index e20d6ad9df80..3faa247af514 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -52,7 +52,7 @@ struct acpi_fan_fst {
 };
 
 struct acpi_fan {
-	acpi_handle handle;
+	struct acpi_device *adev;
 	bool acpi4;
 	bool has_fst;
 	struct acpi_fan_fif fif;
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 29ca97503deb..8b20b8a55c13 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -340,17 +340,18 @@ static int acpi_fan_dsm_init(struct device *dev)
 		},
 	};
 	struct acpi_fan *fan = dev_get_drvdata(dev);
+	acpi_handle fan_handle = fan->adev->handle;
 	union acpi_object *obj;
 	int ret = 0;
 
-	if (!acpi_check_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
+	if (!acpi_check_dsm(fan_handle, &acpi_fan_microsoft_guid, 0,
 			    BIT(ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY) |
 			    BIT(ACPI_FAN_DSM_SET_TRIP_POINTS)))
 		return 0;
 
 	dev_info(dev, "Using Microsoft fan extensions\n");
 
-	obj = acpi_evaluate_dsm_typed(fan->handle, &acpi_fan_microsoft_guid, 0,
+	obj = acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, 0,
 				      ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy,
 				      ACPI_TYPE_INTEGER);
 	if (!obj)
@@ -392,8 +393,8 @@ static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u64 lower
 	};
 	union acpi_object *obj;
 
-	obj = acpi_evaluate_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
-				ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
+	obj = acpi_evaluate_dsm(fan->adev->handle, &acpi_fan_microsoft_guid,
+				0, ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
 	kfree(obj);
 
 	return 0;
@@ -503,7 +504,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	fan->handle = device->handle;
+	fan->adev = device;
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index d3374f8f524b..c5d8419f41c5 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -94,7 +94,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	struct acpi_fan_fst fst;
 	int ret;
 
-	ret = acpi_fan_get_fst(fan->handle, &fst);
+	ret = acpi_fan_get_fst(fan->adev->handle, &fst);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0




