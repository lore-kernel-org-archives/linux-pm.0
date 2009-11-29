From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] thawing from suspend hangs
Date: Sun, 29 Nov 2009 01:27:31 +0100
Message-ID: <200911290127.31841.rjw__6548.03181901133$1259454546$gmane$org@sisk.pl>
References: <175969118.224053.1259409540698.JavaMail.open-xchange@ox2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175969118.224053.1259409540698.JavaMail.open-xchange@ox2>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "pm@smely.org" <pm@smely.org>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 28 November 2009, pm@smely.org wrote:
> hello suspenders,
> 
> i'm running suse 11.2. hibernation has been working perfectly on my machine
> since 10.2 up to 11.2rc2. when i installed the final 11.2, resume is hanging my
> machine on switching to X. (keyboard dead) suspending from/ resuming to
> text-mode is no problem.

Well, please file a bug report against openSUSE 11.2 at bugzilla.novell.com and
tell me the bug numer.

> chlnx2:~/Documents # s2ram -n
> Machine unknown
> This machine can be identified by:
>     sys_vendor   = "Gigabyte Technology Co., Ltd."
>     sys_product  = "M56S-S3"
>     sys_version  = " "
>     bios_version = "F3"
> See http://en.opensuse.org/S2ram for details.
> 
> Linux chlnx2 2.6.31.5-0.1-desktop #1 SMP PREEMPT 2009-10-26 15:49:03 +0100
> x86_64 x86_64 x86_64 GNU/Linux
> 
> in /etc/pm/config.d/myconfig i tried
> S2RAM_OPTS="{all of the ones from the list in http://en.opensuse.org/S2ram}"
> it showed an effect, but none helped
> 
> additionaly, i tried in /etc/sysconfig/videobios
> VIDEOBIOS_PARAMETERS="3c 1280 1024"
> (interesting in this context: setting VIDEOBIOS_PATCH=yes here would start the
> script /etc/init.d/boot.videobios from /usr/lib/pm-utils/sleep.d/80videobios;
> but on my 11.2, there is no such file /etc/init.d/boot.videobios)
> 
> changing "vga=0x31a" to "vga=0" in /boot/grub/menu.lst seems to change only the
> display-mode during the boot and the splash-sequence, and thus making no
> difference.
> 
> 
> i spent already hours reading through blogs (which are so far terribly poor on
> this issue), trying various settings and rebooting my system, none of which
> worked. it's really a pity that i believed the promise, that only urgent bugs
> will be fixed going from rc2 to final. this one is clearly not a bugfix, or, if
> you want, is exactly the opposite ... i'm frustrated. even more, because under
> the new kde4, many tools do no save their state properly on logout.

Do you use the radeon X driver by chance?

Rafael
