From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Mon, 1 May 2006 14:35:52 -0700
Message-ID: <200605011435.52860.david-b@pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A5055F11C0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70603926023791108=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5055F11C0@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============70603926023791108==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Monday 24 April 2006 2:32 pm, Woodruff, Richard wrote:

> The current pseudo export 
> of these non-functional states doesn't seem so useful.  Having some
> fuzzy level of idleness seems much better.

I've come to believe that userspace has little or no business caring
about the details of power states ... except to the extent that a driver
exports them.  After all, the driver might not support all the possible
hardware states.  And the same controller on two different systems might
expose different power management functionality, based on (among other
things) what external hardware is wired up.


> The point of the idle states Len was floating attempts to define a level
> of on-ness/idleness.  As it turns out there was a nice correlation to
> some ACPI states.  Numbering them seems reasonable, else your just
> wasting effort translating 'state0, state1, state2, ...', keeping the
> naming convention simple '0,1,2,..0xffff' would seem to lend itself to
> code sharing of necessary class/device specific translation code.

I don't think I agree with "seem".  We'd get right back into the mess
we now have ... not just expecting "2" to mean the same thing everywhere
(aargh!) but also finding needs for integer "1.5" that is somehow stuck
between "1" and "2".  Much easier to do that with strings!

Plus, numbers lead to an assumption that things can be compared.
One is less than two ... but is an apple less than an orange?
In the same way, different power states are not necessarily
comparable on one single axis.

  
> > Actually the wakeup characteristics are orthogonal, there are
> > per-device bits controlling whether a device can and should do
> > the wakeup.  We don't for example treat "PCI_D3hot with wakeup"
> > as a distinct state. 
> 
> In my current hack attempts I am trying to associate a 'device' D2 state
> with a local device sleep with an async wake up enabled.  In this state
> a devices accesses are locked out until the device wake up event
> happens.  This async wake can be from a device specific wake up or from
> an associated timer resource.

So would that be a "wake the whole system" or a runtime power
management mechanism to provide functionality without very much
of a power drain?  I've done the latter a few times, but never
needed to expose it through sysfs.  If it works, it kind of needs
to be enabled at almost all times, to avoid nightmares of config
management and debugging.

- Dave



--===============70603926023791108==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70603926023791108==--
