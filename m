From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Thu, 31 Mar 2005 10:39:10 +0200
Message-ID: <20050331083909.GA1387@elf.ucw.cz>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54179809211088514=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <200503310226.03495.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============54179809211088514==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > We currently freeze processes for suspend-to-ram, too. I guess that
> > > > disable_usermodehelper is probably better and that in_suspend() should
> > > > only be used for sanity checks... go with disable_usermodehelper and
> > > > sorry for the noise.
> > > 
> > > Here's another possibility: Freeze the workqueue that
> > > call_usermodehelper uses (remember that code I didn't push hard enough
> > > to Andrew?), and let invocations of call_usermodehelper block in
> > > TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on
> > 
> > There may be many devices in the system, and you are going to need
> > quite a lot of RAM for all that... That's why they do not queue it
> > during boot, IIRC. Disabling usermode helper seems right.
> 
> Ok, what do you think about this one?
> 
> ===================================================================
> 
> swsusp: disable usermodehelper after generating memory snapshot and
>         before resuming devices, so when device fails to resume we
>         won't try to call hotplug - userspace stopped anyway.
> 
> Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
> 
> 
>  include/linux/kmod.h  |    3 +++
>  kernel/kmod.c         |   14 +++++++++++++-
>  kernel/power/disk.c   |    2 ++
>  kernel/power/swsusp.c |    1 -
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: dtor/kernel/power/disk.c
> ===================================================================
> --- dtor.orig/kernel/power/disk.c
> +++ dtor/kernel/power/disk.c
> @@ -205,6 +205,8 @@ int pm_suspend_disk(void)
>  
>  	if (in_suspend) {
>  		pr_debug("PM: writing image.\n");
> +		usermodehelper_disable();
> +		device_resume();
>  		error = swsusp_write();
>  		if (!error)
>  			power_down(pm_disk_mode);
> Index: dtor/kernel/power/swsusp.c
> ===================================================================
> --- dtor.orig/kernel/power/swsusp.c
> +++ dtor/kernel/power/swsusp.c
> @@ -853,7 +853,6 @@ static int suspend_prepare_image(void)
>  int swsusp_write(void)
>  {
>  	int error;
> -	device_resume();
>  	lock_swapdevices();
>  	error = write_suspend_image();
>  	/* This will unlock ignored swap devices since writing is

Looks good, except... why move code around? Could you just call
usermodehelper_disable from swsusp_write?
							Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============54179809211088514==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54179809211088514==--
