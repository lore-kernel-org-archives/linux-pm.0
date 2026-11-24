Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535476;
	b=BvTJCDlCplLOKXbgunmzEnj0vWlTCACY8egiqWxFmp10eYTxVa6J11oCaVjCqVl4s/2l
	 6yjhxtYu7zOgxP7V5xWWFsHDQY9k9g/p+Rk2i9g6EKVn4q+VE+tBdZ3wNUfKHzxeuVEk5
	 q4+hiqdItLIvcfdU6keEJ7xaQBM9YX+ozn492OU1o1RvMRjlQtTbJaSpCAC5NVDeUEen6
	 bYG8cHwHYcNAvdvQa1Wlqv7mwcnwzrTArWcrKvxRzuodJ+0d3SExbXT75hrbTvkyE8hxT
	 Wpd1axjvj/PZ9dwo2o6xsEuTqvGWJpkaSgrZ9Ql99d6HCHGif2M7ULZDeNyMEKpwMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=AIx7fq3n2ktTL2eOCMRU+CyAH4JrwlN6Lghw2gP3AC4=;
	b=43ajsRS0iVCz7ZXQ9eSK9YlNcsEygl4zPYHNNVFi52Iil9d4MU0iqHAtzCt0+qzK8mou
	 8GQMcSu0fSb4Z8c2nGuq4sR23uXueU26PpzK436+DB8lGjjhDB5IAGskWKROha963Yh+V
	 7jBdmbvu61vNegDLj/QdrziT8ql0fBs0ejy1mP3uKApLqxiAn1WCe4jBpmFXDFqCSmPGX
	 ePTRGsRDI7e6kdChfQRQD7x/pd73+Wz5RtNTFx+MMFbtEYeIfOgpYJzK14OQkv97l0Bw0
	 ncimZ6WjS4DJhCgUVNhlCUPL0lHTWmLwluCWN4vvT8QXGN9hURyzBKTNj7T29rNunEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shjsg7H5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD47606A326;
	Tue, 24 Nov 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shjsg7H5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BA91F000D8;
	Tue, 24 Nov 2026 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535475;
	bh=AIx7fq3n2ktTL2eOCMRU+CyAH4JrwlN6Lghw2gP3AC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Shjsg7H5ThOCNdHm/fx4v0gEF2T/8CeXMvN7v4cCYsVBA81WBEiC1MxNd7RIGGEFN
	 gc7SrPZ9XJxT3cL+l1LkPTWWLmRYubieMdyl3kfANKWaeg61OWiDZAbi7rw1Tl4fPa
	 je9nhfmYoUo1h6FVOP0DCB2qibg19q2eZXQBUUMcjpMnfTnya4KUuXwP70lYW8px3t
	 RC9+0meMMio0JX+9f6t9VlStZpkwe5sfZPvrwugqlTWxFI4Kpqmsz1W3s9bmG6x8nL
	 NcHR0pAkO0FnRMXl3KXnz/z4rbIYt0Mk4aHeJI5aqpGRKHdtt6vwzaS+lUVdpJwcoH
	 2xsC8wVDHEEKQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 2/5] ACPI: fan: Stop using driver_data pointer from struct
 acpi_device
Date: Tue, 24 Nov 2026 16:47:12 +0100
Message-ID: <6217460.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3985766.kQq0lBPeGt@rafael.j.wysocki>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of using the driver_data pointer under struct acpi_device,
make the ACPI fan driver use the driver data under the dev member of
struct acpi_device and clean it up properly on driver removal and on
probe failures.

While at it, unify the code ordering of acpi_fan_delete_attributes()
with the rollback path in acpi_fan_create_attributes().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_attr.c | 19 +++++++++++--------
 drivers/acpi/fan_core.c |  1 -
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 5b43b7bb0ab4..e8b8fe936930 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -65,7 +65,7 @@ static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr,
 static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
-	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
+	struct acpi_fan *fan = dev_get_drvdata(&acpi_dev->dev);
 
 	return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
 }
@@ -88,6 +88,7 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 	if (!fan->acpi4)
 		return 0;
 
+	dev_set_drvdata(&device->dev, fan);
 	sysfs_attr_init(&fan->fine_grain_control.attr);
 	fan->fine_grain_control.show = show_fine_grain_control;
 	fan->fine_grain_control.store = NULL;
@@ -122,6 +123,7 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 
 rem_fst_attr:
+	dev_set_drvdata(&device->dev, NULL);
 	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 
 	return status;
@@ -130,15 +132,16 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 void acpi_fan_delete_attributes(struct acpi_fan *fan)
 {
 	struct acpi_device *device = fan->adev;
-	int i;
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+	if (fan->acpi4) {
+		int i;
 
-	if (!fan->acpi4)
-		return;
+		for (i = 0; i < fan->fps_count; ++i)
+			sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
 
-	for (i = 0; i < fan->fps_count; ++i)
-		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
+		sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+		dev_set_drvdata(&device->dev, NULL);
+	}
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 4a12e3bfe3be..daa035f8270a 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -478,7 +478,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	}
 
 	fan->adev = device;
-	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
 	if (acpi_has_method(device->handle, "_FST")) {
-- 
2.51.0




