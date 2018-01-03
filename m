From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RESEND PATCH 2/8] turbostat: Fix node and siblings lookup data
Date: Wed, 3 Jan 2018 07:58:43 -0500
Message-ID: <90ece10d-3b68-8d77-89af-b060ba8ba20e@redhat.com>
References: <20171103122550.13341-1-prarit@redhat.com>
 <20171103122550.13341-3-prarit@redhat.com>
 <CAJvTdK=-pH_XTS5dNsgz+MEhqN-mYOwQaHOs_Qc+58+KpEp4Zw@mail.gmail.com>
 <0e6f30bf-8dad-a8a1-612c-6b39fcbf5e1c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeACM6o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jan 2018 07:58:44 -0500
In-Reply-To: <0e6f30bf-8dad-a8a1-612c-6b39fcbf5e1c@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, charles.rose@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, suravee.suthikulpanit@amd.com



On 12/09/2017 06:25 AM, Prarit Bhargava wrote:
> 
> 
> On 12/08/2017 05:47 PM, Len Brown wrote:
>> This patch causes a core dump:
>>
>> turbostat: malloc.c:2394: sysmalloc: Assertion `(old_top ==
>> initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >=
>> MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end &
>> (pagesize - 1)) == 0)' failed.
>>
>> Aborted (core dumped)
>>
> 
> Odd.  I ran this on Intel Haswell and up ... what system did you run this on?

ping?  Len?

P.

> 
> P.
> 
