From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:34:40 +0100
Message-ID: <20080208213440.GG12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222833.GA23004@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760651AbYBHVes@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080207222833.GA23004@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> And for good measure name it wakeup.lds.
> 
> Do we never need data from a .h file?
> If we do name it wakeup.lds.S and kbuild
> will fix it (assuming we have wakeup.lds
> as a prerequisite where it is needed.

This does not work for me. gas (or someone?) puts # comments on the
beggining of wakeup.lds, and I get compile failure. Yes, I'd like to
have it preprocessed.

# 1 "/data/l/linux/arch/x86/kernel/acpi/realmode/wakeup.lds.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "./include/linux/autoconf.h" 1
# 1 "<command line>" 2
# 1 "/data/l/linux/arch/x86/kernel/acpi/realmode/wakeup.lds.S"





OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(1)
ENTRY(_start)
....

ld:arch/x86/kernel/acpi/realmode/wakeup.lds:1: ignoring invalid
character `#' in expression
ld:arch/x86/kernel/acpi/realmode/wakeup.lds:1: syntax error


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
