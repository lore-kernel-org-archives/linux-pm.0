From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] PM / OPP: Cleanup a little bit of a bitrot
Date: Wed, 24 Dec 2014 11:22:54 -0600
Message-ID: <1419441777-25651-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbaLXRXB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Dec 2014 12:23:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>

It is a little usual to see with multiple contributors that file tends to loose
a consistent feel. So, try and fix it up in this trivial change series - no
functional changes at all.


based on v3.19-rc1 tag

Nishanth Menon (3):
  PM / OPP: export dev_pm_opp_get_notifier
  PM / OPP: Ensure consistent naming of static functions
  PM / OPP: Update kernel documentation

 drivers/base/power/opp.c |  190 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 44 deletions(-)

-- 
1.7.9.5

