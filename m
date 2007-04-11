From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Wed, 11 Apr 2007 11:55:51 +0200
Message-ID: <200704111155.52455.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704092220.10039.rjw@sisk.pl>
	<461C8FF4.80202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <461C8FF4.80202@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 11 April 2007 09:36, Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> > On Monday, 9 April 2007 22:07, Jiri Slaby wrote:
> >> Rafael J. Wysocki napsal(a):
> >>> Thanks for testing.
> >> [...]
> >>> --- linux-2.6.21-rc5.orig/kernel/power/swsusp.c
> >>> +++ linux-2.6.21-rc5/kernel/power/swsusp.c
> >>> @@ -229,13 +229,13 @@ int swsusp_shrink_memory(void)
> >>>  		size +=3D highmem_size;
> >>>  		for_each_zone (zone)
> >>>  			if (populated_zone(zone)) {
> >>> +				tmp +=3D snapshot_additional_pages(zone);
> >>>  				if (is_highmem(zone)) {
> >>>  					highmem_size -=3D
> >>>  					zone_page_state(zone, NR_FREE_PAGES);
> >>>  				} else {
> >>>  					tmp -=3D zone_page_state(zone, NR_FREE_PAGES);
> >>>  					tmp +=3D zone->lowmem_reserve[ZONE_NORMAL];
> >>> -					tmp +=3D snapshot_additional_pages(zone);
> >> I have bad news for you :(. I thought I had unpatched kernel, but it h=
appens
> >> in -rc6 too.
> > =

> > I guess you mean you're still seeing the 'not enough memory to suspend'
> > problem?
> =

> Yes:
> Disabling non-boot CPUs ...
> kvm: disabling virtualization on CPU1
> Breaking affinity for irq 9
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> CPU1 is down
> swsusp: critical section:
> swsusp: Need to copy 158309 pages
> swsusp: Not enough free memory
> Error -12 suspending
> Enabling non-boot CPUs ...
> SMP alternatives: switching to SMP code
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1

How reproducible is it?  I'm going to try to reproduce it on one of my boxe=
s.

> >> Next, when this occurs, kernel CPU1 is not brought up and next suspend=
 hangs
> >> on "Suspending consoles".
> > =

> > Hm, there probably is a bug in an error path.  Do you use the built in =
swsusp
> > or s2disk?
> =

> built-in. It happens only sometimes, here, as you can see, CPU1 was
> successfully brought up.

Sigh.  Then probably there's a problem with the CPU hotplugging and it'll be
hard to find, I'm afraid.

Greetings,
Rafael
