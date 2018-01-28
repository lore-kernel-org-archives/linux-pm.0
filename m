From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RESEND PATCH 2/8] turbostat: Fix node and siblings lookup data
Date: Sun, 28 Jan 2018 18:16:26 -0500
Message-ID: <93d04e2f-a552-43a4-c13a-583296483ab8@redhat.com>
References: <20171103122550.13341-1-prarit@redhat.com>
 <20171103122550.13341-3-prarit@redhat.com>
 <CAJvTdK=-pH_XTS5dNsgz+MEhqN-mYOwQaHOs_Qc+58+KpEp4Zw@mail.gmail.com>
 <0e6f30bf-8dad-a8a1-612c-6b39fcbf5e1c@redhat.com>
 <90ece10d-3b68-8d77-89af-b060ba8ba20e@redhat.com>
 <CAJvTdKmdNic5T-JTgN0L7U12OvQr8rPEKjz7eDM7ToK1b_0=hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754286AbeA1XQ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Jan 2018 18:16:28 -0500
In-Reply-To: <CAJvTdKmdNic5T-JTgN0L7U12OvQr8rPEKjz7eDM7ToK1b_0=hg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, charles.rose@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, suravee.suthikulpanit@amd.com



On 01/28/2018 12:43 PM, Len Brown wrote:
>>>> This patch causes a core dump:
>>>>
>>>> turbostat: malloc.c:2394: sysmalloc: Assertion `(old_top ==
>>>> initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >=
>>>> MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end &
>>>> (pagesize - 1)) == 0)' failed.
>>>>
>>>> Aborted (core dumped)
>>>>
>>>
>>> Odd.  I ran this on Intel Haswell and up ... what system did you run this on?
> 
> my laptop.
> 
> Let me take a closer look at this...
> 
> I may have a patch for you to test on an AMD system for me, can you do that?
> I'll be putting the latest on my kernel.og turbostat branch.

Sure ... let me know when it's ready.

P.

> 
> thanks,
> -Len
> 
