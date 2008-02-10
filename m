From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Sun, 10 Feb 2008 22:14:57 +0100
Message-ID: <20080210211457.GJ15662@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802082301.51582.rjw@sisk.pl> <20080208220834.GA1631@elf.ucw.cz> <200802090118.50418.rjw@sisk.pl> <47ACF488.7070502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757397AbYBJVOz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47ACF488.7070502@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-02-08 16:32:08, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
>>
>> Consolidated patch is appended.  I'll test it tomorrow on x86-64.
>>
>> I'd like to add the cleaned up beeping code to it and perhaps try to push it
>> for -mm testing without any further changes.  We can still do more cleanups in
>> followup patches.
>>
>
> The other thing to figure out is to what extent we can clean up the 
> conditionals in the video mode code by refactoring.  All they really do 
> here is save space by removing functionality not needed for wakeup, because 
> I didn't know how much space was realistic.
>
> It's possible we can remove them altogether by having a dummy boot_params 
> structure (4K).

I'd say that few #ifdefs are acceptable if we save 4K, but...

Sam... is there something that urgently needs fixing?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
