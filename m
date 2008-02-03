From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: wakeup code translated to .c
Date: Sun, 03 Feb 2008 12:02:30 -0800
Message-ID: <47A61DD6.7040502@zytor.com>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz> <20080203184931.GA2648@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753465AbYBCUD0@vger.kernel.org>
In-Reply-To: <20080203184931.GA2648@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Feb 03, 2008 at 07:16:48PM +0100, Pavel Machek wrote:
>> Hi!
>>
>>>> This version works on 32-bit, and builds on 64-bit (but I'm pretty
>>>> sure it does not work. 32-bit code probably needs to go into rm/....)
>>>>
>>> Do you have an updated version or is this the latest one?
>> I'm glad you ask ;-). Here's reasonably-recent version (I have
>> slightly cleaner one, but it got obscured by 2.6.24-git merge), I
>> eventually got it to work on 64-bit, by reusing trampoline.S code.
>>
>> 								Pavel
>> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> Hi PAvel.
> 
> Before you submit this for real we need me to take a deper
> look into your Makefiles.
> We do not want this duplication between boot and acpi.
> And the way you deal with code sharing from boot/ is not
> OK either.
> 
> But I do have a few other things pending before I have time
> so please ping me in a week or two.
> 

Don't blame Pavel for that.  That has a quick hack I threw together to 
give him something at all to work with.

	-hpa
