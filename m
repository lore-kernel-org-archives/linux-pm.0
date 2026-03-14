Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF021D590
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450868; cv=none; b=l+il1A+qKUrh1RLstXeJ5jSoFa6gVH7mIRX1PC03naJmhDKuZz84b91mJzw9LqSZmBLFSDuzo58/J5Uk3a6oCg7uaiL1GHCW2xkMKD4l/unZrwTqni2TxflPLDdvPBPi8bg/Cql90wXqrfLct3AZhvC8TVMDYbbeLYF5vAJcbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450868; c=relaxed/simple;
	bh=XHbl72cclXR+zm2VcZmnvv5dBh4VcDHgiOUpiSCB07Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1eIZkrota9xKn+zv/nx91jrF/0RPsRK0hOjDnNSskMhNSsqozdJ1uzM61cQshBk2P9ySyYmSTDiz6+SEDywGzUs+TACH/sp0LXE8yT2ulhvQ2KEm1WaQlqIKvPDv/r5FFS+GONVlNU1HFJE/BXU+Yw1uFioPFuN46GkIlDpjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eWDBbWim; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eWDBbWim"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773450864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQi0pI+4Vgu1Lfj9y9irZKMoSe3vETHmNVwHzRRG7Lc=;
	b=eWDBbWim9+tVUg3ABX3DoZxCYS2+ea4ts++B3y+kC5XSImmrR+pMOhJ5oNq9rbe5sZIjZT
	F68QDp+xH2eY1NDSLh4kqhC8E1ZymZuBOc+DJ4YWyhFEsUv3YoFayruE5XJiEldnxYRQpw
	GNU6ZM5aZ3fNW9m4K3iCoc23SNwxuzY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal: sprd: Use min instead of clamp in sprd_thm_temp_to_rawdata
Date: Sat, 14 Mar 2026 02:13:07 +0100
Message-ID: <20260314011305.710278-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=thorsten.blum@linux.dev; h=from:subject; bh=XHbl72cclXR+zm2VcZmnvv5dBh4VcDHgiOUpiSCB07Q=; b=kA0DAAoWXqtxINjMdS4ByyZiAGm0tiGhSdtMtD6Dz14UnxCpAYM8OkKsLXDbV3MAVF19lPBTF Ih0BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmm0tiEACgkQXqtxINjMdS6x1wD2OHMR XaTQSJqtw5QWzX8zN1FBaVcJdM2DSpAIolJbCAEA109+hQsZWryBmDCo/Xsz1xF4O669+Ju92zh thyQA3Aw=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Clamping 'val' to itself is unnecessary and the expression can be
simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
is also redundant and can be removed.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/sprd_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e546067c9621..511f1e7959b6 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -201,7 +201,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	 */
 	val = (temp + sen->cal_offset) / sen->cal_slope;
 
-	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
+	return min(val, SPRD_THM_RAW_DATA_HIGH - 1);
 }
 
 static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
