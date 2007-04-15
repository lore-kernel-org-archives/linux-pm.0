From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Sun, 15 Apr 2007 21:54:07 +0200
Message-ID: <200704152154.09212.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704151837.40756.rjw@sisk.pl>
	<20070415194023.GA2538@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070415194023.GA2538@melchior.yamamaya.is-a-geek.org>
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
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Sunday, 15 April 2007 21:40, Tobias Diedrich wrote:
> Rafael J. Wysocki wrote:
> > On Sunday, 15 April 2007 17:14, David Brownell wrote:
> > > On Sunday 15 April 2007 4:16 am, Rafael J. Wysocki wrote:
> > > > On Sunday, 15 April 2007 10:02, Tobias Diedrich wrote:
> > > =

> > > > > > > > Yes, it's a Asus M2N-SLI-Deluxe Mainboard with a Athlon64 3=
200+
> > > > > > > > single core CPU.
> > > =

> > > And NVidia southbridge, so OHCI not UHCI (plus EHCI) ... one experime=
nt
> > > would be to disable the EHCI (high speed USB) support in BIOS, to make
> > > for a simpler hardware configuration, and see if that makes BIOS happ=
ier.
> > > (Or better, just take EHCI out of your Linux config.)  Likewise, taki=
ng
> > > the 8042 drivers out of Linux.
> > > =

> > > I wouldn't be surprised if those factors didn't matter, but it'd be g=
ood
> > > to rule them out.
> > =

> > I think the disabling of i8042 support might help.
> =

> Still hangs with "# CONFIG_SERIO_I8042 is not set".
> =

> > > > Dmitry, could you please have a look?
> > > > =

> > > > > And I can now confirm that unpatched 2.6.21-rc6 works fine as long
> > > > > as USB legacy support is disabled (however without legacy support=
 I
> > > > > can't use the USB keyboard to control grub).
> > > > =

> > > > I think using the 'shutdown' mode of suspend would be better.  Ther=
e's a little
> > > > point in using 'platform' on desktop systems anyway.
> > > > =

> > > > Frankly, I don't know what to do about it.  If we move platform_fin=
ish() after
> > > > device_resume(), some systems may be broken ...
> > > =

> > > What I'm curious about is exactly why the patch matters.  What ACPI
> > > magic is being invoked to confuse, or unconfuse, those controllers?
> > =

> > I think the patch helps, because it makes the ACPI magic be done while =
the
> > i8042's .resume() is being executed.
> > =

> > Which makes me think the following patch might help:
> =

> Unfortunately not, I tried this before disabling CONFIG_SERIO_I8042.

Well, this means i8042 can be ruled out, so the problem probably is related
to the ACPI resume which makes it _much_ more difficult to debug.

Can you compile the ACPI drivers: processor, thermal, fan, battery, etc. as
modules, boot the kernel with init=3D/bin/bash and see if the problem is st=
ill
present (please keep CONFIG_SERIO_I8042 unset just in case)?

Rafael
