From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 8 May 2015 12:36:02 -0400
Message-ID: <CAJvTdK=ok=xWR16R-3_+kpxujBSFOLqQ3DNNyFgE-Kc8en=PTg@mail.gmail.com>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<Pine.LNX.4.44L0.1505081026250.1219-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35449 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbEHQgE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 12:36:04 -0400
In-Reply-To: <Pine.LNX.4.44L0.1505081026250.1219-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, May 8, 2015 at 10:34 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 8 May 2015, Len Brown wrote:
>
>> From: Len Brown <len.brown@intel.com>
>>
>> Remove sys_sync() from the kernel's suspend flow.
>>
>> sys_sync() is extremely expensive in some configurations,
>> and so the kernel should not force users to pay this cost
>> on every suspend.
>>
>> The user-space utilities s2ram and s2disk choose to invoke sync() today.
>> A user can invoke suspend directly via /sys/power/state to skip that cost.
>
> I can understand the motivation for this, but is it aimed in the right
> direction?
>
> Consider a system where sys_sync() is very expensive.  Should such a
> system be using system suspend in the first place?  If there is a valid
> use case, why does the extra overhead of sys_sync() matter?

There are four significant issues with sys_sync() here:

1. It is not determinitic
    Some devices (and their caches) are quick  on the 1st sync,
    and then slow on the 2nd sync etc.

2. worst case latency is obscene, there are examples of some
    syncs which take over 3,000 ms to complete.

3. It doesn't necessarily deliver on the assumed benefits.
    Rafael tells me that it depends on the file system
    exactly what sync does.  Look no further than the fact
    that for two sync's in a row, the 2nd one may be slower.

4. Whether to sync or not is a policy choice, and that choice
    should be made by the user, not the kernel.  Many systems today
    want to wake for a packet, process that packet, and get back
    to sleep as fast as possible.  Jamming a sys_sync() in their
    wake doesn't make sense.

> To put it another way, if the system wants to go into a low-latency
> suspend state, why doesn't it use an extreme version of runtime suspend
> rather than system suspend?

There are systems where systems suspend is FAST, except for the sync.
I can e-mail you the analyze_suspend output for such a system.

> This reminds me of the discussions we had with the Android developers
> when they proposed adding wakelocks to the kernel -- they needed them
> so that they could support system suspend when what they really wanted
> to do was an extreme version of runtime suspend.  But generally
> speaking, sys_sync() is not tremendously expensive on devices running
> Android.

Unfortunately, sys_sync() can be a significant pain point,
even for systems that run Android.

Len Brown, Intel Open Source Technology Center
