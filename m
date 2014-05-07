From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: pm_runtime_barrier breaks autosuspend
Date: Wed, 7 May 2014 16:45:30 -0700
Message-ID: <CAPcyv4j7riP70DFrBbU66vW0b5B+F5UTEq8O_6ymS5HGgnb4TA@mail.gmail.com>
References: <CAPcyv4h9prfrxmEvVamzCaT9Hc91WR90VO6k2PQa9RkSinAvuA@mail.gmail.com>
	<Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
	<CAPcyv4hf2hQGEsZXtFJiVa0GC-7A6RpKUDOTY6C7xkpDEaezRA@mail.gmail.com>
	<6921768.5dEhd41WuE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:34900 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaEGXpb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 19:45:31 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so2275972veb.37
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2014 16:45:30 -0700 (PDT)
In-Reply-To: <6921768.5dEhd41WuE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, May 7, 2014 at 4:58 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 07, 2014 08:50:28 AM Dan Williams wrote:
>> On Wed, May 7, 2014 at 8:21 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Tue, 6 May 2014, Dan Williams wrote:
>> >
>> >> > Why didn't pm_request_resume() result in an autosuspend?
>> >>
>> >> Found it.
>> >>
>> >> The last thing pm_runtime_barrier() does is pm_runtime_put_noidle()
>> >> which may cause the autosuspend timer to never be reset.
>> >
>> > Rafael, this seems like a bug.  Should pm_runtime_barrier() be changed
>> > so that just before the spinlock is released, we queue an autosuspend
>> > request if dev->power.use_autosuspend is set and all the other
>> > conditions are met?
>>
>> ...or at least rename it to pm_runtime_barrier_noidle()?  I.e. make it
>> clear that it needs to be wrapped by get / put, or an explicit suspend
>> request queued afterwards.
>
> Can you please point me to the piece of code where the problem happens?
>

I discovered it in a patch set re-working usb port power management.
I can point you at a git tree after I post the next revision of the
patch set.  But, in the meantime I'll add you to the cc for the patch
that works around this behavior in pm_runtime_barrier().

--
Dan
