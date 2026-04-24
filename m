Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2D365A07;
	Fri, 24 Apr 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027258; cv=none; b=N2TsoRhWk67auC+I8BToM9PtcSr8vruUpOPeQNbwBGi1freMZo12F4jwe9SjDYxyKg1OQGVjBtEpyY0xyyN5Hk7zmqN+2FKvJqZbLNERSd+9mZE3dBIyBYUq1bM4XaLATWbO6ZsKnPIAPiU+FRwd9TNDcH8pNR6eg+mP5TzZD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027258; c=relaxed/simple;
	bh=qheYcZzIXj5CW3/Fu4qkGxj72XsBsWqt6bl3zNWbvpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELIrgAM4yFqqCx2Eoi3EYr/mWFJWFsWxM0zZ3hh/kDs6DzcjFJfOB8e0JUVTBmwSDrOO8+0BUgynQe3BZwqW4M3auZd+pHxLEdi4Jipr0w36eA7ng0je31UY3YawVqH9n/IdxYkIBAASfyntOcI6HaCUL8pVe1n3UIzoiiLoE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V547EU+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V547EU+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A8C19425;
	Fri, 24 Apr 2026 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027258;
	bh=qheYcZzIXj5CW3/Fu4qkGxj72XsBsWqt6bl3zNWbvpw=;
	h=From:To:Cc:Subject:Date:From;
	b=V547EU+jjNpvN8s1L770yBUalIjY/4mIFbuPjC9ML+Xx9r5dVg0pc26gAQTspjxFr
	 Wa8yWN9F+k/RDX0/XiSB9HUwH3nwr6bcqqRqbQLh14JlAKoiv6CYjpXWt/zfO+qogz
	 UHInC0uyYxx9VLWF28ufeGN+sqzZ1p+Mi+Ynft0Qa5mfMqNX4H1cNtLhGQFjiDXV++
	 O6l3qLV8/vPA6AF1nU5T1eUzchPVgW69dKteHConRjGCyI8vnEQ5vLLKirATkBgKE0
	 +OUCDgUU1WKhevC7rtYIzJdvrznPAO6GmdVEC7K+YTM/EyM4TmE1yNWUNIAFv2x/4X
	 DHpcb5v270jZQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDxw-0000000AyoW-0jlT;
	Fri, 24 Apr 2026 12:40:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] pmdomain: core: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:40:50 +0200
Message-ID: <20260424104050.2617041-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly if a device that lacks a release function is
ever freed.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pmdomain/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4d32fc676aaf..e01884f2d7b7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -33,9 +33,7 @@ static const struct bus_type genpd_provider_bus_type = {
 };
 
 /* The parent for genpd_provider devices. */
-static struct device genpd_provider_bus = {
-	.init_name = "genpd_provider",
-};
+static struct device *genpd_provider_bus;
 
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
@@ -2325,7 +2323,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	device_initialize(&genpd->dev);
 	genpd->dev.release = genpd_provider_release;
 	genpd->dev.bus = &genpd_provider_bus_type;
-	genpd->dev.parent = &genpd_provider_bus;
+	genpd->dev.parent = genpd_provider_bus;
 
 	if (!genpd_is_dev_name_fw(genpd)) {
 		dev_set_name(&genpd->dev, "%s", genpd->name);
@@ -3567,11 +3565,9 @@ static int __init genpd_bus_init(void)
 {
 	int ret;
 
-	ret = device_register(&genpd_provider_bus);
-	if (ret) {
-		put_device(&genpd_provider_bus);
-		return ret;
-	}
+	genpd_provider_bus = root_device_register("genpd_provider");
+	if (IS_ERR(genpd_provider_bus))
+		return PTR_ERR(genpd_provider_bus);
 
 	ret = bus_register(&genpd_provider_bus_type);
 	if (ret)
@@ -3593,7 +3589,7 @@ static int __init genpd_bus_init(void)
 err_prov_bus:
 	bus_unregister(&genpd_provider_bus_type);
 err_dev:
-	device_unregister(&genpd_provider_bus);
+	root_device_unregister(genpd_provider_bus);
 	return ret;
 }
 core_initcall(genpd_bus_init);
-- 
2.53.0

