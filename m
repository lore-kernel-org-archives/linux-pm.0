From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: Can't s2ram 22-rc2 [Was: 2.6.22-rc2 BUG: at
	slub_def.h:77]
Date: Mon, 21 May 2007 11:55:52 +0200
Message-ID: <1179741352.4980.11.camel__26418.3062165559$1179741440$gmane$org@localhost>
References: <1179728579.11803.1.camel@localhost>
	<465153AF.5030008@gmail.com> <1179736498.4980.1.camel@localhost>
	<46515A7D.20003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46515A7D.20003@gmail.com>
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
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-21 at 10:38 +0200, Jiri Slaby wrote:
> Played with Cc list.
> 
> Soeren Sonnenburg napsal(a):
> > On Mon, 2007-05-21 at 10:09 +0200, Jiri Slaby wrote:
> >> Soeren Sonnenburg napsal(a):
> >>> a regression (well I switched to slub) happens on boot...
> > 
> >>> BUG: at include/linux/slub_def.h:77 kmalloc_index()
> >>>  [<c0176448>] get_slab+0x1c8/0x250
> > [...]
> >> Could you try this patch:
> >> http://lkml.org/lkml/2007/5/19/171
> > 
> > yes, that does fix the issue (at least I don't see the BUG: anymore on
> > boot). however I can no longer s2ram on 22rc2. 
> 
> Whit what kind of error or what happens?

pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x170() returns -16
suspend_device(): pci_device_suspend+0x0/0x60() returns -16
Could not suspend device 0000:00:1d.0: error -16

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)

lspci/dmesg are in this mail:
http://marc.info/?l=linux-kernel&m=117973679209855&w=2

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
