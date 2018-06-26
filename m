From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch net-next RFC 03/12] mlxsw: core: Add core environment
 module for port temperature reading
Date: Tue, 26 Jun 2018 17:50:51 +0000
Message-ID: <HE1PR0502MB375314997425DFF8DA5D3D1BA2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1530015037-67361-1-git-send-email-vadimp@mellanox.com>
 <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
 <20180626142238.GB5064@lunn.ch> <20180626170012.GA28370@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180626170012.GA28370@roeck-us.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Tuesday, June 26, 2018 8:00 PM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: Vadim Pasternak <vadimp@mellanox.com>; linux-pm@vger.kernel.org;
> netdev@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com;
> jiri@resnulli.us
> Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
> module for port temperature reading
>=20
> On Tue, Jun 26, 2018 at 04:22:38PM +0200, Andrew Lunn wrote:
> > On Tue, Jun 26, 2018 at 12:10:28PM +0000, Vadim Pasternak wrote:
> >
> > Adding the linux-pm@vger.kernel.org list.
> >
> > > Add new core_env module to allow port temperature reading. This
> > > information has most critical impact on system's thermal monitoring
> > > and is to be used by core_hwmon and core_thermal modules.
> > >
> > > New internal API reads the temperature from all the modules, which
> > > are equipped with the thermal sensor and exposes temperature
> > > according to the worst measure. All individual temperature values
> > > are normalized to pre-defined range.
> >
> > This patchset has been sent to the netdev list before. I raised a few
> > questions about this, which is why it is now being posted to a bigger
> > group for review.
> >
> > The hardware has up to 64 temperature sensors. These sensors are
> > hot-plugable, since they are inside SFP modules, which are
> > hot-plugable. Different SFP modules can have different operating
> > temperature ranges. They contain an EEPROM which lists upper and lower
> > warning and fail temperatures, and report alarms when these thresholds
> > a reached.
> >
> > This code takes the 64 sensors readings and calculates a single value
> > it passes to one thermal zone. That thermal zone then controls one fan
> > to keep this single value in range.
> >
> > I queried is this is the correct way to do this? Would it not be
> > better to have up to 64 thermal zones? Leave the thermal core to
> > iterate over all the zones in order to determine how the fan should be
> > driven?
> >
> I very much think so. This problem must exist elsewhere; essentially it i=
s the
> bundling of multiple temperature sensors into a single thermal zone. I am=
 not
> sure if this should be 64 thermal zones or one thermal zone with up to 64
> sensors and some algorithm to select the relevant temperature; that would=
 be
> up to the thermal subsystem maintainers to decide. Either case, the senso=
rs
> should be handled and reported as individual sensors, with appropriate li=
mits,
> not as single sensor.
> Yes, I understand that means we'll have hundreds of hwmon devices, but th=
at
> should not be a problem (and if it is, we'll have to fix the problem, not=
 the code
> exposing it).

I guess that many thermal zones with single PWM control will not work.
PWM will never stabilize in case there are some hot and some cold modules.

It seems it could be only temperature input array providing to the thermal
zone. And additionally it should have arrays at least for the warning and c=
ritical
thresholds.

We are using step-wise thermal algorithm as a default.
In case thermal zone will have multi temperature inputs this algorithm poss=
ibly
should be adapted for handling temperature arrays (input and thresholds)
along with the thermal zone normalization parameters - more or less the sam=
e
normalization process as I provided in this patch, but generic for the ther=
mal
subsystem.

Or another possibility - to add some new thermal algorithm "step-wise-multi=
"
or something like that.

However, I have some concerns on this matter.
Our hardware provides bulk reading of the modules temperature, means
I can get all inputs by one hardware request, which is important optimizati=
on.
Reading each module individually will be resulted in huge overhead and will
require maybe some cashing of temperature inputs. =20

And also, now we have up to 64 modules per system and on the way the
system supporting 128 modules.
Would it be good to have such huge number of hwmon configuration records,
like:=20
HWMON_T_INPUT | HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM ?


>=20
> I understand that the thermal subsystem does not currently support handli=
ng this
> problem. There may also be some missing pieces between the hwmon and
> thermal subsystems, such as reporting limits or alarms when a hwmon drive=
r
> register with the thermal subsystem.
>=20
> Maybe it is time to add this support as part of this patch series ?
>=20
> > This is possibly the first board with so many sensors. However, i
> > doubt it is totally unique. Other big Ethernet switches with lots of
> > SFP modules may be added later. Also, 10G copper PHYs often have
> > temperature sensors, so this is not limited to just boards with
> > optical ports. So having a generic solution would be good.
>=20
> Agreed.
>=20
> Thanks,
> Guenter
>=20
> >
> > What do the Linux PM exports say about this?
> >
> > Thanks
> > 	Andrew
