From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Fri, 1 Apr 2005 10:49:00 +0200
Message-ID: <200504011049.01540.rjw@sisk.pl>
References: <20050329181831.GB8125@elf.ucw.cz>
	<20050331221814.GC1802@elf.ucw.cz>
	<1112308137.18871.7.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79728832093515178=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <1112308137.18871.7.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============79728832093515178==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 1 of April 2005 00:28, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2005-04-01 at 08:18, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Ok, what do you think about this one?
> > > > >
> > > > > ===================================================================
> > > > >
> > > > > swsusp: disable usermodehelper after generating memory snapshot and
> > > > >         before resuming devices, so when device fails to resume we
> > > > >         won't try to call hotplug - userspace stopped anyway.
> > > > 
> > > > Hm, shouldn't we disable it before we start to freeze processes? We don't
> > > > want any more processes trying to start up after we've taken care of
> > > > them..
> > > > 
> > > 
> > > Can't a device be removed (for any reason) _while_ we are freezing
> > > processes? I think freeszing code will properly deal with it... What
> > > about suspend semantics - if suspend fails do we say the device should
> > > be operational or the system should attempt to re-initialize? I.e. we
> > > are not doing suspend after all - can we still drop messages on the
> > > floor? After all, we still have ability to run coldplug after failed
> > > suspend.
> > 
> > I believe we should freeze hotplug before processes.

I agree.  IMO user space should not be considered as available once we have
started freezing processes, so hotplug should be disabled before.  By the same
token, it should only be enabled after the processes have been restarted
during resume (or after suspend has failed).

BTW, it seems to me that the forking of new processes could be disabled
before we start to freeze the existing ones.

> > Dropping messages on the floor should not be a problem, we should just
> > call coldplug after failed suspend.
> 
> How will you know which devices to call coldplug for, post resume? (Or
> does it figure that out itself somehow?)

I think the drivers that need the hotplug to resume should defer their resume
routines until usermodehelper is enabled (it seems to me that we can use
a completion to handle this).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============79728832093515178==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79728832093515178==--
