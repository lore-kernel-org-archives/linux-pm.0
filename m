From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: suspend/resume uevents [was Re: Introducing HAL
	userspace power management]
Date: Sat, 12 Mar 2005 07:49:00 +1100
Message-ID: <1110574140.32510.12.camel@desktop.cunningham.myip.net.au>
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
	<20050311084158.GA1705@elf.ucw.cz>
	<1110557099.4203.19.camel@daxter.boston.redhat.com>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90466497609236218=="
In-Reply-To: <1110557099.4203.19.camel-Kbn0pMe1eZsEMMbVNdFDoACJwEvxM/w9@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Zeuthen <davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============90466497609236218==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-03-12 at 03:04, David Zeuthen wrote:
> Oh, I thought the kernel was moving towards presenting user space with
> an abstract interface much like /sys/power/state; that would definitely
> be easier on user space (we don't have to add new code for every PM
> framework), but I do understand if you don't want to do this as it have
> negative consequences. But at least some form of feature parity across
> different PM frameworks would be nice (e.g. if you make APM resume send
> an event, do the same for ACPI and PMU) because in many ways user space
> do have to design for lowest common denominator when abstracting this.

APM is considered obsolete, even Stephen Rothwell says that :> This is
why no work has been done on making it have a sys interface, IIUC.

The /sys interface is the way to go. Some of us are just too scared
by^W^W busy to implement kobjects and keep putting off the transition :>

> > > > . I'm *not* going to do that from kernel. But standartizing what needs
> > > > to be ran on resume is indeed good idea, and few lines in
> > > > Documentation/power/* are probably worth it.

Slow reply, I know.

There's an excellent hibernate script written by Bernard Blackham that
we use for suspend2, but is also able to handle swsusp etc. If everyone
would start using it... (me included! [Bernard, that's five times I've
said it!])

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============90466497609236218==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============90466497609236218==--
