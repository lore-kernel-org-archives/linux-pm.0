From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
Date: Wed, 30 Mar 2005 08:31:18 +1000
Message-ID: <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
References: <4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
	<d120d500050329130714e1daaf@mail.gmail.com>
	<20050329211239.GG8125@elf.ucw.cz>
	<d120d50005032913331be39802@mail.gmail.com>
	<20050329214408.GH8125@elf.ucw.cz>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43350215722039254=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329214408.GH8125-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

--===============43350215722039254==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Wed, 2005-03-30 at 07:44, Pavel Machek wrote:
> We currently freeze processes for suspend-to-ram, too. I guess that
> disable_usermodehelper is probably better and that in_suspend() should
> only be used for sanity checks... go with disable_usermodehelper and
> sorry for the noise.

Here's another possibility: Freeze the workqueue that
call_usermodehelper uses (remember that code I didn't push hard enough
to Andrew?), and let invocations of call_usermodehelper block in
TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on kernel
processes in that state. Of course if you won't want the freeze
processes for str, but do want to freeze call_usermodehelper, I guess
you'd still need the in_suspend() macro.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============43350215722039254==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43350215722039254==--
