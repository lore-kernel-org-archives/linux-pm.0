From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH v2 0/7] typec: tcpm: Add sink side support for PPS
Date: Tue, 21 Nov 2017 13:51:41 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B079B@SW-EX-MBX01.diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <20171121133547.GA17418@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121133547.GA17418@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 21 November 2017 13:36, Heikki Krogerus write:

> Hi Adam,
> 
> On Tue, Nov 14, 2017 at 11:44:41AM +0000, Adam Thomson wrote:
> > This patch set adds sink side support for the PPS feature introduced in the
> > USB PD 3.0 specification.
> >
> > The source PPS supply is represented using the Power Supply framework to provide
> > access and control APIs for dealing with it's operating voltage and current,
> > and switching between a standard PDO and PPS APDO operation. During standard
> PDO
> > operation the voltage and current is read-only, but for APDO PPS these are
> > writable as well to allow for control.
> >
> > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > expectation is that the external user will be required to ensure re-requests
> > occur regularly to ensure PPS remains and the source does not hard reset.
> >
> > Changes in v2:
> >  - Use USB_PD and usb_pd prefixes for macros and inline functions in headers.
> >  - Negotiate spec revision of PD headers during initial contract agreement.
> >  - New headers now use SPDX tags for referencing correct license.
> >
> > NOTE: Code changes are based on linux-next tag 'next-20171114' to pick up
> > the move out of staging of TCPM related code.
> >
> > Adam Thomson (7):
> >   typec: tcpm: Add PD Rev 3.0 definitions to PD header
> >   typec: tcpm: Add ADO header for Alert message handling
> >   typec: tcpm: Add SDB header for Status message handling
> >   typec: tcpm: Add core support for sink side PPS
> >   power: supply: Add type for USB PD PPS chargers
> >   typec: tcpm: Represent source supply through power_supply class
> >   typec: tcpm: Add support for sink PPS related messages
> >
> >  drivers/power/supply/power_supply_sysfs.c |   2 +-
> >  drivers/usb/typec/Kconfig                 |   1 +
> >  drivers/usb/typec/fusb302/Kconfig         |   2 +-
> >  drivers/usb/typec/fusb302/fusb302.c       |  63 +--
> >  drivers/usb/typec/tcpm.c                  | 851 +++++++++++++++++++++++++++++-
> >  include/linux/power_supply.h              |   1 +
> >  include/linux/usb/pd.h                    | 174 +++++-
> >  include/linux/usb/pd_ado.h                |  42 ++
> >  include/linux/usb/pd_ext_sdb.h            |  31 ++
> >  include/linux/usb/tcpm.h                  |   2 +-
> >  10 files changed, 1071 insertions(+), 98 deletions(-)
> >  create mode 100644 include/linux/usb/pd_ado.h
> >  create mode 100644 include/linux/usb/pd_ext_sdb.h
> 
> These don't apply on top of Badhri's series:
> http://www.spinics.net/lists/kernel/msg2649921.html

Hi Heikki,

When I submitted these I was aware of Badhri's patch set but at the time they
hadn't been approved or pulled, at least not into the version of Linux next
that I had based on. If these are now merged in to Linux Next then I'll re-spin
based on those changes.
