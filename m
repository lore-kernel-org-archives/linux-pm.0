Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F14A482A;
	Mon, 21 Sep 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001568; cv=none; b=shZn9vgWWI9HadqjUl4l/KWQUn7iEok4DsJxsYH+/fKNfEq7lVH/4WdXDdR29itB/5Q36LmH9XyxiNoC9Jyr8YQcKytYuX22c2aG/Xh/7s4iyTdWbPDi++O3Uedkskc0+pPEt/zAoDZUq3am6D/FWTRuXAtCPLE2cAItF4OKLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001568; c=relaxed/simple;
	bh=/5Q//Aq1aM5k2sxhg4y8t5ltSJXZEcn51IvhOJB6Gos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpdZNC+wbCZ7a7ab8USxohHKTJVxGVaMhEppWpos2wiry8xPZ506KRreqT8j7rjnYLshalLp36XRBSHJVQDLpLuF7Z1yDSfOq2MTv6Xi/P+5/3TZ6rHvUKS7YyZ/tLH6Nt6X7H5grlxhgJqYdEOP2ksV2RLzGSOrcMXqqF8JJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFc0ryuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFc0ryuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009081F00893;
	Mon, 21 Sep 2026 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001566;
	bh=wmWiC2Ylqqu6L2SbGAs32gmZrOgZzLH5dEw4pZz35U4=;
	h=From:To:Cc:Subject:Date;
	b=cFc0ryuNwfrYaRnMGZxfrSYVqjZ1aDV2LdwYrL1LVJVdoAIh5NI/ktLaoK4FE95SK
	 TZBCge8nBfLEdeo0oRcvVXGYBcx5hT4NoExG1QOCNyzHBGqw15i/w429UCd7cpz5El
	 LpvhQcS/mEK1M3D8jrMcEpuZ5K7hcIHF0HZf/rEPEKtoHir9NYJgFir2SPV/IYB8NN
	 K7Rcal8x7f+a8rAuFtBazp1G8Z2bQTtq/T5qhJsszLcFTt48dfz9B62WzWBU1FUDBS
	 aobv1rrp7Jpp9KQYV5zuSFc97oehTw4Zl412/rFLn86bXNepr1EKgliAKQF+jZmKx9
	 /nTEvY4hp+3Bw==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Thorsten Blum <blum@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: soc_slider: Simplify slider_def_*_set()
Date: Mon, 21 Sep 2026 16:36:41 +0200
Message-ID: <20260921143644.69381-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=blum@kernel.org; h=from:subject; bh=/5Q//Aq1aM5k2sxhg4y8t5ltSJXZEcn51IvhOJB6Gos=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkbHf4U/J37PWLPnYBnU9601Qi9nbU6/yTvJem/z/VnW FiUZy2V6ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJlJxm+J8lMiHJNd5EfltI vbvKhHr/arWolre3r1UvsHXdwJI2/xjDPyW3B0y7j7fbWS4R26VavWyanFAit0/NZWXTW583ds5 SZAcA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Return errors directly to simplify slider_def_balance_set() and
slider_def_offset_set().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 .../processor_thermal_soc_slider.c            | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 91f291627132..e161b95828e8 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -66,15 +66,16 @@ static int slider_def_balance_set(const char *arg, const struct kernel_param *kp
 	guard(mutex)(&slider_param_lock);
 
 	ret = kstrtou8(arg, 16, &slider_val);
-	if (!ret) {
-		if (slider_val <= slider_values[SOC_POWER_SLIDER_PERFORMANCE] ||
-		    slider_val >= slider_values[SOC_POWER_SLIDER_POWERSAVE])
-			return -EINVAL;
+	if (ret)
+		return ret;
 
-		slider_balanced_param = slider_val;
-	}
+	if (slider_val <= slider_values[SOC_POWER_SLIDER_PERFORMANCE] ||
+	    slider_val >= slider_values[SOC_POWER_SLIDER_POWERSAVE])
+		return -EINVAL;
 
-	return ret;
+	slider_balanced_param = slider_val;
+
+	return 0;
 }
 
 static int slider_def_balance_get(char *buf, const struct kernel_param *kp)
@@ -101,14 +102,15 @@ static int slider_def_offset_set(const char *arg, const struct kernel_param *kp)
 	guard(mutex)(&slider_param_lock);
 
 	ret = kstrtou8(arg, 16, &offset);
-	if (!ret) {
-		if (offset > SOC_SLIDER_VALUE_MAXIMUM)
-			return -EINVAL;
+	if (ret)
+		return ret;
 
-		slider_offset = offset;
-	}
+	if (offset > SOC_SLIDER_VALUE_MAXIMUM)
+		return -EINVAL;
 
-	return ret;
+	slider_offset = offset;
+
+	return 0;
 }
 
 static int slider_def_offset_get(char *buf, const struct kernel_param *kp)
