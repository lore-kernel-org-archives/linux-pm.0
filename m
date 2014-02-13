From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 0/6] drivers/acpi: fix driver compile errors when CONFIG_PM_SLEEP is undefined
Date: Wed, 12 Feb 2014 20:19:04 -0700
Message-ID: <cover.1392250669.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:55318
	"EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390AbaBMDTP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 22:19:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shuahkhan@gmail.com

The following acpi drivers fail with compile errors when CONFIG_PM_SLEEP
is undefined.

Shuah Khan (6):
  drivers/acpi: fix ac driver compile error when CONFIG_PM_SLEEP is
    undefined
  drivers/acpi: fix battery driver compile error when CONFIG_PM_SLEEP is
    undefined
  drivers/acpi: fix button driver compile error when CONFIG_PM_SLEEP is
    undefined
  drivers/acpi: fix fan driver compile error when CONFIG_PM_SLEEP is
    undefined
  drivers/acpi: fix sbs driver compile error when CONFIG_PM_SLEEP is
    undefined
  drivers/acpi: fix thermal driver compile error when CONFIG_PM_SLEEP
    is undefined

 drivers/acpi/ac.c      |    2 ++
 drivers/acpi/battery.c |    2 ++
 drivers/acpi/button.c  |    2 ++
 drivers/acpi/fan.c     |    3 +++
 drivers/acpi/sbs.c     |    2 ++
 drivers/acpi/thermal.c |    2 ++
 6 files changed, 13 insertions(+)

-- 
1.7.10.4

