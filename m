Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64D2F6181;
	Thu, 29 Jan 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710740; cv=none; b=CLkt95rcp736NK+dhU+7wmNNuBWk2novrECROv5tzkxbOQUJhwiv93PwUrverEILZGFwuYnJPRyBScjhxL0lC2AHU8Gttfl1tvKt6v+UtdoQkwL31d4WExMklZSTSPSVxyLNg3Ny+CPzMFVsHIF0jLUDqmXo7UIjP7LfJWk2S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710740; c=relaxed/simple;
	bh=CLXURq7tlSrIb+QZ2FESlRHc+yoIVSsLvnSsvxf0JUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgYB+j3FiybtmFB5DjTNuAnRlqS59Ca9DdAEE2w9tox4tPnaOUn7pQq8XH7A0DU4b1XYkMU80QDklqeKEIEjXaAr6u4IcbKymnlEV8dUMhJc6v02CcmjaPHbpT8YoQcBhBRKPVieaghwV8vqicm2aA16CsOLe+R/F0bxbbf771g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oi8myQ9y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oi8myQ9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710739; x=1801246739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLXURq7tlSrIb+QZ2FESlRHc+yoIVSsLvnSsvxf0JUY=;
  b=Oi8myQ9y8b8vRAsVGvC7JX+h+QI9tuXS40afMFRqCIgEXG4ma5NSfR6p
   4jXkQCBQT4QDOm3dYYfW3B52Jj0rVAW7VNSo46LKDySy/fbjgo5yqsrGA
   HCpLeZcbrf3pJMXSykYc79T52+0u+xodqn8Hvxuk9gaiIzRWI+jAwl6Oe
   zzRjjxQSWZ0B7w8H1yQrw1Yx37CUgLatw3Y1jctoYQjlzXBJvz/BnPHcC
   bW2CuEFO5KQyvmB7MNeSkox1wCdb5XokRVDagyjI+WbvHaIw0AaEyJSar
   QvmqANLjpx4ulJ+SHZE5aFKsRBAWEwOvpBqOAQqnSMgXcciFV9sBI30b7
   g==;
X-CSE-ConnectionGUID: LamOqH9CQCSnulDkpSzNkA==
X-CSE-MsgGUID: KttSY8+nRjOWLufuu2ddNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158280"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:59 -0800
X-CSE-ConnectionGUID: Xsn2QIhpSoukT7gB2j1Qjg==
X-CSE-MsgGUID: 1TcGD0alSmeebOPI8M6rng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255287"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:57 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/7] i3c: master: Allow controller drivers to select runtime PM device
Date: Thu, 29 Jan 2026 20:18:36 +0200
Message-ID: <20260129181841.130864-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129181841.130864-1-adrian.hunter@intel.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Some I3C controller drivers need runtime PM to operate on a device other
than the parent device.  To support that, add an rpm_dev pointer to
struct i3c_master_controller so drivers can specify which device should
be used for runtime power management.

If a driver does not set rpm_dev explicitly, default to using the parent
device to maintain existing behaviour.

Update the runtime PM helpers to use rpm_dev instead of dev.parent.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master.c       | 9 ++++++---
 include/linux/i3c/master.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 49fb6e30a68e..bcc493dc9d04 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -108,10 +108,10 @@ static struct i3c_master_controller *dev_to_i3cmaster(struct device *dev)
 
 static int __must_check i3c_master_rpm_get(struct i3c_master_controller *master)
 {
-	int ret = master->rpm_allowed ? pm_runtime_resume_and_get(master->dev.parent) : 0;
+	int ret = master->rpm_allowed ? pm_runtime_resume_and_get(master->rpm_dev) : 0;
 
 	if (ret < 0) {
-		dev_err(master->dev.parent, "runtime resume failed, error %d\n", ret);
+		dev_err(master->rpm_dev, "runtime resume failed, error %d\n", ret);
 		return ret;
 	}
 	return 0;
@@ -120,7 +120,7 @@ static int __must_check i3c_master_rpm_get(struct i3c_master_controller *master)
 static void i3c_master_rpm_put(struct i3c_master_controller *master)
 {
 	if (master->rpm_allowed)
-		pm_runtime_put_autosuspend(master->dev.parent);
+		pm_runtime_put_autosuspend(master->rpm_dev);
 }
 
 int i3c_bus_rpm_get(struct i3c_bus *bus)
@@ -2975,6 +2975,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
+	if (!master->rpm_dev)
+		master->rpm_dev = parent;
+
 	ret = i3c_master_rpm_get(master);
 	if (ret)
 		return ret;
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index af2bb48363ba..4be67a902dd8 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -501,6 +501,7 @@ struct i3c_master_controller_ops {
  *	 registered to the I2C subsystem to be as transparent as possible to
  *	 existing I2C drivers
  * @ops: master operations. See &struct i3c_master_controller_ops
+ * @rpm_dev: Runtime PM device
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
  * @hotjoin: true if the master support hotjoin
@@ -526,6 +527,7 @@ struct i3c_master_controller {
 	struct i3c_dev_desc *this;
 	struct i2c_adapter i2c;
 	const struct i3c_master_controller_ops *ops;
+	struct device *rpm_dev;
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
 	unsigned int hotjoin: 1;
-- 
2.51.0

