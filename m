Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080095;
	b=4VnKXFIBFU0LU4X/bbY+Rg7X+x7++jhzsRnNu6KZ+LajPVXGonJfDO36UfiU/QLKU421
	 zgv02ZXbkkhSewrt0arDBoVi1VQ5NYKIyRjfbQTdzNADyA0MgHD/viao9ONBpYvlF2oXV
	 IyPby8om7IZCUdCSM60dpDGSF/DG1Au/9n6GxJA+2i6osqH+1pS5t1Ut5MilNnL6QB/vZ
	 3PC7Ixlo46Y7ZWaqZtlLQWIDcCgJiQIOTAUV5/YV06oUnNTaS5uMiyaS4/Nj+5IBHuK62
	 8kJx0sgOh1qy81rW0xYJGSc1JzAng/IwVVj/Q5751dz19w8Ke8JhacteeKicMEfyfYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080095;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=0DI7j/c/MfCh2LopA/Js2dbquKxuxdQPBDN39m4fksQ=;
	b=NMG3o5G8SbMUbvMUSMFRVhNAOCmaZWU3TQZGEPc8iyAidmfhv0bDKpRA4DVzD+6Juaeo
	 SAuMKysZfCEJ8ZhJNNLVRy4B1FEiaT91S+rpAUA8fJEFn3uJLyBrGryROACniNjNpNv57
	 l62qZnx3xI9pmL/hJ9oNfIOD5BJU2OtlEsgLHAMGCeY22A0rODagHrTpkpOe5Bg4Wouej
	 /SJpyHniI3PtcAPLpJrdw98LZB7tUDerV6TDVdb2+CpxIdaEDRVVneGkE1WjseYzTYqXR
	 Og+vMMSgyDbJ10YjV34tHboxeqiWgDQX5X2kld4lBS8eeDTgaqnp2h69nQtjUSfcF6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jrxMUBFG;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF34606A324
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF34606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jrxMUBFG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0D
	I7j/c/MfCh2LopA/Js2dbquKxuxdQPBDN39m4fksQ=; b=jrxMUBFGZ3mHRXJQBb
	5fq9lzozy/ykTc6Cl7+KtwNNfwV+rOTPi04xG2FwDZLnJrFwccjaFPHe7h+aNqzB
	z7O3POcYPZmb2dLz0ekaiifB9PVu3rwr8o+QplFXso0DDTPVbM7cdBDxBSeP+fAH
	2bTCASYJV7Tfdm1ukNe6lLyWo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnhCGEv_5quVLcIg--.49474S2;
	Thu, 19 Nov 2026 17:21:10 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	deepak.sikri@st.com
Cc: linux-pm@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] cpufreq: spear: Fix clock reference leak in spear_cpufreq_target()
Date: Thu, 19 Nov 2026 17:21:07 +0800
Message-Id: <20261119092107.2996479-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wCnhCGEv_5quVLcIg--.49474S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7GF45AF1UZFy8uF15Jwb_yoW8Gw4fpF
	4UW3yjkry8JFsxt3WUAF4DW34Fvas2kFW7KFySk3Zavwn8JFy5ZayUKry0qF4a9FWkAa9Y
	qr4Ut3WxXFW8Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pir-BtUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gZr2Wr+v4bN0AAA3q

spear1340_cpu_get_possible_parent() acquires a clock reference with
clk_get() for each frequency transition. However, spear_cpufreq_target()
never releases this reference, leaking a clock consumer object and its
reference on both success and error paths. Add a common cleanup path to
release the source clock reference.

Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Add the missing space after the comma in the commit message.
 - Rename the common cleanup label to out_put_clk. Thanks, Zhongqiu!
---
 drivers/cpufreq/spear-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index ffe5eda82f0b..188d4d0b2c56 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -136,7 +136,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 	newfreq = clk_round_rate(srcclk, newfreq * mult);
 	if (newfreq <= 0) {
 		pr_err("clk_round_rate failed for cpu src clock\n");
-		return newfreq;
+		ret = newfreq;
+		goto out_put_clk;
 	}
 
 	if (mult == 2)
@@ -147,6 +148,9 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 	if (ret)
 		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
 
+out_put_clk:
+	if (mult == 2)
+		clk_put(srcclk);
 	return ret;
 }
 
-- 
2.25.1

