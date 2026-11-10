Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352595;
	b=MdwWV5SXeeDcGH/u4OCoJ1rigFd1r7xkziMwVH4aZb1jEq/KT2vHImyWP+LL0OvZwVXM
	 QyYiXqkB+IMuaKPf3mYWrarh811y5u+ZxirTJqMu+XB/SHqXLvYEbAQSLM4qlfEAO4t5b
	 /8nsqqITe7fih/u1WdD5dFG25VPZsZtFeGH3tPeCbRgeCmYC2HACS2d5Rl1M04/1QjzyP
	 6Ne+E/aqFvdeMXcrfzqkGRvdjyeCqb6iatuBvM4XWlKFJ5IDgP7Gklu7reoENGdPVRr8b
	 g+pBwzPG1HTCW6cfAWurLSXQh1lNnFNT/AFPYzhI4Zkar0HhHFuLodP1Tqd81Y7Fvqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=6nTsZ/RgXNuXFvUEOOod+VrfRUKjmcSNKfCi4mcdtew=;
	b=JSvpbhlm6DVU3iTsMolEMsVBRPNjj+eXdJL4kJYUdvVx6W0qGdkx0vXvdq6l4AzzKYSt
	 LIryIY2iOuu/On8jX6aAjQ3JkccLW4bU+96s0DahUFSgn5Ek6bkMSmSijqNYcYizmiTfE
	 UceQEO+5CfRsg/3zXueam8UX1y/hM3NQ4xj8eUoJ+1Gb+iWm12GmcxOZ99f+hTdfzB0dK
	 Wf5HCFZbMVUsAE4tDw/8LeviOQ7CZLxN+/G8obm8cqX3aRQp/lzBwCiXiSCNcUl0Hjf5k
	 eYblmq6ekrvoYvsNT43qqwuPpoaUJw9fb1hBJ3lu7zAISMBxAG2yJzBqMt78ZF+fo2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AD0+5cJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2A606A31C;
	Tue, 10 Nov 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AD0+5cJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279C21F0093C;
	Tue, 10 Nov 2026 23:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352595;
	bh=6nTsZ/RgXNuXFvUEOOod+VrfRUKjmcSNKfCi4mcdtew=;
	h=From:To:Cc:Subject:Date;
	b=AD0+5cJ9U8heCaFLs2Es9NkLfx4HqcOuXJkT1M3r8+4nKh2OURint6h+q3uNC8Qff
	 wuBZubxaCng9wbhXozeNsp8EJkpHEbAfPPkVXnht0EZExN3JLE8hvCnRHK5uDhRs69
	 qjtm2rfFgOHFErby0I/HKC45MSlaTrCZun1JS/zgqKlFKLC96ciNt7bO9RMIUuMvDb
	 kdV+nVtEoM/g6WbOHeHA2Txc+vuQEbYnVb3B4GUCdDB6McXLvk0vfngu7pK0q5DMc0
	 xpuu5WBcv4gD8MlYq0C9sBSVFUuqSc/6xh0tEphKjWNCLxdB8gZSIGsdVWQTxLPlR8
	 nB61MKSTwocTg==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thorsten Blum <blum@kernel.org>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Use guard(mutex) to simplify the code
Date: Wed, 11 Nov 2026 00:16:08 +0100
Message-ID: <20261110231611.7159-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=blum@kernel.org; h=from:subject; bh=E8eRpZAaRYrtKKN/A57Tver+fDtXhcLGt9YXI+b+VYo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmfl+42ZTrL1xswQb1+jXfpt61n+BXTduUveVUm1p94W /pgaXJORykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEroHhr8B7wRPf7nuFVeUf neUXnftK7NIm7cvHJsgtq1UO+lMr387wz/5ehffu1dmFqkuk7B8ldLUfVO07a7246vkarfAf7l/ 3MgEA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use guard(mutex) to replace explicit mutex_{lock,unlock}() calls.

