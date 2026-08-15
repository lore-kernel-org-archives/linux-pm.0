Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4C35E944
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787517; cv=none; b=qaYUMuu2e8zWZbcM1ksQJM8HLQDMSLUFV3gXR15uTgFJAHKihY7MNJ8hj4Y4afiYFCSaXhcGbCLl85nKoylUDWB9triqrurNSNj7S+tHIRUFWBrRe7NNZU0tuBfMPvl1Kimw9ywmHWWWJxdo2wix0XZks7QMTGAWj1lseIQ3dLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787517; c=relaxed/simple;
	bh=QWdTBcf0vqrmBmp4CDFL905KC/WN+kA12wxfTkcS118=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw9BNL0t7a9Tj59BGZlPLu8liety10/GHtP+LHGyIDmPHTHu+mCL3//oTdZf9/mMXWrQWkqPgFpnxUzQTwpcEbCyZZkpeIPiwOYqbMT/z+PKYZayC3QbbEVtS3zWpRqypyW60vccIZ6/ujqYUzB9VJyBZsF1L/fAGvNBeirJX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+mY1cZr; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+mY1cZr"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QWdTBcf0vqrmBmp4CDFL905KC/WN+kA12wxfTkcS118=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786787513; v=1; x=1787392313;
 b=L+mY1cZr+aT4pJZVkwl9rA6dkHLs1Ajy8vO+4N9yN1ZMlA4iNYe+MEHfHeJajLmZv+X36O0J
 WFwMMb2ZQC7aM1GV9E4yeGaCYiXJBF+YaXLaRvO5D3jj/QtIoef+6ipqgMX/xYvez2MwQflKA7C
 rTo4L900yKHlHabj6Qo5v8zo=
X-Envelope-To: linux-pm@vger.kernel.org
Received: from fedora.fritz.box (62.216.208.217)
	by mta11.migadu.com with ESMTPS id 5daa9b9628cb2088;
	Sat, 15 Aug 2026 09:51:53 +0000
X-Migadu-Flow: FLOW_OUT
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <ynorov@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Drop redundant clamp() in duration_set()
Date: Sat, 15 Aug 2026 11:51:41 +0200
Message-ID: <20260815095143.3821-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=thorsten.blum@linux.dev; h=from:subject; bh=QWdTBcf0vqrmBmp4CDFL905KC/WN+kA12wxfTkcS118=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkNZutzfr0O9DUXEdB99JSn8WxY0dt5l3y/PikWlWzrf rxpyo6kjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIRwtGhl2dFnyfDEPMMk49 dT678obLlvlHqx7G7apefSFFM+PV0z+MDAsN+7/aPFeMy73G8zL/j8aBDH1P+fqydJWnL2X4v90 8zwgA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

duration_set() rejects any new_duration outside the valid range before
the assignment, making the clamp() call redundant.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..1efdaabc4bb8 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -94,7 +94,7 @@ static int duration_set(const char *arg, const struct kernel_param *kp)
 	}
 
 	mutex_lock(&powerclamp_lock);
-	duration = clamp(new_duration, 6ul, 25ul) * 1000;
+	duration = new_duration * 1000;
 	mutex_unlock(&powerclamp_lock);
 exit:
 
