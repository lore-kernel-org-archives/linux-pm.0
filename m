Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E473839B2;
	Fri, 28 Aug 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946354; cv=none; b=T1hwRQA8ZW8Tbjhc871paPMk+q/NKrdTr9QkmlUzQM1wSGYLHGyO5lX2msOfxE8cOgcZM2VQCEcdn6rskSH5qlJzgk4yEbtBq2iuhI/rpKK1/qA1+xVJJGw++5/+2jsWNhCWIUE1ADKfEcKZ7d77gLdbfyuw01KWQVhKjS3eX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946354; c=relaxed/simple;
	bh=tCsiZBiYPehejGUeHiDc0BgbGX8YTDVYlr001hmss4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqscO5wnZaj51a9Bg6G8M7RhwasjgrRwXQVvEdOKiM3lBFzuC2dkC16LHmoq3rmEYKG6sbgwlqGd1zUKq1K9DvV1URfh3jdosdevPrv90XFkU+THPioSwMqHMFlPRokFq31ygzVJ3Nj+opXNiMCHSjtnMbLsDlQAyQIn21bvEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfeXnJas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfeXnJas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F71F000E9;
	Fri, 28 Aug 2026 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787946352;
	bh=xO/LyGrKZJSPSj7xd3r4pi0nvpQUgWUKaHc5JWAYVII=;
	h=From:To:Cc:Subject:Date;
	b=cfeXnJasxOQ8qe9q9lVySaPAmKkMDrA7cPYkobU0BcTs6WGQ0Asgw4hgKceAKjVqV
	 e1ysd7AUibV33wNIoagLcnOyYqPZ6wmCrAdl/FfNZ2NEyDa8DNCGWZSta1J0pC5UGq
	 fTev5kNJVmfdo7HI4dLxzyckgfNQWEMegShmaRFkOYqC8gmbx2Bnz1WNykNGL/fm7F
	 9W6I0mCNx7aS0ZkC7Sy0JkUQu0pG11V2jIjS3c/HIJPaX6kq+TTfIFhZzc/zvtfcgj
	 5sybmukcXswdfwmjWuvV1wSjVqz+w6tfRPu4FLqjAV1Y+yq8u+bqkevO/lr+JD8nQQ
	 6NswZWYWwWWag==
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
Subject: [PATCH v2] thermal: intel: powerclamp: Simplify idle_inject_update()
Date: Fri, 28 Aug 2026 21:45:27 +0200
Message-ID: <20260828194530.43370-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=blum@kernel.org; h=from:subject; bh=tCsiZBiYPehejGUeHiDc0BgbGX8YTDVYlr001hmss4I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkTn0aV9nCeN330XLdwi8IumfwFCVOMxf5kScTZVc29G J9jXGHdUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABPhv8XwP3Gztbfw86LwFe80 Qng9z2xLYF/8R7E6+q/o1psN7GosZgz/a2QWH9ZK4bMOYrHa+YGrcf8J5ylzxLWEM5fd+Ld7Z5Q TCwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Drop the local update variable and call idle_inject_set_duration()
directly instead. Also return !should_skip directly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Call get_run_time() after powerclamp_adjust_controls() as before and
  as suggested by Sashiko [1]
- v1: https://lore.kernel.org/r/20260828184354.39423-2-blum@kernel.org/

[1] https://sashiko.dev/#/patchset/20260828184354.39423-2-blum%40kernel.org
---
 drivers/thermal/intel/intel_powerclamp.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..da10b02bc028 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -536,23 +536,17 @@ static struct idle_inject_device *ii_dev;
  */
 static bool idle_inject_update(void)
 {
-	bool update = false;
-
 	/* We can't sleep in this callback */
 	if (!mutex_trylock(&powerclamp_lock))
 		return true;
 
 	if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
+		unsigned int runtime;
 
 		should_skip = powerclamp_adjust_controls(powerclamp_data.target_ratio,
 							 powerclamp_data.guard,
 							 powerclamp_data.window_size_now);
-		update = true;
-	}
-
-	if (update) {
-		unsigned int runtime = get_run_time();
-
+		runtime = get_run_time();
 		idle_inject_set_duration(ii_dev, runtime, duration);
 	}
 
@@ -560,10 +554,7 @@ static bool idle_inject_update(void)
 
 	mutex_unlock(&powerclamp_lock);
 
-	if (should_skip)
-		return false;
-
-	return true;
+	return !should_skip;
 }
 
 /* This function starts idle injection by calling idle_inject_start() */
