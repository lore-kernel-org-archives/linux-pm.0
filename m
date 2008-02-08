From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 07 Feb 2008 23:40:47 -0800
Message-ID: <47AC077F.1010809@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <47AB887E.7010000@zytor.com> <200802080006.54151.rjw@sisk.pl> <20080207233509.GB21468@elf.ucw.cz> <47AB975C.1010902@zytor.com> <20080208070419.GA4544@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934664AbYBHHlm@vger.kernel.org>
In-Reply-To: <20080208070419.GA4544@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> I really need the entry point to be at offset 0, so 
>>> that I can get
>>> pointers to my data. I could not figure out how to do 
>>> it any other
>>> way. And if 0 is taken, I thought I'd put header at the 
>>> end.
>>>
>> Why not just put the structure at 0, and put pointers in 
>> the structure to everything else you need?
> 
> segments:offsets rear its ugly head here. I need %ds to point to my
> data, and the way to do it is copy it from %cs; that needs start to be
> at 0.
> 
> If you can find a solution that does not need this (some
> segment/offset arithmetics at beggining of wakeup?) we could use it,
> but I was lost between relocations.
> 

Let me look at it in the morning.  Got a specific pointer?

	-hpa
