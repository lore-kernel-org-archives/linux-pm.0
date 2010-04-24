From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Sat, 24 Apr 2010 10:44:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004241037230.6848-100000__47973.8643080511$1272120342$gmane$org@netrider.rowland.org>
References: <20100424055523.GC2290@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100424055523.GC2290@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 24 Apr 2010, Pavel Machek wrote:

> On Fri 2010-04-23 20:20:47, Arve Hj?nnev?g wrote:
> > On Fri, Apr 23, 2010 at 9:43 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> > > On Fri, 23 Apr 2010, Pavel Machek wrote:
> > >
> > >> Hi!
> > >>
> > >> > Add a misc device, "suspend_blocker", that allows user-space proce=
sses
> > >> > to block auto suspend. The device has ioctls to create a suspend_b=
locker,
> > >> > and to block and unblock suspend. To delete the suspend_blocker, c=
lose
> > >> > the device.
> > >> >
> > >> > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> > >>
> > >> > --- a/Documentation/power/suspend-blockers.txt
> > >> > +++ b/Documentation/power/suspend-blockers.txt
> > >> > @@ -95,3 +95,20 @@ if (list_empty(&state->pending_work))
> > >> > =A0else
> > >> > =A0 =A0 suspend_block(&state->suspend_blocker);
> > >> >
> > >> > +User-space API
> > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> > +
> > >> > +To create a suspend_blocker from user-space, open the suspend_blo=
cker device:
> > >> > + =A0 =A0fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> > >> > +then call:
> > >> > + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);
> > >>
> > >>
> > >> This seems like very wrong idea -- it uses different ioctl number for
> > >> each length AFAICT.
> > >
> > > How about specifying the name by an ordinary write() call instead of
> > > by an ioctl()?
> > >
> > =

> > I prefer using ioctls. We have three operations at the moment. Init,
> > block and unblock. If we do init with write but block and unblock
> > using ioctls, it would be pretty strange. Specifying a command and
> =

> Why would it be "strange"?

Why indeed?  Using write() is the natural way to pass a data buffer
into the kernel, especially a variable-length buffer.

Mixing ioctl() and write() might seem strange at first, but it has
plenty of precedent.  Consider adjusting the settings for a serial
port, for example.

> > argument in a string to write is more complicated to parse than using
> > ioctls.
> =

> More complicated to parse?

It shouldn't be -- especially if you assume that the init action must
always come first.  The first write would contain the suspend blocker's
name; all following writes would have to be either "on" or "off".  =

That's not hard to parse.

Alan Stern
