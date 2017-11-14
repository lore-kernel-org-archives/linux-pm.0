From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH v2 0/7] typec: tcpm: Add sink side support for PPS
Date: Tue, 14 Nov 2017 11:44:41 +0000
Message-ID: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.114]:57883 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753186AbdKNLoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 06:44:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

This patch set adds sink side support for the PPS feature introduced in the
USB PD 3.0 specification.

The source PPS supply is represented using the Power Supply framework to provide
access and control APIs for dealing with it's operating voltage and current,
and switching between a standard PDO and PPS APDO operation. During standard PDO
operation the voltage and current is read-only, but for APDO PPS these are
writable as well to allow for control.

It should be noted that the keepalive for PPS is not handled within TCPM. The
expectation is that the external user will be required to ensure re-requests
occur regularly to ensure PPS remains and the source does not hard reset.

Changes in v2:
 - Use USB_PD and usb_pd prefixes for macros and inline functions in headers.
 - Negotiate spec revision of PD headers during initial contract agreement.
 - New headers now use SPDX tags for referencing correct license.

NOTE: Code changes are based on linux-next tag 'next-20171114' to pick up
the move out of staging of TCPM related code.

Adam Thomson (7):
  typec: tcpm: Add PD Rev 3.0 definitions to PD header
  typec: tcpm: Add ADO header for Alert message handling
  typec: tcpm: Add SDB header for Status message handling
  typec: tcpm: Add core support for sink side PPS
  power: supply: Add type for USB PD PPS chargers
  typec: tcpm: Represent source supply through power_supply class
  typec: tcpm: Add support for sink PPS related messages

 drivers/power/supply/power_supply_sysfs.c |   2 +-
 drivers/usb/typec/Kconfig                 |   1 +
 drivers/usb/typec/fusb302/Kconfig         |   2 +-
 drivers/usb/typec/fusb302/fusb302.c       |  63 +--
 drivers/usb/typec/tcpm.c                  | 851 +++++++++++++++++++++++++++++-
 include/linux/power_supply.h              |   1 +
 include/linux/usb/pd.h                    | 174 +++++-
 include/linux/usb/pd_ado.h                |  42 ++
 include/linux/usb/pd_ext_sdb.h            |  31 ++
 include/linux/usb/tcpm.h                  |   2 +-
 10 files changed, 1071 insertions(+), 98 deletions(-)
 create mode 100644 include/linux/usb/pd_ado.h
 create mode 100644 include/linux/usb/pd_ext_sdb.h

-- 
1.9.1
