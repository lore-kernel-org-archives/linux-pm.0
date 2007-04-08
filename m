From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: resume sometimes reboots or freezes Laptop,
	trying to debug
Date: Sun, 8 Apr 2007 18:28:27 +0200
Message-ID: <200704081828.27704.rjw@sisk.pl>
References: <1015f9200704071721y2599e571m6ef2a063478c2cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1015f9200704071721y2599e571m6ef2a063478c2cc6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 8 April 2007 02:21, Sascha Heid wrote:
> Hello List!
> =

> I have a pretty new Laptop with the following specs:
> =

> Lenovo X60T (Tablet)
> Core Duo
> SATA
> Intel GMA Videocard
> Gentoo-Linux running Kernel 2.6.20
> =

> The issue is that about 1 of 10 resumes from RAM do not work by either
> the Laptop rebooting or freezing.
> What makes it more frustrating is that it is completely unpredictable
> for me, sometimes i can resume 30 times in a row and when i start
> working on something it will crash on the next resume.
> =

> After trying different kernels and configurations im now down to a
> kernel with APIC and prefetching disabled and only 1 module in use
> (WLAN).
> I also tried both the suspend2ram that comes with the kernel and s2ram
> from suspend.sf.net, the result being the same.
> =

> I have pm-debugging and tracing enabled in the kernel but thats where im =
stuck.
> =

> Most of the times i get something like this:
> =

>  Magic number: 0:351:236
>  hash matches device ttyv6
> =

> with various terminals
> =

> and sometimes this
> =

>  Magic number: 0:798:378
>  hash matches drivers/base/power/resume.c:46
> =

> (no further line mentioning any device here)
> =

> To suspend the laptop i run this:
> =

> chvt 1
> echo 1 > /sys/power/pm_trace
> #/home/sascha/suspend-0.5/s2ram -f -a3
> echo mem > /sys/power/state
> setserial /dev/ttyS0 port 0x0200 irq 5 autoconfig
> chvt 7
> =

> I found 1 other Linux-user with a X60T that has the same (or more)
> suspend/resume issues using standard ubuntu and suse configurations.
> =

> If anyone has any idea or advice i would appreciate it very much.

Please try 2.6.21-rc6.  If it doesn't work, please file a bug report at bug=
zilla.kernel.org .

Greetings,
Rafael
