From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
 module for port temperature reading
Date: Tue, 26 Jun 2018 20:18:21 +0200
Message-ID: <20180626181821.GA9800@lunn.ch>
References: <1530015037-67361-1-git-send-email-vadimp@mellanox.com>
 <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
 <20180626142238.GB5064@lunn.ch>
 <20180626170012.GA28370@roeck-us.net>
 <HE1PR0502MB375314997425DFF8DA5D3D1BA2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HE1PR0502MB375314997425DFF8DA5D3D1BA2490@HE1PR0502MB3753.eurprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>
List-Id: linux-pm@vger.kernel.org

> However, I have some concerns on this matter.
> Our hardware provides bulk reading of the modules temperature, means
> I can get all inputs by one hardware request, which is important optimization.
> Reading each module individually will be resulted in huge overhead and will
> require maybe some cashing of temperature inputs.  

Well, you can cache the SFP calibration values, and the 4 limit
values. To get an actually temperature you need to read 2 bytes from
the SFP module. I don't see why that would be expensive. You talk to
the firmware over PCIe right? So you have lots of bandwidth.

    Andrew
