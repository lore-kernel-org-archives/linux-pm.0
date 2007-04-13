From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during	suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 08:45:06 +1000
Message-ID: <1176504306.7112.206.camel@nigel.suspend2.net>
References: <460B6E4B.3060004@gmail.com> <200704132241.52725.rjw@sisk.pl>
	<20070413221016.GQ28264@elf.ucw.cz> <200704140035.36355.rjw@sisk.pl>
	<20070413224053.GT28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413224053.GT28264@elf.ucw.cz>
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
Cc: linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2007-04-14 at 00:40 +0200, Pavel Machek wrote:
> Hi!
> =

> > > > > > Well, it looks like someone allocated about 6000 pages after we=
 had freed
> > > > > > enough memory for suspending.
> > > > > =

> > > > > We have a tunable allowance in Suspend2 for this, because fglrx
> > > > > allocates a lot of pages in its suspend routine if DRI is enabled=
. I
> > > > > think some other drivers do too, but fglrx is the main one I know.
> > > > =

> > > > I wasn't aware of that, thanks for the information.
> > > > =

> > > > I think this means we'll probably need to add a tunable, similar to=
 image_size,
> > > > that will allow the users to specify how much spare memory they wan=
t to reserve
> > > > for suspending (instead of the constant PAGES_FOR_IO).  IMO we can =
call it
> > > > 'spare_memory'.
> > > =

> > > Just increase PAGES_FOR_IO. This should not be tunable.
> > =

> > Well, I'm not sure.  First, we don't really know what the value of it s=
hould be
> > and this alone is a good enough reason for making it tunable, IMHO.  Se=
cond, I
> > think different systems may need different PAGES_FOR_IO and taking just=
 the
> > maximum (even if we learn how much that actually is) seems to be wastef=
ul in
> =

> Well,  it is wasteful as in "we save slightly smaller image than we
> could". That's okay with me.

No. If the driver can't allocate the memory, your call to device_suspend
will fail. This isn't about image size but about success or failure to
hibernate.

Nigel
