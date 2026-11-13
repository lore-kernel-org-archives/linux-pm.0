Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609351;
	b=D7sezzEH3p1JCM4y/RT9uZrNf8ShVRwiVyDQcC+9QRnAw2EbkHNFGWKhmiDr4suX6/aY
	 ZqAJtt3MrDQ92ZQUmhv81BdtP0BjaSA91x3+1GiCJ3EBq2AvDIo0Vr7+VLdpdANU1LNRY
	 0t6ntXBbWJhGhu8ZfkDzPxV6S1sfn3ulhPIkdM/YnU3MvcJR3/iRPo+35Kkwfebbkgu4/
	 L2nsRtPmCxYKO+VGBiRSiDFt5IZyvlVMMM1IYLYXZPA0rP1MeJpPQQ7G7OjwU3xTUCtX0
	 xlpKlcyX2QoS70lxrYBwXvITDjrrrEQGBxgMhb5hw4+xhIOo/4V1/Q7xCXF0ZbNqhSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=PX1ttxKVOZxrJeyGfGlzT4IGS7bABbDeROC86QayIBs=;
	b=0ELagyXO9fdzviYj+E4oOkvxLS2REMTl1kk/Tc+sN2Fy5YD9ZmciaR6zmHOPfNfJDFx8
	 D0epYTBs4SVhU3HW79xRrs9yWkKAucDct+4OR8TrKh1Y2yNEB0HH2+yo/qCySDlZA9c7j
	 7KWLkWKoua6rph/IQRODK4OM/5nP/NWhGqEDxqVrY+2vKPmfP9xrLOlK2yjmhXhOjd/2U
	 cDw32tboT1RKcfkD1jW24atGLTq69t6NgnbwUbM4AC80cvrBJivWvGOUSdlPhM9nFrD9s
	 4W6/nLTQbOfIkkjKT1dTsKA1epwU28O3RUEb1ekHqgBkX9X0dx31YUpxwaets8vFmtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPLuOZ9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E117606A54B;
	Fri, 13 Nov 2026 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPLuOZ9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E381F000C4;
	Fri, 13 Nov 2026 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609351;
	bh=PX1ttxKVOZxrJeyGfGlzT4IGS7bABbDeROC86QayIBs=;
	h=From:To:Cc:Subject:Date;
	b=gPLuOZ9G9+5ioK6UnQg9TAukeq7aXe6VvCu3jlgVfCfjjSJQx/OZTpNRskzTwEcFo
	 f/jLIRJMYuw9+RnEQlX4qFoXIhS8vFPCYBF7Ot5JwSrmdu2OAHrutsVXkeEf9erR5e
	 YylST9VykjjsB83A8fCM1JpqApK6k3hiiR2+Z1OwbBG+B9sj481ZWV1k0Xp9c5k5Ni
	 LtPTAKXt8IR5xeG+xkxT3AHrrsPYAbltabnspFeaf3olWahTKKC7Y0vD87NccSThsh
	 Sya45Z1lxpoCqF7ZpTUalDS1m+nCF76lGCbOrxvAlOzytChYlC5mz9PyMfekzdruOH
	 2cALqnmWiY9OA==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thorsten Blum <blum@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: intel: powerclamp: Use guard(mutex) to simplify the code
Date: Fri, 13 Nov 2026 23:34:59 +0100
Message-ID: <20261113223501.1581-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6225; i=blum@kernel.org; h=from:subject; bh=Ft2oU+13SjjohTS76xXk9TD/fRnsbZv26a4tbuMWwoQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnfJ0xVU/n8KTNligXjS+4VjRGqu4QtHDZ/+f37VNoxd 8GpdcEtHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRpEOMDBeetn+daVWZOjM6 ofHUr51S67zdJhmfXr0qkf89U8uxGZIMf3guvs3qXltTut/LoUm0I2cz+yZN+xK37iiXicsq2mw PcwMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use guard(mutex) to replace explicit mutex_{lock,unlock}() calls.

Simplify the return paths and drop redundant ret initializations in
duration_set(), window_size_set(), and powerclamp_set_cur_state().

In cpumask_set(), use __free(free_cpumask_var) to remove all goto
statements.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 89 +++++++++---------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index df898fc3f3e6..3c031ce2a80c 100644
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
@@ -146,31 +143,25 @@ static bool check_invalid(const struct cpumask *mask, u8 idle)
 
 static int cpumask_set(const char *arg, const struct kernel_param *kp)
 {
-	cpumask_var_t new_mask;
+	cpumask_var_t new_mask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
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
 
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto skip_cpumask_set;
-	}
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
 
 	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
 			   nr_cpumask_bits);
 	if (ret)
-		goto free_cpumask_set;
+		return ret;
 
-	if (cpumask_empty(new_mask) || check_invalid(new_mask, max_idle)) {
-		ret = -EINVAL;
-		goto free_cpumask_set;
-	}
+	if (cpumask_empty(new_mask) || check_invalid(new_mask, max_idle))
+		return -EINVAL;
 
 	/*
 	 * When module parameters are passed from kernel command line
@@ -179,14 +170,7 @@ static int cpumask_set(const char *arg, const struct kernel_param *kp)
 	 * cpumask can be allocated and copied before here. Also
 	 * in this case this cpumask is used as the default mask.
 	 */
-	ret = allocate_copy_idle_injection_mask(new_mask);
-
-free_cpumask_set:
-	free_cpumask_var(new_mask);
-skip_cpumask_set:
-	mutex_unlock(&powerclamp_lock);
-
-	return ret;
+	return allocate_copy_idle_injection_mask(new_mask);
 }
 
 static int cpumask_get(char *buf, const struct kernel_param *kp)
@@ -264,25 +248,22 @@ static struct powerclamp_calibration_data cal_data[MAX_TARGET_RATIO];
 
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
@@ -507,10 +488,9 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 	msr_last = msr_now;
 	tsc_last = tsc_now;
 
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 	if (powerclamp_data.clamping)
 		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
-	mutex_unlock(&powerclamp_lock);
 }
 
 static struct idle_inject_device *ii_dev;
@@ -634,9 +614,8 @@ static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
 static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	mutex_lock(&powerclamp_lock);
+	guard(mutex)(&powerclamp_lock);
 	*state = powerclamp_data.target_ratio;
-	mutex_unlock(&powerclamp_lock);
 
 	return 0;
 }
@@ -644,15 +623,15 @@ static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
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
@@ -660,23 +639,21 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
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

base-commit: b9d700d6f727936a58df7361f439597ca1d84a5a
