From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Subject: HCD polling root hub status before controller is brought
	out of suspend
Date: Thu, 4 Nov 2010 14:21:14 -0700
Message-ID: <AANLkTikiwJ1F5deXS9yrtW9-7QbhNZX00svPWe-ihXM_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1362298010884736253=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============1362298010884736253==
Content-Type: multipart/alternative; boundary=0016e6460746e8350a049440bc7f

--0016e6460746e8350a049440bc7f
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am running into a crash on 2.6.36-rc7 kernel when I am bringing ohci
controller out of suspend. Our suspend gates the clocks, so any access to
the ohci registers becomes a bus error.
I tracked the crash down to hcd polling function running off the timer. And
it happens _before_ pm core calls our ohci resume method.

#1  0x80310b84 in ohci_hub_status_data (hcd=<value optimized out>,
buf=<value optimized out>)
    at drivers/usb/host/ohci-hub.c:520
#2  0x802f11a0 in usb_hcd_poll_rh_status (hcd=<value optimized out>) at
drivers/usb/core/hcd.c:675
#3  0x8003faec in call_timer_fn (h=<value optimized out>) at
kernel/timer.c:1057
#4  __run_timers (h=<value optimized out>) at kernel/timer.c:1118
#5  run_timer_softirq (h=<value optimized out>) at kernel/timer.c:1297
#6  0x80038ff0 in __do_softirq () at kernel/softirq.c:219
#7  0x80039140 in do_softirq () at kernel/softirq.c:266
#8  0x800392d8 in irq_exit () at kernel/softirq.c:303
#9  0x8000c35c in plat_irq_dispatch (regs=<value optimized out>) at
arch/mips/brcmstb/irq.c:423
#10 0x80001784 in ret_from_exception () at arch/mips/kernel/entry.S:34

The simplest fix was to clear hcd->rh_pollable before going into suspend,
and restoring it after resume, but I am wondering if it is a known issue and
there is a better solution to the problem.

Thanks,
Maksim Rayskiy.

--0016e6460746e8350a049440bc7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I am running into a crash on 2.6.36-rc7 kernel when I am brin=
ging ohci controller out of suspend. Our suspend gates the clocks, so any a=
ccess to the ohci registers becomes a bus error. <br>I tracked the crash do=
wn to hcd polling function running off the timer. And it happens _before_ p=
m core calls our ohci resume method.<br>

<br>#1=A0 0x80310b84 in ohci_hub_status_data (hcd=3D&lt;value optimized out=
&gt;, buf=3D&lt;value optimized out&gt;)<br>=A0=A0=A0 at drivers/usb/host/o=
hci-hub.c:520<br>#2=A0 0x802f11a0 in usb_hcd_poll_rh_status (hcd=3D&lt;valu=
e optimized out&gt;) at drivers/usb/core/hcd.c:675<br>

#3=A0 0x8003faec in call_timer_fn (h=3D&lt;value optimized out&gt;) at kern=
el/timer.c:1057<br>#4=A0 __run_timers (h=3D&lt;value optimized out&gt;) at =
kernel/timer.c:1118<br>#5=A0 run_timer_softirq (h=3D&lt;value optimized out=
&gt;) at kernel/timer.c:1297<br>

#6=A0 0x80038ff0 in __do_softirq () at kernel/softirq.c:219<br>#7=A0 0x8003=
9140 in do_softirq () at kernel/softirq.c:266<br>#8=A0 0x800392d8 in irq_ex=
it () at kernel/softirq.c:303<br>#9=A0 0x8000c35c in plat_irq_dispatch (reg=
s=3D&lt;value optimized out&gt;) at arch/mips/brcmstb/irq.c:423<br>

#10 0x80001784 in ret_from_exception () at arch/mips/kernel/entry.S:34<br><=
br>The simplest fix was to clear hcd-&gt;rh_pollable before going into susp=
end, and restoring it after resume, but I am wondering if it is a known iss=
ue and there is a better solution to the problem.<br>

<br>Thanks,<br>Maksim Rayskiy.<br><br>

--0016e6460746e8350a049440bc7f--

--===============1362298010884736253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1362298010884736253==--
