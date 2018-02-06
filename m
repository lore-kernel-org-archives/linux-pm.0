From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Tue, 6 Feb 2018 15:51:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <e2cb104f53e20a01f3b44442068c549e5d0e1ac3.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130131131.GF14922@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180130131131.GF14922@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 30 January 2018 13:12, Heikki Krogerus wrote:

> Hi Adam,
>
> On Tue, Jan 02, 2018 at 03:50:54PM +0000, Adam Thomson wrote:
> > This commit adds a power_supply class instance to represent a
> > PD source's voltage and current properties. This provides an
> > interface for reading these properties from user-space or other
> > drivers.
> >
> > For PPS enabled Sources, this also provides write access to set
> > the current and voltage and allows for swapping between standard
> > PDO and PPS APDO.
> >
> > As this represents a superset of the information provided in the
> > fusb302 driver, the power_supply instance in that code is removed
> > as part of this change, so reverting the commit titled
> > 'typec: tcpm: Represent source supply through power_supply class'
>
>
>
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  .../ABI/testing/sysfs-class-power-tcpm-source-psy  |  92 ++++++++
> >  drivers/usb/typec/Kconfig                          |   1 +
> >  drivers/usb/typec/fusb302/Kconfig                  |   2 +-
> >  drivers/usb/typec/fusb302/fusb302.c                |  63 +-----
> >  drivers/usb/typec/tcpm.c                           | 233 ++++++++++++++++++++-
> >  5 files changed, 328 insertions(+), 63 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-tcpm-source-
> psy
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> > new file mode 100644
> > index 0000000..4986cba
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
> > @@ -0,0 +1,92 @@
> > +What: 		/sys/class/power_supply/tcpm-source-psy/type
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the main type of source supply.
> > +	Type-C is a USB standard so this property always returns "USB".
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/connected_type
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the type of source supply that is
> > +	connected, if the supply is online. The value is always Type C
> > +	unless a source has been attached which is identified as USB-PD capable.
> > +
> > +	Valid values:
> > +		- "USB_TYPE_C"	: Type C connected supply, not UBS-PD capable
> > +				  (default value)
> > +		- "USB_PD"	: USB-PD capable source supply connected
> > +		- "USB_PD_PPS"	: USB-PD PPS capable source supply connected
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/online
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the online state of the source
> > +	supply. When the value of this property is not 0, and the supply allows
> > +	it, then it's possible to switch between online states (i.e. 1 -> 2,
> > +	2 -> 1)
> > +
> > +	Valid values:
> > +		- 0	: Offline, no source supply attached
> > +		- 1	: Fixed Online, Type-C or USB-PD capable supply
> > +			  attached, non-configurable current and voltage
> > +			  properties in this state.
> > +		- 2	: PPS Online, USB-PD PPS feature enabled, 'current_now'
> > +			  and 'voltage_now' properties can be modified in this
> > +			  state. Re-writing of this value again, once already
> > +			  set, will re-request the same configured voltage and
> > +			  current values. This can be used as a keep-alive for
> > +			  the PPS connection.
> > +			  [NOTE: This is value only selectable if
> > +			   'connected_type' reports a value of "USB_PD_PPS"]
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_min
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the minimum voltage the source supply
> > +	can provide.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_max
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the maximum voltage the source supply
> > +	can provide.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/voltage_now
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the voltage the source supply is
> > +	providing now. This property can only be written to if the source supply
> > +	is in online state '2' (PPS enabled), otherwise it's read-only
> > +	information.
> > +
> > +	Value in microvolts.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/current_max
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-only property describes the maximum current the source supply
> > +	can provide.
> > +
> > +	Value in microamps.
> > +
> > +What: 		/sys/class/power_supply/tcpm-source-psy/current_now
> > +Date:		December 2017
> > +Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > +Description:
> > +	This read-write property describes the current the source supply can
> > +	provide now. This property can only be written to if the source supply
> > +	is in online state '2' (PPS enabled), otherwise it's read-only
> > +	information.
> > +
> > +	Value in microamps.
>
> I think those should be documented for the entire psy class, not just
> for this driver.

Right now there is no documentation for the generic psy class. The stuff in
sysfs-class-power is device specific property information, and the same goes for
sysfs-class-power-twl4030. The property usage can vary depending on driver
implementation, an example being the 'online' property which can differ between
drivers, so the usage I have here is very much tcpm related. Also, the ability
to write to certain properties varies depending on the driver and HW, so here
where we configure 'voltage_now' and 'current_now', the likelihood is that most
other psy driver implementations won't allow for this.

Sebastian, do you have any thoughts on this discussion? Would be useful to get
your input here.

>
> > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > index bcb2744..1ef606d 100644
> > --- a/drivers/usb/typec/Kconfig
> > +++ b/drivers/usb/typec/Kconfig
> > @@ -48,6 +48,7 @@ if TYPEC
> >  config TYPEC_TCPM
> >  	tristate "USB Type-C Port Controller Manager"
> >  	depends on USB
> > +	select POWER_SUPPLY
>
> I'm a little bit uncomfortable with such a strong dependency on an
> other subsystem that we may not always need, but let's see what
> Guenter says.

Right now I've used the psy class to represent power information from the
external PD source supply, so for the scenarios where we're the source or a
non-PD device has been attached then this is not going to provide any
information to user-space. I guess in the future we could update to represent
information when we're the PD source as well, although that'll likely be all
just read-only info. Right now, not sure if this is something that would be
useful.

Sebastian, do you seen any problems on the dependency front?
