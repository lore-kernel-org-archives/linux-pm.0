From: Prarit Bhargava <prarit@redhat.com>
Subject: [RESEND PATCH 0/3 v4] powercap, intel_rapl, implement time window checks
Date: Mon, 21 Mar 2016 08:27:13 -0400
Message-ID: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbcCUM1V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 08:27:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>, Mathias Krause <minipli@googlemail.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>

This was submitted back in December and not picked up after review.

P.

-----8<----
The Intel ASDM provides a maximum time window that can be specified when
setting a time window in the RAPL driver.  While the ASDM doesn't explicitly
provide a minimum time window value, it does provide a minimum time window
unit that also can be used as a minimum value.

This patchset implements barrier checking for the time windows, and adds
reporting of a known bug in which the maxmimum time window value may be
erroneously set to 0, as well as a module parameter to avoid the maximum
window checks on broken BIOSes.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
Cc: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Prarit Bhargava (3):
  powercap, intel_rapl, implement get_max_time_window
  powercap, intel_rapl, implement check for minimum time window
  powercap, intel_rapl, Add ignore_max_time_window_check module
    parameter for broken BIOSes

 drivers/powercap/intel_rapl.c   |   50 +++++++++++++++++++++++++++++++++++++++
 drivers/powercap/powercap_sys.c |    6 +++--
 2 files changed, 54 insertions(+), 2 deletions(-)

-- 
1.7.9.3