Simplify the return paths and drop redundant ret initializations in
duration_set(), window_size_set(), and powerclamp_set_cur_state().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 71 ++++++++++--------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 1ffcb0a699e5..8461ba868248 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -80,25 +80,22 @@ static unsigned int window_size;
 
 static int duration_set(const char *arg, const struct kernel_param *kp)
 {
-	int ret = 0;
+	int ret;
 	unsigned long new_duration;
 
 	ret = kstrtoul(arg, 10, &new_duration);
 	if (ret)
-		goto exit;
+		return ret;
 	if (new_duration > 25 || new_duration < 6) {
 		pr_err("Out of recommended range %lu, between 6-25ms\n",
 			new_duration);
-		ret = -EINVAL;
-		goto exit;
+		return -EINVAL;
 	}
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 	duration = new_duration * 1000;
-	mutex_unlock(&powerclamp_lock);
-exit:
 
-	return ret;
+	return 0;
 }
 
 static int duration_get(char *buf, const struct kernel_param *kp)
@@ -149,17 +146,14 @@ static int cpumask_set(const char *arg, const struct kernel_param *kp)
 	cpumask_var_t new_mask;
 	int ret;
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 
 	/* Can't set mask when cooling device is in use */
-	if (powerclamp_data.clamping) {
-		ret = -EAGAIN;
-		goto skip_cpumask_set;
-	}
+	if (powerclamp_data.clamping)
+		return -EAGAIN;
 
-	ret = alloc_cpumask_var(&new_mask, GFP_KERNEL);
-	if (!ret)
-		goto skip_cpumask_set;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return 0;
 
 	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
 			   nr_cpumask_bits);
@@ -182,8 +176,6 @@ static int cpumask_set(const char *arg, const struct kernel_param *kp)
 
 free_cpumask_set:
 	free_cpumask_var(new_mask);
-skip_cpumask_set:
-	mutex_unlock(&powerclamp_lock);
 
 	return ret;
 }
@@ -263,25 +255,22 @@ static struct powerclamp_calibration_data cal_data[MAX_TARGET_RATIO];
 
 static int window_size_set(const char *arg, const struct kernel_param *kp)
 {
-	int ret = 0;
+	int ret;
 	unsigned long new_window_size;
 
 	ret = kstrtoul(arg, 10, &new_window_size);
 	if (ret)
-		goto exit_win;
+		return ret;
 	if (new_window_size > 10 || new_window_size < 2) {
 		pr_err("Out of recommended window size %lu, between 2-10\n",
 			new_window_size);
-		ret = -EINVAL;
-		goto exit_win;
+		return -EINVAL;
 	}
 
 	window_size = new_window_size;
 	smp_mb();
 
-exit_win:
-
-	return ret;
+	return 0;
 }
 
 static const struct kernel_param_ops window_size_ops = {
@@ -506,10 +495,9 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 	msr_last = msr_now;
 	tsc_last = tsc_now;
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 	if (powerclamp_data.clamping)
 		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
-	mutex_unlock(&powerclamp_lock);
 }
 
 static struct idle_inject_device *ii_dev;
@@ -633,9 +621,8 @@ static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
 static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 	*state = powerclamp_data.target_ratio;
-	mutex_unlock(&powerclamp_lock);
 
 	return 0;
 }
@@ -643,15 +630,15 @@ static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long new_target_ratio)
 {
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 
 	new_target_ratio = clamp(new_target_ratio, 0UL,
 				(unsigned long) (max_idle - 1));
 
 	if (powerclamp_data.target_ratio == new_target_ratio)
-		goto exit_set;
+		return 0;
 
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
@@ -659,23 +646,21 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 		ret = start_power_clamp();
 		if (ret)
 			powerclamp_data.target_ratio = 0;
-		goto exit_set;
-	} else	if (powerclamp_data.target_ratio > 0 && new_target_ratio == 0) {
+		return ret;
+	}
+
+	if (powerclamp_data.target_ratio > 0 && new_target_ratio == 0) {
 		pr_info("Stop forced idle injection\n");
 		end_power_clamp();
 		powerclamp_data.target_ratio = 0;
-	} else	/* adjust currently running */ {
-		unsigned int runtime;
-
-		powerclamp_data.target_ratio = new_target_ratio;
-		runtime = get_run_time();
-		idle_inject_set_duration(ii_dev, runtime, duration);
+		return 0;
 	}
 
-exit_set:
-	mutex_unlock(&powerclamp_lock);
+	/* adjust currently running */
+	powerclamp_data.target_ratio = new_target_ratio;
+	idle_inject_set_duration(ii_dev, get_run_time(), duration);
 
-	return ret;
+	return 0;
 }
 
 /* bind to generic thermal layer as cooling device*/
