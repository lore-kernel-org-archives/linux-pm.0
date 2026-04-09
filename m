Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314322749EA;
	Thu,  9 Apr 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739573; cv=none; b=bqHtTtggjieblpC/Qx4KKWFaq5dYaCSWc9u3ZFCdhq1fBuMLVezhlK143+4AUNDC7pCT27PxkjJ/AF6xYU3MPKiNABFDYzMZq5zzK0JigtMjY3pLZHTqpRCQC6yoWnQPhvHriWbL9N+AFCnBfyyEuZxH3NVbV3V53DNTwOEgsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739573; c=relaxed/simple;
	bh=/CD3r/8ZrV6NizCvbITZXKeqNMuD1dL7A65opHTPK2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLlrDTpdhim7h3cGZ3IOop1zHVbkG2LiASp1+juXx54UgutX8FxiaEkXp/Tbd1fGJlibcR8UU1HRj+5m0ePWP7eSMpqABY0YzJzZODwC/zpasIztZC+mNp14UX8dfvRRkWobzyo9AIrXvd97mV+iNap2dFlIvzEGHPa+YXDSdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 1rP/+D1DRJir+2j/hHMjKg==
X-CSE-MsgGUID: eAPoP2GDRgOt6f1AQ9enYg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Apr 2026 21:59:31 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.172])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 62E6441B5544;
	Thu,  9 Apr 2026 21:59:27 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH] thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry
Date: Thu,  9 Apr 2026 14:59:16 +0200
Message-ID: <20260409125916.2244241-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trim_offset field was removed from struct rzg3e_thermal_priv but
its kernel-doc entry was left behind. Remove it to fix the mismatch.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index dde021e283b7..f0e29fe633db 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -93,7 +93,6 @@ struct rzg3e_thermal_info {
  * @info: chip type specific information
  * @trmval0: calibration value 0 (b)
  * @trmval1: calibration value 1 (c)
- * @trim_offset: offset for trim registers in syscon
  * @lock: protects hardware access during conversions
  */
 struct rzg3e_thermal_priv {
-- 
2.25.1

