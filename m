From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH,
	fix] Re: [Regression] 2.6.31-git: tty change broke resume from
	hibernation on MSI Wind U100
Date: Mon, 28 Sep 2009 22:20:32 +0200
Message-ID: <200909282220.32582.rjw__42715.1183401749$1254169545$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0909280202280.14348-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0909280202280.14348-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, Dave Young <hidave.darkstar@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 28 September 2009, Alan Stern wrote:
> On Mon, 28 Sep 2009, Dave Young wrote:
> =

> > On Mon, Sep 28, 2009 at 2:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Sunday 27 September 2009, Alan Stern wrote:
> > >> On Sun, 27 Sep 2009, Rafael J. Wysocki wrote:
> > >>
> > >> > Tested, works.
> > >> >
> > >> > Greg, could you please consider taking the patch below? =C2 It fix=
es a recent
> > >> > hibernation regression for me, so if not this one, another fix is =
necessary.
> > >>
> > >> This patch has a mistake.
> > >>
> > >> > Index: linux-2.6/drivers/usb/serial/usb-serial.c
> > >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> > --- linux-2.6.orig/drivers/usb/serial/usb-serial.c
> > >> > +++ linux-2.6/drivers/usb/serial/usb-serial.c
> > >> > @@ -1210,7 +1210,7 @@ static const struct tty_operations seria
> > >> > =C2  =C2  .chars_in_buffer =3D =C2  =C2  =C2 serial_chars_in_buffe=
r,
> > >> > =C2  =C2  .tiocmget =3D =C2  =C2  =C2  =C2  =C2  =C2  serial_tiocm=
get,
> > >> > =C2  =C2  .tiocmset =3D =C2  =C2  =C2  =C2  =C2  =C2  serial_tiocm=
set,
> > >> > - =C2  .shutdown =3D =C2  =C2  =C2  =C2  =C2  =C2  serial_release,
> > >> > + =C2  .cleanup =3D =C2  =C2  =C2  =C2  =C2  =C2  =C2 serial_relea=
se,
> > >> > =C2  =C2  .install =3D =C2  =C2  =C2  =C2  =C2  =C2  =C2 serial_in=
stall,
> > >> > =C2  =C2  .proc_fops =3D =C2  =C2  =C2  =C2  =C2  =C2 &serial_proc=
_fops,
> > >> > =C2 };
> > >>
> > >> It isn't enough to change the method pointer. =C2 The code in
> > >> serial_release() has to be changed too; it must not call tty_shutdow=
n()
> > >> any more.
> > >
> > > Would it be sufficient to remove the tty_shutdown() call from
> > > serial_release()?
> > =

> > I think so, because standard shutdown will be called in queue_release_o=
ne_tty.
> > =

> > Alan, could you confirm about this?  Thus I'd like to update the patch.
> =

> Yes, that's right.  Just remove the function call.  But what happens if
> the device is a serial console?  Shouldn't the call to tty_shutdown()  =

> be skipped in that case?  (Eventually this won't matter; the console
> code will be straightened out so that we never release a serial console
> device.  But for now it's important.)
> =

> If you think it would be appropriate, you could also rename
> serial_release() to serial_cleanup() -- it's up to you.

The patch has been fixed up by Linus and merged as
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3Df278a2f7bbc2239f479eaf63d0b3ae573b1d746c

If any more fixes are necessary, they'll have to go on top of it.

Best,
Rafael
