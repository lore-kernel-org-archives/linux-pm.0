From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: Small pm documentation cleanups
Date: Thu, 07 Feb 2008 08:27:03 +1100
Message-ID: <47AA2627.4030509@nigel.suspend2.net>
References: <20080204234700.GA1912@elf.ucw.cz> <200802050224.51039.rjw@sisk.pl>	<47A7F581.8060300@nigel.suspend2.net> <20080205182712.GA9483@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759369AbYBFV1s@vger.kernel.org>
In-Reply-To: <20080205182712.GA9483@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi again.

Pavel Machek wrote:
> Hi!
> 
>>> On Tuesday, 5 of February 2008, Pavel Machek wrote:
>>>> Small documentation fixes/additions that accumulated in my tree.
>>>>
>>>> Signed-off-by: Pavel Machek <pavel@suse.cz>
>>> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>>>
> ...
>>>> 0
>>>>   	acpi_sleep=	[HW,ACPI] Sleep options
>>>> -			Format: { s3_bios, s3_mode }
>>>> -			See Documentation/power/video.txt
>>>> +			Format: { s3_bios, s3_mode, s3_beep }
>>>> +			See Documentation/power/video.txt for s3_bios and s3_mode.
>>>> +			s3_beep is for debugging; it beeps on PC speaker as soon as
>>>> +			kernel's real-mode entry point is called.
>> s/kernel's/the kernel's/
> 
> Thanks for comments, I applied them.

You're welcome. Sorry for replying again, but I just noticed another one 
in the line above - it should be something like "it makes the PC's 
speaker beep as soon as" ('on PC speaker' isn't right).

Sorry for not getting that last time.

Nigel
