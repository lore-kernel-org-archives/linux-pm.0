From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFD] swsusp problem: Drivers allocate much memory
	during	suspend (was: Re: 2.6.21-rc5: swsusp: Not enough free memory)
Date: Sat, 14 Apr 2007 07:34:43 +1000
Message-ID: <1176500083.7112.180.camel@nigel.suspend2.net>
References: <460B6E4B.3060004@gmail.com> <200704131400.12021.rjw@sisk.pl>
	<1176466896.7112.159.camel@nigel.suspend2.net>
	<200704132241.52725.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704132241.52725.rjw@sisk.pl>
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

On Fri, 2007-04-13 at 22:41 +0200, Rafael J. Wysocki wrote:
> On Friday, 13 April 2007 14:21, Nigel Cunningham wrote:
> > Hi.
> > =

> > On Fri, 2007-04-13 at 14:00 +0200, Rafael J. Wysocki wrote:
> > > > =

> > > > Shrinking memory...  Pages needed: 128103 normal, 0 highmem
> > > > Pages needed: 125226 normal, 0 highmem
> > > > Pages needed: -5757 normal, 0 highmem
> > > > Pages needed: -5757 normal, 0 highmem
> > > > Pages needed: -5757 normal, 0 highmem
> > > > Pages needed: -5757
> > > > Pages needed: 127953 normal, 0 highmem
> > > > Pages needed: 125076 normal, 0 highmem
> > > > Pages needed: -6043 normal, 0 highmem
> > > > Pages needed: -6043 normal, 0 highmem
> > > > Pages needed: -6043 normal, 0 highmem
> > > > Pages needed: -6043
> > > > done (200 pages freed)
> > > > Freed 800 kbytes in 0.16 seconds (5.00 MB/s)
> > > > Suspending console(s)
> > > > ...
> > > > CPU1 is down
> > > > swsusp: critical section:
> > > > swsusp: Need to copy 131358 pages
> > > > swsusp: Normal pages needed: 131358
> > > > swsusp: Normal pages needed: 131358 + 1024 + 22, available pages: 1=
30607
> > > =

> > > Well, it looks like someone allocated about 6000 pages after we had f=
reed
> > > enough memory for suspending.
> > =

> > We have a tunable allowance in Suspend2 for this, because fglrx
> > allocates a lot of pages in its suspend routine if DRI is enabled. I
> > think some other drivers do too, but fglrx is the main one I know.
> =

> I wasn't aware of that, thanks for the information.
> =

> I think this means we'll probably need to add a tunable, similar to image=
_size,
> that will allow the users to specify how much spare memory they want to r=
eserve
> for suspending (instead of the constant PAGES_FOR_IO).  IMO we can call it
> 'spare_memory'.
> =

> Still, this doesn't look like a real solution, because it would require t=
he
> users affected by this problem to experiment with suspending in order to
> figure out how much spare memory they will need.
> =

> IMO to really fix the problem, we should let the drivers that need much m=
emory
> for suspending allocate it _before_ the memory shrinker is called.  For t=
his
> purpose we can use notifiers that will be called before we start the shri=
nking
> of memory.  Namely, if a driver needs to allocate substantial amount of m=
emory
> for suspending, it can register a notifier that will be called before we =
try to
> shrink memory.  Then, the memory needed by the driver may be allocated in
> this notifier (of course, in that case it will also have to be called if =
the
> shrinking of memory fails, so that the memory allocated by the driver for
> suspending can be freed) and used in the driver's .suspend() routine.
> =

> Comments welcome.

Yeah. I've thought about it too. It could also be good for that acpi
routine that was allocating memory during in an atomic context with the
wrong flagas. Another idea that occurred to me would be to allow drivers
to have a routine saying how much memory they will need, which we could
call to calculate the allowance we need. Personally, I think the
notifier chain is simpler and preferable :)

Regards,

Nigel
