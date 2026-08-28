Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E923EAA0;
	Fri, 28 Aug 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942685; cv=none; b=u+C72s7ma28WWBaKwyI051DFLoGzVsxOTivC4Rw0VPp4R7FKBsMJiOiqrliblOtL5bmMFsD3flbHXZWt+VEBbtHe9vo62OmYpUuS6JmgCrifTQv4DUjCbVKkCqrO4fU2Cy+hGpdn6O9B+d/S98pLTAtfqYhEsOwvpMz0ojIZm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942685; c=relaxed/simple;
	bh=3jffpBVcukgUyYNOF1ssAjF3OhCA3KPbXMICgn/glIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9OUh7rqwtu85ZyoVHqqLaSiVJskVy8TMOoGQx/i7qy/vvXZu72cPIr9elkqOMWy/NtN66fF7hEm9eWiXqxItaI41aE9IlRnbYKGsjxiHMhKG9YHcXPMv2eKhvNqBaj1/hHBckFdnsP1KMbbkpr/o7cFwo9n0CaNcf4Q4UzSKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP0zpmXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP0zpmXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8981F000E9;
	Fri, 28 Aug 2026 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942684;
	bh=8fVC3zflRr7ax3cbdpWuGVK1Lo8LoOrXskquDbFPkzw=;
	h=From:To:Cc:Subject:Date;
	b=QP0zpmXHSEIuntr9BXJY8voPqfnC5T9tn9EUI8Dyx2SIFd6FG31JsJqWkkgW6jt5D
	 jOOYJiPVZNBYho9VISR8o3+m3Xtp8nAfV1HmG6XHpvOSp5ULZ0AYG13BJJopKDidUz
	 yTOpjcFEZsR6vhzP7TlTIQnjEEroNl0nUNHRxEPV4uAlVPwsmLgb2VsI9YE6oJE/1x
	 3+mBan1SLSR7uKYOtMxfB0mzK2iJPobrRgl81UmoZlnYLu/LM4+DQ9ENemMNvkifnf
	 YlQLOxJ7Rw1tEDX+5ZdOuIQybunlKEMuYfPSOW3I3v/NyWnbwFdw7S1grfYBd8mcAr
	 mVKiLL7u4PdfA==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <ynorov@nvidia.com>
Cc: Thorsten Blum <blum@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Simplify idle_inject_update()
Date: Fri, 28 Aug 2026 20:43:52 +0200
Message-ID: <20260828184354.39423-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=blum@kernel.org; h=from:subject; bh=3jffpBVcukgUyYNOF1ssAjF3OhCA3KPbXMICgn/glIs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkTr732amjbcPHdhLJcj52r95QUyQgETrtjdW9nnRLH5 SlFtkeDO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiC6QZ/jseeHbpzIfgGd5W Kzx5jPqUPvebeObWc2y6nuEuyn4hzp3hf1CT/BXBneKli9lFkg51yv//xzL15dacY87nK9R0dqS acQAA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Drop the local update variable and call idle_inject_set_duration()
directly instead. Also return !should_skip directly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..c693cea4c526 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -536,23 +536,16 @@ static struct idle_inject_device *ii_dev;
  */
 static bool idle_inject_update(void)
 {
-	bool update = false;
-
 	/* We can't sleep in this callback */
 	if (!mutex_trylock(&powerclamp_lock))
 		return true;
 
 	if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
+		unsigned int runtime = get_run_time();
 
 		should_skip = powerclamp_adjust_controls(powerclamp_data.target_ratio,
 							 powerclamp_data.guard,
 							 powerclamp_data.window_size_now);
-		update = true;
-	}
-
-	if (update) {
-		unsigned int runtime = get_run_time();
-
 		idle_inject_set_duration(ii_dev, runtime, duration);
 	}
 
@@ -560,10 +553,7 @@ static bool idle_inject_update(void)
 
 	mutex_unlock(&powerclamp_lock);
 
-	if (should_skip)
-		return false;
-
-	return true;
+	return !should_skip;
 }
 
 /* This function starts idle injection by calling idle_inject_start() */
