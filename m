From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 00:35:35 +0200
Message-ID: <200704140035.36355.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704132241.52725.rjw@sisk.pl>
	<20070413221016.GQ28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413221016.GQ28264@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 00:10, Pavel Machek wrote:
> Hi!
> =

> > > > Well, it looks like someone allocated about 6000 pages after we had=
 freed
> > > > enough memory for suspending.
> > > =

> > > We have a tunable allowance in Suspend2 for this, because fglrx
> > > allocates a lot of pages in its suspend routine if DRI is enabled. I
> > > think some other drivers do too, but fglrx is the main one I know.
> > =

> > I wasn't aware of that, thanks for the information.
> > =

> > I think this means we'll probably need to add a tunable, similar to ima=
ge_size,
> > that will allow the users to specify how much spare memory they want to=
 reserve
> > for suspending (instead of the constant PAGES_FOR_IO).  IMO we can call=
 it
> > 'spare_memory'.
> =

> Just increase PAGES_FOR_IO. This should not be tunable.

Well, I'm not sure.  First, we don't really know what the value of it shoul=
d be
and this alone is a good enough reason for making it tunable, IMHO.  Second=
, I
think different systems may need different PAGES_FOR_IO and taking just the
maximum (even if we learn how much that actually is) seems to be wasteful in
the vast majority of cases.  Finally, I think it may be possible to speed up
image saving by increasing PAGES_FOR_IO without playing with the
image size and we can let the user try it (think of distro kernels that are
compiled for many different users).

Still, I'm not going to fight for that.

> > Still, this doesn't look like a real solution, because it would require=
 the
> > users affected by this problem to experiment with suspending in order to
> > figure out how much spare memory they will need.
> =

> Exactly.
> =

> > IMO to really fix the problem, we should let the drivers that need much=
 memory
> > for suspending allocate it _before_ the memory shrinker is called.  For=
 this
> > purpose we can use notifiers that will be called before we start the sh=
rinking
> > of memory.  Namely, if a driver needs to allocate substantial amount
> > of memory
> =

> Yes please. Using that notifier without leaking the memory will be
> "interesting" but if someone needs so much memory during suspend, let
> them eat their own complexity.

Okay, I'm going to prepare a patch along these lines.

Greetings,
Rafael
