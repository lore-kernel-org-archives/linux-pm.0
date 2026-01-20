Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC044CADC;
	Tue, 20 Jan 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922625; cv=none; b=m7pqjFmbUnVGl5RHaU+XuCZZTz4QxFBbJj4fOnxHiMEEREN1ItLi8TKq19ng5cBCdbDc//bFnL/EcE/KBul9CbJnLF7OaHqk84XgeBqFHwrvTrJa4IzBB2spPAs3bin4Ph6YJ/6x3XfcBha/EdAvamMBWLcdN4eIekGuHbGU5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922625; c=relaxed/simple;
	bh=yFpqcP046V33uu7LH9iROjAkwfN+Ziy2MDZKuPNJabk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGS7YZi10l/c+NudhKnSCZujvB+msLb33boTWAN+TxE4jfuL5tpuqqIauZiNV3Z4S8JUN1ODkxGTp2s4fMnBNAt++8+JUSOiQ03/Bk3g0KUoiC+LJJF4vsnbYTMePoK6zYvtxiYhLUffrDhV5w7XvilhDzgQ6sNwAoAeyrhRXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqY0vvXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqY0vvXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806CC16AAE;
	Tue, 20 Jan 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768922624;
	bh=yFpqcP046V33uu7LH9iROjAkwfN+Ziy2MDZKuPNJabk=;
	h=From:To:Cc:Subject:Date:From;
	b=TqY0vvXR7bRhUJKoca81xN6InO15NdEjCG0GIrHXa81xsHN6yTgrk3r7msSaApANj
	 n5ku8XpIHXPLFKqEvGFMIsyIcTax3y+SvnTigROxJihbFOZCrZ/E+54hCuthuk+mL2
	 F7A8o9h57UjVqxHB8p92gLuHC5EOuERFDfbo7hu9XB+jaNqgnHLh8QeFEaPspkRF2H
	 5Q8BVGUBLgAnMbqnR/gAB6UtxFgEDU8QXz543gHfK8cqYyNzpg2E4n6W69w4+CTfD6
	 My0JBD2KMS17rT/HAcNQo4aTMd9LtxsBd8BgFPZXdcOVvgKF8YqEe8vjjgVY9BN/bm
	 VGnBttB3rf/rA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1] thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature
Date: Tue, 20 Jan 2026 16:23:41 +0100
Message-ID: <2815400.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit be0a3600aa1e ("thermal: sysfs: Rework the handling of trip
point updates"), THERMAL_TEMP_INVALID can be passed to sys_set_trip_temp()
and it is treated as a regular temperature value there, so the sysfs
write fails even though it is expected to succeed and disable the given
trip point.

Address this by making sys_set_trip_temp() clear its temp variable when
it is equal to THERMAL_TEMP_INVALID.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -128,6 +128,9 @@ sys_set_trip_temp(struct thermal_zone_de
 	u32 l, h, mask, shift, intr;
 	int tj_max, val, ret;
 
+	if (temp == THERMAL_TEMP_INVALID)
+		temp = 0;
+
 	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
 	if (tj_max < 0)
 		return tj_max;



