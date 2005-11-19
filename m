From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Sat, 19 Nov 2005 09:44:25 +0100
Message-ID: <1132389865.2829.2.camel@laptopd505.fenrus.org>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
	 <1132342590.25914.86.camel@localhost.localdomain>
	 <1132348998.2830.80.camel@laptopd505.fenrus.org>
	 <1132351635.5238.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750973AbVKSIoh@vger.kernel.org>
In-Reply-To: <1132351635.5238.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2005-11-18 at 22:07 +0000, Alan Cox wrote:
> On Gwe, 2005-11-18 at 22:23 +0100, Arjan van de Ven wrote:
> > 1) accessing non-ram memory (eg PCI mmio space) by X and the likes
> >    (ideally should use sysfs but hey, changing X for this will take 
> >    forever)
> 
> Once sysfs supports the relevant capabilities fixing X actually doesn't
> look too horrible

I think the kernel already supports this since at least july if not
earlier. If there's something missing... someone needs to speak up..

(yes vga arbitrage is missing but well that's not there today by any
means either so not a regression)

> , the PCI mapping routines are abstracted and done by
> PCITAG (ie PCI device). You would need the ISA hole too in some cases.

this may need /dev/mem a bit longer, but hopefully is rarer. Once the
pci side is fixed I bet this only is easy to do as well
