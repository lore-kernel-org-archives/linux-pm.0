From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 12:55:33 +0200
Message-ID: <48DA1CA5.20409__28600.3332621933$1222253993$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0809181708500.17483-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0809181708500.17483-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 09/18/2008 11:14 PM, Alan Stern wrote:
> On Wed, 17 Sep 2008, Jiri Slaby wrote:
>> I've found suspend on my desktop defunct in mmotm 2008-09-13-03-09 (opposing to
>> 2008-09-10-19-39).
>>
>> Dmesg says:
>>
>> uhci_hcd 0000:00:1d.1: PCI INT B disabled
>> pci_legacy_suspend(): usb_hcd_pci_suspend+0x0/0x3e0 returns -16
>> pm_op(): pci_pm_suspend+0x0/0xd0 returns -16
>> PM: Device 0000:00:1d.0 failed to suspend: error -16
>> PM: Some devices failed to suspend
> 
> The reason for this error is that the root hub wasn't already 
> suspended.  Was there a USB device plugged into that controller?

No:
/:  Bus 08.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
/:  Bus 07.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M <----
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


> Two days ago I ran 2.6.27-rc6 plus gregkh-all-2.6.27-rc6.patch from
> 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
> 
> on my laptop, and it suspended with no problem.  Can you try the same 
> kernel?
> 
> If you still run into problems, post more of the dmesg log (with 
> CONFIG_USB_DEBUG enabled, of course!).

Hm, it doesn't work. 2 dmesgs from mmotm 2008-09-10-19-39 (without usb debug)
[ok] and -rc6+gkh-all (with usb debug) [fail]:
http://decibel.fi.muni.cz/~xslaby/dmesg_fail.hcd
http://decibel.fi.muni.cz/~xslaby/dmesg_ok.hcd
