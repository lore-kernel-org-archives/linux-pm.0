From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC] removal of drivers/idle/ directory
Date: Wed, 28 Aug 2013 14:22:36 +0200
Message-ID: <2998196.JgbABsZZJs@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18825 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab3H1MWl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 08:22:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Andy Henroid <andrew.d.henroid@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org


Hi,

drivers/idle/ directory currently contains only two drivers:

* intel_idle which is a cpuidle driver for certain Intel processors

* i7300_idle which is a driver for certain Intel x86_64 servers
  (it provides idle memory power savings)

How's about moving intel_idle to drivers/cpuidle/ (where it should
belong as cpuidle driver) and i7300_idle to drivers/platform/x86/
(or eventually to a new directory named drivers/memidle/)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

