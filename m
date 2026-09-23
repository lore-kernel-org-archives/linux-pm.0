Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003D49158A;
	Wed, 23 Sep 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195409; cv=none; b=IgKxVP+eWt+HdrnxW7FkxhVDLS+Ll3EUGbqNAJQHwQPNI74XNnL1y2kPCXjBDhnU/2oaAe6/pN1E3m0l4ftIuKPUy4JzOcLjnenBC70uRzWvslgRKqNAMRHx3Y72u+KeW/g1TmpNgMRB2ZXqsvT0lbYzNgT9G4iGa946Gr7lkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195409; c=relaxed/simple;
	bh=l/L16RIQXOIcpsuc8B/Q27SSoejSacUiZ7VIxJ9/sKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcO2nJodlTtTx5AVWco1L1TouGGiTaBbJxZB4Mx2kCLUGWc/h9wTGt+Q2gPowOTkIblpprAFDa4Di2Eu5ZAQFG3SpCj9FSq+c/jxu7HGIwrTEQHm/NG6mzxTY7zJIleqICoQHkSAIrG73s7k8hb47A1BguVe/OHD5mv5UNz0g9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiQwDmU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiQwDmU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C21F000FF;
	Wed, 23 Sep 2026 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195406;
	bh=WuN/Zw7Tqfx5yCuouJcJKaWCPTaoA0msJCrhu3Ve2NE=;
	h=From:To:Cc:Subject:Date;
	b=FiQwDmU8aPuzb8vCxd6RTpEF8btC8K/X9OkPD0RDSj2vm1WgpFjnMqjQt3ztdcp4M
	 IUPK31a8qWxxkXN56yBwwARKxVrWE7e0Il35ldv4IFLFLrrIopXNUsjj0dGoTr7om5
	 ffzi3nZkq6gKDej9J5w2PjzkEFb1O99wLhututgaC6RGoYtkDxrlZ6MFf0MZoq4IF+
	 zCSVaHQsR+FOIGYI21aeL/NXZ3xeu6sh6yg9J0CmaXbALi1JISkoYcIGNdR1Swh0sx
	 1GSFID9O07+Ay4EdA9PwxNj1LCc0KvKL13cdgUyS4gY1LxsX/woNdHc8ikKbzGxHFy
	 84DnqMy1E+nDg==
From: Thorsten Blum <blum@kernel.org>
To: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/cpufreq_cooling: Simplify cpufreq_set_cur_state()
Date: Wed, 23 Sep 2026 22:29:13 +0200
Message-ID: <20260923202911.90464-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=blum@kernel.org; h=from:subject; bh=l/L16RIQXOIcpsuc8B/Q27SSoejSacUiZ7VIxJ9/sKo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlbzKabXuoO7PmeZrjRRPjSq+bZx1P9v3WumvXNLDy8b kbzzZdPOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAikssZGbZeiD6hMjejor6Z NaHYdYod4zKN9CKZC2vclvx2mLn/vTXDb/b5P+RLozjvV9z+vnNbwWpVSY8PU5VVH/ktSwht4Z2 lxAMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Return freq_qos_update_request() errors directly to simplify the code.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/cpufreq_cooling.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 768859a7aed0..e89036077bef 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -488,12 +488,12 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	frequency = get_state_freq(cpufreq_cdev, state);
 
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
-	if (ret >= 0) {
-		cpufreq_cdev->cpufreq_state = state;
-		ret = 0;
-	}
+	if (ret < 0)
+		return ret;
+
+	cpufreq_cdev->cpufreq_state = state;
 
-	return ret;
+	return 0;
 }
 
 /**
