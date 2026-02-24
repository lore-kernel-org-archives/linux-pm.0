Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8F3A0B3F;
	Tue, 24 Feb 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945086; cv=none; b=vDrqwgOQWSyYfA/B3SA8lqoguh+TcrtpWdFj4z3iS8bwAd5HSO1r07BhvO1EfI67j34F22jQqt4ZQt1r4aoGAMetYWsVbRlZl/4Da55CF5biHEf2ZEBxWobrTU9a48KfCUf3ZmeA+9eVMwjVc2oxcxh93t+Yji8Vi1+KBp1tVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945086; c=relaxed/simple;
	bh=kZgSjaR7mhP38wsRmF8leF3SOT7rcWV2z0nmuGGAdzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jz2Xh8/oqn+hxvrP6M+kF0rDG/S7VLDRXg5ejjtxCUdZn7UfZzf05degMDUk16pEhCyz0hC/7BhGy6IDRfk13RDB6W7/rlmUA64c+pwtn9bjgYixq7YJtOFh8yrdAUy0AwDnwtx8OVVn3Y1Ea05wlCE4tx/RLB/zymaSWR7zPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZQftGFB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZQftGFB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771945072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KcAsZ3CHaQytxOA1JEl/SWaOKrjOymd2YsqbqcBYKOo=;
	b=xZQftGFB/ixKCvhZcJgFfdXM2swk/aYpYWFmMiV4ZmpZD08SYS4pcbcyPqEQxSEpgWooV0
	FNv/uFc5TJn9Kh5XOvH24wpginLeaFTVaNUHTGPmpdF02rJGhGmbi1RSvLhaAsnDULkcIZ
	+vVj5M0g+OBE6PG0cpuCZ44g0jKD6Zk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Freeman Liu <freeman.liu@unisoc.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal: sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
Date: Tue, 24 Feb 2026 15:57:43 +0100
Message-ID: <20260224145743.586746-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The raw temperature data was never clamped to SPRD_THM_RAW_DATA_LOW or
SPRD_THM_RAW_DATA_HIGH because the return value of clamp() was not used.
Fix this by assigning the clamped value to 'rawdata'.

Casting SPRD_THM_RAW_DATA_LOW and SPRD_THM_RAW_DATA_HIGH to u32 is also
redundant and can be removed.

Cc: stable@vger.kernel.org
Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/sprd_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e546067c9621..f7fa83b2428e 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -178,7 +178,7 @@ static int sprd_thm_sensor_calibration(struct device_node *np,
 static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
 				    u32 rawdata)
 {
-	clamp(rawdata, (u32)SPRD_THM_RAW_DATA_LOW, (u32)SPRD_THM_RAW_DATA_HIGH);
+	rawdata = clamp(rawdata, SPRD_THM_RAW_DATA_LOW, SPRD_THM_RAW_DATA_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

