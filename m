From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Thu, 27 Apr 2006 02:22:05 +1000
Message-ID: <444F9E2D.2000901@yahoo.com.au>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl> <444ED9EB.5060205@yahoo.com.au> <200604261341.32500.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932141AbWDZUpY@vger.kernel.org>
In-Reply-To: <200604261341.32500.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Nigel,
thanks

Nigel Cunningham wrote:
> Hi Nick.
> 
> On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> 
>>Rafael J. Wysocki wrote:
>>
>>>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
>>>except for the pages mapped by the current task, without copying.  I think
>>>we can try to do this, but we'll need a patch to freeze bdevs for this
>>>purpose. ;-)
>>
>>Why not the current task? Does it exit the kernel? Or go through some
>>get_uesr_pages path?
> 
> 
> I think Rafael is asleep at the mo, so I'll answer for him - he's wanting it 
> to be compatible with using userspace to control what happens (uswsusp). In 
> that case, current will be the userspace program that's calling the ioctls to 
> get processes frozen etc.

OK, so what happens if, upon exit from kernel, that userspace task
subsequently changes some pagecache but doesn't have that mapped? Or
mmaps something then changes it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
