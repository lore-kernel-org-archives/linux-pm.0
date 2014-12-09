From: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Subject: [PATCH 0/2] Thermal/int340x: _art and _trt fixes
Date: Mon,  8 Dec 2014 18:01:30 -0800
Message-ID: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55255 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbaLICEs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Dec 2014 21:04:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: ilkka.koskinen@linux.intel.com, rui.zhang@intel.com, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

This patch set fixes two issues in parsing _art and _trt acpi entries

Ilkka Koskinen (2):
  Thermal/int340x: Clear the error value of the last
    acpi_bus_get_device() call
  Thermal/int340x: Handle properly the case when _trt or _art acpi entry
    is missing

 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
1.9.1

