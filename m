From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Date: Fri, 9 Feb 2018 15:43:26 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C2030@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180208213054.oqgoktru3lzjiyyn@earth.universe>
 <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
 <20180209150148.624fb4qb34wuml6l@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209150148.624fb4qb34wuml6l@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 09 February 2018 15:02, Sebastian Reichel wrote:

> Hi,
> 
> On Fri, Feb 09, 2018 at 11:28:42AM +0000, Adam Thomson wrote:
> > On 08 February 2018 21:31, Sebastian Reichel wrote:
> > > On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> > > > This commit adds the 'connected_type' property to represent supplies
> > > > which can report a number of different types of supply based on a
> > > > connection event.
> > > >
> > > > Examples of this already exist in drivers whereby the existing 'type'
> > > > property is updated, based on an event, to represent what was
> > > > connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> > > > however don't show all supported connectable types, so this knowledge
> > > > has to be exlicitly known for each driver that supports this.
> > > >
> > > > The 'connected_type' property is intended to fill this void and show
> > > > users all possible types supported by a driver. The property, when
> > > > read, shows all available types for the driver, and the one currently
> > > > chosen is highlighted/bracketed. It is expected that the 'type'
> > > > property would then just show the top-level type, such as 'USB', and
> > > > this would be static.
> > > >
> > > > Currently the 'conn_type' enum contains all of the USB variant types
> > > > that exist for the 'type' enum at this time, and in addition has
> > > > the PPS type. In the future this can be extended further for other
> > > > types which have multiple connected types supported. The mirroring
> > > > is intentional so as to not impact existing usage of the 'type'
> > > > property.
> > > >
> > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > >
> > > Thanks for the patch. I think, that it's a good idea to provide the
> > > subtype in its own property and just set the type property to "USB".
> > > I would prefer to name this "usb_type". Otherwise
> > >
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > >
> > > -- Sebastian
> >
> > Thanks for your review. I chose 'connected_type' as I thought this would be more
> > generic in case other main types would have some dynamic connection element to
> > them and could also benefit from this. If we don't see that as being something
> > we want though then I can make this just for USB.
> 
> If such a thing appears at some point we can add another property.
> I think usb_type is easier to understand from a user point of view
> and it helps to keep our enums clean.

Ok, fair enough. Will update accordingly.
