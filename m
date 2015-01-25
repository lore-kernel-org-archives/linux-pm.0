From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/6] power/reset: restart handler patch series
Date: Sun, 25 Jan 2015 12:30:39 -0800
Message-ID: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45839 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbAYUaw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 15:30:52 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFTpd-000jq9-1q
	for linux-pm@vger.kernel.org; Sun, 25 Jan 2015 20:30:53 +0000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Register with kernel restart handler instead of setting arm_pm_restart
directly, plus some other cleanup.

v2: Rebased to master branch of battery tree
