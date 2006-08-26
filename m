From: Pavel Machek <pavel@ucw.cz>
Subject: usb suspend (was Re:  So,
	what's the status on the recent patches here?)
Date: Sun, 27 Aug 2006 01:34:08 +0200
Message-ID: <20060826233408.GE2551@elf.ucw.cz>
References: <20060825220320.GH9568@elf.ucw.cz>
	<Pine.LNX.4.44L0.0608252215340.32136-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0608252215340.32136-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The idea of the patches is that they will autosuspend a USB hub when =
it
> > > has no active (i.e., unsuspended) children, and autosuspending a root=
 hub
> > > stops the USB controller from doing DMA.  However, non-hub devices ar=
e not
> > > yet automatically suspended, so you will have to suspend the fingerpr=
int
> > > scanner by hand.
> > =

> > That is okay, I can do that. It saves 2 hours of battery life on my
> > machine...
> =

> Come to think of it, you don't need the autosuspend patches to turn these =

> devices off.  You can do it right now with your existing kernel, although =

> it's a little easier with -mm.  (The reason is that -mm contains a =

> development patch which ties a USB device's interfaces to the device =

> itself; suspending the device will automatically suspend all its =

> interfaces, and likewise resuming the device will automatically resume al=
l =

> its interfaces.  With a vanilla kernel you must manually suspend the =

> interfaces before you can suspend the device and manually resume them =

> after resuming the device.)
> =

> Anyway, you can use the deprecated =

> =

> 	echo -n 2 >/sys/devices/.../power/state
> =

> mechanism to suspend all the USB interfaces, devices, and controllers you =

> want -- provided you work your way up from the bottom of the device tree.=
  =

> The autosuspend patch just makes it simpler, since it takes care of =

> suspending and resuming all the hubs for you.

Thanks! That works great and gets my power consumption into reasonable
range.. plus allows fan to actually stop.
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
