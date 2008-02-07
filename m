From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 7 Feb 2008 23:49:08 +0100
Message-ID: <20080207224908.GD6096@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz> <200802072340.06138.rjw@sisk.pl> <47AB8A0F.9@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934031AbYBGWtF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47AB8A0F.9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-07 14:45:35, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
>
>>  ENTRY(wakeup_long64)
>>  wakeup_long64:
>> -	movq    saved_magic, %rax
>> -	movq    $0x123456789abcdef0, %rdx
>> -	cmpq    %rdx, %rax
>> -	jne     bogus_64_magic
>> +	movq	saved_magic, %rax
>> +	movq	$0x123456789abcdef0, %rdx
>> +	cmpq	%rdx, %rax
>> +	jne	bogus_64_magic
>
> A random magic is probably more likely to be unique than something like 
> that.

This is already "unlikely enough", I'd say. It does not look like a
pointer, and it is long enough.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
