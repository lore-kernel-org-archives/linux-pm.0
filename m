From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv5 0/1] of-thermal API change
Date: Thu, 20 Nov 2014 10:12:12 -0400
Message-ID: <1416492733-1624-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:58958 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757053AbaKTOMN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 09:12:13 -0500
Received: by mail-qg0-f41.google.com with SMTP id j5so2130164qga.14
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2014 06:12:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: Caesar Wang <caesar.wang@rock-chips.com>, Wei Ni <wni@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Eduardo Valentin <edubezval@gmail.com>

I am proposing this change in the of-thermal API to sensors. The only
single change is how we represent the callbacks between sensor drivers
and of-thermal.

Essentially, instead of passing callbacks as parameters of the registration
function, now of-thermal users will pass an ops. It is a simple way of
growing the callback API smoothly.

There are already proposals to grow this API. Thus I would like to change
this before we start to introduce new callbacks here.

I changed the existing of-thermal users to adapt accordingly.

Let me know if you have objections.

BR,

Eduardo Valentin (1):
  thermal: of: improve of-thermal sensor registration API

 drivers/hwmon/lm75.c                               |  9 +++--
 drivers/hwmon/ntc_thermistor.c                     |  6 +++-
 drivers/hwmon/tmp102.c                             |  6 +++-
 drivers/thermal/of-thermal.c                       | 39 ++++++++++------------
 drivers/thermal/tegra_soctherm.c                   |  7 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  8 +++--
 include/linux/thermal.h                            | 24 +++++++++----
 7 files changed, 62 insertions(+), 37 deletions(-)

-- 
2.1.3

