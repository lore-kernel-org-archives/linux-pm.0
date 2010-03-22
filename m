From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM ops and PCMCIA bus
Date: Mon, 22 Mar 2010 16:37:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003221621000.1606-100000@iolanthe.rowland.org>
References: <20100322200339.GA7673@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100322200339.GA7673@isilmar.linta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Mar 2010, Dominik Brodowski wrote:

> Alan,
> 
> many thanks for your extensive feedback!

My pleasure.

> On Mon, Mar 22, 2010 at 11:38:44AM -0400, Alan Stern wrote:
> > On Sun, 21 Mar 2010, Dominik Brodowski wrote:
> > > (2) Whenever two functions local to drivers/pcmcia/ds.c --
> > >     runtime_suspend() or runtime_resume() -- are called,
> > >     we need to force a synchronous call to pcmcia_dev_suspend(),
> > >     or to pcmcia_dev_resume(). Currently, we do this by taking
> > >     device_lock() and calling the function manually.
> > 
> > That seems like the right thing to do.  (Except that I don't know what 
> > your device_lock() routine is for.)
> 
> Actually, that's the generic device_lock(), which replaced down(&dev->sem)

Heh.  Guess I'm not used to seeing it yet...

> ... which is used here to not let a reset or a runtime suspend/resume race
> with a system sleep event.

The PM core is supposed to prevent races between runtime suspend/resume
and system sleep, so you don't need to worry about that.  But you do
need to worry about races with reset (this may or may not be the best
way to handle them).


> > I don't understand.  Aren't runtime_suspend() and runtime_resume(), as 
> > mentioned above, already part of your runtime PM interface?  Or at 
> > least, intended to be part of your runtime PM interface?
> 
> Well, they are part of the PCMCIA-local runtime PM interface -- it is based
> around the concept that an user may, whenever she wants, can set a PCMCIA
> device (or the whole card) to the "suspend" state.

> Well, that's not what this "runtime_suspend()" does -- it is the wrapper for
> userspace-issued suspend commands.

> > One of the background assumptions behind the runtime PM
> > framework is that users don't tell the system when to suspend devices.  
> 
> Ah, that's the fundamental issue. I agree that the PCMCIA subsystem does
> something unusual here (relating to PCMCIA cards or PCMCIA devices) --
> but I would prefer not to break how the system currently works.

All right.  It appears that what you have implemented is really a
"power-down" or "on/off" type of interface rather than a
"runtime-suspend" interface.  You can of course have both types of
interfaces at the same time, but keep in mind that they don't work the
same way.


> > > (5) Another problem I'm seeing with the put/get approach: there are three
> > >     different callpaths where runtime_suspend() / runtime_resume() might
> > >     be called.[*] However, each one decreases the counter, which might get < 0.
> > 
> > The counter should never become negative; if it does, there's a bug in
> > your driver.  Every decrement should match a corresponding increment,
> > just like with refcounts.  And the device should never be
> > runtime-suspended unless the counter is 0.
> 
> what's the initial value, actually? Is it 0 or 1?

It is 0.

> > Instead, the system automatically suspends devices when it realizes
> > they aren't being used.
> 
> That's what we could use for PCMCIA sockets.

Yes, that sounds like an easy application.  If the socket contains no 
card, or if all devices on the card are powered-down, then the socket 
can be runtime-suspended.


> > > --- a/drivers/pcmcia/Kconfig
> > > +++ b/drivers/pcmcia/Kconfig
> > > @@ -20,6 +20,7 @@ if PCCARD
> > >  config PCMCIA
> > >  	tristate "16-bit PCMCIA support"
> > >  	select CRC32
> > > +	select PM_RUNTIME
> > 
> > This seems very wrong.  Why do you need it?  Can't the pcmcia subsystem 
> > work correctly without runtime PM support?  Hasn't it been working 
> > correctly that way all along?
> 
> Oh yes, it did. However, continuing support for the PCMCIA-style "runtime
> PM" might need to depend on PM_RUNTIME.

It shouldn't be that way.  Keep the existing PCMCIA-style interface if
you want, but realize that it is separate and independent from the
runtime PM framework and therefore it shouldn't select PM_RUNTIME.

The alternative is to remove the user's ability to power-down PCMCIA 
devices, and rely on the operating system to suspend them at the right 
times.

Alan Stern
