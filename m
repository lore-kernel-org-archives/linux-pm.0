From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Wed, 6 Feb 2008 12:29:26 +0100
Message-ID: <20080206112926.GB8070@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <47A90F23.80009@zytor.com> <200802060242.15097.rjw@sisk.pl> <47A9129A.7050706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762204AbYBFL3W@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47A9129A.7050706@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-02-05 17:51:22, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
>>> The asm() for making beeps really need to be moved to a function and 
>>> cleaned up (redone in C using inb()/outb()) if they are to be retained at 
>>> all.
>>
>> Yes, they are.  For some people they're the only tool to debug broken resume.
>
> That's fine, but they should get cleaned up.
>
> /me is tempted to provide a version which can send messages in Morse Code ;)

Actually, it would probably be accepted. Debugging early resume is
evil enough that any help is welcome.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
