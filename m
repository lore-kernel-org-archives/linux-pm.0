From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 4/4] i8042: support async suspend and
	shutdown
Date: Tue, 4 Aug 2009 15:46:09 +0200
Message-ID: <20090804134609.GK18974__29531.593345064$1249393659$gmane$org@elf.ucw.cz>
References: <1248404532.2670.112.camel@rzhang-dt>
	<20090724071411.GB10760@elf.ucw.cz>
	<1249291590.2670.263.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1249291590.2670.263.camel@rzhang-dt>
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
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org


> > >  	panic_blink = i8042_panic_blink;
> > >  
> > >  	return 0;
> > >  
> > > + err_dev_async_unregister:
> > > +	dev_async_unregister(&i8042_platform_device->dev);
> > >   err_free_device:
> > >  	platform_device_put(i8042_platform_device);
> > >   err_unregister_driver:
> > 
> > I still do not like the interface: manually unregistering seems to be
> > ugly & error prone.
> > 
> hmm, yes, we can check device->dev_async and unregister it in driver
> core, at device_unregister time.
> 
> then I think we should rename the interfaces to:
> device_enable_async_action(dev, type),
> and device_disable_async_action(dev)
> so that they are more like driver core helper functions.
> what do you think?

Yes, that would be nicer.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
