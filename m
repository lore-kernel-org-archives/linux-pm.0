Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45E3D6CD0;
	Wed,  4 Mar 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648233; cv=none; b=sw6ltA+TsVbbHvH0y6y/ua9d+WJpcEP6sozCANe6esGmaoeRo/TzvvHHbLuUpnq6xewuyOO/L5wznZj/PPgWZzWtUmBz8Dh2m0cGld8MuMJeOjC6IIc3kWT8/1DputJIfHfYBhzp+clN1NUVQmC/siLO+6cdcLyTC9Cl1kDjJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648233; c=relaxed/simple;
	bh=MZx+NJBG9GYPs79COSdZaD+MCMhkJPIJL4OlAsjT/UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POlJgnqJxgAcNqLEaJSVUys8PiAMlVhA1pIWI1rqdraJ4GEI6z/xZejOtUpODTtBv79f7h0UBzN1aboUluKKJV7JIsKviGusu5cm+RuyfOUetLAFVonq46TJSqYGzwhpgADZkIjxXt98QttnYx206He5yqoj6/kBkxMStp8KeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK0VriBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK0VriBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693DC4CEF7;
	Wed,  4 Mar 2026 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648233;
	bh=MZx+NJBG9GYPs79COSdZaD+MCMhkJPIJL4OlAsjT/UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rK0VriBM2/ZYSI6eTs2xrKAOlzmZ01cxAD40WqmNqaujUMtmPBzuol6wtfVOsqVL4
	 OP2+mgEHfF6skXNM1RfQ8CgMz9zVUamUv8kF9r1kXNiuiRqKCFxO4ZhlASZEgFt+rC
	 vR9RHnyIGjb3K5Tz0Oxw4HY74EQ5JMijzTN3xUTYpNCrxM3198AIsXUs7n0ShfyM4h
	 6GCnWaMq/ajbbk8SZcAYxTRULCSSb1lcywE9txn3X0K39rYiV9T6h5QdR6zFyCBjRe
	 uWoZ9WK99tuaM5nm6z9BhWlOedP6YKpqmqRyn7zyKuqfUx+QooEvHDBTydgpOrZ7a/
	 Tzed/0MQj4ATw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 4/7] ACPI: TAD: Rearrange RT data validation checking
Date: Wed, 04 Mar 2026 19:14:44 +0100
Message-ID: <3409319.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move RT data validation checks from acpi_tad_set_real_time() to
a separate function called acpi_tad_rt_is_invalid() and use it
also in acpi_tad_get_real_time() to validate data coming from
the platform firmware.

Also make acpi_tad_set_real_time() return -EINVAL when the RT data
passed to it is invalid (instead of -ERANGE which is somewhat
confusing) and introduce ACPI_TAD_TZ_UNSPEC to represent the
"unspecified timezone" value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -49,6 +49,9 @@ MODULE_AUTHOR("Rafael J. Wysocki");
 /* Special value for disabled timer or expired timer wake policy. */
 #define ACPI_TAD_WAKE_DISABLED	(~(u32)0)
 
+/* ACPI TAD RTC */
+#define ACPI_TAD_TZ_UNSPEC	2047
+
 struct acpi_tad_driver_data {
 	u32 capabilities;
 };
@@ -67,6 +70,16 @@ struct acpi_tad_rt {
 	u8 padding[3]; /* must be 0 */
 } __packed;
 
+static bool acpi_tad_rt_is_invalid(struct acpi_tad_rt *rt)
+{
+	return rt->year < 1900 || rt->year > 9999 ||
+	    rt->month < 1 || rt->month > 12 ||
+	    rt->hour > 23 || rt->minute > 59 || rt->second > 59 ||
+	    rt->tz < -1440 ||
+	    (rt->tz > 1440 && rt->tz != ACPI_TAD_TZ_UNSPEC) ||
+	    rt->daylight > 3;
+}
+
 static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -80,12 +93,8 @@ static int acpi_tad_set_real_time(struct
 	unsigned long long retval;
 	acpi_status status;
 
-	if (rt->year < 1900 || rt->year > 9999 ||
-	    rt->month < 1 || rt->month > 12 ||
-	    rt->hour > 23 || rt->minute > 59 || rt->second > 59 ||
-	    rt->tz < -1440 || (rt->tz > 1440 && rt->tz != 2047) ||
-	    rt->daylight > 3)
-		return -ERANGE;
+	if (acpi_tad_rt_is_invalid(rt))
+		return -EINVAL;
 
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
@@ -145,6 +154,9 @@ static int acpi_tad_get_real_time(struct
 	if (ret)
 		return ret;
 
+	if (acpi_tad_rt_is_invalid(rt))
+		return -ENODATA;
+
 	return 0;
 }
 



