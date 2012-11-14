From: Oliver Neukum <oneukum@suse.de>
Subject: PM QOS flags
Date: Wed, 14 Nov 2012 09:22:13 +0100
Message-ID: <1905473.JbZu5BcXPL@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40910 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767793Ab2KONo3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Nov 2012 08:44:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

Hi,

it seems to me that we are missing some flags. I would propose

PM_QOS_FLAG_NO_EXTERNAL_EFFECT
	in some cases going to powersave has externally visible effects
	modems hang up, LEDs on keyboards extinguish, screens blank

PM_QOS_FLAG_NO_HOTPLUG_DETECT
	hotplug is not detected while in powersave

PM_QOS_FLAG_NO_MEDIUM_CHANGE
	the device does not detect medium change events in powersave
	USB storage devices are prime candidates for this

	Regards
		Oliver

