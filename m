From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/base/power/qos.c:330:5: sparse: symbol
 '__dev_pm_qos_update_request' was not declared. Should it be static?
Date: Tue, 23 Oct 2012 12:22:11 +0800
Message-ID: <50861b73.GgA1DPGYKvLmArF0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_50861b73.jqawr+5Hb2MmhLBjEnSjxqnQp11NV9XZL/hm+QXkHSoHBB9v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17484 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab2JWEW2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 00:22:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--=_50861b73.jqawr+5Hb2MmhLBjEnSjxqnQp11NV9XZL/hm+QXkHSoHBB9v
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Rafael,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   13f5e2d9a915373dd1573d8fe0214738bc69004f
commit: a7a02d1a295d3ab9cd894af4f138e30a3000df3d PM / QoS: Make it possible to expose PM QoS device flags to user space
date:   5 hours ago

+ drivers/base/power/qos.c:330:5: sparse: symbol '__dev_pm_qos_update_request' was not declared. Should it be static?

vim +330 drivers/base/power/qos.c

ae0fb4b7 Rafael J. Wysocki 2012-10-23  314  		req->type = type;
b66213cd Jean Pihet        2011-08-25  315  		ret = apply_constraint(req, PM_QOS_ADD_REQ, value);
ae0fb4b7 Rafael J. Wysocki 2012-10-23  316  	}
91ff4cb8 Jean Pihet        2011-08-25  317  
1a9a9152 Rafael J. Wysocki 2011-09-29  318   out:
91ff4cb8 Jean Pihet        2011-08-25  319  	mutex_unlock(&dev_pm_qos_mtx);
1a9a9152 Rafael J. Wysocki 2011-09-29  320  
91ff4cb8 Jean Pihet        2011-08-25  321  	return ret;
91ff4cb8 Jean Pihet        2011-08-25  322  }
91ff4cb8 Jean Pihet        2011-08-25  323  EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
91ff4cb8 Jean Pihet        2011-08-25  324  
91ff4cb8 Jean Pihet        2011-08-25  325  /**
a7a02d1a Rafael J. Wysocki 2012-10-23  326   * __dev_pm_qos_update_request - Modify an existing device PM QoS request.
a7a02d1a Rafael J. Wysocki 2012-10-23  327   * @req : PM QoS request to modify.
a7a02d1a Rafael J. Wysocki 2012-10-23  328   * @new_value: New value to request.
a7a02d1a Rafael J. Wysocki 2012-10-23  329   */
a7a02d1a Rafael J. Wysocki 2012-10-23 @330  int __dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
a7a02d1a Rafael J. Wysocki 2012-10-23  331  {
a7a02d1a Rafael J. Wysocki 2012-10-23  332  	s32 curr_value;
a7a02d1a Rafael J. Wysocki 2012-10-23  333  	int ret = 0;
a7a02d1a Rafael J. Wysocki 2012-10-23  334  
a7a02d1a Rafael J. Wysocki 2012-10-23  335  	if (!req->dev->power.qos)
a7a02d1a Rafael J. Wysocki 2012-10-23  336  		return -ENODEV;
a7a02d1a Rafael J. Wysocki 2012-10-23  337  
a7a02d1a Rafael J. Wysocki 2012-10-23  338  	switch(req->type) {

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--=_50861b73.jqawr+5Hb2MmhLBjEnSjxqnQp11NV9XZL/hm+QXkHSoHBB9v
Content-Type: text/x-diff;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="make-it-static-a7a02d1.diff"

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 3fcbf36..aba1218 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -327,7 +327,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
  * @req : PM QoS request to modify.
  * @new_value: New value to request.
  */
-int __dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
+static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
 {
 	s32 curr_value;
 	int ret = 0;

--=_50861b73.jqawr+5Hb2MmhLBjEnSjxqnQp11NV9XZL/hm+QXkHSoHBB9v--
