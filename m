From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
Date: Wed, 30 Mar 2005 09:46:26 +1000
Message-ID: <1112139986.29392.26.camel@desktop.cunningham.myip.net.au>
References: <20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
	<d120d500050329130714e1daaf@mail.gmail.com>
	<20050329211239.GG8125@elf.ucw.cz>
	<d120d50005032913331be39802@mail.gmail.com>
	<20050329214408.GH8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94019557549106259=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329223519.GI8125-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============94019557549106259==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Wed, 2005-03-30 at 08:35, Pavel Machek wrote:
> Hi!
> 
> > > We currently freeze processes for suspend-to-ram, too. I guess that
> > > disable_usermodehelper is probably better and that in_suspend() should
> > > only be used for sanity checks... go with disable_usermodehelper and
> > > sorry for the noise.
> > 
> > Here's another possibility: Freeze the workqueue that
> > call_usermodehelper uses (remember that code I didn't push hard enough
> > to Andrew?), and let invocations of call_usermodehelper block in
> > TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on
> 
> There may be many devices in the system, and you are going to need
> quite a lot of RAM for all that... That's why they do not queue it
> during boot, IIRC. Disabling usermode helper seems right.

Many devices is true, but very few of them invoke usermode helpers.

[desktop build-2.6.12-rc1]# find -name *.[ch] | xargs grep usermodehelper
./drivers/s390/crypto/z90main.c:        call_usermodehelper(argv[0], argv, envp, 0);
./drivers/net/hamradio/baycom_epp.c:    return call_usermodehelper(eppconfig_path, argv, envp, 1);
./drivers/acpi/thermal.c:       call_usermodehelper(argv[0], argv, envp, 0);
./drivers/acpi/thermal.mod.c:   { 0x436006da, "call_usermodehelper" },
./drivers/input/input.c:        value = call_usermodehelper(argv [0], argv, envp, 0);
./drivers/pnp/pnpbios/core.c:   value = call_usermodehelper (argv [0], argv, envp, 0);
./drivers/macintosh/therm_pm72.c:       return call_usermodehelper(critical_overtemp_path, argv, envp, 0);
./arch/i386/mach-voyager/voyager_thread.c:      if ((ret = call_usermodehelper(argv[0], argv, envp, 1)) != 0) {
./include/linux/kmod.h:extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
./include/linux/kmod.h:extern void usermodehelper_init(void);
./kernel/power/main.c:  return call_usermodehelper(argv[0], argv, envp, 1);
./kernel/power/suspend_userui.c:        retval = call_usermodehelper(userui_program, argv, envp, 0);
./kernel/kmod.c:        call_usermodehelper wait flag, and remove exec_usermodehelper.
./kernel/kmod.c:        ret = call_usermodehelper(modprobe_path, argv, envp, 1);
./kernel/kmod.c:static int ____call_usermodehelper(void *data)
./kernel/kmod.c:        pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
./kernel/kmod.c:static void __call_usermodehelper(void *data)
./kernel/kmod.c:                pid = kernel_thread(____call_usermodehelper, sub_info,
./kernel/kmod.c: * call_usermodehelper - start a usermode application
./kernel/kmod.c:int call_usermodehelper(char *path, char **argv, char **envp, int wait)
./kernel/kmod.c:        DECLARE_WORK(work, __call_usermodehelper, &sub_info);
./kernel/kmod.c:EXPORT_SYMBOL(call_usermodehelper);
./kernel/kmod.c:void __init usermodehelper_init(void)
./kernel/cpuset.c: * Note final arg to call_usermodehelper() is 0 - that means
./kernel/cpuset.c:      return call_usermodehelper(argv[0], argv, envp, 0);
./security/keys/request_key.c:  return call_usermodehelper(argv[0], argv, envp, 1);
./lib/kobject_uevent.c: retval = call_usermodehelper (argv[0], argv, envp, 0);
./lib/kobject_uevent.c:         pr_debug ("%s - call_usermodehelper returned %d\n",
./init/main.c:  usermodehelper_init();

Of course there will be indirect invocations (via kobjects, for
example), but I still think the number is not that great. I'm already
using the method I suggested in unreleased Suspend2 code, and the only
invocation I'm catch is at resume time, for the keseriod.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============94019557549106259==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94019557549106259==--
