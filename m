From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 23:34:14 +0000
Message-ID: <20051118233413.GC2359@spitz.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751182AbVKRXjh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Even it were not for this, the whole idea seems misconcieved to me
> > anyway.
> 
> I'm sceptical too but several Win9x BIOS vendor suspend paths were
> implemented in roughly this way. I don't however see how you can
> co-ordinate the freeze with outstanding O_DIRECT DMA to user pages for
> one item.

I do not see a problem. swsusp process stops all other processes, freezes
the drivers, then asks for system snapshot. It certainly does *not* ask for
O_DIRECT........

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
