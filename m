From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Re: [rft] s2ram wakeup moves to .c, could fix few
	machines
Date: Fri, 8 Feb 2008 22:31:01 +0100
Message-ID: <20080208213101.GE12923@elf.ucw.cz>
References: <20080208210004.GA12923@elf.ucw.cz> <Pine.LNX.4.44L0.0802081617280.5958-100000@iolanthe.rowland.org> <20080208212317.GD12923@elf.ucw.cz> <47ACC942.1020308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760304AbYBHVbM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47ACC942.1020308@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-02-08 13:27:30, H. Peter Anvin wrote:
> Pavel Machek wrote:
>>
>> See arch/x86/kernel/acpi/realmode/wakeup.S (the version that was sent
>> to the list). No problem there, but table stored at nonzero
>> offset. Short jump at the beggining of table would fix it (ugly).
>>
>
> Ugly, but it's the standard way to deal.  We have it in the bzImage format, 
> too.

I'd prefer to keep it as it is, there are no problems.

This way, we can put debugging instructions at the first byte of
wakeup code, which is somehow important.

Plus, with right #defines, it should be clean enough.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
