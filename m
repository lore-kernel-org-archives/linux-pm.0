From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] Thermal cleanups and hardware trip points
Date: Tue, 28 Apr 2015 10:25:50 +0200
Message-ID: <1430209563-647-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58494 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385AbbD1I0I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 04:26:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

The majority of the patches are cleanups and fixes. Only the last two
patches actually implement the hardware trip points.

Note that the hardware trip points are not very well tested currently
and I still have no ready-to-post driver using them. However, Brian
Norris showed interest in these patches, so I am including the patches
in this series nevertheless.

All comments welcome

Changes since v1:
- Use int instead of unsigned long consistently for temperatures
- Instead of misfixing the emulation code add a comment how the
  code is meant
- Add doc entry for .set_trips callback
- initialize prev_low_trip/prev_high_trip properly
- get tz->lock before calling thermal_zone_set_trips()

