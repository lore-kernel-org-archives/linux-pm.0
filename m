From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
Date: Fri, 01 Apr 2005 08:16:36 +1000
Message-ID: <1112307395.18871.4.camel@desktop.cunningham.myip.net.au>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
	<Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
	<d120d50005033108321c8f4ae7@mail.gmail.com>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72433804735443208=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <d120d50005033108321c8f4ae7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============72433804735443208==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Fri, 2005-04-01 at 02:32, Dmitry Torokhov wrote:
> On Thu, 31 Mar 2005 08:02:44 -0800 (PST), Patrick Mochel
> <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org> wrote:
> > 
> > On Thu, 31 Mar 2005, Dmitry Torokhov wrote:
> > 
> > > Ok, what do you think about this one?
> > >
> > > ===================================================================
> > >
> > > swsusp: disable usermodehelper after generating memory snapshot and
> > >         before resuming devices, so when device fails to resume we
> > >         won't try to call hotplug - userspace stopped anyway.
> > 
> > Hm, shouldn't we disable it before we start to freeze processes? We don't
> > want any more processes trying to start up after we've taken care of
> > them..
> > 
> 
> Can't a device be removed (for any reason) _while_ we are freezing
> processes? I think freeszing code will properly deal with it... What
> about suspend semantics - if suspend fails do we say the device should
> be operational or the system should attempt to re-initialize? I.e. we
> are not doing suspend after all - can we still drop messages on the
> floor? After all, we still have ability to run coldplug after failed
> suspend.
> 
> I frankly am not sure at what point to disable usermode helper. Or
> maybe we need to have a list of pending events and suspend khelper_wq
> while suspending.

FWIW, my solution is purely freezer based. I freeze khelper and in the
freezer code ignore kernel threads in state uninterruptible (which is
where kseriod, eg, will be while it waits for the usermode helper
process (which also gets frozen).

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============72433804735443208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72433804735443208==--
