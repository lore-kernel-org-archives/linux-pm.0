From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during	suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 09:03:50 +1000
Message-ID: <1176505430.7112.216.camel@nigel.suspend2.net>
References: <460B6E4B.3060004@gmail.com> <20070413224053.GT28264@elf.ucw.cz>
	<1176504306.7112.206.camel@nigel.suspend2.net>
	<200704140057.35829.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704140057.35829.rjw@sisk.pl>
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

On Sat, 2007-04-14 at 00:57 +0200, Rafael J. Wysocki wrote:
> > > > Well, I'm not sure.  First, we don't really know what the value of =
it should be
> > > > and this alone is a good enough reason for making it tunable, IMHO.=
  Second, I
> > > > think different systems may need different PAGES_FOR_IO and taking =
just the
> > > > maximum (even if we learn how much that actually is) seems to be wa=
steful in
> > > =

> > > Well,  it is wasteful as in "we save slightly smaller image than we
> > > could". That's okay with me.
> > =

> > No. If the driver can't allocate the memory, your call to device_suspend
> > will fail. This isn't about image size but about success or failure to
> > hibernate.
> =

> If we take PAGES_FOR_IO to be the maximum over all possible configurations
> that can hibernate, the majority of systems will just create smaller imag=
es than
> they could have created for smaller PAGES_FOR_IO, but all of them will be
> able to hibernate. :-)

You also use PAGES_FOR_IO in enough_free_mem. Say you set it to the 9000
pages I mentioned before (35M). On a machine with 64 megabytes of
memory, you'll never be able to suspend because you'll never satisfy

free > nr_pages + PAGES_FOR_IO + meta

I'll freely admit that 64 megabytes is tiny nowadays, but it's not
completely unknown. The point is really that you're effectively making
swsusp unusable for machines with RAM < (PAGES_FOR_IO * (say) 3). But
what do you set PAGES_FOR_IO to? There'll always be someone with
$WHIZ_BANG_CONFIG who is pushing to have the value increased, and every
increase knocks out more of your lowend users.

Regards,

Nigel
