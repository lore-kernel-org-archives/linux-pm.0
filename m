From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: suspend/resume uevents [was Re: Introducing HAL
	userspace power management]
Date: Sat, 12 Mar 2005 08:26:42 +1100
Message-ID: <1110576402.32510.14.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0503071125001.1378-100000@ida.rowland.org>
	<1110411138.7779.86.camel@daxter.boston.redhat.com>
	<20050309233556.GO17034@elf.ucw.cz>
	<1110426926.3443.3.camel@daxter.boston.redhat.com>
	<20050310095629.GA13444@elf.ucw.cz>
	<1110476278.3404.60.camel@daxter.boston.redhat.com>
	<20050310211320.GG632@openzaurus.ucw.cz>
	<1110490939.3404.84.camel@daxter.boston.redhat.com>
	<20050310230745.GC10954@elf.ucw.cz>
	<1110518935.4512.14.camel@daxter.boston.redhat.com>
	<1110519283.3049.51.camel@desktop.cunningham.myip.net.au>
	<Pine.LNX.4.50.0503111250320.19793-100000@monsoon.he.net>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40632121601137694=="
In-Reply-To: <Pine.LNX.4.50.0503111250320.19793-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============40632121601137694==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-03-12 at 07:57, Patrick Mochel wrote:
> On Fri, 11 Mar 2005, Nigel Cunningham wrote:
> 
> > Hi.
> >
> > On Fri, 2005-03-11 at 16:28, David Zeuthen wrote:
> > > Maybe I'm reading the source wrong, but isn't it the case that some
> > > laptops using APM (my IBM thinkpad T41 with acpi=off for instance)
> > > suspends without user space interaction when the lid is closed, thus
> > > rendering it impossible to send the event from user space?
> > >
> > > One may even ask whether it's sound to assume that all architectures
> > > will be suspended via user space?
> >
> > The most common way at the moment for a lid switch to activate
> > suspending is via the userspace acpid daemon. I'd be mildly interested
> > if you didn't have something equivalent running on your machine.
> 
> APM doesn't work like that. There *might* be a way for the lid switch
> interrupt to be passed to the kernel, which can the forward it to
> userspace. But traditionally, the interrupt would generate an SMI and be
> handled by the BIOS in a manner completely transparent to the OS (using
> the Evil System Management Mode on x86 processor).

Ah.. sorry. I missed those critical A P M letters :>

Nigel

> While it is true that APM is obsolete, a similar method to suspend some
> systems may be employed by the system designer. I believe it's going to
> be common in embedded systems, where an external signal triggers a suspend
> transition.
> 
> That doesn't preclude us from pushing the signal out to userpsace and
> requiring userspace to trigger the susped through sysfs, but my general
> opinion is that that solution is inelegant in principal and may not be
> fast enough for people employing it.
> 
> 
> 	Pat
> 5B
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============40632121601137694==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============40632121601137694==--
