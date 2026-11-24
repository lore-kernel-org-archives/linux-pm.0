Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535473;
	b=MN+LVyY6QrJyviBlsc6xtL8p03wxrLIZFCPrRCnjh4ASc/Dm8Uhrx+3M4KBc9s/PbO+W
	 Gk8ngxhpMQbyu9I0SJA2318zX5DzO25vk+JCVM3DZGr5yhVNS5F/OOGbsygmEkqrW9TTQ
	 fuCrc5hf9qERq8t5l5eGYMDddClj+nGqRckr6v0Ypcy/FXnsBXQR7+s64wAHwcNUBrGKd
	 3qKGQ8pzCUWgduxUjtbXuIHnBVtvvldYd2H5zDOFCDUO/US1ma648Jiyvfw7sqKAWEMSB
	 m0KTgGiRWk1yGgdcrTtskFz8GRel9aedHTA+7SzHj5vxPlu/X1uXcQ6Rt4xMfHNJxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=GC+wZ4zBLzJXhkL1ey6kvEJXJLnRe5f1CdOVgN0smNU=;
	b=1GVvcMakU/5iOmUt2l2IapByoGTho5pdeWV3beucD0UfWGYWLDux0SwYyFCivD8X69h2
	 Hrhj3M7vPoije7q6FfpypDUrxOW7YXKd5CtmK0H+vKKpOPF8a2nMJpLmS5OwPJt3lC1N7
	 E1lc2pVbEFGLjqmvz380863y/0T3DmPRpEOLu8tzP8E0W+rAfOJaQnX4ec3PY4sSOogvO
	 YdioCKOpRbSdo28C9dOC3T8BZoPz17fTn3NmyhcjEfxdZy12U1J1QCo3+yVmBz3mVbrz/
	 zcwIJGi3K9bRcYEwmmWFKdnP2w3Coabek/AwqT0LQv4OzwPf58tlOlrfgvb/kvagepw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivPKgX+m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80D606A32C;
	Tue, 24 Nov 2026 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivPKgX+m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076611F000C4;
	Tue, 24 Nov 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535472;
	bh=GC+wZ4zBLzJXhkL1ey6kvEJXJLnRe5f1CdOVgN0smNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivPKgX+mDnp9Q0prnirwtR7z6sewGU+oQtYjM+0n7fWZSlWOWBjlukLZ/DCsTsaYt
	 4sIwqqEl68DsXBm2eXkn6fblcF4GX0i+Mj+nExWgwEJi62YqrOfAIcmmsXZxnJXFTd
	 cCqjVnFkeLbWvDr4evhevh4SuRRBvpDX6kUG5M4YxlASCqbqHQyDfWLmOHIN9iC/LX
	 pRmhtWQuynmcMTLT5WVtkJMo6hndH9v1hqqn1F7wAeYTMT9JlDpgq5b7Beectls8DP
	 Z6XjI1cw96W99Vjs3JJE1MZJE4BqUCSKEzw2UEl240f/jYQ4z++cMtj8L4G4puh7v1
	 BtpNO2k+7OWvw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] ACPI: fan: Adjust driver removal code ordering
Date: Tue, 24 Nov 2026 16:47:59 +0100
Message-ID: <8806179.NyiUUSuA9g@rafael.j.wysocki>
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

Change the ordering of acpi_fan_remove() code so that it reflects the
ordering of the rollback path in acpi_fan_probe() where the sysfs
attributes are removed when the thermal class cooling device is not
there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index daa035f8270a..5085d975a20c 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -560,10 +560,10 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
+	thermal_cooling_device_unregister(fan->cdev);
+
 	if (fan->has_fst)
 		acpi_fan_delete_attributes(fan);
-
-	thermal_cooling_device_unregister(fan->cdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0




