Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEF35A925
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785869; cv=none; b=BnMoJsmEhmA7YGHqDwFHi3TAs7WFujS9jBXd3ArApgT3fe7kjBoJVr5d1rXAVzHZKNHRkGQGGfDR5eLF8ZreNH4rkD45WmU1T87cd+LoX/D1waXkg2z/olEEnxQl9FNH8zqt8mQrlNTxVwd+B1am10tAOt5ejKrrDghKCdNvceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785869; c=relaxed/simple;
	bh=2+BzI0yPnKYTHXuQVokoBfWwLn75WttFQlQXlkjxwLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHbyB9iByWw3Rwg9pcxePMXE5uqNd/IQeUmAIs3ahKxZXvX6FQWneZWckv4UHDHgMVwg/mgWsYRYhSllZ8hgu/IGD9VJ1xQdgzgvSJSvdoAS4o+7hAuOyfOQ+cqePOgddCIiJ/9rbKeZQ1rqrbrpztLkpxswnuyr+VZZDehopxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKpVqzDb; arc=none smtp.client-ip=91.218.175.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKpVqzDb"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2+BzI0yPnKYTHXuQVokoBfWwLn75WttFQlQXlkjxwLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786785865; v=1; x=1787390665;
 b=QKpVqzDb/JDWafM6PVkdUFbaV0+KpfqSpbhxnEBxC3la+OyuUwbkNobUJXRBoq8ZDyk2qzPT
 SXMDmimNowIZ9RNhEek2uCVnrDs+jJgh/lDdHsnas0CfJNkfTZJuGCSJRixWNFxyKn4w0ac7wFa
 TYo94fUqb4YnXvQXIDXT+mJI=
X-Envelope-To: linux-pm@vger.kernel.org
Received: from fedora.fritz.box (62.216.208.217)
	by mta10.migadu.com with ESMTPS id 0b75b71cbebdd497;
	Sat, 15 Aug 2026 09:24:25 +0000
X-Migadu-Flow: FLOW_OUT
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: Drop redundant else in proc_thermal_add()
Date: Sat, 15 Aug 2026 11:24:18 +0200
Message-ID: <20260815092419.91246-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=thorsten.blum@linux.dev; h=from:subject; bh=2+BzI0yPnKYTHXuQVokoBfWwLn75WttFQlQXlkjxwLc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkNBs4y+fvUfuk47thqlvQnoGMVc/vbNpflJQusK99d+ 2bFGVrUUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABN558nI0HSl1+a+SpT4T9HL /FE7fyca7mK/Fpha/zGbub+jZ17MB4b/cRzteXHuIStmmhhGP3dLLDgZ8kxs5zfGt5sEhaufG9k xAAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Drop the redundant else branch since ret is immediately overwritten.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index f80dbe2ca7e4..0a007a6413df 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -291,10 +291,8 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	}
 
 	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, get_temp);
-	if (IS_ERR(proc_priv->int340x_zone)) {
+	if (IS_ERR(proc_priv->int340x_zone))
 		return PTR_ERR(proc_priv->int340x_zone);
-	} else
-		ret = 0;
 
 	ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
 					  proc_thermal_notify,
