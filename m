From: Pavel Machek <pavel@ucw.cz>
Subject: Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:59:27 +0100
Message-ID: <20080203235927.GK2799@elf.ucw.cz>
References: <20080130120111.GB22820@elf.ucw.cz> <200802040020.14836.rjw@sisk.pl> <20080203233313.GF2799@elf.ucw.cz> <200802040054.43863.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755230AbYBCX7X@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802040054.43863.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> BTW, I don't like the way in which the 'struct wakeup_header' fields are
> reproduced in rm/wakeup.S very much, because it makes the code fragile.
> It might be better to define the offsets in asm-offsets*.c and refer to them
> relative to wakeup_header (if possible).

If you can do that.. yes, that would be nice. I triple-checked it, but
indeed is fragile.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
