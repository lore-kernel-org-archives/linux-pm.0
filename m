From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 0/1] of-thermal API change
Date: Tue, 18 Nov 2014 10:39:34 -0400
Message-ID: <1416321575-18348-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:41475 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbaKROjo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 09:39:44 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so2498690qgf.38
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2014 06:39:43 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Caesar Wang <caesar.wang@rock-chips.com>, Wei Ni <wni@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Eduardo Valentin <edubezval@gmail.com>

Hello guys,

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
 drivers/thermal/of-thermal.c                       | 40 ++++++++++------------
 drivers/thermal/tegra_soctherm.c                   |  7 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  8 +++--
 include/linux/thermal.h                            | 24 +++++++++----
 7 files changed, 63 insertions(+), 37 deletions(-)

-- 
2.1.3

