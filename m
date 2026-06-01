Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193838E113;
	Mon,  1 Jun 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304531; cv=none; b=clO24BHnSu5CGI9moeO/XefitVgY8Ff4HfTAH45zd4jmPP3pWFagnJM/4u0DNkmH6DCXa09AhTwa5MPeLI+HMmeZkdmrCHb7K0DQnBprjbfNQRfOjVkj888OrU2XGftKnAXIgns82dRp2bzQPfL7s7RwPeXSqrZEbSrClYLjxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304531; c=relaxed/simple;
	bh=TuhC+gB72MdNq9JSjI0WdtI5s0/cWpheTVwCiZh+5vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTN1n3dRxDPvVyeE5ihVgO5N9BQ7ldHaF0OrLAPyvVHfWTks+s3k/sMcA5aJjc4JK1vIMUjgc1u6JUv9+f99XLFB43XdCv1Dlvty6ZLRE9+2nzZEIzMKSeUEZJ+tdc8LKWNqp6iQwNQ2yxgnE1Qp1tKcF9MKFaMn5Ico2w77g2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od5M3PT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od5M3PT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B851F00898;
	Mon,  1 Jun 2026 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780304529;
	bh=jHEucaOZ/SkP3+GAO+GIbzmS3uBQKAYK1l85HUqIyVM=;
	h=From:To:Cc:Subject:Date;
	b=od5M3PT4aW7Wx8Xv9l8iopO0XEOV7svdJARZTb8/8NPfdlPm1Tyd6ls7/i2ShkP6s
	 17mEKfC0tQUVBzHfkmDoCK7Gtg0X5iPUEsmkHrSFTl0gmHd/Jj+NRgPh+rdU092Vh6
	 WzGZHQtaWakc5pM4KvD44Wl0trPHFyjOeStw2e2vTuriG1W7YTK3uYp5tNVyDLD0GD
	 GSUrNHELrLnbJ3aGrFk5DSFreV8uGoZIxBr5eg2iCdLNmNVrAw7HR+TKdvKbmkjeja
	 wTtSx4BBQVHfPGiz2IHEkXLiuiBnpLRt1/6/lQUYZCRYwkdJTX+Y+NiYAy6nzFFuZN
	 NuRhJvuLKL51g==
From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rui.zhang@intel.com
Subject: [PATCH] thermal/core: Fix missing stub for devm_thermal_cooling_device_register
Date: Mon,  1 Jun 2026 11:01:53 +0200
Message-ID: <20260601090152.1243983-2-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=daniel.lezcano@kernel.org; h=from:subject; bh=TuhC+gB72MdNq9JSjI0WdtI5s0/cWpheTVwCiZh+5vQ=; b=owGbwMvMwMG4wki5S8v/hT/jabUkhixZr8YItRkaAmumrWltu876vEjMKFwgO9afb8JaI5vTT YmVLeWdjMYsDIwcDLJiiixStWcfthZfTA49Ua0CM4iVCWQKAxenAEyk4ScHQ9ORfQrRjXknH4WZ nJ/hvESoUCM/OifE0srhpt3P7X4Cru+PslZbbss5+069zy1iiUJpmC9nY4CFIRNb1/55oYHGkw6 tNUiJdDS/5qd9xpPrlF91aqGCShRr6P7m8yUNq042ZfOpRFgqfWNQPnF8bWzN4yeff1pNeG/T8G jShk1vThqmfdduWyw778+kqVnBiYo7Qx9d1fK+35RsGjJJI6rQRsZWY2mxXEmY/lOtxlaZeI6Kz E/5N5iv7Yrdv8bP9sm/LR3ce2ff/7rqsVHdpJU9h9M3f56/27RVawLf6y5Wg7Y4Lu7zOfOezD78 4+TK86ZSkdvk+Q51HXfiiSoT9+YqrDBfvZBlvtFJFRMA
X-Developer-Key: i=daniel.lezcano@kernel.org; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit

Even it is very unlikely the thermal framework is disabled, the newly
added devm_thermal_cooling_device_register() function has not the stub
when the thermal framework is optout in the kernel.

Add it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605301554.S9n45bfQ-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 include/linux/thermal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 81be6e6061b3..083b4f533933 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -344,7 +344,11 @@ static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
+
 static inline struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
+				     const struct thermal_cooling_device_ops *ops)
+{ return ERR_PTR(-ENODEV); }
 
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
-- 
2.43.0

