From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Thu, 31 Mar 2005 11:32:52 -0500
Message-ID: <d120d50005033108321c8f4ae7@mail.gmail.com>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
	<Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <Pine.LNX.4.50.0503310801410.15519-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Mar 2005 08:02:44 -0800 (PST), Patrick Mochel
<mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org> wrote:
> 
> On Thu, 31 Mar 2005, Dmitry Torokhov wrote:
> 
> > Ok, what do you think about this one?
> >
> > ===================================================================
> >
> > swsusp: disable usermodehelper after generating memory snapshot and
> >         before resuming devices, so when device fails to resume we
> >         won't try to call hotplug - userspace stopped anyway.
> 
> Hm, shouldn't we disable it before we start to freeze processes? We don't
> want any more processes trying to start up after we've taken care of
> them..
> 

Can't a device be removed (for any reason) _while_ we are freezing
processes? I think freeszing code will properly deal with it... What
about suspend semantics - if suspend fails do we say the device should
be operational or the system should attempt to re-initialize? I.e. we
are not doing suspend after all - can we still drop messages on the
floor? After all, we still have ability to run coldplug after failed
suspend.

I frankly am not sure at what point to disable usermode helper. Or
maybe we need to have a list of pending events and suspend khelper_wq
while suspending.

-- 
Dmitry
