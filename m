From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 20:18:21 -0800
Message-ID: <200511182018.22060.jbarnes@virtuousgeek.org>
References: <20051115212942.GA9828@elf.ucw.cz> <1132348998.2830.80.camel@laptopd505.fenrus.org> <1132351635.5238.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750932AbVKSFyR@vger.kernel.org>
In-Reply-To: <1132351635.5238.12.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, November 18, 2005 2:07 pm, Alan Cox wrote:
> On Gwe, 2005-11-18 at 22:23 +0100, Arjan van de Ven wrote:
> > 1) accessing non-ram memory (eg PCI mmio space) by X and the likes
> >    (ideally should use sysfs but hey, changing X for this will take
> >    forever)
>
> Once sysfs supports the relevant capabilities fixing X actually
> doesn't look too horrible, the PCI mapping routines are abstracted
> and done by PCITAG (ie PCI device). You would need the ISA hole too
> in some cases.

It's actually partly done already (at least for ia64, but the code I put 
together works on x86 too, iirc, and should work elsewhere).  The ISA 
stuff is exported on a per-bus basis in legacy_io and legacy_mem files.

If vbetool and friends want to get at the ROM, they can use the sysfs 
rom file like everyone else.  There are problems with this however, on 
systems where the ROM is unpacked at 0xc0000 or something, especially 
if the unpacked version is modified by the BIOS at startup time, not 
sure how to address that reliably.

Jesse
