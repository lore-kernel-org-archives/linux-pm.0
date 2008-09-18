From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Thu, 18 Sep 2008 17:14:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809181708500.17483-100000__15201.6044281938$1221772811$gmane$org@iolanthe.rowland.org>
References: <48D1346C.1020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48D1346C.1020203@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Sep 2008, Jiri Slaby wrote:

> Hi,
> 
> I've found suspend on my desktop defunct in mmotm 2008-09-13-03-09 (opposing to
> 2008-09-10-19-39).
> 
> Dmesg says:
> 
> uhci_hcd 0000:00:1d.1: PCI INT B disabled
> pci_legacy_suspend(): usb_hcd_pci_suspend+0x0/0x3e0 returns -16
> pm_op(): pci_pm_suspend+0x0/0xd0 returns -16
> PM: Device 0000:00:1d.0 failed to suspend: error -16
> PM: Some devices failed to suspend

The reason for this error is that the root hub wasn't already 
suspended.  Was there a USB device plugged into that controller?

Two days ago I ran 2.6.27-rc6 plus gregkh-all-2.6.27-rc6.patch from

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/

on my laptop, and it suspended with no problem.  Can you try the same 
kernel?

If you still run into problems, post more of the dmesg log (with 
CONFIG_USB_DEBUG enabled, of course!).

Alan Stern
