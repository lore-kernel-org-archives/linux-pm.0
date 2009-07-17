From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/8] i8042: support device async suspend &
	shutdown
Date: Fri, 17 Jul 2009 04:40:15 +0200
Message-ID: <200907170440.16678.rjw__16619.2989949652$1247798490$gmane$org@sisk.pl>
References: <1247643522.26272.83.camel@rzhang-dt>
	<20090715003716.GE2360@ucw.cz>
	<1247795488.26272.227.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247795488.26272.227.camel@rzhang-dt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday 17 July 2009, Zhang Rui wrote:
> On Wed, 2009-07-15 at 08:37 +0800, Pavel Machek wrote:
> > On Wed 2009-07-15 15:38:42, Zhang Rui wrote:
> > > 
> > > i8042 controller support device async actions.
> > > 
> > > If boot option "dev_async_action" is added,
> > > i8042 controller and its child devices can be
> > > suspended/resumed/shutdown asynchronously.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/input/serio/i8042.c |   10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/drivers/input/serio/i8042.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/input/serio/i8042.c
> > > +++ linux-2.6/drivers/input/serio/i8042.c
> > > @@ -1284,14 +1284,21 @@ static int __init i8042_init(void)
> > >  		goto err_unregister_driver;
> > >  	}
> > >  
> > > -	err = platform_device_add(i8042_platform_device);
> > > +	err = dev_async_register(&i8042_platform_device->dev,
> > > +			DEV_ASYNC_SUSPEND | DEV_ASYNC_SHUTDOWN);
> > >  	if (err)
> > >  		goto err_free_device;
> > >  
> > > +	err = platform_device_add(i8042_platform_device);
> > > +	if (err)
> > > +		goto err_dev_async_unregister;
> > > +
> > >  	panic_blink = i8042_panic_blink;
> > >  
> > >  	return 0;
> > >  
> > > + err_dev_async_unregister:
> > > +	dev_async_unregister(&i8042_platform_device->dev);
> > 
> > 
> > >   err_free_device:
> > >  	platform_device_put(i8042_platform_device);
> > >   err_unregister_driver:
> > > @@ -1304,6 +1311,7 @@ static int __init i8042_init(void)
> > >  
> > >  static void __exit i8042_exit(void)
> > >  {
> > > +	dev_async_unregister(&i8042_platform_device->dev);
> > >  	platform_device_unregister(i8042_platform_device);
> > >  	platform_driver_unregister(&i8042_driver);
> > >  	i8042_platform_exit();
> > 
> > Could we get the core to do async_unregister during device_unregister?
> > 
> yes, we can.
> I think it's a little strange that drivers need to invoke
> dev_async_register to register an async device group, but don't need to
> call dev_async_unregister to unregister it.
> 
> > Or maybe better, just add flags during device_add?
> > 
> Many devices don't know if they support async actions or not during
> device initialization time, like PCI and ACPI devices.
> If we want to create an async group for a PCI device, we have to call
> dev_async_register in the specified PCI device driver, rather than in
> the PCI bus scan stage.

That is quite a big design issue, IMO.

Did you consider any other approach to this?

Best,
Rafael
