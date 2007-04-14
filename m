From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 11:33:32 +0200
Message-ID: <200704141133.33366.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704140057.35829.rjw@sisk.pl>
	<1176505430.7112.216.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176505430.7112.216.camel@nigel.suspend2.net>
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
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 01:03, Nigel Cunningham wrote:
> Hi.
> =

> On Sat, 2007-04-14 at 00:57 +0200, Rafael J. Wysocki wrote:
> > > > > Well, I'm not sure.  First, we don't really know what the value o=
f it should be
> > > > > and this alone is a good enough reason for making it tunable, IMH=
O.  Second, I
> > > > > think different systems may need different PAGES_FOR_IO and takin=
g just the
> > > > > maximum (even if we learn how much that actually is) seems to be =
wasteful in
> > > > =

> > > > Well,  it is wasteful as in "we save slightly smaller image than we
> > > > could". That's okay with me.
> > > =

> > > No. If the driver can't allocate the memory, your call to device_susp=
end
> > > will fail. This isn't about image size but about success or failure to
> > > hibernate.
> > =

> > If we take PAGES_FOR_IO to be the maximum over all possible configurati=
ons
> > that can hibernate, the majority of systems will just create smaller im=
ages than
> > they could have created for smaller PAGES_FOR_IO, but all of them will =
be
> > able to hibernate. :-)
> =

> You also use PAGES_FOR_IO in enough_free_mem. Say you set it to the 9000
> pages I mentioned before (35M). On a machine with 64 megabytes of
> memory, you'll never be able to suspend because you'll never satisfy
> =

> free > nr_pages + PAGES_FOR_IO + meta

Well, in fact our tunable would need to be independent of PAGES_FOR_IO so t=
hat
the memory shrinker could free some spare memory for the drivers.

> I'll freely admit that 64 megabytes is tiny nowadays, but it's not
> completely unknown. The point is really that you're effectively making
> swsusp unusable for machines with RAM < (PAGES_FOR_IO * (say) 3). But
> what do you set PAGES_FOR_IO to? There'll always be someone with
> $WHIZ_BANG_CONFIG who is pushing to have the value increased, and every
> increase knocks out more of your lowend users.

Yes, that's why I said I wasn't sure whether or not the additional tunable =
was
needed.

Still, with the notifiers we have a chance to handle the problem automatica=
lly
and the tunable would require the user to set the right value.

Greetings,
Rafael
