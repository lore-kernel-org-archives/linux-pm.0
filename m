From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 20:54:52 +0200
Message-ID: <48DA8CFC.9020304__28535.0864789963$1222282759$gmane$org@gmail.com>
References: <48DA64FC.4020706@gmail.com>
	<Pine.LNX.4.44L0.0809241229070.5963-100000@iolanthe.rowland.org>
	<20080924181403.GA6336@kroah.com> <48DA84C9.3010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DA84C9.3010707@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 09/24/2008 08:19 PM, Jiri Slaby wrote:
> I see, I need to boot to that kernel anyway, with dynamic_printk param this time.

It didn't work as I expected, nevermind, here comes updated dmesg:
http://decibel.fi.muni.cz/~xslaby/dmesg_fail.hcd

I seem to overlooked the pci identification before. There are my mouse and kbd
connected to that hub behind another hub.
Attaching lsusb -tv again:
/:  Bus 08.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 07.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/3p, 12M
        |__ Port 1: Dev 3, If 0, Class=HID, Driver=usbhid, 12M
        |__ Port 1: Dev 3, If 1, Class=HID, Driver=usbhid, 12M
        |__ Port 2: Dev 4, If 0, Class=HID, Driver=usbhid, 1.5M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M
Full lsusb -vvv version at:
http://decibel.fi.muni.cz/~xslaby/lsusb.hcd
