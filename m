From: miniBill <cmt.minibill@gmail.com>
Subject: Suspend to ram not working
Date: Mon, 12 Oct 2009 21:28:34 +0200
Message-ID: <ef885c730910121228s4dc8a65ak5f0d5fafdc1bd497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Here I paste the discussion I had on the "wrong" mailing list.
The problem is the same with s2ram and pm-suspend
Below you'll find details on the problem and on the computer hw

2009/10/12 Pavel Machek <pavel@ucw.cz>:
> On Mon 2009-10-12 19:33:00, miniBill wrote:
>> 2009/10/12 Pavel Machek <pavel@ucw.cz>:
>> > On Sun 2009-10-11 12:36:06, miniBill wrote:
>> >> 2009/10/10 Pavel Machek <pavel@ucw.cz>:
>> >> > On Thu 2009-10-01 23:26:25, miniBill wrote:
>> >> >> s2ram is not working for me: computer keeps resuming just after standby.
>> >> >> when i use hibernate/turn it off I can then put it into standby once,
>> >> >> then it start auto-resuming
>> >> >> it resumes and doesn't hang so it only takes me a couple of seconds to
>> >> >> test something, and I can do it with jabber working
>> >> >
>> >> > Which kernel/what hardware? Can you report on linux-pm?
>> >> >
>> >> leonardo@debian:~$ uname -a
>> >> Linux debian 2.6.30-choam #1 SMP PREEMPT Mon Sep 28 21:18:24 CEST 2009
>> >> i686 GNU/Linux
>> >> leonardo@debian:~$ lsusb
>> >> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> >> Bus 003 Device 003: ID 093a:2510 Pixart Imaging, Inc. Hama Optical Mouse
>> >> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> >> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> >> Bus 001 Device 003: ID 04f2:b071 Chicony Electronics Co., Ltd 2.0M UVC
>> >> Webcam / CNF7129
>> >> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> >> debian:/home/leonardo# lspci
>> >> 00:00.0 Host bridge: nVidia Corporation MCP79 Host Bridge (rev b1)
>> >> 00:00.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
>> >> 00:03.0 ISA bridge: nVidia Corporation MCP79 LPC Bridge (rev b2)
>> >> 00:03.1 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
>> >> 00:03.2 SMBus: nVidia Corporation MCP79 SMBus (rev b1)
>> >> 00:03.3 RAM memory: nVidia Corporation MCP79 Memory Controller (rev b1)
>> >> 00:03.5 Co-processor: nVidia Corporation MCP79 Co-processor (rev b1)
>> >> 00:04.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1
>> >> Controller (rev b1)
>> >> 00:04.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0
>> >> Controller (rev b1)
>> >> 00:06.0 USB Controller: nVidia Corporation MCP79 OHCI USB 1.1
>> >> Controller (rev b1)
>> >> 00:06.1 USB Controller: nVidia Corporation MCP79 EHCI USB 2.0
>> >> Controller (rev b1)
>> >> 00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio (rev b1)
>> >> 00:09.0 PCI bridge: nVidia Corporation MCP79 PCI Bridge (rev b1)
>> >> 00:0b.0 SATA controller: nVidia Corporation MCP79 AHCI Controller (rev b1)
>> >> 00:0c.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1)
>> >> 00:15.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1)
>> >> 00:16.0 PCI bridge: nVidia Corporation MCP79 PCI Express Bridge (rev b1)
>> >> 02:00.0 VGA compatible controller: nVidia Corporation G96M [GeForce GT
>> >> 120M] (rev a1)
>> >> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>> >> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
>> >> 04:00.0 Network controller: Atheros Communications Inc. AR9285
>> >> Wireless Network Adapter (PCI-Express) (rev 01)
>> >> debian:/home/leonardo# pm-is-supported --suspend && echo "tau"
>> >> tau
>> >> debian:/home/leonardo# dpkg-query  -s pm-utils
>> >> Package: pm-utils
>> >> Status: install ok installed
>> >> ...
>> >> Architecture: all
>> >> Version: 1.2.5-4
>> >> ...
>> >> debian:/home/leonardo# dpkg-query  -s uswsusp
>> >> Package: uswsusp
>> >> Status: install ok installed
>> >> ...
>> >> Architecture: i386
>> >> Source: uswsusp (0.8-1.1)
>> >> Version: 0.8-1.1+b1
>> >> ...
>> >> debian:/home/leonardo# s2ram -n
>> >> Machine unknown
>> >> This machine can be identified by:
>> >>     sys_vendor   = "ASUSTeK Computer Inc. "
>> >>     sys_product  = "K70IO               "
>> >>     sys_version  = "1.0       "
>> >>     bios_version = "209    "
>> >> See http://suspend.sf.net/s2ram-support.html for details.
>> >>
>> >> If you report a problem, please include the complete output above.
>> >>
>> >> Here you are. Need more info?
>> >
>> > Any proprietary modules?
>> >
>> > Good report, try sending it to linux-pm ...
>> >
>> I'm only using nvidia module, version 185.18.36, downloaded from the
>> official website.
>> what's the address of the linux-pm list?
>
> Linux-pm mailing list <linux-pm@lists.osdl.org>
>
> ...but you really need to reproduce w/o nvidia module, first.
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
w/o nvidia module the screen doesn't power on resume, backlight stays down
anyway, I'm gonna copy this to linux-pm list
