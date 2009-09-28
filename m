From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH,
 fix] Re: [Regression] 2.6.31-git: tty change broke resume from
 hibernation on MSI Wind U100
Date: Mon, 28 Sep 2009 02:07:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0909280202280.14348-100000__38148.9460975446$1254118208$gmane$org@netrider.rowland.org>
References: <a8e1da0909272203me287858y2f8d82f3710e07d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a8e1da0909272203me287858y2f8d82f3710e07d3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Sep 2009, Dave Young wrote:

> On Mon, Sep 28, 2009 at 2:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday 27 September 2009, Alan Stern wrote:
> >> On Sun, 27 Sep 2009, Rafael J. Wysocki wrote:
> >>
> >> > Tested, works.
> >> >
> >> > Greg, could you please consider taking the patch below? =C2=A0It fix=
es a recent
> >> > hibernation regression for me, so if not this one, another fix is ne=
cessary.
> >>
> >> This patch has a mistake.
> >>
> >> > Index: linux-2.6/drivers/usb/serial/usb-serial.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/usb/serial/usb-serial.c
> >> > +++ linux-2.6/drivers/usb/serial/usb-serial.c
> >> > @@ -1210,7 +1210,7 @@ static const struct tty_operations seria
> >> > =C2=A0 =C2=A0 .chars_in_buffer =3D =C2=A0 =C2=A0 =C2=A0serial_chars_=
in_buffer,
> >> > =C2=A0 =C2=A0 .tiocmget =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 serial_tiocmget,
> >> > =C2=A0 =C2=A0 .tiocmset =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 serial_tiocmset,
> >> > - =C2=A0 .shutdown =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ser=
ial_release,
> >> > + =C2=A0 .cleanup =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0serial_release,
> >> > =C2=A0 =C2=A0 .install =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0serial_install,
> >> > =C2=A0 =C2=A0 .proc_fops =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&serial_proc_fops,
> >> > =C2=A0};
> >>
> >> It isn't enough to change the method pointer. =C2=A0The code in
> >> serial_release() has to be changed too; it must not call tty_shutdown()
> >> any more.
> >
> > Would it be sufficient to remove the tty_shutdown() call from
> > serial_release()?
> =

> I think so, because standard shutdown will be called in queue_release_one=
_tty.
> =

> Alan, could you confirm about this?  Thus I'd like to update the patch.

Yes, that's right.  Just remove the function call.  But what happens if
the device is a serial console?  Shouldn't the call to tty_shutdown()  =

be skipped in that case?  (Eventually this won't matter; the console
code will be straightened out so that we never release a serial console
device.  But for now it's important.)

If you think it would be appropriate, you could also rename
serial_release() to serial_cleanup() -- it's up to you.

Alan Stern
