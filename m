From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 22:23:17 +0100
Message-ID: <1132348998.2830.80.camel@laptopd505.fenrus.org>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
	 <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161221AbVKRVXa@vger.kernel.org>
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2005-11-18 at 19:36 +0000, Alan Cox wrote:
> On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
> > Just for info: If this goes in, Red Hat/Fedora kernels will fork
> > swsusp development, as this method just will not work there.
> > (We have a restricted /dev/mem that prevents writes to arbitary
> >  memory regions, as part of a patchset to prevent rootkits)
> 
> Perhaps it is trying to tell you that you should be using SELinux rules
> not kernel hacks for this purpose ?

actually no. SELinux can't work, we've looked at that bigtime. Basically
/dev/mem has 3 types in one, and to apply security you need different
roles for each in selinux. so the only option to apply selinux
*anything* is to first split /dev/mem up.

types:
1) accessing non-ram memory (eg PCI mmio space) by X and the likes
   (ideally should use sysfs but hey, changing X for this will take 
   forever)
2) accessing bios memory in the lower 1Gb for various emulation like
   purposes (including vbetool and X mode setting)
3) accessing things the kernel sees as RAM

they are very distinct security wise.
