From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V2] cpufreq: nforce2: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Fri, 09 May 2014 15:08:29 +0900
Message-ID: <000501cf6b4d$1941cbf0$4bc563d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64092 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaEIGIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 02:08:31 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5A00936ME69RA0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 09 May 2014 15:08:30 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is deprecated.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes since v1:
- Added Viresh Kumar's Acked-by.
- Modified commit message to change from 'not preferred' to 'deprecated'. 

 drivers/cpufreq/cpufreq-nforce2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index bc447b9..a225809 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -379,7 +379,7 @@ static struct cpufreq_driver nforce2_driver = {
 };
 
 #ifdef MODULE
-static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
+static const struct pci_device_id nforce2_ids[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2 },
 	{}
 };
-- 
1.7.10.4


