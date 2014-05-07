From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: pm_runtime_barrier breaks autosuspend
Date: Wed, 7 May 2014 08:50:28 -0700
Message-ID: <CAPcyv4hf2hQGEsZXtFJiVa0GC-7A6RpKUDOTY6C7xkpDEaezRA@mail.gmail.com>
References: <CAPcyv4h9prfrxmEvVamzCaT9Hc91WR90VO6k2PQa9RkSinAvuA@mail.gmail.com>
	<Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:39028 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625AbaEGPu3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 11:50:29 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so1504823veb.40
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2014 08:50:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, May 7, 2014 at 8:21 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 6 May 2014, Dan Williams wrote:
>
>> > Why didn't pm_request_resume() result in an autosuspend?
>>
>> Found it.
>>
>> The last thing pm_runtime_barrier() does is pm_runtime_put_noidle()
>> which may cause the autosuspend timer to never be reset.
>
> Rafael, this seems like a bug.  Should pm_runtime_barrier() be changed
> so that just before the spinlock is released, we queue an autosuspend
> request if dev->power.use_autosuspend is set and all the other
> conditions are met?

...or at least rename it to pm_runtime_barrier_noidle()?  I.e. make it
clear that it needs to be wrapped by get / put, or an explicit suspend
request queued afterwards.
