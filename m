From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v5 0/5] typec: tcpm: Add sink side support for PPS
Date: Tue, 20 Mar 2018 14:33:42 +0000
Message-ID: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
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

Changes in v5:
 - Rebase on branch with 'Revert "typec: tcpm: Only request matching pdos"' and
   header changes already included.
 - Update power_supply registration to make power_supply names unique per port,
   to avoid errors creating duplicate psy instances. New name uses port
   dev name as a suffix.
 - Renamed 'connected_type' psy property to 'usb_type', as requested by
   maintainer.
 - Added initial attempt at generic ABI documentation for common psy class
   properties for Battery and USB type supplies.
 - Small update to PPS APDO selection code to limit maximum current requested
   based on sink maximum allowed current. Have left Heikki's 'Acked-by' tag as
   it's a minor change, but can remove if that's not deemed appropriate.

Changes in v4:
 - For PD 3.0 definitions patch, make it benign with regards to existing TCPM
   code so build isn't broken if this one patch is applied, as suggested by
   kbuild robot. Update for dynamic revision is moved to be part of sink side
   PPS support patch.
 - Use PTR_ERR_OR_ZERO macro to simplify return of devm_tcpm_psy_register()
   function, as suggested by kbuild robot.
 - Make devm_tcpm_psy_register() static as not used outside this file.

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

NOTE: Code changes based on usb-next (027bd6cafd9a1e3a109b5e5682c85ac84e804a8d)

Adam Thomson (5):
  typec: tcpm: Add core support for sink side PPS
  Documentation: power: Initial effort to document power_supply ABI
  power: supply: Add 'usb_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply
  typec: tcpm: Add support for sink PPS related messages

 Documentation/ABI/testing/sysfs-class-power | 455 ++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/power/supply/power_supply_sysfs.c   |  50 ++
 drivers/usb/typec/Kconfig                   |   1 +
 drivers/usb/typec/fusb302/Kconfig           |   2 +-
 drivers/usb/typec/fusb302/fusb302.c         |  63 +-
 drivers/usb/typec/tcpm.c                    | 916 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |  16 +
 include/linux/usb/pd.h                      |   4 +-
 include/linux/usb/tcpm.h                    |   2 +-
 10 files changed, 1422 insertions(+), 88 deletions(-)

-- 
1.9.1
