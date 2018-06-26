From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch net-next RFC 03/12] mlxsw: core: Add core environment
 module for port temperature reading
Date: Tue, 26 Jun 2018 19:01:32 +0000
Message-ID: <HE1PR0502MB37535AE1B1E7093E198F0A67A2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1530015037-67361-1-git-send-email-vadimp@mellanox.com>
 <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
 <20180626142238.GB5064@lunn.ch> <20180626170012.GA28370@roeck-us.net>
 <HE1PR0502MB375314997425DFF8DA5D3D1BA2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
 <20180626181821.GA9800@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180626181821.GA9800@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Tuesday, June 26, 2018 9:18 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; linux-pm@vger.kernel.org;
> netdev@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com;
> jiri@resnulli.us
> Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
> module for port temperature reading
>=20
> > However, I have some concerns on this matter.
> > Our hardware provides bulk reading of the modules temperature, means I
> > can get all inputs by one hardware request, which is important optimiza=
tion.
> > Reading each module individually will be resulted in huge overhead and
> > will require maybe some cashing of temperature inputs.
>=20
> Well, you can cache the SFP calibration values, and the 4 limit values. T=
o get an
> actually temperature you need to read 2 bytes from the SFP module. I don'=
t see
> why that would be expensive. You talk to the firmware over PCIe right? So=
 you
> have lots of bandwidth.

Yes, but FW in its turn will run I2C transaction to read temperature sensor=
.

And we also run hwmon and thermal parts of our driver on BMC (Based
Management Controller) on system equipped with it.
In such case host CPU performs networking stuff, while BMC system related
stuff. And in such configuration BMC talks to FW over I2C.
So I'll must to cache.

>=20
>     Andrew
