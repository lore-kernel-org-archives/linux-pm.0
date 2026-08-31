Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B737B3F2;
	Mon, 31 Aug 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205394; cv=none; b=ZnUMOllPM6pF0cWqlbItAfCROmGEQ4tZ7funxBj0VJq/76ko+5rRSuiAPvaEvtO6gYiV23r47pQMl0Nrz3OfSNMb53bPKC27/IelwFaL4eSRuKhv0EvZlGfWkPUdlb74rWrnV+7x9FflOB3blTTw0g+6qjNkbAvQ8IYLN9JRIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205394; c=relaxed/simple;
	bh=HSOzL9f3fJbBUWZTjEoErPW5oKElSQARMiuLctOP2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv0kboSHDH1bpJunl91dOeKsJ/0qMMcF/eF/TjSpAtJWNlawvO6iasZhkKW+XQB7FPROJ1lsFanXsb1zXybKT4e7TecZTcs9Y4QXpt3VYr3vdrrmkJFXHgmYLYmhdtOxz+fvh4pyYhY0EjoX5oKrWIYNx4jPofjiIPL589nnXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyGaFkE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyGaFkE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A62A1F000E9;
	Mon, 31 Aug 2026 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205392;
	bh=Q4S/Ao/HKfFy6Z/FkTaXBxHMPcpWN9SR5Guu9JVSIGc=;
	h=From:To:Cc:Subject:Date;
	b=WyGaFkE+nolkG4PBl99o5zXld0Cvk/Bg3iwrQ6z/vudHU/SAFUrcG597o+OCmh4qP
	 EROQ8VVFwg+Ebore1wrvr9gUHJ1G8DsA4Ny9+KLxN0bjAEXFdSMUxl4YWV0wP7pn7b
	 gup8ZWP3BnM8ldW00tQJt7IQvo1YUB6W5vWc1313MahESgQR/HcEfZZNoKS166QcwV
	 Khs63vDiWnaAzOFjgStLoQT5y2R+iDMPTO2q7JABjgl6+tQ5lVMtVibZPXWSiqcY4C
	 3BPUS+TgmrEhfoii8Sw7wH1teEt7JII1BW4u+/bb3bMP9grrnme1/JzfkvFnwjNbJY
	 UgdGjbo0rhk0w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] thermal: of: Match trip property helper types
Date: Mon, 31 Aug 2026 14:42:35 -0500
Message-ID: <20260831194235.1182138-1-robh@kernel.org>
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
index 0217a49b08ae..deaae7a995c5 100644
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

