From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Fri, 1 Apr 2005 00:18:14 +0200
Message-ID: <20050331221814.GC1802@elf.ucw.cz>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
	<Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
	<d120d50005033108321c8f4ae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13712724115404828=="
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
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============13712724115404828==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

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

I believe we should freeze hotplug before processes. Dropping messages
on the floor should not be a problem, we should just call coldplug
after failed suspend.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============13712724115404828==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13712724115404828==--
