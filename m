From: Pavel Machek <pavel@ucw.cz>
Subject: Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:58:29 +0100
Message-ID: <20080203235829.GJ2799@elf.ucw.cz>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz> <200802032333.02821.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755292AbYBCX6U@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802032333.02821.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

> it looks okay
> (from a very high orbit).

It should look better from closer look. Reusing trampoline_64.S
instead of cut&copy&paste gets us rid of some really nasty assembly
;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
