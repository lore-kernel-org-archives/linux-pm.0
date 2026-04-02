Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC43A0E8A;
	Thu,  2 Apr 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119473; cv=none; b=ESr6HM0d7Lq6uucfM6A8+I6kaR08dvzuX1RpIlZ/Rjv4SKe0c7LqKzQgNOI1s91eIuIruHkeYw7ccDmexayGkZqkxNvhKF0H4vd+RVdg0Zauxmsna9cuHOiiWyLS/Jzv0gXRZGVijMybvmN9vJmvv0HIVZDz2V9HisJ22C/Fzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119473; c=relaxed/simple;
	bh=Ek9LTerfaH9kJ3O1jr5Hlj/rRplbFdX5WHJ6ftcJqak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRt4F/Yl2gl+hF7I+sCpmauZBeifqy3t8dEvtl/cNgYwn4nOEW2adnDIho09/wr/QjLrsXDHKVkm2H0RyI5Bk4li4bE34wQqunUtE5Ye26DeuXg2cXTrwzZKxKlSojw4yvpHckWfuXMPX8eR8uoy7nxmTvJ9TSMhXEz2FvLdryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STPugAKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STPugAKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B98C116C6;
	Thu,  2 Apr 2026 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775119473;
	bh=Ek9LTerfaH9kJ3O1jr5Hlj/rRplbFdX5WHJ6ftcJqak=;
	h=From:To:Cc:Subject:Date:From;
	b=STPugAKm3DCVm2Fj1QWRchhXIQIyPtwuD3TSG1M77GYpfjObmQoqURuEvZqrQUgDQ
	 kZTvtLD22pQCKAzBbw2OQQiQY3yy6K+FkPfQjCYOuLFktOSiHaKoxGZ2tI/Zemyo9g
	 O6libaYZm4azLbNgACOH9iWlOuOcNcElLrDGBsOTRJMxm52FrDDdx9qys5rStIXna9
	 F+rh11cfjWpIsKDW1B9i0CiH7ApsruI0OzmB0edpXQOpw56pAUIwS/JfTzfYpfHSZR
	 HW1brPcWTFP6Iy4Mfy1ysMyCHlZ57bmUy00RiRghhR7eDhWNMB2EgSKLWCPxjETFB/
	 e1skUO2Z2ZHbg==
From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Remove pointless variable when registering a cooling device
Date: Thu,  2 Apr 2026 10:44:25 +0200
Message-ID: <20260402084426.1360086-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

The 'id' variable is set to store the ida_alloc() value which is
already stored into cdev->id. It is pointless to use it because
cdev->id can be used instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/thermal_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b7d706ed7ed9..02ce58223f9f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1061,7 +1061,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	unsigned long current_state;
-	int id, ret;
+	int ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -1078,7 +1078,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret < 0)
 		goto out_kfree_cdev;
 	cdev->id = ret;
-	id = ret;
 
 	cdev->type = kstrdup_const(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
@@ -1135,7 +1134,7 @@ __thermal_cooling_device_register(struct device_node *np,
 out_cdev_type:
 	kfree_const(cdev->type);
 out_ida_remove:
-	ida_free(&thermal_cdev_ida, id);
+	ida_free(&thermal_cdev_ida, cdev->id);
 out_kfree_cdev:
 	kfree(cdev);
 	return ERR_PTR(ret);
-- 
2.43.0

