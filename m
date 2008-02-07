From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 07 Feb 2008 14:46:25 -0800
Message-ID: <47AB8A41.3040008@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757855AbYBGWrW@vger.kernel.org>
In-Reply-To: <20080207222845.GA6096@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> 
> This is probably more acceptable version of beep; but there are
> probably even better ways to clean it...
> 
>         if (wakeup_header.realmode_flags & 4) {
>                 inb(97);
>                 outb(0, 0x80);
>                 outb(3, 97);
>                 outb(0, 0x80);
>                 outb(-74, 67);
>                 outb(0, 0x80);
>                 outb(-119, 66);
>                 outb(0, 0x80);
>                 outb(15, 66);
>         }
> 

What is available at this point -- are BIOS calls still accessible; are 
interrupts running?

	-hpa
