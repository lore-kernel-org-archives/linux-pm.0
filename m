Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB044E045
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138377; cv=none; b=UNZVxJ8rOhgBePZ1F8KzyTbI5o0z69CIekpe/tpQFEERTZx3JbKuI12s/UWQFZfG99qqvOozS/fhSJcQSwGHo6BlvBOKY8VZ1YshAYSpIYwSwFQIX5V78lcJW3XkQXXfkKkjT1SDBgM+jRl4pS8ZEOjFs4jRWD7lCU0JMNOnm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138377; c=relaxed/simple;
	bh=XHbl72cclXR+zm2VcZmnvv5dBh4VcDHgiOUpiSCB07Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8S6ZiInTU52Vp5Q82HVV8TbjMNm6QKB0JXRGx6rBVxVUxkhZufSbuHSkWGXnlvWzjVE2Xhno4hCyGKd+yFqRt7yVmA1u89oPad7xp02zPCUVC5/SJNm3hFTO1s+v/OdwprWhF5XsZbl/pQ6cnN8nliq8P0ljEuxaeR4QhEXKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxa9kKNU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxa9kKNU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773138363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQi0pI+4Vgu1Lfj9y9irZKMoSe3vETHmNVwHzRRG7Lc=;
	b=gxa9kKNUX3+EjD7Ha8OhpJDA8RAEeMqOIyGKjTQmkyNYe7F6OofZRJG/3nDCWnKdMYzbEB
	NEMpIrs58oI4/RDKoed4N+sDf4rqV3Dq5JvXKlYQ3xleU8lQQQzT7WyrgSjtn6LnV4/aW+
	tS0RBK4xo7Hy638qcvdBByFfR+lJfqQ=
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
Date: Tue, 10 Mar 2026 11:25:25 +0100
Message-ID: <20260310102523.201722-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=thorsten.blum@linux.dev; h=from:subject; bh=XHbl72cclXR+zm2VcZmnvv5dBh4VcDHgiOUpiSCB07Q=; b=kA0DAAoWXqtxINjMdS4ByyZiAGmv8ZOhSdtMtD6Dz14UnxCpAYM8OkKsLXDbV3MAVF19lPBTF Ih1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmmv8ZMACgkQXqtxINjMdS6wWQEAkZ6N 0tVponmvGNbhm+Kqig6GvurLYeSlUq0hk6lvmmAA/25tsNZ0nwVQE6OpApM07YP9kvpAuEbHLtI qPyQyZnoC
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
