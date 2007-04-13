From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Fri, 13 Apr 2007 14:00:11 +0200
Message-ID: <200704131400.12021.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704122336.57600.rjw@sisk.pl>
	<4af2d03a0704130314s78d0d831ja52fe8f92efe097a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4af2d03a0704130314s78d0d831ja52fe8f92efe097a@mail.gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>, Gautham R Shenoy <ego@in.ibm.com>
Cc: linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 April 2007 12:14, Jiri Slaby wrote:
> On 4/12/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, 11 April 2007 17:02, Jiri Slaby wrote:
> > > Rafael J. Wysocki napsal(a):
> > > > On Wednesday, 11 April 2007 12:45, Jiri Slaby wrote:
> > > >> Rafael J. Wysocki napsal(a):
> > > >>> On Wednesday, 11 April 2007 09:36, Jiri Slaby wrote:
> > > >>>> Rafael J. Wysocki napsal(a):
> > > >>>>> On Monday, 9 April 2007 22:07, Jiri Slaby wrote:
> > > >>>>>> I have bad news for you :(. I thought I had unpatched kernel, =
but it happens
> > > >>>>>> in -rc6 too.
> > > >>>>> I guess you mean you're still seeing the 'not enough memory to =
suspend'
> > > >>>>> problem?
> > > >>>> Yes:
> > > >>>> Disabling non-boot CPUs ...
> > > >>>> kvm: disabling virtualization on CPU1
> > > >>>> Breaking affinity for irq 9
> > > >>>> CPU 1 is now offline
> > > >>>> SMP alternatives: switching to UP code
> > > >>>> CPU1 is down
> > > >>>> swsusp: critical section:
> > > >>>> swsusp: Need to copy 158309 pages
> > > >>>> swsusp: Not enough free memory
> > > >>>> Error -12 suspending
> > > >>>> Enabling non-boot CPUs ...
> > > >>>> SMP alternatives: switching to SMP code
> > > >>>> Booting processor 1/2 APIC 0x1
> > > >>>> Initializing CPU#1
> > > >>> How reproducible is it?  I'm going to try to reproduce it on one =
of my boxes.
> > > >> My tip is one of three cases: after some work on fresh boot -- some
> > > >> consumers such as thunderbird, firefox, 10 or so terminals with
> > > >> gnome-session. Single xterm + gnome-session semms not to be a prob=
lem.
> > > >
> > > > Does the workaround with setting the image size below 1/2 of RAM wo=
rk for you?
> > >
> > > Yes. Yesterday I must set the value to 350M -- 400M was not enough.
> >
> > Well, I can't reproduce it.
> >
> > Can you please try to reproduce it with the appended patch applied and =
send
> > the output of dmesg to me?
> >
> > Greetings,
> > Rafael
> >
> > ---
> >  kernel/power/snapshot.c |    4 ++--
> >  kernel/power/swsusp.c   |   16 ++++++++++++----
> >  2 files changed, 14 insertions(+), 6 deletions(-)
> =

> Shrinking memory...  Pages needed: 128103 normal, 0 highmem
> Pages needed: 125226 normal, 0 highmem
> Pages needed: -5757 normal, 0 highmem
> Pages needed: -5757 normal, 0 highmem
> Pages needed: -5757 normal, 0 highmem
> Pages needed: -5757
> Pages needed: 127953 normal, 0 highmem
> Pages needed: 125076 normal, 0 highmem
> Pages needed: -6043 normal, 0 highmem
> Pages needed: -6043 normal, 0 highmem
> Pages needed: -6043 normal, 0 highmem
> Pages needed: -6043
> done (200 pages freed)
> Freed 800 kbytes in 0.16 seconds (5.00 MB/s)
> Suspending console(s)
> ...
> CPU1 is down
> swsusp: critical section:
> swsusp: Need to copy 131358 pages
> swsusp: Normal pages needed: 131358
> swsusp: Normal pages needed: 131358 + 1024 + 22, available pages: 130607

Well, it looks like someone allocated about 6000 pages after we had freed
enough memory for suspending.

I suspect one of the device drivers plays some dirty tricks in its .suspend=
()
routine.  Now the question is which one.

I wonder if setting PAGES_FOR_IO in include/linux/suspend.h to eg. 8192 will
help.

> swsusp: Not enough free memory
> Error -12 suspending
> Enabling non-boot CPUs ...
> SMP alternatives: switching to SMP code
> Booting processor 1/2 APIC 0x1
> Not responding.
> Inquiring remote APIC #1...
> ... APIC #1 ID: failed
> ... APIC #1 VERSION: failed
> ... APIC #1 SPIV: failed
> kvm: disabling virtualization on CPU1
> Error taking CPU1 up: -5
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> =

> Please note the CPU#1 bring up problem too.

Yes, and this seems to be related to the APIC.

Gautham, can you please tell me who's the right person to ask about it?

Rafael
