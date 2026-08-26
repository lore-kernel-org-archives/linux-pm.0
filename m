Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144072C21D9;
	Wed, 26 Aug 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758372; cv=none; b=h+uGNCjMhjMeoeOmY9h9tPewkwGXK6E3wp7K7UrrGwvDM/jqCDpDdhjT2Dc5sfsB0/V1h6jIvFskULXvoixDJTGWrQK+eZ5Kp30UgGWZ97HqfB6+gbRzv6fQDmFvAxapnEKf8ZMiEyU2+10HZK1Y++BKz4Rrhc6qr0QdZAQFO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758372; c=relaxed/simple;
	bh=J40l+30bqo/TWKSFs2ZS5U8M9FRsuAwO92aJdBs7SKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn58Ud4VPHyTIEqiVQd534sU8tdUOY1sZF3uMFUD8ukk4y3g3a8DMQATR3+bkqJg+LGpyE/QpOxfseIRCzZg3Zs7S/P0snO2+u+62zaaNN4FYz0rXcU6mVMKlO8jVni9hOkDnqapG6hbyv9/rbs2ElMuwhWpni4SItZo7UI4MYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE6peSFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE6peSFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0CE1F000E9;
	Wed, 26 Aug 2026 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758370;
	bh=6TMO2fi8GNP9yLMBphM2ojRf9+REGiEXMTqq48IVKdk=;
	h=From:To:Cc:Subject:Date;
	b=FE6peSFWNqcf0afq+JceGcCidB8ZXn0hHVcx2bLBJabnkSoAt2mKhgxF+s5zS96Md
	 Of7zxlpxj8f2AmzdpoocPgAFjFEvLGH70q1xCs23G/jwoFIKHWF0LH4QhM0O9dbP7h
	 g+Q0lb42sGFQyBi38We3qq6xeK+g0AywS6t83+wWpMrNonTqqqMbBThK6tByApzzJw
	 aCKGzNHX+sjIU8XTK2xmit3vvGlze2cGKW/qKW3uknut3QMXZgxtNj+IdNUah0JVWu
	 9oy6JTaUXOMlVcC0EIsNAJNlxxXQ+yQxNolIONISy7TBcQCkrnui6I1X453ApbKBNZ
	 UJ1sCpDqNP+gQ==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thorsten Blum <blum@kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: Fix temperature selection around 0 C
Date: Wed, 26 Aug 2026 17:31:43 +0200
Message-ID: <20260826153144.299746-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=blum@kernel.org; h=from:subject; bh=J40l+30bqo/TWKSFs2ZS5U8M9FRsuAwO92aJdBs7SKU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn9bA8CtluU+N1aPHftSbs5s2beWJJ54n+dZ9Gkp4raV y+8MuhX7ChlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJ7G5m+MM5RfKAq+0f71me U2ObGGRjOk8FxS1wOhs+4YWZrU1/yw6GP1zqvzvMtiwx+/Nv10LtGWI9GUsvPG9XTvwQszmP0WC lGjsA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Since commit 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp() to
support negative CPU temperature"), intel_tcc_get_temp() can report
negative temperatures.

proc_thermal_get_zone_temp() still uses *temp as the current maximum and
as an implicit "no reading yet" marker. However, this breaks when a CPU
reports 0 C, because a subsequent negative reading can overwrite it.

Use bool temp_valid to track whether a valid temperature has been read.
Initialize *temp with the first valid reading and only update it with
warmer readings.

Fixes: 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp() to support negative CPU temperature")
Cc: stable@vger.kernel.org # 6.3+
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 .../intel/int340x_thermal/processor_thermal_device.c   | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index f80dbe2ca7e4..b0284c2e2e74 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -179,17 +179,21 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 {
 	int cpu;
 	int curr_temp, ret;
-
-	*temp = 0;
+	bool temp_valid = false;
 
 	for_each_online_cpu(cpu) {
 		ret = intel_tcc_get_temp(cpu, &curr_temp, false);
 		if (ret < 0)
 			return ret;
-		if (!*temp || curr_temp > *temp)
+		if (!temp_valid || curr_temp > *temp) {
 			*temp = curr_temp;
+			temp_valid = true;
+		}
 	}
 
+	if (!temp_valid)
+		return -ENODATA;
+
 	*temp *= 1000;
 
 	return 0;
