Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E69381B02;
	Fri, 12 Jun 2026 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301016; cv=none; b=j7qdoBbEG9sMPO37Ut4f8xIccKUWKW3VG+uqgGV7gQW7Zx46FxxjBLCIo0sUCc3JE/9heEYlhdKXoaAvcztP59eAuSadkkdjJgesdsVcgvxDEAy+XZezRgBgGceAotGDWjx1gmKysyWaASZLfAweAwuUN8XG6oeTZ103FPrO34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301016; c=relaxed/simple;
	bh=vxZZUl3WrvVDQcNlvuUlqynGxP1FsZLsvq7BM8IPh9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUrxedehhKxtQbf51opaSHTLaE9Ig7+4d6wToOekCoZdYVskxMp+jUwHhD4HxhR+GjgW6Rdl7pZO1B/9CKsougF51z6YqcOdKnh+GgsbkmWe3YXsS6nSqPyBNV0VZyDSUope1Ue2lso73IPYWG2etAJZ0bI01V5Vzsv0x8Qmfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4vP1vEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4vP1vEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC431F000E9;
	Fri, 12 Jun 2026 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301014;
	bh=KbnqjfkQJPZDUph6pjQp6xkgQhisdPg4pk2AAvCGOPo=;
	h=From:To:Cc:Subject:Date;
	b=G4vP1vEISHVj+h8gGYQc2OtJHsxXL3dgd6xMml9CP5ShnQiPTOtT7tsyAc0RUYtyF
	 nyd7nte9CYe1aDkadwecQaLgHVfXuDlfQCkCihEG1BRNzs8gGXEWzMvo4cZVnG/+ks
	 kbTCCAtN5VDwSS/NC72p9qX+NLchcg15ZqT+vKDAQi+8c2lfi7XFbjYyeYNh5OWMRR
	 cFlq6lEbZ5QLd1xJ3UllCCNWidXcVmVslhrh6rGu7q0cNA56tneLBx4ZhHMThqrMvU
	 f1WZUh2PPxRKi5JV0WZwN6EX5m1MN42ztex/h2y1BUbeKZqbViR62TyI2nZppiPSrM
	 c316KHYl2iXfA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: of: Match trip property helper types
Date: Fri, 12 Jun 2026 16:50:09 -0500
Message-ID: <20260612215009.1884665-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal-zone binding defines "temperature" as a signed int32
value and "hysteresis" as an unsigned int32 value. Using helpers with
matching types avoids dt_property_check mismatches and preserves the
signed interpretation needed for trips below zero.

Read "temperature" with the signed helper and keep "hysteresis" on the
unsigned helper using separate typed temporaries before storing them in
the trip structure.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/thermal/thermal_of.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 99085c806a1f..196cb29afae9 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -63,22 +63,23 @@ static int thermal_of_get_trip_type(struct device_node *np,
 static int thermal_of_populate_trip(struct device_node *np,
 				    struct thermal_trip *trip)
 {
-	int prop;
+	u32 hysteresis;
+	s32 temperature;
 	int ret;
 
-	ret = of_property_read_u32(np, "temperature", &prop);
+	ret = of_property_read_s32(np, "temperature", &temperature);
 	if (ret < 0) {
 		pr_err("missing temperature property\n");
 		return ret;
 	}
-	trip->temperature = prop;
+	trip->temperature = temperature;
 
-	ret = of_property_read_u32(np, "hysteresis", &prop);
+	ret = of_property_read_u32(np, "hysteresis", &hysteresis);
 	if (ret < 0) {
 		pr_err("missing hysteresis property\n");
 		return ret;
 	}
-	trip->hysteresis = prop;
+	trip->hysteresis = hysteresis;
 
 	ret = thermal_of_get_trip_type(np, &trip->type);
 	if (ret < 0) {
-- 
2.53.0

