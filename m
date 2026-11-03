Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706108;
	b=iVojAtn1X/6s5Hl0X/vUYhgylNrX3cAK9/l5Ogi2nO6DP03XFmYTWDI86IGw8NgdQy6H
	 lrxq9LFG8xI5f9mTJW/dHzkiA7AGGhS8CbuoTdsAryrq+wSvNb087M8tY4mQgCTQtSTli
	 /HHlB0xB4l3kt4LcLRxQQdC7SItMr+9j0pgf6md54f/i57AfYkdEPdTlHW4jvAIs8jMeA
	 asWoV2J95+EQ/TnxZUeFKnOn+rWjv6g9bzZhgZkxFg26GHdMQFYK1x8q92p9IVGDW0Gzt
	 V15PiTf13teTkZmszm7EJ9qDKFPrbkl7+o5OdMJaA3WbXR3lBvM5JSmmmB6LprjXrdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706108;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=98sbnNcQ4xTrrBMCKpTpd4cIOz4HhfKlfG0vG7r4VIU=;
	b=v2E4uk2htDMtQe7uqQZyjP+lXgSzJRGcWxGQbc4tyKF0BhN8uG0UFL+VXHCJACZJrgnY
	 xnZ3KaSY67marxdXKkKYbyQFBpbE6phxf9GeTIrrSXhKr8BliFHFjTziFkMXZOyhmc5Ss
	 778jI4VZXR2CE5SUpUv+b1ZCoYhaQXYWivVh/ZCIj3IuAKP5SpzTfX+s76BNpJJVFVgoP
	 bHBhO+J3i4M/GT+IZXqFNzGlkUNTOMM3BpVfzVcf9viSJR+1dYguHFlamtQ0mYNiPjK+Z
	 L7godw8xNL6b5Al7s0vFzXm1PAVYjBcFdUqcqzYsRzqfONk5YA9IemZF4r9t7ag8S8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=AztlxkXK;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6B606A33B;
	Tue,  3 Nov 2026 11:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB6B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=AztlxkXK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706070;
	bh=98sbnNcQ4xTrrBMCKpTpd4cIOz4HhfKlfG0vG7r4VIU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=AztlxkXKhSYR8sL2oUWf+hWReRl8/zjb3OPEmhJqkg2F15JMqBxHfQnmcbdlfBXYL
	 gHU/WY8MTLMIC5QqaMQO6P9mr1bm3GCJRx7uafsrxAYt7R8Sjts08WXq5wytQHccJw
	 YFIEEqojJvlhHRYKILwHTgiHFsikMFh3D7NGPiC4=
X-QQ-mid: zesmtpip4t1793706065ta37db7c4
X-QQ-Originating-IP: ic6LCeYmqbpu3GOvYX5E4cg1FQtPpeaxLuELqofmFVA=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11553825441436544460
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: bound the PATC trip count
Date: Tue,  3 Nov 2026 19:41:03 +0800
Message-Id: <20261103114103.74195-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NAtipnnbTPeaPDWpvDNGIdvxLeJnPRhJ3WdEmG7uhc+vSzBVVet+PLTP
	Gq/WqtMbI9xtbOVJYrVGBvYM6T/jkFodYbdkG8mPKqmffruWhGYvZWWU9Ifq+cwn1ZJ2wV7
	fthjVarFDLz27w4DxsEaHHWo4wlYfI/96L2TtdpiatnC3D3i9nbnfNvBDgUj6cXXG05Ae8I
	RWC01T4zLScVLsg9YdYWlCi6XRse94Fo3omLnMJoDB9Goxw46dzRQGiGFsOSK1BxPGYa9Ow
	KVjEkDQWh8/nDSGDSkYiC+2foRoCqn7SAaLGiInPfG6u6nIiPH4a1fFo9gbB49kyCg8r/En
	9JWn3FqjfkuNQ59X/qBWG7axzCAR3BWjvIJNIKgl3WszL+r/Pe43u39UC/dGNM6YYB5bdHa
	6gjxKfo3nbFopylGGG7mVkCYoTELMaDp6QcAgZ5N7N6JMmQrkR/4xL0Y288kZRBYtGufH7y
	JEscW5CX9dHdR06OxkbvZtHBdwibh8/5s2pODcE1ZDw0YgU/91D8p1qfG9lLZ3SmvW5b67P
	MaCwtC2DTcD8a5GpXQX3a+oIXVBl8QkiDlfbNEn9zTj/0nExkut2ijS3kjfDs2yHlKRnJIQ
	JxxToalqPEdlLuR+TLLiVYPAulJ0Za9F3f2taK12m3Idh9xzbYQpTS2ikRkhFdrLFNWVjwk
	wGulIZK4BJzSU7baMZd0zF1Gwoym54HOMkWBVeav1D1EZSM6PB9Dx1UybCoyJ1FnGNbamOk
	qmb/0L8ZHhWrTiN1fU10Xc30jGr99JxVUkRYk+zQtX3ZN+gkjuGPxAS7xsQFZNzljlfQDqR
	VYsg4V/4kYmpooWxORQqwBry5oSmGIZUp3Jsuo8O95YXyGUcQmr0LuY+njRMembe+Knanbs
	S3BGljDSWZ21u9+fSxP44kmQZkE5Kc3nnPXpU7BZZE5rl552T/YtBliW0GKA48XZoaW4Lwv
	HfWP4SBDzTPikqwvisZANpwK+Rj88igwRNdoAL0kIVUzgCvDLG60oLJO9x1ZbelN7I+SzDG
	0BOcZW8cVstfvKCMW4QqPLNYQGcME=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

int340x_thermal_zone_add() adds the value returned by PATC to
INT340X_THERMAL_MAX_TRIP_COUNT without checking for overflow, and then
uses the same 64-bit value as the allocation size, as the loop bound,
and as an int argument to int340x_thermal_read_trips().  A PATC value
of U64_MAX makes the allocation count wrap to 12, while the fill loop
still runs for U64_MAX iterations and writes far beyond the allocated
array.  Values above INT_MAX are also truncated when passed to
int340x_thermal_read_trips() and stored in aux_trip_nr.

Also add parentheses to INT340X_THERMAL_MAX_TRIP_COUNT so that the
macro can be used in expressions safely.

Ignore values that cannot be represented as an int after adding room
for the fixed trip points, so the zone still registers with its fixed
trip points.

Fixes: f4118dbe61bb3 ("thermal: intel: int340x: Use generic trip points table")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c | 9 ++++++++-
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 965700ee6962..6eda7823a7e2 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -130,8 +130,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	int34x_zone->adev = adev;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (ACPI_SUCCESS(status))
+	if (ACPI_SUCCESS(status)) {
+		if (trip_cnt > INT_MAX - INT340X_THERMAL_MAX_TRIP_COUNT) {
+			acpi_handle_warn(adev->handle,
+					 "Invalid PATC value %llu, ignoring\n",
+					 trip_cnt);
+			trip_cnt = 0;
+		}
 		int34x_zone->aux_trip_nr = trip_cnt;
+	}
 
 	zone_trips = kzalloc_objs(*zone_trips,
 				  trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index d504e271009a..b1da47cc5402 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -10,7 +10,7 @@
 #include <acpi/acpi_lpat.h>
 
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
-#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
+#define INT340X_THERMAL_MAX_TRIP_COUNT (INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3)
 
 struct active_trip {
 	int temp;
-- 
2.34.1

