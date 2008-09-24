From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 18:04:12 +0200
Message-ID: <48DA64FC.4020706__6653.28652035004$1222276757$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0809241047500.2650-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0809241047500.2650-100000@iolanthe.rowland.org>
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

On 09/24/2008 04:49 PM, Alan Stern wrote:
> On Wed, 24 Sep 2008, Jiri Slaby wrote:
> 
>>>> pm_op(): pci_pm_suspend+0x0/0xd0 returns -16
>>>> PM: Device 0000:00:1d.0 failed to suspend: error -16
>>>> PM: Some devices failed to suspend
>>> The reason for this error is that the root hub wasn't already 
>>> suspended.  Was there a USB device plugged into that controller?
>> No:
> 
>>> If you still run into problems, post more of the dmesg log (with 
>>> CONFIG_USB_DEBUG enabled, of course!).
>> Hm, it doesn't work. 2 dmesgs from mmotm 2008-09-10-19-39 (without usb debug)
>> [ok] and -rc6+gkh-all (with usb debug) [fail]:
>> http://decibel.fi.muni.cz/~xslaby/dmesg_fail.hcd
>> http://decibel.fi.muni.cz/~xslaby/dmesg_ok.hcd
> 
> In fact neither of those logs includes USB debugging messages.  Maybe
> you omitted a mkinitrd step.

I don't think so. I don't use neither vanilla nor initrd so this must be the
kernel. Anyway I recompiled with .config linked in and did
# dmesg >dmesg_config.hcd
# zcat /proc/config.gz >>dmesg_config.hcd
in the built kernel. The file is here:
http://decibel.fi.muni.cz/~xslaby/dmesg_config.hcd
