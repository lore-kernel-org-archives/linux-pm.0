From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Mon, 26 Apr 2010 15:25:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004261518130.1764-100000__25414.714733097$1272309966$gmane$org@iolanthe.rowland.org>
References: <v2ld6200be21004251534y6c820e96l824f3288201a757d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <v2ld6200be21004251534y6c820e96l824f3288201a757d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 25 Apr 2010, Arve Hj=F8nnev=E5g wrote:

> >> > >> > +User-space API
> >> > >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >> > +
> >> > >> > +To create a suspend_blocker from user-space, open the suspend_=
blocker device:
> >> > >> > + =A0 =A0fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC=
);
> >> > >> > +then call:
> >> > >> > + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), na=
me);
> >> > >>
> >> > >>
> >> > >> This seems like very wrong idea -- it uses different ioctl number=
 for
> >> > >> each length AFAICT.
> >> > >
> >> > > How about specifying the name by an ordinary write() call instead =
of
> >> > > by an ioctl()?
> >> > >
> >> >
> >> > I prefer using ioctls. We have three operations at the moment. Init,
> >> > block and unblock. If we do init with write but block and unblock
> >> > using ioctls, it would be pretty strange. Specifying a command and
> >>
> >> Why would it be "strange"?
> >
> > Why indeed? =A0Using write() is the natural way to pass a data buffer
> > into the kernel, especially a variable-length buffer.
> >
> > Mixing ioctl() and write() might seem strange at first, but it has
> > plenty of precedent. =A0Consider adjusting the settings for a serial
> > port, for example.
> >
> That sound like to opposite situation to me. It uses ioctls for setup
> and read/write access the data stream.

Or you could say that it uses ioctls to send commands and read/write to =

pass data.  That's pretty much what you would be doing.

Let's put it another way: You find it excessively strange to do init
using write and to send commands via ioctl, but you don't find it
strange to abuse the ioctl number code for passing the string length?  =

The old saying about motes and beams applies here...

If you insist on using ioctl for init, you should use the standard
convention for passing variable-length data.  The userspace program
sets up a fixed-size buffer containing a pointer to the name and the
name's length, and it passes the buffer's address as the ioctl
argument.

Alan Stern
