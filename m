From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
 module for port temperature reading
Date: Tue, 26 Jun 2018 21:35:28 +0200
Message-ID: <20180626193528.GB9800@lunn.ch>
References: <1530015037-67361-1-git-send-email-vadimp@mellanox.com>
 <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
 <20180626142238.GB5064@lunn.ch>
 <20180626170012.GA28370@roeck-us.net>
 <HE1PR0502MB375314997425DFF8DA5D3D1BA2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
 <20180626181821.GA9800@lunn.ch>
 <HE1PR0502MB37535AE1B1E7093E198F0A67A2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HE1PR0502MB37535AE1B1E7093E198F0A67A2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 26, 2018 at 07:01:32PM +0000, Vadim Pasternak wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Tuesday, June 26, 2018 9:18 PM
> > To: Vadim Pasternak <vadimp@mellanox.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>; linux-pm@vger.kernel.org;
> > netdev@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com;
> > jiri@resnulli.us
> > Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
> > module for port temperature reading
> > 
> > > However, I have some concerns on this matter.
> > > Our hardware provides bulk reading of the modules temperature, means I
> > > can get all inputs by one hardware request, which is important optimization.
> > > Reading each module individually will be resulted in huge overhead and
> > > will require maybe some cashing of temperature inputs.
> > 
> > Well, you can cache the SFP calibration values, and the 4 limit values. To get an
> > actually temperature you need to read 2 bytes from the SFP module. I don't see
> > why that would be expensive. You talk to the firmware over PCIe right? So you
> > have lots of bandwidth.
> 
> Yes, but FW in its turn will run I2C transaction to read temperature sensor.

So how does that add overhead? It needs to read the same two bytes
independent of if it is getting readings from one sensor, or all
sensors.

> And we also run hwmon and thermal parts of our driver on BMC (Based
> Management Controller) on system equipped with it.
> In such case host CPU performs networking stuff, while BMC system related
> stuff. And in such configuration BMC talks to FW over I2C.

So you have a 20MHz I2C bus between your BMC and the firmware. Lets
assume a relativity dumb protocol. 2 bytes for command to read an sfp
sensor, 3 bytes for a replay. 5 bytes, at 20Mbps allows you to read
500,000 sensors per second. And for environment monitoring, 64 sensors
one per second should be sufficient.

    Andrew
