From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during	suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 08:36:00 +1000
Message-ID: <1176503760.7112.194.camel@nigel.suspend2.net>
References: <460B6E4B.3060004@gmail.com> <200704132241.52725.rjw@sisk.pl>
	<20070413221016.GQ28264@elf.ucw.cz>  <200704140035.36355.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704140035.36355.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2007-04-14 at 00:35 +0200, Rafael J. Wysocki wrote:
> On Saturday, 14 April 2007 00:10, Pavel Machek wrote:
> > Hi!
> > =

> > > > > Well, it looks like someone allocated about 6000 pages after we h=
ad freed
> > > > > enough memory for suspending.
> > > > =

> > > > We have a tunable allowance in Suspend2 for this, because fglrx
> > > > allocates a lot of pages in its suspend routine if DRI is enabled. I
> > > > think some other drivers do too, but fglrx is the main one I know.
> > > =

> > > I wasn't aware of that, thanks for the information.
> > > =

> > > I think this means we'll probably need to add a tunable, similar to i=
mage_size,
> > > that will allow the users to specify how much spare memory they want =
to reserve
> > > for suspending (instead of the constant PAGES_FOR_IO).  IMO we can ca=
ll it
> > > 'spare_memory'.
> > =

> > Just increase PAGES_FOR_IO. This should not be tunable.
> =

> Well, I'm not sure.  First, we don't really know what the value of it sho=
uld be
> and this alone is a good enough reason for making it tunable, IMHO.  Seco=
nd, I
> think different systems may need different PAGES_FOR_IO and taking just t=
he
> maximum (even if we learn how much that actually is) seems to be wasteful=
 in
> the vast majority of cases.  Finally, I think it may be possible to speed=
 up
> image saving by increasing PAGES_FOR_IO without playing with the
> image size and we can let the user try it (think of distro kernels that a=
re
> compiled for many different users).

It does vary according to the amount of video memory used for DRM, if I
understand correctly.

Nigel
