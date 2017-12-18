From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 0/7] typec: tcpm: Add sink side support for PPS
Date: Mon, 18 Dec 2017 12:41:35 +0000
Message-ID: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

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

Changes in v3:
 - Drop 'RFC' from patch series titles
 - Rename PPS related defines to be PPS specific rather than generic APDO titles
 - Update source caps logging to only print PPS APDOs, and for others report as
   undefined.
 - Add ABI documentation for tcpm-source-psy sysfs properties
 - Rebase PDO selection on top of 'typec: tcpm: Only request matching pdos'
   patch.
 - Update capabilities validation introduced in
   'typec: tcpm: Validate source and sink caps' to support PPS APDOs.
 - Dropped power_supply 'type' property update for PPS addition
 - Added 'connected_type' property to power_supply framework, to support
   supplies which can report multiple connected types (e.g. USB), as discussed
   with Heikki.

Changes in v2:
 - Use USB_PD and usb_pd prefixes for macros and inline functions in headers.
 - Negotiate spec revision of PD headers during initial contract agreement.
 - New headers now use SPDX tags for referencing correct license.

NOTE: Code changes are based on linux-next tag 'next-20171212' to pick up
capabilities validation and selection updates.

Adam Thomson (7):
  typec: tcpm: Add PD Rev 3.0 definitions to PD header
  typec: tcpm: Add ADO header for Alert message handling
  typec: tcpm: Add SDB header for Status message handling
  typec: tcpm: Add core support for sink side PPS
  power: supply: Add 'connected_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply class
  typec: tcpm: Add support for sink PPS related messages

 .../ABI/testing/sysfs-class-power-tcpm-source-psy  |  92 +++
 drivers/power/supply/power_supply_sysfs.c          |  50 ++
 drivers/usb/typec/Kconfig                          |   1 +
 drivers/usb/typec/fusb302/Kconfig                  |   2 +-
 drivers/usb/typec/fusb302/fusb302.c                |  63 +-
 drivers/usb/typec/tcpm.c                           | 918 ++++++++++++++++++++-
 include/linux/power_supply.h                       |  15 +
 include/linux/usb/pd.h                             | 187 ++++-
 include/linux/usb/pd_ado.h                         |  42 +
 include/linux/usb/pd_ext_sdb.h                     |  31 +
 include/linux/usb/tcpm.h                           |   2 +-
 11 files changed, 1308 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
 create mode 100644 include/linux/usb/pd_ado.h
 create mode 100644 include/linux/usb/pd_ext_sdb.h

-- 
1.9.1
